ZombiePrograms = ZombiePrograms or {}

ZombiePrograms.Police = {}
ZombiePrograms.Police.Stages = {}

ZombiePrograms.Police.Init = function(bandit)
end

ZombiePrograms.Police.GetCapabilities = function()
    -- capabilities are program decided
    local capabilities = {}
    capabilities.melee = true
    capabilities.shoot = true
    capabilities.smashWindow = true
    capabilities.openDoor = true
    capabilities.breakDoor = true
    capabilities.breakObjects = true
    capabilities.unbarricade = true
    capabilities.disableGenerators = true
    capabilities.sabotageCars = true
    return capabilities
end

ZombiePrograms.Police.Prepare = function(bandit)
    local tasks = {}

    Bandit.ForceStationary(bandit, false)
  
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Police.Main = function(bandit)
    local tasks = {}
    local id = BanditUtils.GetCharacterID(bandit)
    local cell = getCell()
    local outOfAmmo = Bandit.IsOutOfAmmo(bandit)
    local outfit = bandit:getOutfitName()
    local walkType = "Run"
    local endurance = -0.06
    local brain = BanditBrain.Get(bandit)

    if bandit:isInARoom() then
        if outOfAmmo then
            walkType = "Run"
        else
            walkType = "WalkAim"
        end
    end

    local health = bandit:getHealth()
    if health < 0.8 then
        walkType = "Limp"
        endurance = 0
    end 
    
    local healthMin = 0.7
    if SandboxVars.Bandits.General_RunAway and health < healthMin then
        return {status=true, next="Escape", tasks=tasks}
    end

    local config = {}
    config.mustSee = false
    config.hearDist = 20

    local target = {}

    local closestZombie = BanditUtils.GetClosestZombieLocation(bandit)
    local closestBandit = BanditUtils.GetClosestEnemyBanditLocation(bandit)
    local closestPlayer = BanditUtils.GetClosestPlayerLocation(bandit, config)

    if Bandit.IsHostile(bandit) then
        local age = getGameTime():getWorldAgeHours() - brain.born
        if age > 1 and closestPlayer.dist > 30 then
            Bandit.ClearTasks(bandit)
            Bandit.SetHostile(bandit, false)
            Bandit.SetProgram(bandit, "Patrol", {})
            local syncData = {}
            syncData.id = brain.id
            syncData.hostile = brain.hostile
            syncData.program = brain.program
            Bandit.ForceSyncPart(bandit, syncData)
            return {status=true, next="Main", tasks=tasks}
        end
    end

    target = closestZombie
    if closestBandit.dist < closestZombie.dist then
        target = closestBandit
        enemy = BanditZombie.GetInstanceById(target.id)
    end

    if Bandit.IsHostile(bandit) and closestPlayer.dist < closestBandit.dist then
        target = closestPlayer
        enemy = BanditPlayer.GetPlayerById(target.id)
    end

    local closeSlow = true
    if enemy then
        local weapon = enemy:getPrimaryHandItem()
        if weapon and weapon:IsWeapon() then
            local weaponType = WeaponType.getWeaponType(weapon)
            if weaponType == WeaponType.firearm or weaponType == WeaponType.handgun then
                closeSlow = false
            end
        end
    end

    -- engage with target
    if target.x and target.y and target.z then
        local targetSquare = cell:getGridSquare(target.x, target.y, target.z)
        if targetSquare then
            Bandit.SayLocation(bandit, targetSquare)
        end

        local tx, ty, tz = target.x, target.y, target.z
        
        local closeSlow = true
        local engageUpfront = false
        if enemy then
            local weapon = enemy:getPrimaryHandItem()
            if weapon and weapon:IsWeapon() then
                local weaponType = WeaponType.getWeaponType(weapon)
                if weaponType == WeaponType.firearm or weaponType == WeaponType.handgun then
                    closeSlow = false
                end
            end

            if target.fx and target.fy and (enemy:isRunning()  or enemy:isSprinting()) then
                engageUpfront = true
            end
        end
        
        if engageUpfront then
            tx, ty = target.fx, target.fy
        end

        table.insert(tasks, BanditUtils.GetMoveTask(endurance, tx, ty, tz, walkType, target.dist, closeSlow))
        return {status=true, next="Main", tasks=tasks}
    else
        -- fixme change to patrol program so its not affected by walkder typical behavior like protersts
        Bandit.ClearTasks(bandit)
        Bandit.SetHostile(bandit, false)
        Bandit.SetProgram(bandit, "Patrol", {})
        local syncData = {}
        syncData.id = brain.id
        syncData.hostile = brain.hostile
        syncData.program = brain.program
        Bandit.ForceSyncPart(bandit, syncData)
        return {status=true, next="Main", tasks=tasks}
    end

    -- fallback
    local subTasks = BanditPrograms.FallbackAction(bandit)
    if #subTasks > 0 then
        for _, subTask in pairs(subTasks) do
            table.insert(tasks, subTask)
        end
    end

    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Police.Escape = function(bandit)
    local tasks = {}
    local weapons = Bandit.GetWeapons(bandit)

    local health = bandit:getHealth()

    local endurance = -0.06
    local walkType = "Run"
    if health < 0.8 then
        walkType = "Limp"
        endurance = 0
    end

    local handweapon = bandit:getVariableString("BanditWeapon")

    local config = {}
    config.mustSee = false
    config.hearDist = 40

    local closestPlayer = BanditUtils.GetClosestPlayerLocation(bandit)

    if closestPlayer.x and closestPlayer.y and closestPlayer.z then

        -- calculate random escape direction
        local deltaX = 100 + ZombRand(100)
        local deltaY = 100 + ZombRand(100)

        local rx = ZombRand(2)
        local ry = ZombRand(2)
        if rx == 1 then deltaX = -deltaX end
        if ry == 1 then deltaY = -deltaY end

        table.insert(tasks, BanditUtils.GetMoveTask(endurance, closestPlayer.x+deltaX, closestPlayer.y+deltaY, 0, walkType, 12, false))
        return {status=true, next="Escape", tasks=tasks}
    end
    return {status=true, next="Escape", tasks=tasks}
end

ZombiePrograms.Police.Follow = function(bandit)
    return {status=true, next="Main", tasks={}}
end