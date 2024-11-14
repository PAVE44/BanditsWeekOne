BWOEvents = BWOEvents or {}

BWOEvents.tab = {}

local findVehicleSpot = function(player)
    for x=player:getX()-40, player:getX()+40 do
        for y=player:getY()-40, player:getY()+40 do
            if (x<-20 or x>20) and (y<-20 or y>20) then
                local square = getCell():getGridSquare(x, y, 0)
                if square and square:isFree(false) then
                    local gt = BanditUtils.GetGroundType(square)
                    if gt == "street" then
                        return x, y
                    end
                end
            end
        end
    end
    return nil, nil
end

local function isInCircle(x, y, cx, cy, r)
    local d2 = (x - cx) ^ 2 + (y - cy) ^ 2
    return d2 <= r ^ 2
end

local findVehicleSpot2 = function(player)
    local px = player:getX()
    local py = player:getY()
    local metaGrid = getWorld():getMetaGrid()
    local rmin = 35
    local rmax = 65
    local cell = player:getCell()
    for x=px-rmax, px+rmax, 5 do
        for y=py-rmax, py+rmax, 5 do
            if isInCircle(x, y, px, py, rmax) and not isInCircle(x, y, px, py, rmin) then
                local zone = metaGrid:getZoneAt(x, y, 0)
                if zone then
                    local zoneType = zone:getType()
                    if zoneType == "Nav" then
                        local square = getCell():getGridSquare(x, y, 0)
                        if square then
                            local gt = BanditUtils.GetGroundType(square)
                            if gt == "street" then
                                local allFree = true
                                for dx=x-4, x+4 do
                                    for dy=y-4, y+4 do
                                        local dsquare = getCell():getGridSquare(dx, dy, 0)
                                        if dsquare then
                                            if not square:isFree(false) then
                                                allFree = false
                                            end
                                        end
                                    end
                                end
                                if allFree then
                                    return x, y
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end


local callCops = function(hostile)

    if BWOPopControl.Police.Cooldown > 0 then return end

    local player = getPlayer()
    local x, y = findVehicleSpot2(player)

    if not x or not y then return end

    local args = {type="Base.PickUpVanLightsPolice", x=x, y=y, engine=true, lights=true, lightbar=true}
    sendClientCommand(player, 'Commands', 'VehicleSpawn', args)

    local arrivalSoundX
    local arrivalSoundY
    if x < player:getX() then 
        arrivalSoundX = player:getX() - 30
    else
        arrivalSoundX = player:getX() + 30
    end

    if y < player:getY() then 
        arrivalSoundY = player:getY() - 30
    else
        arrivalSoundY = player:getY() + 30
    end

    local emitter = getWorld():getFreeEmitter(arrivalSoundX, arrivalSoundY, 0)
    emitter:setVolumeAll(0.5)
    emitter:playSound("ZSPoliceCar1")

    local player = getPlayer()

    config = {}
    config.clanId = 1
    config.hasRifleChance = 0
    config.hasPistolChance = 100
    config.rifleMagCount = 0
    config.pistolMagCount = 3

    local event = {}
    event.hostile = hostile
    event.occured = false
    event.program = {}
    event.program.name = "Bandit"
    event.program.stage = "Prepare"
    event.x = x + 6
    event.y = y + 6
    event.bandits = {}
            
    local bandit = BanditCreator.MakeFromWave(config)
    bandit.outfit = "Police"
    bandit.accuracyBoost = 1.1
    bandit.weapons.melee = "Base.Nightstick"

    table.insert(event.bandits, bandit)
    table.insert(event.bandits, bandit)
            
    sendClientCommand(player, 'Commands', 'SpawnGroup', event)

    BWOPopControl.Police.Cooldown = 40
end

local callSWAT = function(hostile)

    if BWOPopControl.SWAT.Cooldown > 0 then return end

    local player = getPlayer()
    local x, y = findVehicleSpot2(player)

    if not x or not y then return end

    local args = {type="Base.PickUpVanLightsPolice", x=x, y=y, engine=true, lights=true, lightbar=true}
    sendClientCommand(player, 'Commands', 'VehicleSpawn', args)

    local arrivalSoundX
    local arrivalSoundY
    if x < player:getX() then 
        arrivalSoundX = player:getX() - 30
    else
        arrivalSoundX = player:getX() + 30
    end

    if y < player:getY() then 
        arrivalSoundY = player:getY() - 30
    else
        arrivalSoundY = player:getY() + 30
    end

    local emitter = getWorld():getFreeEmitter(arrivalSoundX, arrivalSoundY, 0)
    emitter:setVolumeAll(0.5)
    emitter:playSound("ZSPoliceCar1")

    local player = getPlayer()

    config = {}
    config.clanId = 1
    config.hasRifleChance = 100
    config.hasPistolChance = 100
    config.rifleMagCount = 4
    config.pistolMagCount = 3

    local event = {}
    event.hostile = hostile
    event.occured = false
    event.program = {}
    event.program.name = "Bandit"
    event.program.stage = "Prepare"
    event.x = x + 6
    event.y = y + 6
    event.bandits = {}
            
    local bandit = BanditCreator.MakeFromWave(config)
    bandit.outfit = "ZSPoliceSpecialOps"
    bandit.accuracyBoost = 1.2
    bandit.femaleChance = 0
    bandit.weapons.melee = "Base.Nightstick"

    table.insert(event.bandits, bandit)
    table.insert(event.bandits, bandit)
    table.insert(event.bandits, bandit)
    table.insert(event.bandits, bandit)
    table.insert(event.bandits, bandit)
    table.insert(event.bandits, bandit)
            
    sendClientCommand(player, 'Commands', 'SpawnGroup', event)

    BWOPopControl.SWAT.Cooldown = 120
end

local callMedics = function()

    if BWOPopControl.Medics.Cooldown > 0 then return end

    local player = getPlayer()
    local x, y = findVehicleSpot2(player)

    if not x or not y then return end

    local args = {type="Base.VanAmbulance", x=x, y=y, engine=true, lights=true, lightbar=true}
    sendClientCommand(player, 'Commands', 'VehicleSpawn', args)

    local arrivalSoundX
    local arrivalSoundY
    if x < player:getX() then 
        arrivalSoundX = player:getX() - 30
    else
        arrivalSoundX = player:getX() + 30
    end

    if y < player:getY() then 
        arrivalSoundY = player:getY() - 30
    else
        arrivalSoundY = player:getY() + 30
    end

    local emitter = getWorld():getFreeEmitter(arrivalSoundX, arrivalSoundY, 0)
    emitter:setVolumeAll(0.5)
    emitter:playSound("ZSPoliceCar1")

    local player = getPlayer()

    config = {}
    config.clanId = 1
    config.hasRifleChance = 0
    config.hasPistolChance = 0
    config.rifleMagCount = 0
    config.pistolMagCount = 0

    local event = {}
    event.hostile = false
    event.occured = false
    event.program = {}
    event.program.name = "Medic"
    event.program.stage = "Prepare"
    event.x = x + 6
    event.y = y + 6
    event.bandits = {}
            
    local bandit = BanditCreator.MakeFromWave(config)
    bandit.outfit = "Doctor"
    bandit.weapons.melee = "Base.Scalpel"

    table.insert(event.bandits, bandit)
    table.insert(event.bandits, bandit)
            
    sendClientCommand(player, 'Commands', 'SpawnGroup', event)

    BWOPopControl.Medics.Cooldown = 35
end

local callHazmats = function()

    if BWOPopControl.Hazmats.Cooldown > 0 then return end

    local player = getPlayer()
    local x, y = findVehicleSpot2(player)

    if not x or not y then return end

    local args = {type="Base.VanAmbulance", x=x, y=y, engine=true, lights=true, lightbar=true}
    sendClientCommand(player, 'Commands', 'VehicleSpawn', args)

    local arrivalSoundX
    local arrivalSoundY
    if x < player:getX() then 
        arrivalSoundX = player:getX() - 30
    else
        arrivalSoundX = player:getX() + 30
    end

    if y < player:getY() then 
        arrivalSoundY = player:getY() - 30
    else
        arrivalSoundY = player:getY() + 30
    end

    local emitter = getWorld():getFreeEmitter(arrivalSoundX, arrivalSoundY, 0)
    emitter:setVolumeAll(0.5)
    emitter:playSound("ZSPoliceCar1")

    local player = getPlayer()

    config = {}
    config.clanId = 1
    config.hasRifleChance = 0
    config.hasPistolChance = 100
    config.rifleMagCount = 0
    config.pistolMagCount = 3

    local event = {}
    event.hostile = false
    event.occured = false
    event.program = {}
    event.program.name = "Medic"
    event.program.stage = "Prepare"
    event.x = x + 6
    event.y = y + 6
    event.bandits = {}
            
    local bandit = BanditCreator.MakeFromWave(config)
    bandit.outfit = "HazardSuit"
    bandit.weapons.melee = "Base.Scalpel"

    table.insert(event.bandits, bandit)
    table.insert(event.bandits, bandit)
    table.insert(event.bandits, bandit)
            
    sendClientCommand(player, 'Commands', 'SpawnGroup', event)

    BWOPopControl.Hazmats.Cooldown = 40
end

local explode = function(x, y)
    
    local sounds = {"BurnedObjectExploded", "FlameTrapExplode", "SmokeBombExplode", "PipeBombExplode", "DOExploClose1", "DOExploClose2", "DOExploClose3", "DOExploClose4", "DOExploClose5", "DOExploClose6", "DOExploClose7", "DOExploClose8"}
        
    local function getSound()
        return sounds[1 + ZombRand(#sounds)]
    end
    
    local player = getPlayer()

    -- bomb sound
    local sound = getSound()
    local emitter = getWorld():getFreeEmitter(x, y, 0)
    emitter:playSound(sound)
    emitter:setVolumeAll(0.9)
    addSound(player, x, y, 0, 120, 100)

    -- wake up players
    BanditPlayer.WakeEveryone()
    
    -- explosion and fire
    local square = getCell():getGridSquare(x, y, 0)
    if not square then return end

    if isClient() then
        local args = {x=x, y=y, z=0}
        sendClientCommand('object', 'addExplosionOnSquare', args)
    else
        IsoFireManager.explode(getCell(), square, 100)
    end
    
    -- blast tex
    local effect = {}
    effect.x = square:getX()
    effect.y = square:getY()
    effect.z = square:getZ()
    effect.offset = 320
    effect.name = "explobig"
    effect.frameCnt = 17
    if isClient() then
        sendClientCommand(getPlayer(), 'Commands', 'AddEffect', effect)
    else
        table.insert(BWOEffects.tab, effect)
    end
    
    -- light blast
    local colors = {r=1.0, g=0.5, b=0.5}
    local lightSource = IsoLightSource.new(x, y, 0, colors.r, colors.g, colors.b, 60, 10)
    getCell():addLamppost(lightSource)
                
    local lightLevel = square:getLightLevel(0)
    if lightLevel < 0.95 and player:isOutside() then
        local px = player:getX()
        local py = player:getY()
        local sx = square:getX()
        local sy = square:getY()

        local dx = math.abs(px - sx)
        local dy = math.abs(py - sy)

        local tex
        local dist = math.sqrt(math.pow(sx - px, 2) + math.pow(sy - py, 2))
        if dist > 40 then dist = 40 end

        if dx > dy then
            if sx > px then
                tex = "e"
            else
                tex = "w"
            end
        else
            if sy > py then
                tex = "s"
            else
                tex = "n"
            end
        end

        BWOTex.tex = getTexture("media/textures/blast_" .. tex .. ".png")
        BWOTex.speed = 0.05
        local alpha = 1.2 - (dist / 40)
        if alpha > 1 then alpha = 1 end
        BWOTex.alpha = alpha
    end
    
    -- junk placement
    BanditBaseGroupPlacements.Junk (x-4, y-4, 0, 6, 8, 3)

    -- damage to zombies, players are safe
    local fakeItem = InventoryItemFactory.CreateItem("Base.RollingPin")
    local cell = getCell()
    for dx=x-3, x+5 do
        for dy=y-3, y+4 do
            local square = cell:getGridSquare(dx, dy, 0)
            if square then
                if ZombRand(4) == 1 then
                    BanditBasePlacements.IsoObject("floors_burnt_01_1", dx, dy, 0)
                end
                local zombie = square:getZombie()
                if zombie then
                    zombie:Hit(fakeItem, cell:getFakeZombieForHit(), 50, false, 1, false)
                end
            end
        end
    end
end

BWOEvents.CallCops = function()
    callCops(false)
    BWOScheduler.Add("VehiclesLightBar", 500)
end

BWOEvents.CallCopsHostile = function()
    callCops(true)
    BWOScheduler.Add("VehiclesLightBar", 500)
end

BWOEvents.CallSWAT = function()
    callSWAT(true)
    BWOScheduler.Add("VehiclesLightBar", 500)
end

BWOEvents.CallSWATHostile = function()
    callSWAT(true)
    BWOScheduler.Add("VehiclesLightBar", 500)
end

BWOEvents.CallMedics = function()
    callMedics()
    BWOScheduler.Add("VehiclesLightBar", 500)
end

BWOEvents.CallHazmats = function()
    callHazmats()
    BWOScheduler.Add("VehiclesLightBar", 500)
end

BWOEvents.ChopperAlert = function(player)
    --getCell():getGridSquare(player:getX()-10, player:getY()-10, 0):playSound("DOChopper")
    BanditPlayer.WakeEveryone()
    local emitter = getWorld():getFreeEmitter(player:getX(), player:getY(), 0)
    emitter:playAmbientSound("DOChopper")
    emitter:setVolumeAll(0.9)
    addSound(player, player:getX(), player:getY(), player:getZ(), 150, 100)
end

BWOEvents.VehiclesLightBar = function(player)
    local vehicleList = getCell():getVehicles()
    
    for i=0, vehicleList:size()-1 do
        local vehicle = vehicleList:get(i)
        if vehicle then
            vehicle:setHeadlightsOn(true)
            addSound(player, vehicle:getX(), vehicle:getY(), vehicle:getZ(), 150, 100)
            BanditPlayer.WakeEveryone()
            if vehicle:hasLightbar() then
                local mode = vehicle:getLightbarLightsMode()
                if mode == 0 then
                    vehicle:setLightbarLightsMode(3)
                    -- vehicle:setLightbarSirenMode(2)
                end
            end
        end
    end
end

BWOEvents.VehiclesAlarm = function(player)
    local vehicleList = getCell():getVehicles()
    
    for i=0, vehicleList:size()-1 do
        local vehicle = vehicleList:get(i)
        if vehicle and not vehicle:isEngineRunning() then
            addSound(player, vehicle:getX(), vehicle:getY(), vehicle:getZ(), 150, 100)
            BanditPlayer.WakeEveryone()
            if not vehicle:hasLightbar() then
                vehicle:setAlarmed(true)
                vehicle:triggerAlarm()
            end
        end
    end
end

BWOEvents.Arson = function(player)

    local building = BTWOBuildings.FindBuildingDist(35, 50)
    if building then

        local room = building:getRandomRoom()
        local square = room:getRandomSquare()
        if square then
            explode(square:getX(), square:getY())
            BWOScheduler.Add("VehiclesAlarm", 500)
            if SandboxVars.Bandits.General_ArrivalIcon then
                local icon = "media/ui/loot.png"
                local color = {r=1, g=0.5, b=0} -- orange
                BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, square:getX(), square:getY(), color)
            end
        end
    end

end

BWOEvents.PoliceRiot = function(player)
    config = {}
    config.clanId = 1
    config.hasRifleChance = 100
    config.hasPistolChance = 100
    config.rifleMagCount = 6
    config.pistolMagCount = 4

    local event = {}
    event.hostile = true
    event.occured = false
    event.program = {}
    event.program.name = "Looter"
    event.program.stage = "Prepare"

    local spawnPoint = BanditScheduler.GenerateSpawnPoint(player, ZombRand(40,45))
    if spawnPoint then
        event.x = spawnPoint.x
        event.y = spawnPoint.y
        event.bandits = {}
        
        local bandit = BanditCreator.MakeFromWave(config)
        bandit.outfit = BanditUtils.Choice({"ZSPoliceSpecialOps", "PoliceRiot"})
        bandit.accuracyBoost = 1.1
        bandit.femaleChance = 0
        local intensity = 7
        if intensity > 0 then
            for i=1, intensity do
                table.insert(event.bandits, bandit)
            end
            sendClientCommand(player, 'Commands', 'SpawnGroup', event)
        end

        if SandboxVars.Bandits.General_ArrivalIcon then
            local icon = "media/ui/raid.png"
            local color = {r=0, g=1, b=0} -- orange
            BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, event.x, event.y, color)
        end
    end
end

BWOEvents.Defenders = function(player)
    BanditScheduler.SpawnDefenders(player, 50, 70)
end

BWOEvents.Criminals = function(player)
    config = {}
    config.clanId = 4
    config.hasRifleChance = 0
    config.hasPistolChance = 50
    config.rifleMagCount = 2
    config.pistolMagCount = 3

    local event = {}
    event.hostile = true
    event.occured = false
    event.program = {}
    event.program.name = "Looter"
    event.program.stage = "Prepare"

    local spawnPoint = BanditScheduler.GenerateSpawnPoint(player, ZombRand(40,45))
    if spawnPoint then
        event.x = spawnPoint.x
        event.y = spawnPoint.y
        event.bandits = {}
        
        local bandit = BanditCreator.MakeFromWave(config)
        local intensity = 3
        if intensity > 0 then
            for i=1, intensity do
                table.insert(event.bandits, bandit)
            end
            sendClientCommand(player, 'Commands', 'SpawnGroup', event)
        end

        if SandboxVars.Bandits.General_ArrivalIcon then
            local icon = "media/ui/loot.png"
            local color = {r=1, g=0.5, b=0} -- orange
            BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, event.x, event.y, color)
        end
    end
end

BWOEvents.Bandits = function(player)
    config = {}
    config.clanId = 13
    config.hasRifleChance = 20
    config.hasPistolChance = 75
    config.rifleMagCount = 3
    config.pistolMagCount = 4

    local event = {}
    event.hostile = true
    event.occured = false
    event.program = {}
    event.program.name = "Looter"
    event.program.stage = "Prepare"

    local spawnPoint = BanditScheduler.GenerateSpawnPoint(player, ZombRand(40,45))
    if spawnPoint then
        event.x = spawnPoint.x
        event.y = spawnPoint.y
        event.bandits = {}
        
        local bandit = BanditCreator.MakeFromWave(config)
        local intensity = 5
        if intensity > 0 then
            for i=1, intensity do
                table.insert(event.bandits, bandit)
            end
            sendClientCommand(player, 'Commands', 'SpawnGroup', event)
        end

        if SandboxVars.Bandits.General_ArrivalIcon then
            local icon = "media/ui/loot.png"
            local color = {r=1, g=0.5, b=0} -- orange
            BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, event.x, event.y, color)
        end
    end
end

BWOEvents.Bandits = function(player)
    config = {}
    config.clanId = 9
    config.hasRifleChance = 0
    config.hasPistolChance = 100
    config.rifleMagCount = 0
    config.pistolMagCount = 3

    local event = {}
    event.hostile = true
    event.occured = false
    event.program = {}
    event.program.name = "Looter"
    event.program.stage = "Prepare"

    local spawnPoint = BanditScheduler.GenerateSpawnPoint(player, ZombRand(40,45))
    if spawnPoint then
        event.x = spawnPoint.x
        event.y = spawnPoint.y
        event.bandits = {}
        
        local bandit = BanditCreator.MakeFromWave(config)
        local intensity = 7
        if intensity > 0 then
            for i=1, intensity do
                table.insert(event.bandits, bandit)
            end
            sendClientCommand(player, 'Commands', 'SpawnGroup', event)
        end

        if SandboxVars.Bandits.General_ArrivalIcon then
            local icon = "media/ui/loot.png"
            local color = {r=1, g=0.5, b=0} -- orange
            BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, event.x, event.y, color)
        end
    end
end