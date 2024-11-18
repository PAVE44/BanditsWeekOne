ZombiePrograms = ZombiePrograms or {}

ZombiePrograms.Runner = {}
ZombiePrograms.Runner.Stages = {}

ZombiePrograms.Runner.Init = function(bandit)
end

ZombiePrograms.Runner.GetCapabilities = function()
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

ZombiePrograms.Runner.Prepare = function(bandit)
    local tasks = {}
    local world = getWorld()
    local cell = getCell()
    local cm = world:getClimateManager()
    local dls = cm:getDayLightStrength()

    Bandit.ForceStationary(bandit, false)

    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Runner.Main = function(bandit)
    local tasks = {}

    local id = BanditUtils.GetCharacterID(bandit)
    local bx = bandit:getX()
    local by = bandit:getY()
    local bz = bandit:getZ()
    local walkType = "Run"
    local endurance = 0 -- runners are fit!
    local cell = bandit:getCell()

    -- too sick to run
    if BWOScheduler.SymptomLevel > 2 then
        Bandit.ClearTasks(bandit)
        Bandit.SetProgram(bandit, "Walker", {})

        local brain = BanditBrain.Get(bandit)
        local syncData = {}
        syncData.id = brain.id
        syncData.program = brain.program
        Bandit.ForceSyncPart(bandit, syncData)
        return {status=true, next="Main", tasks=tasks}
    end

    -- follow the street / road
    local direction = bandit:getForwardDirection()
    local angle = direction:getDirection()
    direction:setLength(8)

    local step = 0.785398163 / 2 -- 22.5 deg
    for i = 0, 14 do
        for j=-1, 1, 2 do
            local newangle = angle + (i * j * step)
            if newangle > 6.283185304 then newangle = newangle - 6.283185304 end
            direction:setDirection(newangle)

            local vx = bx + direction:getX()
            local vy = by + direction:getY()
            local vz = bz
            local square = cell:getGridSquare(vx, vy, vz)
            if square then
                local groundType = BanditUtils.GetGroundType(square)
                if groundType == "street" then
                    table.insert(tasks, BanditUtils.GetMoveTask(endurance, vx, vy, vz, walkType, 2, false))
                    return {status=true, next="Main", tasks=tasks}
                end
            end
        end
    end

    -- fallback if no road is found
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
    
    table.insert(tasks, BanditUtils.GetMoveTask(endurance, bx + dx, by + dy, 0, walkType, 10, false))
    
    return {status=true, next="Main", tasks=tasks}
end
