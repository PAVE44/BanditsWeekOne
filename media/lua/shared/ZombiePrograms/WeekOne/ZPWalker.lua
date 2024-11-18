ZombiePrograms = ZombiePrograms or {}

ZombiePrograms.Walker = {}
ZombiePrograms.Walker.Stages = {}

ZombiePrograms.Walker.Init = function(bandit)
end

ZombiePrograms.Walker.GetCapabilities = function()
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

ZombiePrograms.Walker.Prepare = function(bandit)
    local tasks = {}
    local world = getWorld()
    local cell = getCell()
    local cm = world:getClimateManager()
    local dls = cm:getDayLightStrength()

    Bandit.ForceStationary(bandit, false)

    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Walker.Main = function(bandit)
    local tasks = {}

    local cell = bandit:getCell()
    local id = BanditUtils.GetCharacterID(bandit)
    local bx = bandit:getX()
    local by = bandit:getY()
    local bz = bandit:getZ()
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()

    local walkType = "Walk"
    local endurance = 0

    -- if inside building change program
    if not bandit:isOutside() then
        Bandit.ClearTasks(bandit)
        Bandit.SetProgram(bandit, "Inhabitant", {})

        local brain = BanditBrain.Get(bandit)
        local syncData = {}
        syncData.id = brain.id
        syncData.program = brain.program
        Bandit.ForceSyncPart(bandit, syncData)
        return {status=true, next="Main", tasks=tasks}
    end
    
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
    else
        if BWOScheduler.SymptomLevel >= 4 then walkType = "Run" end
    end
    
    -- watch deadbody
    if BWOScheduler.SymptomLevel < 3 then
        local target = BWOObjects.FindDeadBody(bandit)
        if target.x and target.y and target.z then
            if target.dist >= 3 and target.dist < 20 then
                walkType = "Run"
                table.insert(tasks, BanditUtils.GetMoveTask(endurance, target.x, target.y, target.z, walkType, target.dist, false))
                return {status=true, next="Main", tasks=tasks}
            elseif target.dist < 3 then
                local square = cell:getGridSquare(target.x, target.y, target.z)
                if square then
                    deadbody = square:getDeadBody()
                    if deadbody then
                        Bandit.Say(bandit, "CORPSE")
                        local anim = BanditUtils.Choice({"SmellBad", "SmellGag", "PainHead", "ChewNails", "No", "No", "WipeBrow"})
                        local task = {action="FaceLocation", anim=anim, time=100, x=deadbody:getX(), y=deadbody:getY(), z=deadbody:getZ()}
                        table.insert(tasks, task)
                        return {status=true, next="Main", tasks=tasks}
                    end
                end
            end
        end
    end

    -- grill time
    if BWOScheduler.SymptomLevel < 3 and ((hour >= 12 and hour < 15) or (hour >= 18 and hour < 23)) then
        local target = BWOObjects.FindGMD(bandit, "barbecue")
        
        if target.x and target.y and target.z and target.dist < 20 then
            local square = cell:getGridSquare(target.x, target.y, target.z)
            if square then
                local objects = square:getObjects()
                for i=0, objects:size()-1 do
                    local object = objects:get(i)
                    if instanceof(object, "IsoBarbecue") then
                        if object:isLit() then
                            if target.dist >= 5 then
                                walkType = "Walk"
                                table.insert(tasks, BanditUtils.GetMoveTask(endurance, target.x, target.y, target.z, walkType, target.dist, false))
                                return {status=true, next="Main", tasks=tasks}
                            else
                                local rn = ZombRand(5)
                                local anim
                                local item
                                local sound
                                if rn == 0 then
                                    anim = "WaveHi"
                                elseif rn == 1 then
                                    anim = "No"
                                elseif rn == 2 then
                                    anim = "Yes"
                                elseif rn == 3 then
                                    anim = "Eat"
                                    sound = "Eating"
                                    item = "Base.Steak"
                                elseif rn == 4 then
                                    anim = "Drink"
                                    sound = "DrinkingFromBottle"
                                    item = "Bandits.BeerBottle"
                                end
                                local task = {action="TimeItem", anim=anim, sound=sound, item=item, left=true, time=100}
                                table.insert(tasks, task)
                                return {status=true, next="Main", tasks=tasks}
                            end
                        else
                            local asquare = AdjacentFreeTileFinder.Find(square, bandit)
                            if asquare then
                                local dist = math.sqrt(math.pow(bandit:getX() - (square:getX() + 0.5), 2) + math.pow(bandit:getY() - (square:getY() + 0.5), 2))
                                if dist > 1.20 then
                                    table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                                    return {status=true, next="Main", tasks=tasks}
                                else
                                    local task = {action="BarbecueLit", anim="Loot", x=object:getX(), y=object:getY(), z=object:getZ(), time=100}
                                    table.insert(tasks, task)
                                    return {status=true, next="Main", tasks=tasks}
                                end
                            end
                        end
                    end
                end
            end
        end
    end


    -- chat with players and others
    if BWOScheduler.SymptomLevel < 3 then
        local neighborBandit = BanditUtils.GetClosestBanditLocation(bandit)
        local neighborPlayer = BanditUtils.GetClosestPlayerLocation(bandit, true)

        local neighbor = neighborBandit
        if neighborPlayer.dist < neighborBandit.dist then
            neighbor = neighborPlayer
        end

        if neighbor.dist < 3 and ZombRand(2) == 1 then
            if not bandit:getSquare():isSomethingTo(getCell():getGridSquare(neighbor.x, neighbor.y, neighbor.z)) then
                Bandit.Say(bandit, "STREETCHAT")
                local anim = BanditUtils.Choice({"WaveHi", "Yes", "No"}) -- "Talk6", "Talk6", "Talk6", "Talk6", "Talk6"
                local task = {action="FaceLocation", anim=anim, x=neighbor.x, y=neighbor.y, z=neighbor.z, time=100}
                table.insert(tasks, task)
            end
            -- return {status=true, next="Walk", tasks=tasks}
        end
    end

    -- go somewhere
    local rnd = math.abs(id % 4)

    local dx = 0
    local dy = 0
    if rnd == 0 then
        dx = 10
    elseif rnd == 1 then
        dy = 10
    elseif rnd == 2 then
        dx = -10
    elseif rnd == 3 then
        dy = -10
    end

    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    if hour % 2 == 0 then
        dx = -dx
        dy = -dy
    end

    local target = {}
    target.x = bx + dx
    target.y = by + dy
    target.z = 0
    
    table.insert(tasks, BanditUtils.GetMoveTask(endurance, target.x, target.y, target.z, walkType, 10, false))
    
    return {status=true, next="Main", tasks=tasks}
end
