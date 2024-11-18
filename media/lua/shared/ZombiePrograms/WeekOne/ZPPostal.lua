ZombiePrograms = ZombiePrograms or {}

ZombiePrograms.Postal = {}
ZombiePrograms.Postal.Stages = {}

ZombiePrograms.Postal.Init = function(bandit)
end

ZombiePrograms.Postal.GetCapabilities = function()
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

ZombiePrograms.Postal.Prepare = function(bandit)
    local tasks = {}
    local world = getWorld()
    local cell = getCell()
    local cm = world:getClimateManager()
    local dls = cm:getDayLightStrength()

    Bandit.ForceStationary(bandit, false)

    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Postal.Main = function(bandit)
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

    -- interact with players and other npcs
    if BWOScheduler.SymptomLevel < 3 then
        local subTasks = BanditPrograms.Talk(bandit)
        if #subTasks > 0 then
            for _, subTask in pairs(subTasks) do
                table.insert(tasks, subTask)
            end
            return {status=true, next="Main", tasks=tasks}
        end
    end

    -- put newspapers to mailbox
    local target = BWOObjects.FindGMD(bandit, "mailbox")      
    if target.x and target.y and target.z and target.dist < 20 then
        local square = cell:getGridSquare(target.x, target.y, target.z)
        if square then
            local objects = square:getObjects()
            for i=0, objects:size()-1 do
                local object = objects:get(i)
                local container = object:getContainer()
                if container and container:isEmpty() then
                    local asquare = AdjacentFreeTileFinder.Find(square, bandit)
                    if asquare then
                        local dist = BanditUtils.DistTo(bandit:getX(), bandit:getY(), square:getX() + 0.5, square:getY() + 0.5)
                        if dist > 0.5 then
                            table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                            return {status=true, next="Main", tasks=tasks}
                        else
                            local task = {action="PutInContainer", itemType="Base.Newspaper", anim="Loot", x=object:getX(), y=object:getY(), z=object:getZ()}
                            table.insert(tasks, task)
                            return {status=true, next="Main", tasks=tasks}
                        end
                    end
                end
            end
        end
    end

    -- fallback
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
