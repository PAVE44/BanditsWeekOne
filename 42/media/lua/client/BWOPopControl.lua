BWOPopControl = BWOPopControl or {}

-- population control
BWOPopControl.ZombieMax = 0
BWOPopControl.ZombieCnt = 1000

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
    local zombieList = BanditZombie.CacheLightZ
    local gmd = GetBanditModData()

    --[[
    local ccnt = 0
    for k, v in pairs(gmd.Queue) do
        ccnt = ccnt + 1
    end]]

    local cnt = 0
    local zcnt = 0
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
            zcnt = zcnt + 1
        end
    end
    BWOPopControl.ZombieCnt = zcnt
end

-- npc on streets spawner
BWOPopControl.StreetsSpawn = function(cnt)
    local player = getSpecificPlayer(0)
    if not player then return end

    local cell = player:getCell()
    local cm = getWorld():getClimateManager()
    local rainIntensity = cm:getRainIntensity()
    local px, py = player:getX(), player:getY()

    local args = {
        size = 1
    }

    for i = 1, cnt do
        local x = 35 + ZombRand(25)
        local y = 35 + ZombRand(25)
        
        if ZombRand(2) == 1 then x = -x end
        if ZombRand(2) == 1 then y = -y end

        local square = cell:getGridSquare(px + x, py + y, 0)
        if square then
            if square:isOutside() and not BWOSquareLoader.IsInExclusion(square:getX(), square:getY()) then
                
                args.x = square:getX()
                args.y = square:getY()
                args.z = square:getZ()

                local zombieType = ItemPickerJava.getSquareZombiesType(square)
                if zombieType and zombieType == "Army" then
                    args.cid = "d2860ee6-7e18-4132-ad42-8fb3a34ea499" -- army green
                    args.program = "Patrol"
                else
                    
                    local rnd = ZombRand(100)
                    if rnd < 4 then
                        args.cid = "bd53300c-f715-4cf7-a91f-1836a2282944"
                        args.program = "Runner"
                    elseif rnd < 8 then 
                        args.cid = "e216b4ea-e57f-4b15-8cd8-140b82e7b5ea"
                        args.program = "Postal"
                    elseif rnd < 13 then 
                        args.cid = "76e0eb48-ee72-45ac-9b1b-56a66f597235"
                        args.program = "Gardener"
                    elseif rnd < 16 then 
                        args.cid = "e195497c-9a14-4c1f-b15a-b8227d15a682" 
                        args.program = "Janitor"
                    elseif rnd < 17 then
                        args.cid = "72fbcd15-a81b-476a-8c25-1b2caea694de"
                        args.program = "Vandal"
                    else
                        if rainIntensity > 0.02 then
                            args.cid = "c167d1e0-c077-4ee5-b353-88b374de193d" -- walker rain fixme 
                        else
                            args.cid = "c167d1e0-c077-4ee5-b353-88b374de193d" -- walker fixme 
                        end

                        args.program = "Walker"
                    end
                end

                sendClientCommand(player, 'Spawner', 'Clan', args)
            end
        end
    end
end

-- npc on streets despawner
BWOPopControl.StreetsDespawn = function(cnt)
    local player = getSpecificPlayer(0)
    if not player then return end

    local cell = player:getCell()
    local px = player:getX()
    local py = player:getY()

    local removePrg = {"Walker", "Runner", "Postal", "Entertainer", "Janitor", "Medic", "Gardener", "Vandal"}
    local zombieList = BanditUtils.GetAllBanditByProgram(removePrg)

    local i = 0
    for k, zombie in pairs(zombieList) do
        local zx = zombie.x
        local zy = zombie.y
        local dist = BanditUtils.DistTo(px, py, zx, zy)
        
        if dist > 50 then
            local zombieObj = BanditZombie.GetInstanceById(zombie.id)
            zombieObj:removeFromSquare()
            zombieObj:removeFromWorld()
            args = {}
            args.id = zombie.id
            sendClientCommand(player, 'Commands', 'BanditRemove', args)
            i = i + 1
            if i >= cnt then break end
        end
    end
end

-- npcs in buildings spawner
BWOPopControl.InhabitantsSpawn = function(cnt)

    local ts = getTimestampMs()

    local player = getSpecificPlayer(0)
    if not player then return end

    local event = {}
    event.hostile = false
    event.occured = false
    event.program = {}
    event.program.name = "Inhabitant"
    event.program.stage = "Prepare"

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
            
            if not BWOBuildings.IsEventBuilding(building, "home") and not BWOBuildings.IsRecentlyVisited(building) then
                
                if def:getZ() >=0 and math.abs(def:getX() - player:getX()) < 100 and math.abs(def:getX2() - player:getX()) < 100 and 
                math.abs(def:getY() - player:getY()) < 100 and math.abs(def:getY2() - player:getY()) < 100 then

                    local roomSize = BWORooms.GetRoomSize(room)
                    local popMod = 1 -- lags: BWORooms.GetRoomPopMod(room)
                    if popMod > 0 then
                        local cursorStart = cursor
                        cursor = cursor + math.floor(roomSize ^ 1.2)
                        table.insert(roomPool, {room=room, cursorStart=cursorStart, cursorEnd=cursor})
                    end
                end
                
            end
            
        end
    end

    -- now spawn
    for i = 1, cnt do
        local rnd = ZombRand(cursor)
        for _, rp in pairs(roomPool) do
            if rnd >= rp.cursorStart and rnd < rp.cursorEnd then
                local spawnRoom = rp.room

                local occupantsCnt = BWORooms.GetRoomCurrPop(rp.room)
                local occupantsMax = BWORooms.GetRoomMaxPop(rp.room)

                if occupantsCnt < occupantsMax then

                    local spawnRoomDef = spawnRoom:getRoomDef()
                    if spawnRoomDef then
                        local spawnSquare = spawnRoomDef:getFreeSquare()
                        if spawnSquare and not spawnSquare:getZombie() and not spawnSquare:isOutside() and spawnSquare:isFree(false) and BanditCompatibility.HaveRoofFull(spawnSquare) and not BWOSquareLoader.IsInExclusion(spawnSquare:getX(), spawnSquare:getY()) then
                            event.x = spawnSquare:getX()
                            event.y = spawnSquare:getY()
                            event.z = spawnSquare:getZ()
                            local dist = BanditUtils.DistTo(px, py, event.x, event.y)
                            if dist > 30 and dist < 80 then
                                event.bandits = {}
                                local bandit
                                --[[local zombieType = ItemPickerJava.getSquareZombiesType(spawnSquare)
                                if zombieType then
                                    bandit = BanditCreator.MakeFromZombieZone(zombieType)
                                end]]

                                if not bandit then
                                    bandit = BanditCreator.MakeFromRoom(spawnRoom)
                                end

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

    -- print ("--------------- IS: " .. getTimestampMs() - ts)
end

-- npcs in buildings despawner
BWOPopControl.InhabitantsDespawn = function(cnt)
    local player = getSpecificPlayer(0)
    if not player then return end

    local cell = player:getCell()
    local px = player:getX()
    local py = player:getY()

    local removePrg = {"Inhabitant", "Medic", "Janitor", "Entertainer"}
    local zombieList = BanditUtils.GetAllBanditByProgram(removePrg)

    local i = 0
    for k, zombie in pairs(zombieList) do
        local zx = zombie.x
        local zy = zombie.y
        local dist = BanditUtils.DistTo(px, py, zx, zy)
        
        if dist > 50 then
            local zombieObj = BanditZombie.GetInstanceById(zombie.id)
            zombieObj:removeFromSquare()
            zombieObj:removeFromWorld()
            args = {}
            args.id = zombie.id
            sendClientCommand(player, 'Commands', 'BanditRemove', args)
            i = i + 1
            if i >= cnt then break end
        end
    end
end

-- survivors spawner
BWOPopControl.SurvivorsSpawn = function(missing)

    local player = getSpecificPlayer(0)
    if not player then return end

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
    local player = getSpecificPlayer(0)
    if not player then return end

    local cell = player:getCell()
    local px = player:getX()
    local py = player:getY()

    local removePrg = {"Survivor"}
    local zombieList = BanditUtils.GetAllBanditByProgram(removePrg)

    local i = 0
    for k, zombie in pairs(zombieList) do
        local zx = zombie.x
        local zy = zombie.y
        local dist = BanditUtils.DistTo(px, py, zx, zy)
        
        if dist > 50 then
            local zombieObj = BanditZombie.GetInstanceById(zombie.id)
            zombieObj:removeFromSquare()
            zombieObj:removeFromWorld()
            args = {}
            args.id = zombie.id
            sendClientCommand(player, 'Commands', 'BanditRemove', args)
            i = i + 1
            if i >= cnt then break end
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

    local ts = getTimestampMs()

    local player = getSpecificPlayer(0)
    if not player then return end

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
    tab.Patrol = 0
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
    BWOPopControl.InhabitantsNominal = 80
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
        BWOPopControl.ZombieMax = 3
    elseif BWOScheduler.WorldAge >= 120 and BWOScheduler.WorldAge < 128 then -- occasional zombies
        BWOPopControl.ZombieMax = 8
    elseif BWOScheduler.WorldAge == 128  then -- outbreak
        BWOPopControl.ZombieMax = 70
        BWOPopControl.StreetsNominal = 53
        BWOPopControl.InhabitantsNominal = 50
    elseif BWOScheduler.WorldAge == 129 then 
        BWOPopControl.ZombieMax = 70
        BWOPopControl.StreetsNominal = 56
        BWOPopControl.InhabitantsNominal = 40
        BWOPopControl.SurvivorsNominal = 2
    elseif BWOScheduler.WorldAge == 130 then
        BWOPopControl.ZombieMax = 70
        BWOPopControl.StreetsNominal = 59
        BWOPopControl.InhabitantsNominal = 30
        BWOPopControl.SurvivorsNominal = 3
    elseif BWOScheduler.WorldAge == 131 then
        BWOPopControl.ZombieMax = 70
        BWOPopControl.StreetsNominal = 62
        BWOPopControl.InhabitantsNominal = 15
        BWOPopControl.SurvivorsNominal = 5
    elseif BWOScheduler.WorldAge == 132 then
        BWOPopControl.ZombieMax = 70
        BWOPopControl.StreetsNominal = 55
        BWOPopControl.InhabitantsNominal = 15
        BWOPopControl.SurvivorsNominal = 8
    elseif BWOScheduler.WorldAge >= 133 and BWOScheduler.WorldAge < 170 then
        BWOPopControl.ZombieMax = 1000
        BWOPopControl.InhabitantsNominal = 4
        BWOPopControl.StreetsNominal = 1
        BWOPopControl.SurvivorsNominal = 6
    elseif BWOScheduler.WorldAge >= 169 then
        BWOPopControl.ZombieMax = 1000
        BWOPopControl.SurvivorsNominal = 0
        BWOPopControl.InhabitantsNominal = 0
        BWOPopControl.StreetsNominal = 0
    end
    
    -- ADJUST: people on the streets

    -- count currently active civs
    BWOPopControl.StreetsCnt = tab.Walker + tab.Runner + tab.Patrol + tab.Postal + tab.Gardener + tab.Janitor + tab.Entertainer + tab.Vandal

    -- count desired population of civs
    local nominal = BWOPopControl.StreetsNominal
    -- local density = BanditScheduler.GetDensityScore(player, 120) * 1.4
    local density = BWOBuildings.GetDensityScore(player, 120) / 8000
    if density > 2.5 then density = 2.5 end
    local hourmod = getHourScore()
    local pop = nominal * density * hourmod * SandboxVars.BanditsWeekOne.StreetsPopMultiplier
    BWOPopControl.StreetsMax = pop
    
    -- count missing amount to spawn
    -- ts = getTimestampMs()
    local missing = BWOPopControl.StreetsMax - BWOPopControl.StreetsCnt
    if missing > 20 then missing = 20 end
    if missing >= 1 then
        BWOPopControl.StreetsSpawn(missing)
    elseif missing < 0 then
        local surplus = -missing
        BWOPopControl.StreetsDespawn(surplus)
    end
    -- print ("POPCONTROL STREET: " .. (getTimestampMs() - ts))
    -- ADJUST: inhabitants (civs in buildings)
    
    -- count currently active civs
    BWOPopControl.InhabitantsCnt = tab.Inhabitant

    -- count desired population of civs
    local nominal = BWOPopControl.InhabitantsNominal
    -- local density = BanditScheduler.GetDensityScore(player, 120) * 1.2
    BWOPopControl.InhabitantsMax = nominal * SandboxVars.BanditsWeekOne.InhabitantsPopMultiplier

    -- count missing amount to spawn
    --ts = getTimestampMs()
    local missing = BWOPopControl.InhabitantsMax - BWOPopControl.InhabitantsCnt
    if missing > 20 then missing = 20 end
    if missing >= 1 then
        BWOPopControl.InhabitantsSpawn(missing)
    elseif missing < 0 then
        local surplus = -missing
        BWOPopControl.InhabitantsDespawn(surplus)
    end
    --print ("POPCONTROL INHAB: " .. (getTimestampMs() - ts))
    
    -- ADJUST: survivors (first organized immune civs)
    -- count currently active civs
    BWOPopControl.SurvivorsCnt = tab.Survivor

    -- count desired population of civs
    local nominal = BWOPopControl.SurvivorsNominal
    BWOPopControl.SurvivorsMax = nominal

    -- count missing amount to spawn
    --ts = getTimestampMs()
    local missing = BWOPopControl.SurvivorsMax - BWOPopControl.SurvivorsCnt
    if missing > 4 then missing = 4 end
    if missing >= 1 then
        BWOPopControl.SurvivorsSpawn(missing)
    elseif missing < 0 then
        local surplus = -missing
        BWOPopControl.SurvivorsDespawn(surplus)
    end
    --print ("POPCONTROL SURV: " .. (getTimestampMs() - ts))
    
    -- debug report:
    if isDebugEnabled() or isAdmin() then
        print ("----------- POPULATION STATS -----------")
        print ("WORLD AGE: " .. BWOScheduler.WorldAge .. "(" .. ((BWOScheduler.WorldAge+9) * 60) .. ")" .. " SYMPTOM LVL:" .. BWOScheduler.SymptomLevel)
        print ("INHAB: " .. BWOPopControl.InhabitantsCnt .. "/" .. BWOPopControl.InhabitantsMax)
        print ("STREET: " .. BWOPopControl.StreetsCnt .. "/" .. BWOPopControl.StreetsMax)
        print ("SURVIVOR: " .. BWOPopControl.SurvivorsCnt .. "/" .. BWOPopControl.SurvivorsMax)
        print ("ZOMBIE: " .. totalz .. "/" .. BWOPopControl.ZombieMax)
        print ("DENSITY SCORE:" .. density)
        print ("----------------------------------------")
    end

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

    local isInCircle = function(x, y, cx, cy, r)
        local d2 = (x - cx) ^ 2 + (y - cy) ^ 2
        return d2 <= r ^ 2
    end

    if not bandit:getVariableBoolean("Bandit") then return end

    if BWOScheduler.World.PostNuclearFallout then
        local outfit = bandit:getOutfitName()
        local gmd = GetBWOModData()
        local nukes = gmd.Nukes
        for _, nuke in pairs(nukes) do
            if isInCircle(bandit:getX(), bandit:getY(), nuke.x, nuke.y, nuke.r) then
                if bandit:getZ() >= 0 and outfit ~= "HazardSuit" then
                    if bandit:isOutside() then
                        bandit:setHealth(bandit:getHealth() - 0.0020)
                    else
                        bandit:setHealth(bandit:getHealth() - 0.0010)
                    end
                end
                break
            end
        end
    end
end

Events.EveryOneMinute.Add(everyOneMinute)
Events.OnTick.Add(onTick)
Events.OnZombieUpdate.Add(OnBanditUpdate)