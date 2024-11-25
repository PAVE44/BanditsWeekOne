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
    capabilities.smashWindow = not BWOPopControl.Police.On
    capabilities.openDoor = true
    capabilities.breakDoor = not BWOPopControl.Police.On
    capabilities.breakObjects = not BWOPopControl.Police.On
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
    if BWOScheduler.WorldAge > 57 then 
        walkType = "Run"
        endurance = -0.06
    end
    
    local health = bandit:getHealth()
    if health < 0.8 then
        walkType = "Limp"
        endurance = 0
    end 

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

    -- if has a specifit outfit change program
    local outfit = bandit:getOutfitName()
    if outfit == "Postal" then
        Bandit.ClearTasks(bandit)
        Bandit.SetProgram(bandit, "Postal", {})

        local brain = BanditBrain.Get(bandit)
        local syncData = {}
        syncData.id = brain.id
        syncData.program = brain.program
        Bandit.ForceSyncPart(bandit, syncData)
        return {status=true, next="Main", tasks=tasks}
    elseif outfit == "Farmer" then
        Bandit.ClearTasks(bandit)
        Bandit.SetProgram(bandit, "Gardener", {})

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
    
    -- react to events
    local subTasks = BanditPrograms.Events(bandit)
    if #subTasks > 0 then
        for _, subTask in pairs(subTasks) do
            table.insert(tasks, subTask)
        end
        return {status=true, next="Main", tasks=tasks}
    end

    -- atm
    local subTasks = BanditPrograms.ATM(bandit)
    if #subTasks > 0 then
        for _, subTask in pairs(subTasks) do
            table.insert(tasks, subTask)
        end
        return {status=true, next="Main", tasks=tasks}
    end

    -- grill time
    if BWOScheduler.SymptomLevel < 3 and ((hour >= 12 and hour < 15) or (hour >= 18 and hour < 23)) then
        local target = BWOObjects.FindGMD(bandit, "barbecue")
        local test = LosUtil.lineClear(cell, bx, by, bz, target.x, target.y, target.z, false)
        if target.x and target.y and target.z and target.dist < 20 then
            local square = cell:getGridSquare(target.x, target.y, target.z)
            if square and BanditUtils.LineClear(bandit, square) then
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

    -- chair/bench rest

    local subTasks = BanditPrograms.Bench(bandit)
    if #subTasks > 0 then
        for _, subTask in pairs(subTasks) do
            table.insert(tasks, subTask)
        end
        return {status=true, next="Main", tasks=tasks}
    end

    -- interact with players and other npcs
    local subTasks = BanditPrograms.Talk(bandit)
    if #subTasks > 0 then
        for _, subTask in pairs(subTasks) do
            table.insert(tasks, subTask)
        end
        return {status=true, next="Main", tasks=tasks}
    end

     -- most pedestrian will follow the street / road, some will just "gosomwhere" for variability
     --
    if id % 4 > 0 then
        local subTasks = BanditPrograms.FollowRoad(bandit, walkType)
        if #subTasks > 0 then
            for _, subTask in pairs(subTasks) do
                table.insert(tasks, subTask)
            end
            return {status=true, next="Main", tasks=tasks}
        end
    end

    -- go somewhere if no road is found
    local subTasks = BanditPrograms.GoSomewhere(bandit, walkType)
    if #subTasks > 0 then
        for _, subTask in pairs(subTasks) do
            table.insert(tasks, subTask)
        end
        return {status=true, next="Main", tasks=tasks}
    end
    
    -- fallback if going somewhere results in interior square
    local subTasks = BanditPrograms.Fallback(bandit)
    if #subTasks > 0 then
        for _, subTask in pairs(subTasks) do
            table.insert(tasks, subTask)
        end
        return {status=true, next="Main", tasks=tasks}
    end

    return {status=true, next="Main", tasks=tasks}
end
