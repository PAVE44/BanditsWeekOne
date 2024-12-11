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
        local x = 30 + ZombRand(20)
        local y = 30 + ZombRand(20)
        
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
                    if rnd < 4 then
                        bandit.outfit = BanditUtils.Choice({"StreetSports", "AuthenticJogger", "AuthenticFitnessInstructor"})
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
                        bandit.outfit = BanditUtils.Choice({"Hobbo"})
                        bandit.weapons.melee = "Base.Broom"
                        event.program.name = "Janitor"
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
            if math.abs(def:getX() - player:getX()) < 100 and math.abs(def:getX2() - player:getX()) < 100 and 
               math.abs(def:getY() - player:getY()) < 100 and math.abs(def:getY2() - player:getY()) < 100 then
                local roomSize = BWORooms.GetRoomSize(room)
                local popMod = BWORooms.GetRoomPopMod(room)
                cursor = cursor + math.floor(roomSize * popMod)
                table.insert(roomPool, {room=room, cursor=cursor})
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
                    if spawnSquare then
                        event.x = spawnSquare:getX()
                        event.y = spawnSquare:getY()
                        event.z = spawnSquare:getZ()
                        local dist = BanditUtils.DistTo(px, py, event.x, event.y)
                        if dist > 30 and dist < 50 then
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
    BWOPopControl.StreetsCnt = tab.Walker + tab.Runner + tab.Postal + tab.Gardener + tab.Janitor + tab.Entertainer

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
    BWOPopControl.InhabitantsMax = nominal * density * 1.5

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
    print ("Total B/Z: " .. totalb .. "/" .. totalz)

    print ("----------------------------------------")

end

-- controls npc reaction to player violence
BWOPopControl.CheckHostility = function(bandit, attacker)

    if not attacker then return end

    -- attacking zombies is ok!
    if not bandit:getVariableBoolean("Bandit") then return end

    -- killing bandits is ok!
    local brain = BanditBrain.Get(bandit)
    if brain.clan > 0 then return end

    -- to weak to respond
    -- local infection = Bandit.GetInfection(bandit)
    -- if infection > 0 then return end

    -- who saw this changes program
    local witnessList = BanditZombie.GetAllB()
    for id, witness in pairs(witnessList) do
        if not witness.brain.hostile then
            local dist = math.sqrt(math.pow(bandit:getX() - witness.x, 2) + math.pow(bandit:getY() - witness.y, 2))
            if dist < 15 then
                local actor = BanditZombie.GetInstanceById(witness.id)
                if actor:CanSee(bandit) then

                    local params = {}
                    params.x = bandit:getX()
                    params.y = bandit:getY()
                    params.z = bandit:getZ()

                    local wasPlayerFault = false
                    if instanceof(attacker, "IsoPlayer") and attacker:getDisplayName() == getPlayer():getDisplayName() and brain.clan == 0 and brain.program.name ~= "Thief" then
                        wasPlayerFault = true
                        if brain.id ~= id then
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
                        end
                    else
                        -- call friendly police
                        if BWOPopControl.Police.On then
                            params.hostile = false
                            BWOScheduler.Add("CallCops", params, 12000)
                        end
                    end

                    -- witnessing civilians need to change peaceful behavior to active
                    local activatePrograms = {"Police", "Inhabitant", "Walker", "Runner", "Postal", "Janitor", "Gardener", "Entertainer"}
                    for _, prg in pairs(activatePrograms) do
                        if witness.brain.program.name == prg then 
                            local outfit = actor:getOutfitName()
                            if outfit == "Police" then
                                Bandit.ClearTasks(actor)
                                Bandit.SetProgram(actor, "Police", {})
                                if wasPlayerFault then
                                    Bandit.SetHostile(actor, true)
                                end
                            else
                                if ZombRand(4) > 0 then
                                    Bandit.ClearTasks(actor)
                                    Bandit.SetProgram(actor, "Active", {})
                                    if wasPlayerFault and ZombRand(2) == 0 then
                                        Bandit.SetHostile(actor, true)
                                    end
                                    Bandit.Say(actor, "SPOTTED")
                                end
                            end

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

local everyOneMinute = function ()
    BWOPopControl.UpdateCivs()
end

local onTick = function(numTicks)
    if numTicks % 2 == 0 then
        BWOPopControl.Zombie()
    end
end

local onHitZombie = function(zombie, attacker, bodyPartType, handWeapon)
    BWOPopControl.CheckHostility(zombie, attacker)
end

local onZombieDead = function(zombie)

    if not zombie:getVariableBoolean("Bandit") then return end
        
    local bandit = zombie

    local attacker = bandit:getAttackedBy()
    if not attacker then
        attacker = bandit:getTarget()
    end

    BWOPopControl.CheckHostility(bandit, attacker)

    -- register dead body
    local args = {x=bandit:getX(), y=bandit:getY(), z=bandit:getZ()}
    sendClientCommand(getPlayer(), 'Commands', 'DeadBodyAdd', args)

    local params ={}
    params.x = bandit:getX()
    params.y = bandit:getY()
    params.z = bandit:getZ()
    params.hostile = false

    -- call medics
    if BWOPopControl.Medics.On then
        BWOScheduler.Add("CallMedics", params, 15000)
    elseif BWOPopControl.Hazmats.On then
        BWOScheduler.Add("CallHazmats", params, 15500)
    end

    -- deprovision bandit (bandit main function is no longer doing that for clan 0)
    Bandit.Say(bandit, "DEAD", true)

    local id = BanditUtils.GetCharacterID(bandit)
    local brain = BanditBrain.Get(bandit)

    bandit:setUseless(false)
    bandit:setReanim(false)
    bandit:setVariable("Bandit", false)
    bandit:setPrimaryHandItem(nil)
    bandit:clearAttachedItems()
    bandit:resetEquippedHandsModels()
    -- bandit:getInventory():clear()

    args = {}
    args.id = id
    sendClientCommand(getPlayer(), 'Commands', 'BanditRemove', args)
    BanditBrain.Remove(bandit)
end

local onNewFire = function(fire)
    local params ={}
    params.x = fire:getX()
    params.y = fire:getY()
    params.z = fire:getZ()
    params.hostile = true
    BWOScheduler.Add("CallFireman", params, 4800)

    local args = {x=params.x, y=params.y, z=params.z, otype="fire", ttl=BanditUtils.GetTime()+25000}
    sendClientCommand(getPlayer(), 'Commands', 'ObjectAdd', args)
end

Events.EveryOneMinute.Add(everyOneMinute)
Events.OnTick.Add(onTick)
Events.OnHitZombie.Add(onHitZombie)
Events.OnZombieDead.Add(onZombieDead)
Events.OnNewFire.Add(onNewFire)

