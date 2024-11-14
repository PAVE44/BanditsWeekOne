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
    local walkType = "Walk"
    local endurance = 0
    local world = getWorld()
    local cm = world:getClimateManager()
    local dls = cm:getDayLightStrength()
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()
    local square = bandit:getSquare()
    local room = square:getRoom()

    -- if outside building then remove
    -- if outside  building change program
    if bandit:isOutside() then
        Bandit.ClearTasks(bandit)
        Bandit.SetProgram(bandit, "Walker", {})

        local brain = BanditBrain.Get(bandit)
        local syncData = {}
        syncData.id = brain.id
        syncData.program = brain.program
        Bandit.ForceSyncPart(bandit, syncData)
    end
    
    if room then
        local def = room:getRoomDef()
        local roomName = room:getName()

        -- global actions independent of room type
        
        -- symptoms
        if math.abs(id) % 10 > 0 then
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

        -- intrustion
        if BWOScheduler.SymptomLevel < 2 then
            local playerList = BanditPlayer.GetPlayers()
            for i=0, playerList:size()-1 do
                local player = playerList:get(i)
                if player and not BanditPlayer.IsGhost(player) then
                    local building = player:getBuilding()
                    local room = player:getSquare():getRoom()
                    
                    if building then
                        local roomName = room:getName()
                        if (BTWOBuildings.GetType(building) == "residential" or roomName == "security") and bandit:CanSee(player) and not player:isOutside() then
                            Bandit.Say(bandit, "DEFENDER_SPOTTED")
                            BWOScheduler.Add("CallCopsHostile", 1000)
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

        -- barricade
        local barricadable = BWOObjects.FindBarricadable(bandit, def)
        if barricadable then
            local dist = math.sqrt(math.pow(bandit:getX() - (barricadable:getX() + 0.5), 2) + math.pow(bandit:getY() - (barricadable:getY() + 0.5), 2))
            if dist > 0.70 then
                table.insert(tasks, BanditUtils.GetMoveTask(0, barricadable:getX(), barricadable:getY(), barricadable:getZ(), "Walk", dist, false))
                return {status=true, next="Main", tasks=tasks}
            else
                local task1 = {action="Equip", itemPrimary="Base.Hammer"}
                table.insert(tasks, task1)

                local task2 = {action="Barricade", anim="Hammer", time=500, x=barricadable:getX(), y=barricadable:getY(), z=barricadable:getZ()}
                table.insert(tasks, task2)
                return {status=true, next="Main", tasks=tasks}
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