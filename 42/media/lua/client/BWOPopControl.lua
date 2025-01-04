BWOPopControl = BWOPopControl or {}

-- population control
BWOPopControl.ZombieMax = 0
BWOPopControl.ZombieCnt = 0

BWOPopControl.SurvivorsCnt = 0
BWOPopControl.SurvivorsNominal = 0
BWOPopControl.SurvivorsMax = 0

BWOPopControl.InhabitantsCnt = 0
BWOPopControl.InhabitantsNominal = 0 
BWOPopControl.InhabitantsMax = 0

BWOPopControl.StreetsCnt = 0
BWOPopControl.StreetsNominal = 0
BWOPopControl.StreetsMax = 0

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

-- zombie despawner
BWOPopControl.Zombie = function()
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
                -- fixme: zombie:canBeDeletedUnnoticed(float)
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

-- npc on streets spawner
BWOPopControl.StreetsSpawn = function(cnt)
    local player = getPlayer()
    local cell = player:getCell()
    local px, py = player:getX(), player:getY()

    config = {}
    config.clanId = 0
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
        local x = 35 + ZombRand(25)
        local y = 35 + ZombRand(25)
        
        if ZombRand(2) == 1 then x = -x end
        if ZombRand(2) == 1 then y = -y end

        local square = cell:getGridSquare(px + x, py + y, 0)
        if square then
            if square:isOutside() and not BWOSquareLoader.IsInExclusion(square:getX(), square:getY()) then
                local groundType = BanditUtils.GetGroundType(square) 
                if groundType == "street" then
                    event.x = square:getX()
                    event.y = square:getY()
                    local rnd = ZombRand(100)
                    if rnd < 4 then
                        bandit.outfit = BanditUtils.Choice({"StreetSports"})
                        event.program.name = "Runner"
                        event.program.stage = "Prepare"
                    elseif rnd < 8 then 
                        bandit.outfit = BanditUtils.Choice({"Postal"})
                        event.program.name = "Postal"
                        event.program.stage = "Prepare"
                    elseif rnd < 13 then 
                        bandit.outfit = BanditUtils.Choice({"Farmer"})
                        event.program.name = "Gardener"
                        event.program.stage = "Prepare"
                    elseif rnd < 16 then 
                        bandit.outfit = BanditUtils.Choice({"Sanitation"})
                        bandit.weapons.melee = "Base.Broom"
                        event.program.name = "Janitor"
                        event.program.stage = "Prepare"
                    elseif rnd < 17 then 
                        bandit.outfit = BanditUtils.Choice({"Bandit"})
                        bandit.weapons.melee = "Base.Crowbar"
                        event.program.name = "Vandal"
                        event.program.stage = "Prepare"
                    else
                        bandit.outfit = BanditUtils.Choice({"Generic05", "Generic04", "Generic03", "Generic02", "Generic01"})
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

-- npc on streets despawner
BWOPopControl.StreetsDespawn = function(cnt)
    local player = getPlayer()
    local cell = player:getCell()
    local px = player:getX()
    local py = player:getY()

    local removePrg = {"Walker", "Runner", "Postal", "Entertainer", "Janitor", "Medic", "Gardener", "Vandal"}
    local zombieList = cell:getZombieList()
    
    for i = 0, zombieList:size() - 1 do
        local zombie = zombieList:get(i)

        if zombie and zombie:getVariableBoolean("Bandit") then
            local brain = BanditBrain.Get(zombie)
            local prg = brain.program.name
            
            for _, prg in pairs(removePrg) do
                if prg == brain.program.name then
                    local zx = zombie:getX()
                    local zy = zombie:getY()
                    local dist = BanditUtils.DistTo(px, py, zx, zy)
                    
                    if dist > 50 then
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

-- npcs in buildings spawner
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

    -- the probability of spawn in a room will depend on room size and other factors
    local cursor = 0
    local roomPool = {}
    for i = 0, rooms:size() - 1 do
        local room = rooms:get(i)
        local def = room:getRoomDef()

        if def then
            local building = room:getBuilding()
            local buildingDef = building:getDef()
            buildingDef:setAlarmed(false)
            if not BWOBuildings.IsEventBuilding(building, "home") then
                if math.abs(def:getX() - player:getX()) < 100 and math.abs(def:getX2() - player:getX()) < 100 and 
                math.abs(def:getY() - player:getY()) < 100 and math.abs(def:getY2() - player:getY()) < 100 then
                    local roomSize = BWORooms.GetRoomSize(room)
                    local popMod = BWORooms.GetRoomPopMod(room)
                    cursor = cursor + math.floor(roomSize * popMod)
                    table.insert(roomPool, {room=room, cursor=cursor})
                end
            end
        end
    end

    -- now spawn
    for i = 1, cnt do
        local rnd = ZombRand(cursor)
        for _, rp in pairs(roomPool) do
            if rnd < rp.cursor then
                local spawnRoom = rp.room
                local spawnRoomDef = spawnRoom:getRoomDef()
                if spawnRoomDef then
                    local spawnSquare = spawnRoomDef:getFreeSquare()
                    if spawnSquare and spawnSquare:haveRoofFull() and not BWOSquareLoader.IsInExclusion(spawnSquare:getX(), spawnSquare:getY()) then
                        event.x = spawnSquare:getX()
                        event.y = spawnSquare:getY()
                        event.z = spawnSquare:getZ()
                        local dist = BanditUtils.DistTo(px, py, event.x, event.y)
                        if dist > 30 and dist < 80 then
                            event.bandits = {}
                            local bandit = BanditCreator.MakeFromRoom(spawnRoom)
                            if bandit then
                                table.insert(event.bandits, bandit)
                                sendClientCommand(player, 'Commands', 'SpawnGroup', event)
                                break
                            end
                        end
                    end
                end
            end
        end
    end
end

-- npcs in buildings despawner
BWOPopControl.InhabitantsDespawn = function(cnt)
    local player = getPlayer()
    local cell = player:getCell()
    local px = player:getX()
    local py = player:getY()

    local removePrg = {"Inhabitant", "Medic", "Janitor", "Entertainer"}
    local zombieList = cell:getZombieList()

    for i = 0, zombieList:size() - 1 do
        local zombie = zombieList:get(i)

        if zombie and zombie:getVariableBoolean("Bandit") then
            local brain = BanditBrain.Get(zombie)
            
            for _, prg in pairs(removePrg) do
                if prg == brain.program.name then
                    local zx = zombie:getX()
                    local zy = zombie:getY()
                    local dist = BanditUtils.DistTo(px, py, zx, zy)
                    
                    if dist > 50 then
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

-- survivors spawner
BWOPopControl.SurvivorsSpawn = function(missing)

    local player = getPlayer()

    config = {}
    config.clanId = 0
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

-- survivors despawner
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
                    
                    if dist > 50 then
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

-- controls numbers of overall populations and inits spawn / despawn procedures for various groups when necessary
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
    local totalz = 0 -- all zeds

    local tab = {}
    tab.Active = 0
    tab.ArmyGuard = 0
    tab.Bandit = 0
    tab.Entertainer = 0
    tab.Fireman = 0
    tab.Gardener = 0
    tab.Inhabitant = 0
    tab.Janitor = 0
    tab.Medic = 0
    tab.Police = 0
    tab.Postal = 0
    tab.RiotPolice = 0
    tab.Runner = 0
    tab.Survivor = 0
    tab.Vandal = 0
    tab.Walker = 0

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
        else
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

    -- ADJUST: population nominals
    BWOPopControl.ZombieMax = 0
    BWOPopControl.StreetsNominal = 50
    BWOPopControl.InhabitantsNominal = 50
    BWOPopControl.SurvivorsNominal = 0

    if BWOScheduler.WorldAge == 83 then -- occasional zombies
        BWOPopControl.ZombieMax = 1
    elseif BWOScheduler.WorldAge == 86 then -- occasional zombies
        BWOPopControl.ZombieMax = 1
    elseif BWOScheduler.WorldAge >= 91 and BWOScheduler.WorldAge < 94 then -- occasional zombies
        BWOPopControl.ZombieMax = 2
    elseif BWOScheduler.WorldAge >= 105 and BWOScheduler.WorldAge < 108 then -- occasional zombies
        BWOPopControl.ZombieMax = 3
    elseif BWOScheduler.WorldAge >= 114 and BWOScheduler.WorldAge < 117 then -- occasional zombies
        BWOPopControl.ZombieMax = 4
    elseif BWOScheduler.WorldAge >= 120 and BWOScheduler.WorldAge < 124 then -- occasional zombies
        BWOPopControl.ZombieMax = 4
    elseif BWOScheduler.WorldAge >= 136 and BWOScheduler.WorldAge < 138 then -- occasional zombies
        BWOPopControl.ZombieMax = 4
        BWOPopControl.StreetsNominal = 60
        BWOPopControl.InhabitantsNominal = 40
    elseif BWOScheduler.WorldAge == 148 then -- outbreak
        BWOPopControl.ZombieMax = 4
        BWOPopControl.StreetsNominal = 70
        BWOPopControl.InhabitantsNominal = 30
        BWOPopControl.SurvivorsNominal = 2
    elseif BWOScheduler.WorldAge == 149 then
        BWOPopControl.ZombieMax = 8
        BWOPopControl.StreetsNominal = 80
        BWOPopControl.InhabitantsNominal = 20
        BWOPopControl.SurvivorsNominal = 3
    elseif BWOScheduler.WorldAge == 150 then
        BWOPopControl.ZombieMax = 16
        BWOPopControl.StreetsNominal = 80
        BWOPopControl.InhabitantsNominal = 20
        BWOPopControl.SurvivorsNominal = 5
    elseif BWOScheduler.WorldAge == 151 then
        BWOPopControl.ZombieMax = 64
        BWOPopControl.StreetsNominal = 70
        BWOPopControl.InhabitantsNominal = 30
        BWOPopControl.SurvivorsNominal = 8
    elseif BWOScheduler.WorldAge >= 152 and BWOScheduler.WorldAge < 169 then
        BWOPopControl.ZombieMax = 80
        BWOPopControl.SurvivorsNominal = 5
    elseif BWOScheduler.WorldAge >= 169 then
        BWOPopControl.ZombieMax = 1000
        BWOPopControl.SurvivorsNominal = 0
        BWOPopControl.InhabitantsNominal = 0
        BWOPopControl.StreetsNominal = 0
    end
    
    -- ADJUST: people on the streets

    -- count currently active civs
    BWOPopControl.StreetsCnt = tab.Walker + tab.Runner + tab.Postal + tab.Gardener + tab.Janitor + tab.Entertainer + tab.Vandal

    -- count desired population of civs
    local nominal = BWOPopControl.StreetsNominal
    local density = BanditScheduler.GetDensityScore(player, 120) * 1.4
    local hourmod = getHourScore()
    local pop = nominal * density * hourmod * SandboxVars.BanditsWeekOne.StreetsPopMultiplier
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
    -- local density = BanditScheduler.GetDensityScore(player, 120) * 1.2
    BWOPopControl.InhabitantsMax = nominal * density * SandboxVars.BanditsWeekOne.InhabitantsPopMultiplier

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
    BWOPopControl.SurvivorsCnt = tab.Survivor

    -- count desired population of civs
    local nominal = BWOPopControl.SurvivorsNominal
    BWOPopControl.SurvivorsMax = nominal

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
    print ("WORLD AGE: " .. BWOScheduler.WorldAge .. "(" .. ((BWOScheduler.WorldAge+9) * 60) .. ")" .. " SYMPTOM LVL:" .. BWOScheduler.SymptomLevel)
    print ("INHAB: " .. BWOPopControl.InhabitantsCnt .. "/" .. BWOPopControl.InhabitantsMax)
    print ("STREET: " .. BWOPopControl.StreetsCnt .. "/" .. BWOPopControl.StreetsMax)
    print ("SURVIVOR: " .. BWOPopControl.SurvivorsCnt .. "/" .. BWOPopControl.SurvivorsMax)
    print ("ZOMBIE: " .. totalz .. "/" .. BWOPopControl.ZombieMax)
    print ("DENSITY SCORE:" .. density)
    print ("----------------------------------------")

end

local everyOneMinute = function()
    BWOPopControl.UpdateCivs()
end

local onTick = function(numTicks)
    
    if numTicks % 2 == 0 then
        BWOPopControl.Zombie()
    end
end

local OnBanditUpdate = function(bandit)
    if not bandit:getVariableBoolean("Bandit") then return end

    if BWOScheduler.World.PostNuclearFallout then
        local outfit = bandit:getOutfitName()
        if bandit:getZ() >= 0 and outfit ~= "HazardSuit" then
            if bandit:isOutside() then
                bandit:setHealth(bandit:getHealth() - 0.00020)
            else
                bandit:setHealth(bandit:getHealth() - 0.00010)
            end
        end
    end
end

Events.EveryOneMinute.Add(everyOneMinute)
Events.OnTick.Add(onTick)
Events.OnZombieUpdate.Add(OnBanditUpdate)