BWOEvents = BWOEvents or {}

BWOEvents.tab = {}

-- these is a set of various event functions that are triggered by time based on a schedule

local isInCircle = function(x, y, cx, cy, r)
    local d2 = (x - cx) ^ 2 + (y - cy) ^ 2
    return d2 <= r ^ 2
end

local findVehicleSpot2 = function(sx, sy)
    local player = getPlayer()
    local px = player:getX()
    local py = player:getY()
    local metaGrid = getWorld():getMetaGrid()
    local rmin = 20
    local rmax = 65
    local cell = getCell()
    for x=sx-rmax, sx+rmax, 5 do
        for y=sy-rmax, sy+rmax, 5 do
            if isInCircle(x, y, sx, sy, rmax) then
                local zone = metaGrid:getZoneAt(x, y, 0)
                if zone then
                    local zoneType = zone:getType()
                    if zoneType == "Nav" then
                        local dist = BanditUtils.DistToManhattan(x, y, px, py)
                        if dist > rmin then
                            local square = getCell():getGridSquare(x, y, 0)
                            if square then
                                local gt = BanditUtils.GetGroundType(square)
                                if gt == "street" then
                                    local allFree = true
                                    for dx=x-4, x+4 do
                                        for dy=y-4, y+4 do
                                            local dsquare = getCell():getGridSquare(dx, dy, 0)
                                            if dsquare then
                                                if not square:isFree(false) or square:getVehicleContainer() then
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

local addBoomBox = function(x, y, z, cassette)
    local cell = getCell()
    local square = cell:getGridSquare(x, y, z)
    if not square then return end

    local surfaceOffset = BanditUtils.GetSurfaceOffset(x, y, z)
    local radioItem = square:AddWorldInventoryItem("Tsarcraft.TCBoombox", 0.5, 0.5, surfaceOffset)

    local radio = IsoRadio.new(cell, square, getSprite(TCMusic.WorldMusicPlayer[radioItem:getFullType()]))
    square:AddTileObject(radio)
    radio:getModData().tcmusic = {}
    radio:getModData().tcmusic.itemid = x .. y .. z
    radio:getModData().tcmusic.deviceType = "IsoObject"
    radio:getModData().tcmusic.isPlaying = false
    radio:getModData().RadioItemID = radioItem:getID() .. "tm"
    radio:getDeviceData():setIsTurnedOn(false)
    radio:getDeviceData():setPower(radioItem:getDeviceData():getPower())
    radio:getDeviceData():setDeviceVolume(radioItem:getDeviceData():getDeviceVolume())
    if radioItem:getDeviceData():getIsBatteryPowered() and radioItem:getDeviceData():getHasBattery() then
        radio:getDeviceData():setPower(radioItem:getDeviceData():getPower())
    else
        radio:getDeviceData():setHasBattery(false)
    end

    -- local cassetteItem = InventoryItemFactory.CreateItem("Tsarcraft.CassetteDepecheModePersonalJesus(1989)")
    local cassetteItem = InventoryItemFactory.CreateItem(cassette)
    radio:getModData().tcmusic.mediaItem = cassetteItem:getType()
    radio:transmitModData()

    if isClient() then 
        radio:transmitCompleteItemToServer(); 
    end
end

local arrivalSound = function(x, y, sound)
    local player = getPlayer()
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
    emitter:playSound(sound)
end

BWOEvents.CallCops = function(params)
    if BWOPopControl.Police.Cooldown > 0 then return end

    local x, y = findVehicleSpot2(params.x, params.y)
    if not x or not y then return end

    local args = {type="Base.PickUpVanLightsPolice", x=x, y=y, engine=true, lights=true, lightbar=true}
    sendClientCommand(getPlayer(), 'Commands', 'VehicleSpawn', args)
    arrivalSound(x, y, "ZSPoliceCar1")

    config = {}
    config.clanId = 0
    config.hasRifleChance = 0
    config.hasPistolChance = 100
    config.rifleMagCount = 0
    config.pistolMagCount = 3

    local event = {}
    event.hostile = params.hostile
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
            
    sendClientCommand(getPlayer(), 'Commands', 'SpawnGroup', event)

    local vparams = {}
    vparams.lightbar = true
    BWOScheduler.Add("VehiclesUpdate", vparams, 500)

    if SandboxVars.Bandits.General_ArrivalIcon then
        local icon = "media/ui/sheriff.png"
        local color
        if event.hostile then
            color = {r=1, g=0, b=0} -- red
        else
            color = {r=0, g=1, b=0} -- green
        end
        BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, params.x, params.y, color)
    end

    BWOPopControl.Police.Cooldown = 100
end

BWOEvents.CallSWAT = function(params)
    if BWOPopControl.SWAT.Cooldown > 0 then return end

    local x, y = findVehicleSpot2(params.x, params.y)
    if not x or not y then return end

    local args = {type="Base.PickUpVanLightsPolice", x=x, y=y, engine=true, lights=true, lightbar=true}
    sendClientCommand(getPlayer(), 'Commands', 'VehicleSpawn', args)
    arrivalSound(x, y, "ZSPoliceCar1")

    config = {}
    config.clanId = 0
    config.hasRifleChance = 100
    config.hasPistolChance = 100
    config.rifleMagCount = 4
    config.pistolMagCount = 3

    local event = {}
    event.hostile = params.hostile
    event.occured = false
    event.program = {}
    event.program.name = "Bandit"
    event.program.stage = "Prepare"
    event.x = x + 6
    event.y = y + 6
    event.bandits = {}
            
    local bandit = BanditCreator.MakeFromWave(config)
    bandit.outfit = "ZSPoliceSpecialOps"
    bandit.accuracyBoost = 1.3
    bandit.femaleChance = 0
    bandit.weapons.melee = "Base.Nightstick"

    table.insert(event.bandits, bandit)
    table.insert(event.bandits, bandit)
    table.insert(event.bandits, bandit)
    table.insert(event.bandits, bandit)
    table.insert(event.bandits, bandit)
    table.insert(event.bandits, bandit)
            
    sendClientCommand(getPlayer(), 'Commands', 'SpawnGroup', event)

    local vparams = {}
    vparams.lightbar = true
    BWOScheduler.Add("VehiclesUpdate", vparams, 500)

    BWOPopControl.SWAT.Cooldown = 300
end

BWOEvents.CallMedics = function(params)
    if BWOPopControl.Medics.Cooldown > 0 then return end

    local x, y = findVehicleSpot2(params.x, params.y)
    if not x or not y then return end

    local args = {type="Base.VanAmbulance", x=x, y=y, engine=true, lights=true, lightbar=true}
    sendClientCommand(getPlayer(), 'Commands', 'VehicleSpawn', args)
    arrivalSound(x, y, "ZSPoliceCar1")

    config = {}
    config.clanId = 0
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
            
    local bandit1 = BanditCreator.MakeFromWave(config)
    bandit1.outfit = "Doctor"
    bandit1.weapons.melee = "Base.Scalpel"
    table.insert(event.bandits, bandit1)

    local bandit2 = BanditCreator.MakeFromWave(config)
    bandit2.outfit = "AmbulanceDriver"
    bandit2.weapons.melee = "Base.Scalpel"
    table.insert(event.bandits, bandit2)

            
    sendClientCommand(getPlayer(), 'Commands', 'SpawnGroup', event)
    
    local vparams = {}
    vparams.lightbar = true
    BWOScheduler.Add("VehiclesUpdate", vparams, 500)

    BWOPopControl.Medics.Cooldown = 80
end

BWOEvents.CallHazmats = function(params)

    if BWOPopControl.Hazmats.Cooldown > 0 then return end

    local x, y = findVehicleSpot2(params.x, params.y)
    if not x or not y then return end

    local args = {type="Base.VanAmbulance", x=x, y=y, engine=true, lights=true, lightbar=true}
    sendClientCommand(getPlayer(), 'Commands', 'VehicleSpawn', args)
    arrivalSound(x, y, "ZSPoliceCar1")

    config = {}
    config.clanId = 0
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
            
    sendClientCommand(getPlayer(), 'Commands', 'SpawnGroup', event)

    local vparams = {}
    vparams.lightbar = true
    BWOScheduler.Add("VehiclesUpdate", vparams, 500)

    BWOPopControl.Hazmats.Cooldown = 100
end

BWOEvents.CallFireman = function(params)
    if BWOPopControl.Fireman.Cooldown > 0 then return end

    local x, y = findVehicleSpot2(params.x, params.y)
    if not x or not y then return end

    local args = {type="Base.PickUpTruckLightsFire", x=x, y=y, engine=true, lights=true, lightbar=true}
    sendClientCommand(getPlayer(), 'Commands', 'VehicleSpawn', args)
    arrivalSound(x, y, "ZSPoliceCar1")

    config = {}
    config.clanId = 0
    config.hasRifleChance = 0
    config.hasPistolChance = 0
    config.rifleMagCount = 0
    config.pistolMagCount = 0

    local event = {}
    event.hostile = false
    event.occured = false
    event.program = {}
    event.program.name = "Fireman"
    event.program.stage = "Prepare"
    event.x = x + 6
    event.y = y + 6
    event.bandits = {}
            
    local bandit = BanditCreator.MakeFromWave(config)
    bandit.outfit = "FiremanFullSuit"

    table.insert(event.bandits, bandit)
    table.insert(event.bandits, bandit)
    table.insert(event.bandits, bandit)
            
    sendClientCommand(getPlayer(), 'Commands', 'SpawnGroup', event)

    local vparams = {}
    vparams.lightbar = true
    BWOScheduler.Add("VehiclesUpdate", vparams, 500)

    if SandboxVars.Bandits.General_ArrivalIcon then
        local icon = "media/ui/crew.png"
        local color = {r=1, g=0, b=0} -- red
        BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, x, y, color)
    end

    BWOPopControl.Fireman.Cooldown = 60
end

BWOEvents.Siren = function(params)
    local emitter = getWorld():getFreeEmitter(params.x + 10, params.y - 20, 0)
    emitter:playAmbientSound("DOSiren2")
    emitter:setVolumeAll(0.9)
    addSound(getPlayer(), params.x, params.y, params.z, 150, 100)
end

BWOEvents.ChopperAlert = function(params)
    BanditPlayer.WakeEveryone()
    local emitter = getWorld():getFreeEmitter(params.x, params.y, 0)
    emitter:playAmbientSound(params.sound)
    emitter:setVolumeAll(0.9)
    addSound(getPlayer(), params.x, params.y, params.z, 150, 100)
end

BWOEvents.VehiclesUpdate = function(params)
    local vehicleList = getCell():getVehicles()
    
    for i=0, vehicleList:size()-1 do
        local vehicle = vehicleList:get(i)
        if vehicle then

            if params.headlights then
                vehicle:setHeadlightsOn(true)
            end
            
            if params.lightbar then
                if vehicle:hasLightbar() then
                    local mode = vehicle:getLightbarLightsMode()
                    if mode == 0 then
                        vehicle:setLightbarLightsMode(3)
                        -- vehicle:setLightbarSirenMode(2)
                    end
                end
            end

            if params.alarm  then
                if not vehicle:hasLightbar() then
                    addSound(getPlayer(), vehicle:getX(), vehicle:getY(), vehicle:getZ(), 150, 100)
                    BanditPlayer.WakeEveryone()
                    vehicle:setAlarmed(true)
                    vehicle:triggerAlarm()
                end
            end
        end
    end
end

BWOEvents.Arson = function(params)

    local building = BWOBuildings.FindBuildingDist(35, 50)
    if building then

        local room = building:getRandomRoom()
        if room then
            local square = room:getRandomSquare()
            if square then
                explode(square:getX(), square:getY())
                local vparams = {}
                vparams.alarm = true
                BWOScheduler.Add("VehiclesUpdate", vparams, 500)

                if SandboxVars.Bandits.General_ArrivalIcon then
                    local icon = "media/ui/arson.png"
                    local color = {r=1, g=0, b=0} -- red
                    BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, square:getX(), square:getY(), color)
                end
            end
        end
    end
end

BWOEvents.Protest = function(params)
    local args = {x=params.x, y=params.y, z=params.z, otype="protest"}
    sendClientCommand(getPlayer(), 'Commands', 'ObjectAdd', args)

    if SandboxVars.Bandits.General_ArrivalIcon then
        local icon = "media/ui/protests.png"
        local color = {r=0, g=1, b=0} -- red
        BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, params.x, params.y, color)
    end
end

BWOEvents.RegisterBase = function(params)
    local player = getPlayer()
    local building = player:getBuilding()
    if building then
        local buildingDef = building:getDef()
        local x = buildingDef:getX()
        local y = buildingDef:getY()
        local x2 = buildingDef:getX2()
        local y2 = buildingDef:getY2()

        local args = {x=x, y=y, x2=x2, y2=y2}
        sendClientCommand(player, 'Commands', 'BaseUpdate', args)

        if SandboxVars.Bandits.General_ArrivalIcon and params.icon then
            local icon = "media/ui/defend.png"
            local color = {r=0.5, g=1, b=0.5} -- GREEN
            BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, (x + x2) / 2, (y + y2) / 2, color)
        end
    end
end

BWOEvents.GetStartInventory = function(params)
    local player = getPlayer()
    local building = player:getBuilding()
    if building then
        local buildingDef = building:getDef()
        local keyId = buildingDef:getKeyId()

        local item = InventoryItemFactory.CreateItem("Base.Key2")
        item:setKeyId(keyId)
        item:setName("Home Key")
        player:getInventory():AddItem(item)
    end

    for i=1, 12 + ZombRand(10) do
        local item = InventoryItemFactory.CreateItem("Base.Money")
        player:getInventory():AddItem(item)
    end
end

BWOEvents.EventEntertainer = function(params)
    local player = getPlayer()

    config = {}
    config.clanId = 0
    config.hasRifleChance = 0
    config.hasPistolChance = 0
    config.rifleMagCount = 0
    config.pistolMagCount = 0

    local event = {}
    event.hostile = false
    event.occured = false
    event.program = {}
    event.program.name = "Entertainer"
    event.program.stage = "Prepare"

    local spawnPoint = BanditScheduler.GenerateSpawnPoint(player, ZombRand(28,35))
    if spawnPoint then
        event.x = spawnPoint.x
        event.y = spawnPoint.y
        event.bandits = {}
        
        local bandit = BanditCreator.MakeFromWave(config)

        local rnd = ZombRand(10)
        -- rnd = 9
        if rnd == 0 then
            -- bandit.outfit = "AuthenticBiker"
            -- bandit.femaleChance = 50
            -- bandit.weapons.melee = "Base.GuitarElectricRed"
            bandit.outfit = "Priest"
            bandit.femaleChance = 0
        elseif rnd == 1 then
            bandit.outfit = "Dean"
            bandit.femaleChance = 0
            bandit.weapons.melee = "Base.GuitarElectricBassBlack"
        elseif rnd == 2 then
            -- bandit.outfit = "Rocker"
            -- bandit.femaleChance = 0
            -- bandit.weapons.melee = "Base.GuitarAcoustic"
            bandit.outfit = "Priest"
            bandit.femaleChance = 0
        elseif rnd == 3 then
            bandit.outfit = "Joan"
            bandit.femaleChance = 100
            bandit.weapons.melee = "Base.Violin"
        elseif rnd == 4 then
            bandit.outfit = "John"
            bandit.femaleChance = 0
            bandit.weapons.melee = "Base.Saxophone"
        elseif rnd == 5 then
            -- bandit.outfit = "Duke"
            -- bandit.femaleChance = 0
            -- bandit.weapons.melee = "Base.Flute"
            bandit.outfit = "Priest"
            bandit.femaleChance = 0
        elseif rnd == 6 then
            bandit.outfit = "Young"
            bandit.femaleChance = 0
            local cassette = "Tsarcraft.CassetteBanditBreakdance01"
            addBoomBox(event.x, event.y, 0, cassette)
        elseif rnd == 7 then
            bandit.outfit = "AuthenticClown"
            bandit.femaleChance = 0
        elseif rnd == 8 then
            bandit.outfit = "AuthenticClownObese"
            bandit.femaleChance = 0
        elseif rnd == 9 then
            bandit.outfit = "Priest"
            bandit.femaleChance = 0
        end

        table.insert(event.bandits, bandit)
        sendClientCommand(player, 'Commands', 'SpawnGroup', event)

        if SandboxVars.Bandits.General_ArrivalIcon then
            local icon = "media/ui/friend.png"
            local color = {r=1, g=0.7, b=0.8} -- pink
            BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, event.x, event.y, color)
        end
    end
end

BWOEvents.EventBuildingParty = function(params)
    local player = getPlayer()

    local house = BWOBuildings.FindBuildingType("residential")
    if not house then return end

    local cell = player:getCell()
    local def = house:getDef()
    local id = def:getKeyId()

    -- replace light and find what we need
    local boombox
    local counter
    local fridge
    local otable
    local bx = def:getX()
    local bx2 = def:getX2()
    local by = def:getY()
    local by2 = def:getY2()
    for x=bx, bx2 do
        for y=by, by2 do
            local square = cell:getGridSquare(x, y, 0)
            if square then
                local room = square:getRoom()
                if room then
                    local roomName = room:getName()
                    local objects = square:getObjects()
                    for i=0, objects:size()-1 do
                        local object = objects:get(i)
                        if instanceof(object, "IsoLightSwitch") then
                            local lightList = object:getLights()
                            if lightList:size() > 0 then
                                object:setBulbItemRaw("Base.LightBulbRed")
                                object:setPrimaryR(1)
                                object:setPrimaryG(0)
                                object:setPrimaryB(0)
                                object:setActive(true)
                            end
                        end
                        if roomName ~= "bathroom" and roomName ~= "bedroom" then
                            local sprite = object:getSprite()
                            if sprite then
                                local props = sprite:getProperties()
                                if props:Is("CustomName") then
                                    local name = props:Val("CustomName")
                                    if name == "Boombox" then
                                        boombox = object
                                    elseif name == "Low Table" then
                                        counter = object
                                    elseif name == "Counter" then
                                        counter = object
                                    elseif name == "Oak Round Table" then
                                        counter = object
                                    elseif name == "Light Round Table" then
                                        counter = object
                                    elseif name == "Table" then
                                        otable = object
                                    elseif name == "Fridge" then
                                        fridge = object
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    if not counter then return end

    -- add boombox
    local square = counter:getSquare()
    if not boombox then
        local cassette = BanditUtils.Choice({"Tsarcraft.CassetteBanditParty01", "Tsarcraft.CassetteBanditParty02", "Tsarcraft.CassetteBanditParty03", "Tsarcraft.CassetteBanditParty04", "Tsarcraft.CassetteBanditParty05"})
        addBoomBox(square:getX(), square:getY(), square:getZ(), cassette)
    end

    -- add beer to fridge
    if fridge then
        local container = fridge:getContainerByType("fridge")
        if container then
            for i=1, 20 + ZombRand(10) do
                local item = container:AddItem("Base.BeerBottle")
                if item then
                    container:addItemOnServer(item)
                end
            end
        end
    end

    -- add pizza on table
    if otable then
        local tableSquare = otable:getSquare()
        local surfaceOffset = BanditUtils.GetSurfaceOffset(tableSquare:getX(), tableSquare:getY(), tableSquare:getZ())
        local item1 = InventoryItemFactory.CreateItem("Base.PizzaWhole")
        tableSquare:AddWorldInventoryItem(item1, 0.6, 0.6, surfaceOffset)
        
        local item2 = InventoryItemFactory.CreateItem("Base.Base.Wine2")
        tableSquare:AddWorldInventoryItem(item2, 0.2, 0.2, surfaceOffset)
    end

    local args = {id=id, event="party"}
    sendClientCommand(player, 'Commands', 'EventBuildingAdd', args)

    -- inhabitants
    local event = {}
    event.hostile = false
    event.occured = false
    event.program = {}
    event.program.name = "Inhabitant"
    event.program.stage = "Prepare"
    local room = square:getRoom()
    local roomDef = room:getRoomDef()
    local pop = 8
    for i=1, pop do
        local spawnSquare = roomDef:getFreeSquare()
        if spawnSquare then
            event.x = spawnSquare:getX()
            event.y = spawnSquare:getY()
            event.z = spawnSquare:getZ()
            event.bandits = {}
            local bandit = BanditCreator.MakeFromRoom(room)

            if bandit then
                if ZombRand(2) == 0 then
                    bandit.outfit = BanditUtils.Choice({"StripperBlack", "StripperNaked", "StripperPink", "AuthenticSexyBunny", "AuthenticSexyNurse", "DressShort", "Naked", "Party", "AuthenticRaveGirl", "AuthenticNightClub"})
                    bandit.femaleChance = 100
                else
                    bandit.outfit = BanditUtils.Choice({"Thug", "Party", "Young", "Stripper", "PoliceStripper", "FiremanStripper", "Naked", "AuthenticNightClub"})
                    bandit.femaleChance = 0
                end

                table.insert(event.bandits, bandit)
                sendClientCommand(player, 'Commands', 'SpawnGroup', event)
            end
        end
    end

    -- marker
    if SandboxVars.Bandits.General_ArrivalIcon then
        local icon = "media/ui/defend.png"
        local color = {r=1, g=0.7, b=0.8} -- PINK
        BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, (bx + bx2) / 2, (by + by2) / 2, color)
    end
end

BWOEvents.FixVehicles = function(params)
    local player = getPlayer()
    local cell = player:getCell()
    local vehicleList = cell:getVehicles()
    for i=0, vehicleList:size()-1 do
        local vehicle = vehicleList:get(i)
        local scriptName = vehicle:getScriptName()
        if scriptName:embodies("Burnt") or scriptName:embodies("Smashed") then
            if isClient() then
                sendClientCommand(player, "vehicle", "remove", { vehicle = vehicle:getId() })
            else
                vehicle:permanentlyRemove()
            end
        else
            vehicle:repair()
        end
    end
end

BWOEvents.Defenders = function(params)
    local player = getPlayer()
    BanditScheduler.SpawnDefenders(player, 50, 70)
end

--spawn groups

BWOEvents.Thieves = function(params)
    local player = getPlayer()

    local base = BanditPlayerBase.GetBase(player)
    if not base then return end

    config = {}
    config.clanId = 13
    config.hasRifleChance = 0
    config.hasPistolChance = 70
    config.rifleMagCount = 0
    config.pistolMagCount = 2

    local event = {}
    event.hostile = false
    event.occured = false
    event.program = {}
    event.program.name = "Thief"
    event.program.stage = "Prepare"

    local spawnPoint = BanditScheduler.GenerateSpawnPoint(player, ZombRand(40,45))
    if spawnPoint then
        event.x = spawnPoint.x
        event.y = spawnPoint.y
        event.bandits = {}
        
        local bandit = BanditCreator.MakeFromWave(config)
        local intensity = params.intensity
        if intensity > 0 then
            for i=1, intensity do
                table.insert(event.bandits, bandit)
            end
            sendClientCommand(player, 'Commands', 'SpawnGroup', event)
        end

        if SandboxVars.Bandits.General_ArrivalIcon then
            local icon = "media/ui/thief.png"
            local color = {r=1, g=1, b=0.5} -- yellow
            BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, event.x, event.y, color)
        end

        if SandboxVars.Bandits.General_ArrivalWakeUp then
            BanditPlayer.WakeEveryone()
        end
    end
end

BWOEvents.PoliceRiot = function(params)
    local player = getPlayer()

    config = {}
    config.clanId = 6
    config.hasRifleChance = 100
    config.hasPistolChance = 100
    config.rifleMagCount = 6
    config.pistolMagCount = 4

    local event = {}
    event.hostile = false
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
        bandit.femaleChance = 0
        local intensity = params.intensity
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

BWOEvents.Criminals = function(params)
    local player = getPlayer()

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
    event.program.name = "Bandit"
    event.program.stage = "Prepare"

    local spawnPoint = BanditScheduler.GenerateSpawnPoint(player, ZombRand(40,45))
    if spawnPoint then
        event.x = spawnPoint.x
        event.y = spawnPoint.y
        event.bandits = {}
        
        local bandit = BanditCreator.MakeFromWave(config)
        local intensity = params.intensity
        if intensity > 0 then
            for i=1, intensity do
                table.insert(event.bandits, bandit)
            end
            sendClientCommand(player, 'Commands', 'SpawnGroup', event)
        end

        if SandboxVars.Bandits.General_ArrivalIcon then
            local icon = "media/ui/raid.png"
            local color = {r=1, g=0.5, b=0} -- orange
            BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, event.x, event.y, color)
        end
    end
end

BWOEvents.Bandits = function(params)
    local player = getPlayer()

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
    event.program.name = "Bandit"
    event.program.stage = "Prepare"

    local spawnPoint = BanditScheduler.GenerateSpawnPoint(player, ZombRand(40,45))
    if spawnPoint then
        event.x = spawnPoint.x
        event.y = spawnPoint.y
        event.bandits = {}
        
        local bandit = BanditCreator.MakeFromWave(config)
        local intensity = params.intensity
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

BWOEvents.Bikers = function(params)
    local player = getPlayer()

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
        local intensity = params.intensity
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

BWOEvents.Inmates = function(params)
    local player = getPlayer()

    config = {}
    config.clanId = 5
    config.hasRifleChance = 10
    config.hasPistolChance = 50
    config.rifleMagCount = 2
    config.pistolMagCount = 2

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
        local intensity = 14
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

BWOEvents.Asylum = function(params)
    local player = getPlayer()

    config = {}
    config.clanId = 2
    config.hasRifleChance = 0
    config.hasPistolChance = 0
    config.rifleMagCount = 0
    config.pistolMagCount = 0

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
        local intensity = 16
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

