BWOPopControl = BWOPopControl or {}

-- population control
BWOPopControl.ZombieMax = 0
BWOPopControl.ZombieCnt = 0

BWOPopControl.SurvivorsCnt = 0
BWOPopControl.SurvivorsNominal = 0
BWOPopControl.SurvivorsMax = 100

BWOPopControl.InhabitantsCnt = 0
BWOPopControl.InhabitantsNominal = 40
BWOPopControl.InhabitantsMax = 40

BWOPopControl.StreetsCnt = 0
BWOPopControl.StreetsNominal = 40
BWOPopControl.StreetsMax = 40

-- emergency services control
BWOPopControl.Police = {} 
BWOPopControl.Police.Cooldown = 0
BWOPopControl.Police.On = true

BWOPopControl.SWAT = {} 
BWOPopControl.SWAT.Cooldown = 0
BWOPopControl.SWAT.On = true

BWOPopControl.Security = {}
BWOPopControl.Security.Cooldown = 0
BWOPopControl.Security.On = true

BWOPopControl.Medics = {}
BWOPopControl.Medics.Cooldown = 0
BWOPopControl.Medics.On = true

BWOPopControl.Hazmats = {}
BWOPopControl.Hazmats.Cooldown = 0
BWOPopControl.Hazmats.On = true

BWOPopControl.Fireman = {} 
BWOPopControl.Fireman.Cooldown = 0
BWOPopControl.Fireman.On = true


BWOPopControl.Zombie = function()
    -- local x = SandboxVars.ZombieConfig.PopulationMultiplier
    -- SandboxVars.ZombieConfig.PopulationMultiplier = 0.1
    if BWOPopControl.ZombieMax >= 400 then return end
    local fakeZombie = getCell():getFakeZombieForHit()
    local zombieList = BanditZombie.GetAllZ()
    local gmd = GetBanditModData()

    local ccnt = 0
    for k, v in pairs(gmd.Queue) do
        ccnt = ccnt + 1
    end

    local cnt = 0
    BWOPopControl.ZombieCnt = 0
    for id, z in pairs(zombieList) do
        cnt = cnt + 1
        local test = BWOPopControl
        if cnt > BWOPopControl.ZombieMax then
            local zombie = BanditZombie.GetInstanceById(z.id)
            -- local id = BanditUtils.GetCharacterID(zombie)
            if zombie and zombie:isAlive() and not gmd.Queue[id] then
                zombie:removeFromSquare()
                zombie:removeFromWorld()
                args = {}
                args.id = id
                sendClientCommand(player, 'Commands', 'BanditRemove', args)
            end
        else
            BWOPopControl.ZombieCnt = BWOPopControl.ZombieCnt + 1
        end
    end
end

BWOPopControl.StreetsSpawn = function(cnt)
    local player = getPlayer()
    local cell = player:getCell()
    local px, py = player:getX(), player:getY()

    config = {}
    config.clanId = 1
    config.hasRifleChance = 0
    config.hasPistolChance = 3
    config.rifleMagCount = 0
    config.pistolMagCount = 1

    local event = {}
    event.hostile = false
    event.occured = false
    event.program = {}
    event.program.name = "Walker"
    event.program.stage = "Prepare"
    event.bandits = {}

    local bandit = BanditCreator.MakeFromWave(config)

    for i = 1, cnt do
        local x = 30 + ZombRand(30)
        local y = 30 + ZombRand(30)
        
        if ZombRand(2) == 1 then x = -x end
        if ZombRand(2) == 1 then y = -y end

        local square = cell:getGridSquare(px + x, py + y, 0)
        if square then
            if square:isOutside() then
                local groundType = BanditUtils.GetGroundType(square) 
                if groundType == "street" then
                    event.x = square:getX()
                    event.y = square:getY()
                    local rnd = ZombRand(100)
                    if rnd < 5 then
                        bandit.outfit = BanditUtils.Choice({"StreetSports", "AuthenticJogger", "AuthenticFitnessInstructor"})
                        event.program.name = "Runner"
                        event.program.stage = "Prepare"
                    elseif rnd < 10 then 
                        bandit.outfit = BanditUtils.Choice({"Postal"})
                        event.program.name = "Postal"
                        event.program.stage = "Prepare"
                    elseif rnd < 15 then 
                        bandit.outfit = BanditUtils.Choice({"Farmer"})
                        event.program.name = "Gardener"
                        event.program.stage = "Prepare"
                    elseif rnd < 20 then 
                        bandit.outfit = BanditUtils.Choice({"AuthenticHomeless"})
                        bandit.weapons.melee = "Base.Broom"
                        event.program.name = "Janitor"
                        event.program.stage = "Prepare"
                    else
                        bandit.outfit = BanditUtils.Choice({"Generic02", "Generic01"})
                        event.program.name = "Walker"
                        event.program.stage = "Prepare"
                    end
                    bandit.weapons.melee = "Base.BareHands"
                    table.insert(event.bandits, bandit)
                    sendClientCommand(player, 'Commands', 'SpawnGroup', event)
                end
            end
        end
    end
end

BWOPopControl.StreetsDespawn = function(cnt)
    local player = getPlayer()
    local cell = player:getCell()
    local px = player:getX()
    local py = player:getY()

    local removePrg = {"Walker", "Runner", "Postal", "Entertainer", "Janitor", "Medic", "Gardener"}
    local zombieList = cell:getZombieList()
    
    for i = 0, zombieList:size() - 1 do
        local zombie = zombieList:get(i)

        if zombie:getVariableBoolean("Bandit") then
            local brain = BanditBrain.Get(zombie)
            local prg = brain.program.name
            
            for _, prg in pairs(removePrg) do
                if prg == brain.program.name then
                    local zx = zombie:getX()
                    local zy = zombie:getY()
                    local dist = BanditUtils.DistTo(px, py, zx, zy)
                    
                    if dist > 45 then
                        zombie:removeFromSquare()
                        zombie:removeFromWorld()
                        args = {}
                        args.id = brain.id
                        sendClientCommand(player, 'Commands', 'BanditRemove', args)
                        i = i + 1
                        if i >= cnt then return end
                    end
                end
            end
        end
    end
end

BWOPopControl.InhabitantsSpawn = function(cnt)

    local event = {}
    event.hostile = false
    event.occured = false
    event.program = {}
    event.program.name = "Inhabitant"
    event.program.stage = "Prepare"

    local player = getPlayer()
    local cell = player:getCell()
    local px, py = player:getX(), player:getY()
    local rooms = cell:getRoomList()
    local buildings = {}
    for i = 0, rooms:size() - 1 do
        local room = rooms:get(i)

        local building = room:getBuilding()
        if building then
            local def = building:getDef()
            local key = def:getKeyId()

            if not buildings[key] then
                buildings[key] = building
            end
        end
    end

    local s = 0
    for key, building in pairs(buildings) do
        local room = building:getRandomRoom()
        if room then
            local roomDef = room:getRoomDef()
            if roomDef then
                local roomName = room:getName()

                if ZombRand(3) > 0 then
                    local pop = BWOBuildings.GetRoomPop(room)
                    local multiplier = BWOBuildings.GetPopMultiplier(building)
                    local btype = BWOBuildings.GetType(building)
                    pop = math.floor(pop * multiplier)

                    if btype ~= "residential" and roomName == "bathroom" then
                        pop = 0
                    end

                    for i=1, pop do
                        local spawnSquare = roomDef:getFreeSquare()
                        if spawnSquare then
                            event.x = spawnSquare:getX()
                            event.y = spawnSquare:getY()
                            event.z = spawnSquare:getZ()
                            event.bandits = {}
                            local bandit = BanditCreator.MakeFromRoom(room)
                            local dist = BanditUtils.DistTo(px, py, event.x, event.y)
                            if bandit and dist > 30 then
                                table.insert(event.bandits, bandit)
                                sendClientCommand(player, 'Commands', 'SpawnGroup', event)
                                s = s + pop

                                if s > cnt then return end
                            end
                        end
                    end
                end
            end
        end
    end
end

BWOPopControl.InhabitantsDespawn = function(cnt)
    local player = getPlayer()
    local cell = player:getCell()
    local px = player:getX()
    local py = player:getY()

    local removePrg = {"Inhabitant", "Medic", "Janitor", "Entertainer"}
    local zombieList = cell:getZombieList()

    for i = 0, zombieList:size() - 1 do
        local zombie = zombieList:get(i)

        if zombie:getVariableBoolean("Bandit") then
            local brain = BanditBrain.Get(zombie)
            
            for _, prg in pairs(removePrg) do
                if prg == brain.program.name then
                    local zx = zombie:getX()
                    local zy = zombie:getY()
                    local dist = BanditUtils.DistTo(px, py, zx, zy)
                    
                    if dist > 55 then
                        zombie:removeFromSquare()
                        zombie:removeFromWorld()
                        args = {}
                        args.id = brain.id
                        sendClientCommand(player, 'Commands', 'BanditRemove', args)
                        i = i + 1
                        if i >= cnt then return end
                    end
                end
            end
        end
    end
end

BWOPopControl.SurvivorsSpawn = function(missing)

    local player = getPlayer()

    config = {}
    config.clanId = 1
    config.hasRifleChance = 0
    config.hasPistolChance = 30
    config.rifleMagCount = 0
    config.pistolMagCount = 2

    local event = {}
    event.hostile = false
    event.occured = false
    event.program = {}
    event.program.name = "Survivor"
    event.program.stage = "Prepare"

    for i=1, missing do
        local spawnPoint = BanditScheduler.GenerateSpawnPoint(player, ZombRand(35,50))
        if spawnPoint then
            event.x = spawnPoint.x
            event.y = spawnPoint.y
            event.bandits = {}
            
            local bandit = BanditCreator.MakeFromWave(config)
            table.insert(event.bandits, bandit)
            
            sendClientCommand(player, 'Commands', 'SpawnGroup', event)

        end
    end
end

BWOPopControl.SurvivorsDespawn = function(cnt)
    local player = getPlayer()
    local cell = player:getCell()
    local px = player:getX()
    local py = player:getY()

    local removePrg = {"Survivor"}
    local zombieList = cell:getZombieList()
    
    for i = 0, zombieList:size() - 1 do
        local zombie = zombieList:get(i)

        if zombie:getVariableBoolean("Bandit") then
            local brain = BanditBrain.Get(zombie)
            local prg = brain.program.name
            
            for _, prg in pairs(removePrg) do
                if prg == brain.program.name then
                    local zx = zombie:getX()
                    local zy = zombie:getY()
                    local dist = BanditUtils.DistTo(px, py, zx, zy)
                    
                    if dist > 45 then
                        zombie:removeFromSquare()
                        zombie:removeFromWorld()
                        args = {}
                        args.id = brain.id
                        sendClientCommand(player, 'Commands', 'BanditRemove', args)
                        i = i + 1
                        if i >= cnt then return end
                    end
                end
            end
        end
    end
end

BWOPopControl.UpdateCivs = function()

    local function getHourScore()
        local hmap = {}
        hmap[0] = 0.20
        hmap[1] = 0.15
        hmap[2] = 0.10
        hmap[3] = 0.05
        hmap[4] = 0.05
        hmap[5] = 0.35
        hmap[6] = 0.85
        hmap[7] = 1.20
        hmap[8] = 1.20
        hmap[9] = 1.00
        hmap[10] = 1.00
        hmap[11] = 0.80
        hmap[12] = 0.80
        hmap[13] = 0.80
        hmap[14] = 0.80
        hmap[15] = 1.0
        hmap[16] = 1.2
        hmap[17] = 1.2
        hmap[18] = 1.0
        hmap[19] = 1.0
        hmap[20] = 1.0
        hmap[21] = 0.9
        hmap[22] = 0.7
        hmap[23] = 0.4

        local gameTime = getGameTime()
        local hour = gameTime:getHour()
        return hmap[hour]
    end

    local player = getPlayer()
    local px = player:getX()
    local py = player:getY()

    -- gather civ stats
    local cell = getCell()
    local zombieList = cell:getZombieList()

    local totalb = 0 -- all civs
    local totalbc = 0 -- all civs close to player
    local totalz = 0 -- all zeds
    local totalzc = 0 -- all zeds close to player

    local tab = {}
    tab.Active = 0
    tab.Gardener = 0
    tab.Inhabitant = 0
    tab.Janitor = 0
    tab.Medic = 0
    tab.Entertainer = 0
    tab.Postal = 0
    tab.Runner = 0
    tab.Walker = 0
    tab.Active = 0
    tab.Looter = 0
    tab.Bandit = 0

    for i = 0, zombieList:size() - 1 do
        local zombie = zombieList:get(i)
        local zx = zombie:getX()
        local zy = zombie:getY()
        local dist = BanditUtils.DistTo(px, py, zx, zy)
        if zombie:getVariableBoolean("Bandit") then
            local brain = BanditBrain.Get(zombie)
            local prg = brain.program.name
            if tab[prg] then
                tab[prg] = tab[prg] + 1
            else
                tab[prg] = 1
            end
            if dist < 50 then
                totalbc = totalbc + 1
            end
            totalb = totalb + 1
        else
            if dist < 50 then
                totalzc = totalzc + 1
            end
            totalz = totalz + 1
        end

    end

    -- ADJUST cooldowns 
    if BWOPopControl.Police.Cooldown > 0 then
        BWOPopControl.Police.Cooldown = BWOPopControl.Police.Cooldown - 1
    end
    if BWOPopControl.SWAT.Cooldown > 0 then
        BWOPopControl.SWAT.Cooldown = BWOPopControl.SWAT.Cooldown - 1
    end
    if BWOPopControl.Security.Cooldown > 0 then
        BWOPopControl.Security.Cooldown = BWOPopControl.Security.Cooldown - 1
    end
    if BWOPopControl.Medics.Cooldown > 0 then
        BWOPopControl.Medics.Cooldown = BWOPopControl.Medics.Cooldown - 1
    end

    -- ADJUST: people on the streets

    -- count currently active civs
    BWOPopControl.StreetsCnt = tab.Walker + tab.Runner + tab.Postal + tab.Gardener + tab.Janitor

    -- count desired population of civs
    local nominal = BWOPopControl.StreetsNominal
    local density = BanditScheduler.GetDensityScore(player, 120)
    local hourmod = getHourScore()
    local pop = nominal * density * hourmod
    BWOPopControl.StreetsMax = pop

    -- count missing amount to spawn
    local missing = BWOPopControl.StreetsMax - BWOPopControl.StreetsCnt
    if missing > 20 then missing = 20 end
    if missing > 0 then
        BWOPopControl.StreetsSpawn(missing)
    elseif missing < 0 then
        local surplus = -missing
        BWOPopControl.StreetsDespawn(surplus)
    end

    -- ADJUST: inhabitants (civs in buildings)

    -- count currently active civs
    BWOPopControl.InhabitantsCnt = tab.Inhabitant

    -- count desired population of civs
    local nominal = BWOPopControl.InhabitantsNominal
    local density = BanditScheduler.GetDensityScore(player, 120)
    BWOPopControl.InhabitantsMax = nominal * density

    -- count missing amount to spawn
    local missing = BWOPopControl.InhabitantsMax - BWOPopControl.InhabitantsCnt
    if missing > 20 then missing = 20 end
    if missing > 0 then
        BWOPopControl.InhabitantsSpawn(missing)
    elseif missing < 0 then
        local surplus = -missing
        BWOPopControl.InhabitantsDespawn(surplus)
    end
    
    -- ADJUST: survivors (first organized immune civs)
    -- count currently active civs
    BWOPopControl.SurvivorsCnt = tab.Looter

    -- count desired population of civs
    local nominal = BWOPopControl.SurvivorsNominal
    BWOPopControl.SurvivorsMax = nominal * (totalzc - 10)

    -- count missing amount to spawn
    local missing = BWOPopControl.SurvivorsMax - BWOPopControl.SurvivorsCnt
    if missing > 4 then missing = 4 end
    if missing > 0 then
        BWOPopControl.SurvivorsSpawn(missing)
    elseif missing < 0 then
        local surplus = -missing
        BWOPopControl.SurvivorsDespawn(surplus)
    end

    -- debug report:
    print ("----------- POPULATION STATS -----------")
    print ("WORLD AGE: " .. BWOScheduler.WorldAge .. " SYMPTOM LVL:" .. BWOScheduler.SymptomLevel)
    print ("INHAB: " .. BWOPopControl.InhabitantsCnt .. "/" .. BWOPopControl.InhabitantsMax)
    print ("STREET: " .. BWOPopControl.StreetsCnt .. "/" .. BWOPopControl.StreetsMax)
    print ("SURVIVOR: " .. BWOPopControl.SurvivorsCnt .. "/" .. BWOPopControl.SurvivorsMax)
    print ("ZOMBIE: " .. totalz .. "/" .. BWOPopControl.ZombieMax)
    print ("Total B/Z: " .. totalb .. "/" .. totalz)

    print ("----------------------------------------")

end

BWOPopControl.UpdateZombie = function(numTicks)
    if numTicks % 2 == 0 then
        BWOPopControl.Zombie()
    end
end

BWOPopControl.CheckHostility = function(bandit, attacker)

    if not attacker then return end

    -- attacking zombies is ok!
    if not bandit:getVariableBoolean("Bandit") then return end

    -- killing bandits is ok!
    local brain = BanditBrain.Get(bandit)
    if brain.clan > 1 then return end

    -- to weak to respond
    -- local infection = Bandit.GetInfection(bandit)
    -- if infection > 0 then return end

    -- who saw this changes program
    local witnessList = BanditZombie.GetAllB()
    for id, witness in pairs(witnessList) do
        if not witness.brain.hostile then
            local dist = math.sqrt(math.pow(bandit:getX() - witness.x, 2) + math.pow(bandit:getY() - witness.y, 2))
            if dist < 12 then
                local actor = BanditZombie.GetInstanceById(witness.id)
                if actor:CanSee(bandit) then

                    local params ={}
                    params.x = bandit:getX()
                    params.y = bandit:getY()
                    params.z = bandit:getZ()

                    -- attacking by player retaliation is handled by main Bandits mod, here we just want to call hostile cops additionally
                    -- theifs are exception, they spawn technically as friendy so attacking them here should not trigger enemy, but friendly cops
                    if instanceof(attacker, "IsoPlayer") and attacker:getDisplayName() == getPlayer():getDisplayName() and brain.program.name ~= "Thief" then
                        local outfit = bandit:getOutfitName()
                        if outfit == "Police" then
                            if BWOPopControl.SWAT.On then
                                params.hostile = true
                                BWOScheduler.Add("CallSWAT", params, 19500)
                            end
                        else
                            if BWOPopControl.Police.On then
                                params.hostile = true
                                BWOScheduler.Add("CallCops", params, 12000)
                            end
                        end

                    else
                        -- call friendly police
                        if BWOPopControl.Police.On then
                            params.hostile = false
                            BWOScheduler.Add("CallCops", params, 12000)
                        end
                    end

                    -- witnessing civilians need to change peaceful behavior to active
                    local activatePrograms = {"Inhabitant", "Walker", "Runner", "Postal", "Janitor", "Gardener", "Entertainer"}
                    for _, prg in pairs(activatePrograms) do
                        if witness.brain.program.name == prg then 
                            Bandit.SetProgram(actor, "Active", {})
                            local brain = BanditBrain.Get(actor)
                            if brain then
                                local syncData = {}
                                syncData.id = brain.id
                                syncData.hostile = brain.hostile
                                syncData.program = brain.program
                                Bandit.ForceSyncPart(actor, syncData)
                            end
                        end
                    end
                end
            end
        end
    end
end

BWOPopControl.OnHitZombie = function(zombie, attacker, bodyPartType, handWeapon)
    BWOPopControl.CheckHostility(zombie, attacker)
end

BWOPopControl.OnZombieDead = function(zombie)
    local attacker = zombie:getAttackedBy()
    BWOPopControl.CheckHostility(zombie, attacker)

    -- register dead body
    local args = {x=zombie:getX(), y=zombie:getY(), z=zombie:getZ()}
    sendClientCommand(getPlayer(), 'Commands', 'DeadBodyAdd', args)

    local params ={}
    params.x = zombie:getX()
    params.y = zombie:getY()
    params.z = zombie:getZ()
    params.hostile = false

    if BWOPopControl.Medics.On then
        BWOScheduler.Add("CallMedics", params, 15000)
    elseif BWOPopControl.Hazmats.On then
        BWOScheduler.Add("CallHazmats", params, 15500)
    end
end

BWOPopControl.OnNewFire = function(fire)
    local params ={}
    params.x = fire:getX()
    params.y = fire:getY()
    params.z = fire:getZ()
    params.hostile = true
    BWOScheduler.Add("CallFireman", params, 4800)
end

Events.EveryOneMinute.Add(BWOPopControl.UpdateCivs)
Events.OnTick.Add(BWOPopControl.UpdateZombie)
Events.OnHitZombie.Add(BWOPopControl.OnHitZombie)
Events.OnZombieDead.Add(BWOPopControl.OnZombieDead)
Events.OnNewFire.Add(BWOPopControl.OnNewFire)

