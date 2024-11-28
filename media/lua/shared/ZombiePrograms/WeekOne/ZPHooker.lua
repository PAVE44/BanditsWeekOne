ZombiePrograms = ZombiePrograms or {}

ZombiePrograms.Hooker = {}
ZombiePrograms.Hooker.Stages = {}

ZombiePrograms.Hooker.Init = function(bandit)
end

ZombiePrograms.Hooker.GetCapabilities = function()
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

ZombiePrograms.Hooker.Prepare = function(bandit)
    local tasks = {}
    local world = getWorld()
    local cell = getCell()
    local cm = world:getClimateManager()
    local dls = cm:getDayLightStrength()

    Bandit.ForceStationary(bandit, false)

    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Hooker.Main = function(bandit)
    local tasks = {}

    local cell = bandit:getCell()
    local id = BanditUtils.GetCharacterID(bandit)
    local bx = bandit:getX()
    local by = bandit:getY()
    local bz = bandit:getZ()
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
    end
    
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
    else
        if BWOScheduler.SymptomLevel >= 4 then walkType = "Run" end
    end

    -- chat with players and others
    if BWOScheduler.SymptomLevel < 3 then
        local neighborBandit = BanditUtils.GetClosestBanditLocation(bandit)
        local neighborPlayer = BanditUtils.GetClosestPlayerLocation(bandit, true)

        neighbor = neighborBandit
        if neighborPlayer.dist < neighborBandit.dist then
            neighbor = closestBandit
        end

        if neighbor.dist < 3 and ZombRand(2) == 1 then
            if not bandit:getSquare():isSomethingTo(getCell():getGridSquare(neighbor.x, neighbor.y, neighbor.z)) then
                Bandit.Say(bandit, "STREETCHAT")
                local anim = BanditUtils.Choice({"Talk1", "Talk2", "Talk3", "Talk4", "Talk5", "WaveHi", "Yes", "No"})
                local task = {action="FaceLocation", anim=anim, x=neighbor.x, y=neighbor.y, z=neighbor.z, time=100}
                table.insert(tasks, task)
            end
            -- return {status=true, next="Walk", tasks=tasks}
        end
    end

    -- go somewhere
    local rnd = math.abs(id) % 4

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

ZombiePrograms.Hooker.Walk = function(bandit)
    local tasks = {}
    return {status=true, next="Main", tasks=tasks}
end