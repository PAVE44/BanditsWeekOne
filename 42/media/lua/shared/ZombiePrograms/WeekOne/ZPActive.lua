ZombiePrograms = ZombiePrograms or {}

ZombiePrograms.Active = {}
ZombiePrograms.Active.Stages = {}

ZombiePrograms.Active.Init = function(bandit)
end

ZombiePrograms.Active.GetCapabilities = function()
    -- capabilities are program decided
    local capabilities = {}
    capabilities.melee = true
    capabilities.shoot = true
    capabilities.smashWindow = true
    capabilities.openDoor = true
    capabilities.breakDoor = not BWOPopControl.Police.On
    capabilities.breakObjects = not BWOPopControl.Police.On
    capabilities.unbarricade = false
    capabilities.disableGenerators = false
    capabilities.sabotageCars = false
    return capabilities
end

ZombiePrograms.Active.Prepare = function(bandit)
    local tasks = {}

    Bandit.ForceStationary(bandit, false)
  
    local player = getSpecificPlayer(0)
    local px, py = player:getX(), player:getY()
    local anim = BanditUtils.Choice({"Spooked1", "Spooked2"})
    local task2 = {action="TimeFace", anim=anim, x=px, y=py, time=100}
    table.insert(tasks, task2)
    
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Active.Main = function(bandit)
    local tasks = {}
    local id = BanditUtils.GetCharacterID(bandit)
    local cell = getCell()
    local outOfAmmo = Bandit.IsOutOfAmmo(bandit)
    local outfit = bandit:getOutfitName()
    local walkType = "Run"
    local endurance = -0.06

    if bandit:isInARoom() then
        if outOfAmmo then
            walkType = "Run"
        else
            walkType = "WalkAim"
        end
    end

    local coward = math.abs(id) % 2 == 0
    if SandboxVars.Bandits.General_RunAway and coward then
        return {status=true, next="Escape", tasks=tasks}
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
    end

    local endurance = 0 -- -0.02

    local health = bandit:getHealth()
    if health < 0.8 then
        walkType = "Limp"
        endurance = 0
    end 
 
    local target = {}
    local enemy

    local config = {}
    config.mustSee = false
    config.hearDist = 20

    local closestZombie = BanditUtils.GetClosestZombieLocation(bandit)
    local closestBandit = BanditUtils.GetClosestEnemyBanditLocation(bandit)
    local closestPlayer = BanditUtils.GetClosestPlayerLocation(bandit, config)

    target = closestZombie
    if closestBandit.dist < closestZombie.dist then
        target = closestBandit
        enemy = BanditZombie.GetInstanceById(target.id)
    end

    if Bandit.IsHostile(bandit) and closestPlayer.dist < closestBandit.dist and closestPlayer.dist < closestZombie.dist then
        target = closestPlayer
        enemy = BanditPlayer.GetPlayerById(target.id)
    end

    -- no targets, relax
    if target.dist > 30 then

        relaxMap = {}
        relaxMap["StreetSports"] = "Runner"
        relaxMap["Postal"] = "Postal"
        relaxMap["Farmer"] = "Gardener"
        relaxMap["Sanitation"] = "Janitor"
        relaxMap["Bandit"] = "Vandal"
        relaxMap["Police"] = "Patrol"
        relaxMap["Police_SWAT"] = "Patrol"
        relaxMap["ZSPoliceSpecialOps"] = "Patrol"
        relaxMap["MallSecurity"] = "Patrol"
        relaxMap["ArmyCamoGreen"] = "Patrol"
        relaxMap["ArmyCamoDesert"] = "Patrol"
        relaxMap["ArmyInstructor"] = "Patrol"
        relaxMap["ZSArmySpecialOps"] = "ArmyGuard"
        relaxMap["BWOMilitaryOfficer"] = "Patrol"
        relaxMap["Doctor"] = "Medic"
        relaxMap["AmbulanceDriver"] = "Medic"
        relaxMap["HazardSuit"] = "Medic"
        relaxMap["Fireman"] = "Fireman"
        relaxMap["FiremanFullSuit"] = "Fireman"

        if relaxMap[outfit] then
            Bandit.SetProgram(bandit, relaxMap[outfit], {})
        else
            if bandit:isOutside() then
                Bandit.SetProgram(bandit, "Walker", {})
            else
                Bandit.SetProgram(bandit, "Inhabitant", {})
            end
        end

        local brain = BanditBrain.Get(bandit)
        local syncData = {}
        syncData.id = brain.id
        syncData.program = brain.program
        Bandit.ForceSyncPart(bandit, syncData)
        return {status=true, next="Main", tasks=tasks}
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

    if target.x and target.y and target.z then

        -- out of ammo, get close
        local minDist = 2
        if outOfAmmo then
            minDist = 0.5
        end

        if target.dist > minDist then

            -- must be deterministic, not random (same for all clients)
            local dx = 0
            local dy = 0
            local dxf = ((math.abs(id) % 10) - 5) / 10
            local dyf = ((math.abs(id) % 11) - 5) / 10

            table.insert(tasks, BanditUtils.GetMoveTask(endurance, target.x+dx+dxf, target.y+dy+dyf, target.z, walkType, target.dist, closeSlow))
            return {status=true, next="Main", tasks=tasks}
        end
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

ZombiePrograms.Active.Escape = function(bandit)
    local tasks = {}
    local id = BanditUtils.GetCharacterID(bandit)
    local health = bandit:getHealth()

    local endurance = -0.06
    local walkType = "Run"
    if health < 0.8 then
        walkType = "Limp"
        endurance = 0
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

    local config = {}
    config.mustSee = false
    config.hearDist = 40

    local closestPlayer = BanditUtils.GetClosestPlayerLocation(bandit, config)

    if closestPlayer.dist > 30 then
        if bandit:isOutside() then
            Bandit.SetProgram(bandit, "Walker", {})
        else
            Bandit.SetProgram(bandit, "Inhabitant", {})
        end

        local brain = BanditBrain.Get(bandit)
        local syncData = {}
        syncData.id = brain.id
        syncData.program = brain.program
        Bandit.ForceSyncPart(bandit, syncData)
        return {status=true, next="Main", tasks=tasks}
    end

    if closestPlayer.x and closestPlayer.y and closestPlayer.z then

        -- calculate random escape direction
        local deltaX = 100 + ZombRand(100)
        local deltaY = 100 + ZombRand(100)

        local rx = ZombRand(2)
        local ry = ZombRand(2)
        if rx == 1 then deltaX = -deltaX end
        if ry == 1 then deltaY = -deltaY end

        table.insert(tasks, BanditUtils.GetMoveTask(endurance, closestPlayer.x+deltaX, closestPlayer.y+deltaY, 0, walkType, 12, false))
    end
    return {status=true, next="Escape", tasks=tasks}
end

ZombiePrograms.Active.Wait = function(bandit)
    return {status=true, next="Main", tasks={}}
end

