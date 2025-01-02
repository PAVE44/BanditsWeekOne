BWOEvents = BWOEvents or {}

-- these is a set of various event functions that are triggered by time based on a schedule

local isInCircle = function(x, y, cx, cy, r)
    local d2 = (x - cx) ^ 2 + (y - cy) ^ 2
    return d2 <= r ^ 2
end

local findVehicleSpot2 = function(sx, sy)
    local player = getPlayer()
    local px = player:getX()
    local py = player:getY()
    local rmin = 20
    local rmax = 65
    local cell = getCell()
    for x=sx-rmax, sx+rmax, 5 do
        for y=sy-rmax, sy+rmax, 5 do
            if isInCircle(x, y, sx, sy, rmax) then
                if BanditUtils.HasZoneType(x, y, 0, "Nav") then
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

local findBombSpot = function (px, py, outside)
    local x
    local y

    local miss = true
    if ZombRand(5) > 1 then
        -- find targets
        local zombieList = BanditZombie.GetAll()
        for by=-6, 6 do
            for bx=-6, 6 do
                local y1 = py + by * 6 - 3
                local y2 = py + by * 6 + 3
                local x1 = px + bx * 6 - 3
                local x2 = px + bx * 6 + 3
                
                local cnt = 0
                local killList = {}
                for id, zombie in pairs(zombieList) do
                    if zombie.x > x1 and zombie.x < x2 and zombie.y > y1 and zombie.y < y2 then
                        if not zombie.isBandit then
                            cnt = cnt + 1
                        end
                    end
                end
                if cnt > 4 then
                    miss = false
                    x = x1 - 2 + ZombRand(5)
                    y = y1 - 2 + ZombRand(5)
                    break
                end
            end
        end
    end

    -- if no targets then random miss
    if miss then
        local offset = 2
        local r = 88
        if outside then
            offset = 6  
            r = 55
        end

        local ox = offset + ZombRand(r)
        local oy = offset + ZombRand(r)

        if ZombRand(2) == 1 then ox = -ox end
        if ZombRand(2) == 1 then oy = -oy end

        x = px + ox
        y = py + oy
    end

    return x, y
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
    effect.name = "explo_big_01"
    effect.frameCnt = 17
    table.insert(BWOEffects.tab, effect)
    
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
        BWOTex.mode = "full"
        local alpha = 1.2 - (dist / 40)
        if alpha > 1 then alpha = 1 end
        BWOTex.alpha = alpha
    end
    
    -- junk placement
    BanditBaseGroupPlacements.Junk (x-4, y-4, 0, 6, 8, 3)

    -- damage to zombies, players are safe
    local fakeItem = instanceItem("Base.RollingPin")
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
    local cassetteItem = instanceItem(cassette)
    radio:getModData().tcmusic.mediaItem = cassetteItem:getType()
    radio:transmitModData()

    if isClient() then 
        radio:transmitCompleteItemToServer(); 
    end
end

local addRadio = function(x, y, z)
    local cell = getCell()
    local square = cell:getGridSquare(x, y, z)
    if not square then return end

    --local surfaceOffset = BanditUtils.GetSurfaceOffset(x, y, z)
    -- local radioItem = square:AddWorldInventoryItem("appliances_radio_01_0", 0.5, 0.5, surfaceOffset)

    local radio = IsoRadio.new(cell, square, getSprite("appliances_radio_01_0"))
    square:AddTileObject(radio)
    radio:getDeviceData():setIsTurnedOn(false)
    radio:getDeviceData():setPower(0.5)
    radio:getDeviceData():setDeviceVolume(4)
    radio:getDeviceData():setHasBattery(true)

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

local spawnVehicle = function(x, y, vtype)
    local cell = getCell()
    local square = getCell():getGridSquare(x, y, 0)
    if not square then return end

    local vehicle = addVehicleDebug(vtype, IsoDirections.S, nil, square)
    if not vehicle then return end

    for i = 0, vehicle:getPartCount() - 1 do
        local container = vehicle:getPartByIndex(i):getItemContainer()
        if container then
            container:removeAllItems()
        end
    end

    vehicle:getModData().BWO = {}
    vehicle:getModData().BWO.wasRepaired = true
    vehicle:repair()
    vehicle:setColor(0, 0, 0)
    vehicle:setGeneralPartCondition(80, 100)
    vehicle:putKeyInIgnition(vehicle:createVehicleKey())
    vehicle:tryStartEngine(true)
    vehicle:engineDoStartingSuccess()
    vehicle:engineDoRunning()
    vehicle:setHeadlightsOn(true)
    vehicle:setLightbarLightsMode(3)
end

-- params: [headlight(opt), lightbar(opt), alarm(opt)]
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

-- params: [x, y, sound]
BWOEvents.Sound = function(params)
    local emitter = getWorld():getFreeEmitter(params.x, params.y, 0)
    emitter:playAmbientSound(params.sound)
    emitter:setVolumeAll(1)
end

-- params: [x, y]
BWOEvents.Siren = function(params)
    local emitter = getWorld():getFreeEmitter(params.x + 10, params.y - 20, 0)
    emitter:playAmbientSound("DOSiren2")
    emitter:setVolumeAll(0.9)
    addSound(getPlayer(), params.x, params.y, params.z, 150, 100)
end

BWOEvents.SetHydroPower = function(params)
    getWorld():setHydroPowerOn(params.on)
    if params.on == false then
        local player = getPlayer()
        player:playSound("WorldEventElectricityShutdown")
    end
end

-- params: [x, y, sound]
BWOEvents.ChopperAlert = function(params)
    BanditPlayer.WakeEveryone()
    local emitter = getWorld():getFreeEmitter(params.x, params.y, 0)
    emitter:playAmbientSound(params.sound)
    emitter:setVolumeAll(0.9)
    addSound(getPlayer(), params.x, params.y, params.z, 150, 100)
end

-- params: [icon]
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
    end
end

-- params: []
BWOEvents.Start = function(params)
    local player = getPlayer()
    local building = player:getBuilding()
    if building then
        local buildingDef = building:getDef()
        local keyId = buildingDef:getKeyId()

        -- register player home
        local args = {id=keyId, event="home"}
        sendClientCommand(player, 'Commands', 'EventBuildingAdd', args)

        -- generate home key
        local item = instanceItem("Base.Key1")
        item:setKeyId(keyId)
        item:setName("Home Key")
        player:getInventory():AddItem(item)

        -- profession items
        local profession = player:getDescriptor():getProfession()
        local professionItemType
        if profession == "fireofficer" then
            professionItemType = "Base.Extinguisher"
        elseif profession == "mechanics" then
            professionItemType = "Base.Wrench"
        elseif profession == "lumberjack" then
            professionItemType = "Base.Woodaxe"
        elseif profession == "doctor" then
            professionItemType = "Base.Scalpel"
        elseif profession == "policeofficer" then
            professionItemType = "Base.Nightstick"
        end
        
        if professionItemType then
            local professionItem = instanceItem(professionItemType)
            player:getInventory():AddItem(professionItem)
        end

        -- show home icon
        if SandboxVars.Bandits.General_ArrivalIcon then
            local x = buildingDef:getX()
            local y = buildingDef:getY()
            local x2 = buildingDef:getX2()
            local y2 = buildingDef:getY2()

            local icon = "media/ui/defend.png"
            local color = {r=0.5, g=1, b=0.5} -- GREEN
            BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, (x + x2) / 2, (y + y2) / 2, color)
        end
    end

    -- give some starting cash
    for i=1, 25 + ZombRand(60) do
        local item = instanceItem("Base.Money")
        player:getInventory():AddItem(item)
    end
end

BWOEvents.StartDay = function(params)
    local player = getPlayer()
    player:playSound("ZSDayStart")
    
    BWOTex.tex = getTexture("media/textures/day_" .. params.day .. ".png")
    BWOTex.speed = 0.011
    BWOTex.mode = "center"
    BWOTex.alpha = 2.4
end

-- params: [x, y]
BWOEvents.Jets = function(params)
    local sound = "DOJet"

    local jet1 = {}
    jet1.x = params.x - 8
    jet1.y = params.y + 8
    jet1.sound = sound
    BWOScheduler.Add("Sound", jet1, 1)

    local jet2 = {}
    jet2.x = params.x + 8
    jet2.y = params.y - 8
    jet2.sound = sound
    BWOScheduler.Add("Sound", jet2, 300)
end

-- params: []
BWOEvents.Arson = function(params)
    local building = BWOBuildings.FindBuildingDist(getPlayer(), 35, 50)
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

-- params: [x, y, outside]
BWOEvents.BombDrop = function(params)
    local affectedZones = {}
    affectedZones.Forest = false
    affectedZones.DeepForest = false
    affectedZones.Nav = true
    affectedZones.Vegitation = false
    affectedZones.TownZone = true
    affectedZones.Ranch = false
    affectedZones.Farm = true
    affectedZones.TrailerPark = true
    affectedZones.ZombiesType = false
    affectedZones.FarmLand = false
    affectedZones.LootZone = true
    affectedZones.ZoneStory = true

    local function isAffectedZone(zoneType)
        for zt, zv in pairs(affectedZones) do
            if zoneType == zt and zv then return true end
        end

        return false
    end

    if BWOSquareLoader.IsInExclusion(params.x, params.y) then return end

    -- where it hits
    local x, y = findBombSpot(params.x, params.y, params.outside)

    -- strike only in urban area
    local zone = getWorld():getMetaGrid():getZoneAt(x, y, 0)
    if zone then
        local zoneType = zone:getType()
        if isAffectedZone(zoneType) then

            explode(x, y)

            -- junk placement
            BanditBaseGroupPlacements.Junk (x-4, y-4, 0, 6, 8, 3)

            -- damage to zombies, players are safe
            local fakeItem = instanceItem("Base.RollingPin")
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
    end
end

-- params: [x, y, intensity, outside]
BWOEvents.BombRun = function(params)
    local jets = {}

    if BWOSquareLoader.IsInExclusion(params.x, params.y) then return end

    jets.x = params.x
    jets.y = params.y
    BWOScheduler.Add("Jets", jets, 1)

    if not params.intensity then params.intensity = 4 end

    local d = 15000
    for i = 0, params.intensity do
        local bomb = {}
        bomb.x = params.x
        bomb.y = params.y
        bomb.outside = params.outside

        d = d + 77 + ZombRand(254)
        BWOScheduler.Add("BombDrop", bomb, d)

        if i == 0 then
            local vparams = {}
            vparams.alarm = true
            BWOScheduler.Add("VehiclesUpdate", vparams, d + 10)
        end
    end
end
-- params: []
BWOEvents.FinalSolution = function(params)
    local player = getPlayer()
    local px = player:getX()
    local py = player:getY()
    local params = {}
    params.x = px
    params.y = py
    params.r = 80

    local nukes = BWOSquareLoader.nukes
    if #nukes > 0 then
        player:playSound("BWOInstrumentOrgan")
        local ct = 100
        for _, nuke in pairs(nukes) do

            if isInCircle(px, py, nuke.x, nuke.y, nuke.r) then
                BWOScheduler.Add("Nuke", params, 50000)
            else
                BWOScheduler.Add("NukeDist", nuke, ct)
                ct = ct + 4000 + ZombRand(10000)
            end
        end
    end
end

-- params: [x, y, outside]
BWOEvents.Nuke = function(params)
    local player = getPlayer()

    BWOTex.speed = 0.018
    BWOTex.tex = getTexture("media/textures/mask_white.png")
    BWOTex.mode = "full"
    BWOTex.alpha = 3
    player:playSound("DOKaboom")

    args = {}
    args.x = params.x
    args.y = params.y
    args.r = params.r
    sendClientCommand(player, 'Commands', 'Nuke', args)

    local zombieList = BanditZombie.GetAll()
    for id, z in pairs(zombieList) do
        local dist = math.sqrt(math.pow(z.x - params.x, 2) + math.pow(z.y - params.y, 2))
        if dist < params.r then
            local character = BanditZombie.GetInstanceById(id)
            if character and character:isOutside() then
                character:SetOnFire()
            end
        end
    end

    if player:isOutside() then
        player:SetOnFire()
    end
end

-- params: [x, y, outside]
BWOEvents.NukeDist = function(params)
    local player = getPlayer()

    BWOTex.speed = 0.05
    BWOTex.tex = getTexture("media/textures/mask_white.png")
    BWOTex.mode = "full"
    BWOTex.alpha = 1.1
    player:playSound("BWOKaboomDist")

    local banditList = BanditZombie.GetAllB()
    for  id, _ in pairs(banditList) do
        local bandit = BanditZombie.GetInstanceById(id)
        Bandit.Say(bandit, "STREETCHATFINAL")
    end
end

-- params: [x, y, outside]
BWOEvents.JetFighter = function(params)

    if BWOSquareLoader.IsInExclusion(params.x, params.y) then return end

    local zombieList = BanditZombie.GetAll()
    for by=-1, 1 do
        for bx=-1, 1 do
            local y1 = params.y + by * 20 - 10
            local y2 = params.y + by * 20 + 10
            local x1 = params.x + bx * 20 - 10
            local x2 = params.x + bx * 20 + 10
            
            local cnt = 0
            local killList = {}
            for id, zombie in pairs(zombieList) do
                if zombie.x > x1 and zombie.x < x2 and zombie.y > y1 and zombie.y < y2 then
                    -- the strike is counting zombies only, but if threshold is reached all in the area will be affected
                    if not zombie.isBandit then
                        cnt = cnt + 1
                    end
                    killList[zombie.id] = zombie
                end
            end

            if cnt >= 10 then
                local fakeItem = instanceItem("Base.AssaultRifle")
                local fakeZombie = getCell():getFakeZombieForHit()
                for id, zombie in pairs(killList) do
                    local character = BanditZombie.GetInstanceById(id)
                    if character and character:isOutside() then
                        character:Hit(fakeItem, fakeZombie, 1 + ZombRand(20), false, 1, false)
                        -- SwipeStatePlayer.splash(character, fakeItem, fakeZombie)
                    end
                end

                if outside and params.x > x1 and params.x < x2 and params.y > y1 and params.y < y2 then
                    if ZombRand(4) == 0 then
                        getPlayer():Hit(fakeItem, fakeZombie, 0.8, false, 1, false)
                        -- SwipeStatePlayer.splash(player, fakeItem, fakeZombie)
                    end
                end

                local sound = "DOA10"
                local emitter = getWorld():getFreeEmitter(x1+10, y1+10, 0)
                emitter:playSound(sound)
                emitter:setVolumeAll(0.9)
                addSound(player, x1+10, y1+10, 0, 120, 100)
                return
            end
        end
    end
end

-- params: [x, y, intensity, outside]
BWOEvents.JetFighterRun = function(params)

    if BWOSquareLoader.IsInExclusion(params.x, params.y) then return end

    local jets = {}
    jets.x = params.x
    jets.y = params.y
    BWOScheduler.Add("Jets", jets, 1)

    if not params.intensity then params.intensity = 1 end

    local d = 14000
    for i = 0, params.intensity do
        local bomb = {}
        bomb.x = params.x
        bomb.y = params.y
        bomb.outside = params.outside

        d = d + 77 + ZombRand(254)
        BWOScheduler.Add("JetFighter", bomb, d)
    end
end

-- params: [x, y, intensity, outside]
BWOEvents.GasRun = function(params)

    if BWOSquareLoader.IsInExclusion(params.x, params.y) then return end

    local jets = {}
    jets.x = params.x
    jets.y = params.y
    BWOScheduler.Add("Jets", jets, 1)

    if not params.intensity then params.intensity = 1 end

    local d = 14000
    for i = 0, params.intensity do
        local bomb = {}
        bomb.x = params.x
        bomb.y = params.y
        bomb.outside = params.outside

        d = d + 79 + ZombRand(239)
        BWOScheduler.Add("GasDrop", bomb, d)
    end
end

-- params: [x, y, outside]
BWOEvents.GasDrop = function(params)

    if BWOSquareLoader.IsInExclusion(params.x, params.y) then return end

    local x, y = findBombSpot(params.x, params.y, params.outside)
    local svec = {}
    table.insert(svec, {x=-3, y=-1})
    table.insert(svec, {x=3, y=1})
    table.insert(svec, {x=-1, y=-3})
    table.insert(svec, {x=1, y=3})

    for _, v in pairs(svec) do
        local effect = {}
        effect.x = x + v.x
        effect.y = y + v.y
        effect.z = 0
        effect.offset = 300
        effect.poison = true
        effect.colors = {r=0.1, g=0.7, b=0.2, a=0.2}
        effect.name = "mist_01"
        effect.frameCnt = 60
        effect.frameRnd = true
        effect.repCnt = 10
        table.insert(BWOEffects.tab, effect)
    end

    local colors = {r=0.2, g=1.0, b=0.3}
    local lightSource = IsoLightSource.new(x, y, 0, colors.r, colors.g, colors.b, 60, 10)
    getCell():addLamppost(lightSource)

    local emitter = getWorld():getFreeEmitter(x, y, 0)
    emitter:playSound("DOGas")
    emitter:setVolumeAll(0.25)
end

-- params: []
BWOEvents.ProtestAll = function(params)
    local cnt = 100
    for _, pcoords in pairs(BWOSquareLoader.protests) do 
        BWOScheduler.Add("Protest", {x=pcoords.x, y=pcoords.y, z=pcoords.z}, cnt)
        cnt = cnt + 200 + ZombRand(200)
    end
end

-- params: [x, y, z]
BWOEvents.Protest = function(params)
    local args = {x=params.x, y=params.y, z=params.z, otype="protest"}
    sendClientCommand(getPlayer(), 'Commands', 'ObjectAdd', args)

    if SandboxVars.Bandits.General_ArrivalIcon then
        local icon = "media/ui/protests.png"
        local color = {r=0, g=1, b=0} -- red
        BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, params.x, params.y, color)
    end
end

-- params: [eid(opt)]
BWOEvents.Entertainer = function(params)
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

        local rnd
        local icon = "media/ui/concert.png"
        if params.eid then
            rnd = params.eid
        else
            rnd = ZombRand(10)
        end

        -- rnd = 9
        if rnd == 0 then
            -- bandit.outfit = "AuthenticBiker"
            -- bandit.femaleChance = 50
            -- bandit.weapons.melee = "Base.GuitarElectric"
            bandit.outfit = "Priest"
            bandit.femaleChance = 0
            icon = "media/ui/cross.png"
        elseif rnd == 1 then
            bandit.outfit = "Dean"
            bandit.femaleChance = 0
            bandit.weapons.melee = "Base.GuitarElectricBass"
        elseif rnd == 2 then
            -- bandit.outfit = "Rocker"
            -- bandit.femaleChance = 0
            -- bandit.weapons.melee = "Base.GuitarAcoustic"
            bandit.outfit = "Priest"
            bandit.femaleChance = 0
            icon = "media/ui/cross.png"
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
            icon = "media/ui/cross.png"
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
            icon = "media/ui/cross.png"
        end

        table.insert(event.bandits, bandit)
        sendClientCommand(player, 'Commands', 'SpawnGroup', event)

        if SandboxVars.Bandits.General_ArrivalIcon then
            local color = {r=1, g=0.7, b=0.8} -- pink
            BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, event.x, event.y, color)
        end
    end
end

-- params: []
BWOEvents.BuildingParty = function(params)
    local player = getPlayer()

    local house = BWOBuildings.FindBuildingWithRoom("bedroom")
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
                            object:setCanBeModified(true)
                            object:setActivated(false)
                            object:setActive(false)
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

        -- true music version
        -- local cassette = BanditUtils.Choice({"Tsarcraft.CassetteBanditParty01", "Tsarcraft.CassetteBanditParty02", "Tsarcraft.CassetteBanditParty03", "Tsarcraft.CassetteBanditParty04", "Tsarcraft.CassetteBanditParty05"})
        -- addBoomBox(square:getX(), square:getY(), square:getZ(), cassette)

        -- vanilla version
        addRadio(square:getX(), square:getY(), square:getZ())
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
        local item1 = instanceItem("Base.PizzaWhole")
        tableSquare:AddWorldInventoryItem(item1, 0.6, 0.6, surfaceOffset)
        
        local item2 = instanceItem("Base.Wine2")
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
                    bandit.outfit = BanditUtils.Choice({"StripperBlack", "StripperNaked", "StripperPink", "DressShort", "Naked", "Party"})
                    bandit.femaleChance = 100
                else
                    bandit.outfit = BanditUtils.Choice({"Thug", "Party", "Young", "Stripper", "PoliceStripper", "FiremanStripper", "Naked"})
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

-- spawn groups

-- emergency services spawn groups

-- params: [x, y, hostile]
BWOEvents.CallCops = function(params)
    if BWOPopControl.Police.Cooldown > 0 then return end

    local x, y = findVehicleSpot2(params.x, params.y)
    if not x or not y then return end

    spawnVehicle (x, y, "Base.PickUpVanLightsPolice")
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
    event.program.name = "Police"
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

    BWOPopControl.Police.Cooldown = SandboxVars.BanditsWeekOne.PoliceCooldown -- 30
end

-- params: [x, y, hostile]
BWOEvents.CallSWAT = function(params)
    if BWOPopControl.SWAT.Cooldown > 0 then return end

    local x, y = findVehicleSpot2(params.x, params.y)
    if not x or not y then return end

    spawnVehicle (x, y, "Base.PickUpVanLightsPolice")
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

    BWOPopControl.SWAT.Cooldown = SandboxVars.BanditsWeekOne.SWATCooldown -- 120
end

-- params: [x, y]
BWOEvents.CallMedics = function(params)
    if BWOPopControl.Medics.Cooldown > 0 then return end

    local x, y = findVehicleSpot2(params.x, params.y)
    if not x or not y then return end

    spawnVehicle (x, y, "Base.VanAmbulance")
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

    if SandboxVars.Bandits.General_ArrivalIcon then
        local icon = "media/ui/medics.png"
        local color = {r=0, g=1, b=0} -- green
        BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, params.x, params.y, color)
    end

    BWOPopControl.Medics.Cooldown = SandboxVars.BanditsWeekOne.MedicsCooldown -- 45
end

-- params: [x, y]
BWOEvents.CallHazmats = function(params)

    if BWOPopControl.Hazmats.Cooldown > 0 then return end

    local x, y = findVehicleSpot2(params.x, params.y)
    if not x or not y then return end

    spawnVehicle (x, y, "Base.VanAmbulance")
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

    BWOPopControl.Hazmats.Cooldown = SandboxVars.BanditsWeekOne.HazmatCooldown -- 50
end

-- params: [x, y]
BWOEvents.CallFireman = function(params)
    if BWOPopControl.Fireman.Cooldown > 0 then return end

    local x, y = findVehicleSpot2(params.x, params.y)
    if not x or not y then return end

    spawnVehicle (x, y, "Base.PickUpTruckLightsFire")
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

    BWOPopControl.Fireman.Cooldown = SandboxVars.BanditsWeekOne.FiremanCooldown -- 25
end

-- bandits spawn groups

-- params: []
BWOEvents.Defenders = function(params)
    local player = getPlayer()
    BanditScheduler.SpawnDefenders(player, 50, 70)
end

-- params: [intensity]
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

-- params: [intensity, hostile]
BWOEvents.PoliceRiot = function(params)
    local player = getPlayer()

    config = {}
    config.clanId = 6
    config.hasRifleChance = 0
    config.hasPistolChance = 0
    config.rifleMagCount = 0
    config.pistolMagCount = 0

    local event = {}
    event.hostile = params.hostile
    event.occured = false
    event.program = {}
    event.program.name = "RiotPolice"
    event.program.stage = "Prepare"

    local spawnPoint = BanditScheduler.GenerateSpawnPoint(player, ZombRand(40,45))
    if spawnPoint then
        event.x = spawnPoint.x
        event.y = spawnPoint.y
        event.bandits = {}
        
        local bandit = BanditCreator.MakeFromWave(config)
        bandit.outfit = "PoliceRiot"
        bandit.femaleChance = 0
        local intensity = params.intensity
        if intensity > 0 then
            for i=1, intensity do
                table.insert(event.bandits, bandit)
            end
            sendClientCommand(player, 'Commands', 'SpawnGroup', event)
        end

        if SandboxVars.Bandits.General_ArrivalIcon then
            local icon = "media/ui/sheriff.png"
            local color = {r=1, g=0, b=0} -- orange
            BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, event.x, event.y, color)
        end
    end
end

-- params: [intensity]
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

-- params: [intensity]
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

-- params: [intensity]
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

-- params: [intensity]
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

-- params: [intensity]
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

-- params: [intensity]
BWOEvents.Army = function(params)
    local player = getPlayer()

    config = {}
    config.clanId = 16
    config.hasRifleChance = 100
    config.hasPistolChance = 100
    config.rifleMagCount = 6
    config.pistolMagCount = 4

    local event = {}
    event.hostile = false
    event.occured = false
    event.program = {}
    event.program.name = "Police"
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
            local color = {r=0, g=1, b=0} -- green
            BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, event.x, event.y, color)
        end
    end
end

-- params: [intensity]
BWOEvents.ArmyPatrol = function(params)
    local player = getPlayer()

    config = {}
    config.clanId = 0
    config.hasRifleChance = 100
    config.hasPistolChance = 100
    config.rifleMagCount = 6
    config.pistolMagCount = 4

    local event = {}
    event.hostile = false
    event.occured = false
    event.program = {}
    event.program.name = "Patrol"
    event.program.stage = "Prepare"

    local spawnPoint = BanditScheduler.GenerateSpawnPoint(player, ZombRand(40,45))
    if spawnPoint then
        event.x = spawnPoint.x
        event.y = spawnPoint.y
        event.bandits = {}
        
        local bandit = BanditCreator.MakeFromWave(config)
        bandit.hairStyle = BanditUtils.Choice({"Bald", "Fresh", "Demi", "FlatTop", "MohawkShort"})
        bandit.accuracyBoost = 1.6
        bandit.femaleChance = 0
        bandit.health = 6
        bandit.outfit = "ZSArmySpecialOps"
        bandit.weapons.melee = "Base.HuntingKnife"

        local intensity = params.intensity
        if intensity > 0 then
            for i=1, intensity do
                table.insert(event.bandits, bandit)
            end
            sendClientCommand(player, 'Commands', 'SpawnGroup', event)
        end

        if SandboxVars.Bandits.General_ArrivalIcon then
            local icon = "media/ui/raid.png"
            local color = {r=0, g=1, b=0} -- green
            BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, event.x, event.y, color)
        end
    end
end
