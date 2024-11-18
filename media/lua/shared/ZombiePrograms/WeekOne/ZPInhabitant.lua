ZombiePrograms = ZombiePrograms or {}

ZombiePrograms.Inhabitant = {}
ZombiePrograms.Inhabitant.Stages = {}

ZombiePrograms.Inhabitant.Init = function(bandit)
end

ZombiePrograms.Inhabitant.GetCapabilities = function()
    -- capabilities are program decided
    local capabilities = {}
    capabilities.melee = false
    capabilities.shoot = false
    capabilities.smashWindow = false
    capabilities.openDoor = true
    capabilities.breakDoor = false
    capabilities.breakObjects = false
    capabilities.unbarricade = false
    capabilities.disableGenerators = false
    capabilities.sabotageCars = false
    return capabilities
end

ZombiePrograms.Inhabitant.Prepare = function(bandit)
    local tasks = {}
    local world = getWorld()
    local cell = getCell()
    local cm = world:getClimateManager()
    local dls = cm:getDayLightStrength()

    Bandit.ForceStationary(bandit, false)

    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Inhabitant.Main = function(bandit)
    local tasks = {}

    local id = BanditUtils.GetCharacterID(bandit)
    local bx = bandit:getX()
    local by = bandit:getY()
    local bz = bandit:getZ()
    local world = getWorld()
    local cell = getCell()
    local cm = world:getClimateManager()
    local dls = cm:getDayLightStrength()
    local square = bandit:getSquare()
    local room = square:getRoom()
    local building = square:getBuilding()
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()

    local walkType = "Walk"
    local endurance = 0

    -- if outside building change program
    if bandit:isOutside() then
        Bandit.ClearTasks(bandit)
        Bandit.SetProgram(bandit, "Walker", {})

        local brain = BanditBrain.Get(bandit)
        local syncData = {}
        syncData.id = brain.id
        syncData.program = brain.program
        Bandit.ForceSyncPart(bandit, syncData)
        return {status=true, next="Main", tasks=tasks}
    end
    
    if room then
        local def = room:getRoomDef()
        local roomName = room:getName()

        -- global actions independent of room type
        
        -- symptoms
        if math.abs(id) % 4 > 0 then
            if BWOScheduler.SymptomLevel == 3 then
                walkType = "Limp"
            elseif BWOScheduler.SymptomLevel >= 4 then
                walkType = "Scramble"
            end

            local subTasks = BanditPrograms.Symptoms(bandit)
            if #subTasks > 0 then
                for _, subTask in pairs(subTasks) do
                    table.insert(tasks, subTask)
                end
                return {status=true, next="Main", tasks=tasks}
            end
        end

        -- crime scene
        if BWOScheduler.SymptomLevel < 3 then
            local subTasks = BanditPrograms.CrimeScene(bandit)
            if #subTasks > 0 then
                for _, subTask in pairs(subTasks) do
                    table.insert(tasks, subTask)
                end
                return {status=true, next="Main", tasks=tasks}
            end
        end

        -- house event actions
        if BWOScheduler.SymptomLevel < 2 then
            if BWOBuildings.IsEventBuilding(building, "party") then

                local boombox = BWOObjects.Find(bandit, def, "Boombox")
                if boombox then

                    local partyOn = -- false
                    if hour >= 19 or hour < 5 then 
                        partyOn = true
                    end

                    if partyOn then
                        local dd = boombox:getDeviceData()
                        if not dd:getIsTurnedOn() or not boombox:getModData().tcmusic.isPlaying then
                            local square = boombox:getSquare()
                            local asquare = AdjacentFreeTileFinder.Find(square, bandit)
                            if asquare then
                                local dist = math.sqrt(math.pow(bandit:getX() - (asquare:getX() + 0.5), 2) + math.pow(bandit:getY() - (asquare:getY() + 0.5), 2))
                                if dist > 0.70 then
                                    table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                                    return {status=true, next="Main", tasks=tasks}
                                else
                                    local task = {action="BoomboxToggle", on=true, anim="Loot", x=square:getX(), y=square:getY(), z=square:getZ(), time=100}
                                    table.insert(tasks, task)
                                    return {status=true, next="Main", tasks=tasks}
                                end
                            end
                        end

                        local rnd = ZombRand(5)
                        if rnd == 0 then
                            local task = {action="Smoke", anim="Smoke", item="Bandits.Cigarette", left=true, time=100}
                            table.insert(tasks, task)
                            return {status=true, next="Main", tasks=tasks}
                        elseif rnd == 1 then
                            local task = {action="TimeItem", anim="Drink", sound="DrinkingFromBottle", item="Bandits.BeerBottle", left=true, time=100}
                            table.insert(tasks, task)
                            return {status=true, next="Main", tasks=tasks}
                        else
                            local anim = BanditUtils.Choice({"DanceHipHop3", "DanceLocking", "DanceShuffling", "DanceArmsHipHop", "DanceGandy", "DanceHouseDancing", "DanceRaiseTheRoof", "DanceRobotOne", "DanceRobotTwo", "DanceSnake"})
                            local task = {action="Time", anim=anim, time=500}
                            table.insert(tasks, task)
                            return {status=true, next="Main", tasks=tasks}
                        end
                    end
                end
            else

                local playerList = BanditPlayer.GetPlayers()
                for i=0, playerList:size()-1 do
                    local player = playerList:get(i)
                    if player and not BanditPlayer.IsGhost(player) then
                        local building = player:getBuilding()
                        local room = player:getSquare():getRoom()
                        
                        if building then
                            local base = BanditPlayerBase.GetBase(player)
                            if not base then
                                local roomName = room:getName()
                                if BWOBuildings.IsIntrusion(building, room) and bandit:CanSee(player) and not player:isOutside() then
                                    Bandit.Say(bandit, "DEFENDER_SPOTTED")
                                    BWOScheduler.Add("CallCopsHostile", 1000)
                                end
                            end
                        end
                    end
                end
            end
        end

        -- light switch
        if world:isHydroPowerOn() then
            local ls = BWOObjects.FindLightSwitch(bandit, def)
            if ls then

                local active = true
                --if (hour >= 6 and hour <= 8) or (hour >= 18 and hour <= 22) then
                if (hour < 6 or hour > 22) and roomName == "bedroom" then
                    active = false
                end

                if active ~= ls:isActivated() then
                    local square = ls:getSquare()
                    if not square:isFree(false) then
                        local asquare = AdjacentFreeTileFinder.Find(square, bandit)
                        if asquare then square = asquare end
                    end
                    if square then
                        local dist = math.sqrt(math.pow(bandit:getX() - (square:getX() + 0.5), 2) + math.pow(bandit:getY() - (square:getY() + 0.5), 2))
                        if dist > 0.70 then
                            table.insert(tasks, BanditUtils.GetMoveTask(0, square:getX(), square:getY(), square:getZ(), "Walk", dist, false))
                            return {status=true, next="Main", tasks=tasks}
                        else
                            local task = {action="LightToggle", anim="Loot", active=active, x=ls:getSquare():getX(), y=ls:getSquare():getY(), z=ls:getSquare():getZ()}
                            table.insert(tasks, task)
                            return {status=true, next="Main", tasks=tasks}
                        end
                    end
                end
            end
        end

        local door = BWOObjects.FindExteriorDoor(bandit, def)
        if door then

            local unlock
            if BWOPopControl.ZombieMax > 0 then
                unlock = false
            else
                local buildingType = BWOBuildings.GetType(building)
                local hours = BWOBuildings.OpenHours[buildingType]
            
                if door:IsOpen() or not door:isLockedByKey() then
                    if hour < hours.open or hour >= hours.close then
                        unlock = false -- lock doors
                    end
                elseif door:isLockedByKey() or door:isLocked() then
                    if hour >= hours.open and hour < hours.close then
                        unlock = true -- unlock doors
                    end
                end
            end

            if unlock ~= nil then
                local standSquare = door:getSquare()
                if standSquare:isOutside() then
                    standSquare = door:getOppositeSquare()
                end

                local dist = math.sqrt(math.pow(bandit:getX() - (standSquare:getX() + 0.5), 2) + math.pow(bandit:getY() - (standSquare:getY() + 0.5), 2))
                if dist > 0.70 then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, standSquare:getX(), standSquare:getY(), standSquare:getZ(), "Walk", dist, false))
                    return {status=true, next="Main", tasks=tasks}
                else
                    local task = {action="DoorLock", time=80, unlock=unlock, x=door:getX(), y=door:getY(), z=door:getZ()}
                    table.insert(tasks, task)
                    return {status=true, next="Main", tasks=tasks}
                end
            end
        end

        -- barricade
        if BWOPopControl.ZombieMax >= 2 then
            local barricadable = BWOObjects.FindBarricadable(bandit, def)
            if barricadable then
                --local standSquare = barricadable:getIndoorSquare()
                local standSquare = barricadable:getSquare()
                if standSquare:isOutside() then
                    standSquare = barricadable:getOppositeSquare()
                end

                local dist = math.sqrt(math.pow(bandit:getX() - (standSquare:getX() + 0.5), 2) + math.pow(bandit:getY() - (standSquare:getY() + 0.5), 2))
                if dist > 0.70 then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, standSquare:getX(), standSquare:getY(), standSquare:getZ(), "Walk", dist, false))
                    return {status=true, next="Main", tasks=tasks}
                else
                    local task1 = {action="Equip", itemPrimary="Base.Hammer"}
                    table.insert(tasks, task1)

                    local task2 = {action="Barricade", anim="Hammer", time=500, x=barricadable:getX(), y=barricadable:getY(), z=barricadable:getZ()}
                    table.insert(tasks, task2)
                    return {status=true, next="Main", tasks=tasks}
                end
            end
        end

        -- actions specific to room type
        if BWORoomPrograms[roomName] then
            local subTasks = BWORoomPrograms[roomName](bandit, def)
            if #subTasks > 0 then
                for _, subTask in pairs(subTasks) do
                    table.insert(tasks, subTask)
                end
                return {status=true, next="Main", tasks=tasks}
            end
        end
    end
    
    -- fallback
    local anim = BanditUtils.Choice({"ShiftWeight", "ChewNails", "PullAtCollar", "WipeBrow", "WipeHead"})
    local task = {action="Time", anim=anim, time=100}
    table.insert(tasks, task)

    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Inhabitant.Walk = function(bandit)
    local tasks = {}
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Inhabitant.Run = function(bandit)
    local tasks = {}
    return {status=true, next="Main", tasks=tasks}
end