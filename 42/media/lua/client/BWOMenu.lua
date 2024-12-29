local TAHeal = require("TimedActions/TAHeal")

BWOMenu = BWOMenu or {}

BWOMenu.HealPerson = function(player, square, bandit)
    if luautils.walkAdj(player, square) then
        ISTimedActionQueue.add(TAHeal:new(player, square, bandit))
    end
end

BWOMenu.SpawnRoom = function(player, square, prgName)

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
    event.program.name = prgName
    event.program.stage = "Prepare"
    event.bandits = {}

    local room = square:getRoom()
    if room then
        local roomDef = room:getRoomDef()
        if roomDef then
            local spawnSquare = roomDef:getFreeSquare()
            if spawnSquare then
                event.x = spawnSquare:getX()
                event.y = spawnSquare:getY()
                event.z = spawnSquare:getZ()
                local bandit = BanditCreator.MakeFromRoom(room)
                if bandit then
                    table.insert(event.bandits, bandit)
                    sendClientCommand(player, 'Commands', 'SpawnGroup', event)
                end
            end
        end
    end
end

BWOMenu.SpawnWave = function(player, square, prgName)
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
    event.program.name = prgName
    event.program.stage = "Prepare"
    event.x = square:getX()
    event.y = square:getY()
    event.bandits = {}
   
    local bandit = BanditCreator.MakeFromWave(config)

    if prgName == "Walker" then
        bandit.outfit = BanditUtils.Choice({"Generic02", "Generic01"})
    elseif prgName == "Fireman" then
        bandit.outfit = BanditUtils.Choice({"FiremanFullSuit"})
        bandit.weapons.melee = "Base.Axe"
    elseif prgName == "Gardener" then
        bandit.outfit = BanditUtils.Choice({"Farmer"})
    elseif prgName == "Janitor" then
        bandit.outfit = BanditUtils.Choice({"Sanitation"})
        bandit.weapons.melee = "Base.Broom"
    elseif prgName == "Medic" then
        bandit.outfit = BanditUtils.Choice({"Doctor"})
        bandit.weapons.melee = "Base.Scalpel"
    elseif prgName == "Postal" then
        bandit.outfit = BanditUtils.Choice({"Postal"})
    elseif prgName == "Runner" then
        bandit.outfit = BanditUtils.Choice({"StreetSports", "AuthenticJogger", "AuthenticFitnessInstructor"})
    elseif prgName == "Vandal" then
        bandit.outfit = BanditUtils.Choice({"Bandit"})
    end
    table.insert(event.bandits, bandit)

    sendClientCommand(player, 'Commands', 'SpawnGroup', event)
end

BWOMenu.FlushDeadbodies = function(player)
    local args = {a=1}
    sendClientCommand(getPlayer(), 'Commands', 'DeadBodyFlush', args)
end

BWOMenu.EventArmy = function(player)
    local params = {}
    params.intensity = 12
    BWOScheduler.Add("Army", params, 100)
end

BWOMenu.EventArmyPatrol = function(player)
    local params = {}
    params.intensity = 9
    BWOScheduler.Add("ArmyPatrol", params, 100)
end

BWOMenu.EventArson = function(player)
    local params = {}
    params.x = player:getX()
    params.y = player:getY()
    params.z = player:getZ()
    BWOScheduler.Add("Arson", params, 100)
end

BWOMenu.EventGasDrop = function(player)
    local params = {}
    params.x = player:getX()
    params.y = player:getY()
    params.z = player:getZ()
    params.outside = player:isOutside()
    BWOScheduler.Add("GasDrop", params, 100)
end

BWOMenu.EventGasRun = function(player)
    local params = {}
    params.x = player:getX()
    params.y = player:getY()
    params.z = player:getZ()
    params.outside = player:isOutside()
    params.intensity = 10
    BWOScheduler.Add("GasRun", params, 100)
end

BWOMenu.EventBombDrop = function(player)
    local params = {}
    params.x = player:getX()
    params.y = player:getY()
    params.z = player:getZ()
    params.outside = player:isOutside()
    BWOScheduler.Add("BombDrop", params, 100)
end

BWOMenu.EventBombRun = function(player)
    local params = {}
    params.x = player:getX()
    params.y = player:getY()
    params.z = player:getZ()
    params.intensity = 20
    params.outside = player:isOutside()
    BWOScheduler.Add("BombRun", params, 100)
end

BWOMenu.EventNuke = function(player)
    local params = {}
    params.x = player:getX()
    params.y = player:getY()
    params.r = 80
    BWOScheduler.Add("Nuke", params, 100)
end

BWOMenu.EventFinalSolution = function(player)
    local params = {}
    BWOScheduler.Add("FinalSolution", params, 100)
end

BWOMenu.EventEntertainer = function(player)
    local params ={}
    params.x = player:getX()
    params.y = player:getY()
    params.z = player:getZ()
    BWOScheduler.Add("Entertainer", params, 100)
end

BWOMenu.EventParty = function (player)
    local params = {}
    BWOScheduler.Add("BuildingParty", params, 100)
end

BWOMenu.EventJetFighter = function (player)
    local params = {}
    params.x = player:getX()
    params.y = player:getY()
    params.z = player:getZ()
    params.outside = player:isOutside()
    BWOScheduler.Add("JetFighter", params, 100)
end

BWOMenu.EventJetFighterRun = function (player)
    local params = {}
    params.x = player:getX()
    params.y = player:getY()
    params.z = player:getZ()
    params.outside = player:isOutside()
    BWOScheduler.Add("JetFighterRun", params, 100)
end

BWOMenu.EventProtest = function(player)
    local params = {}
    params.x = player:getX()
    params.y = player:getY()
    params.z = player:getZ()
    BWOScheduler.Add("Protest", params, 100)
end

BWOMenu.EventStart = function(player)
    local params = {}
    BWOScheduler.Add("GetStartInventory", params, 100)
end

BWOMenu.EventPoliceRiot = function(player)
    local params = {}
    params.intensity = 10
    params.hostile = true
    BWOScheduler.Add("PoliceRiot", params, 100)
end

BWOMenu.EventBikers = function(player)
    local params = {}
    params.intensity = 5
    BWOScheduler.Add("Bikers", params, 100)
end

BWOMenu.EventCriminals = function(player)
    local params = {}
    params.intensity = 3
    BWOScheduler.Add("Criminals", params, 100)
end

BWOMenu.EventBandits = function(player)
    local params = {}
    params.intensity = 7
    BWOScheduler.Add("Bandits", params, 100)
end

function BWOMenu.WorldContextMenuPre(playerID, context, worldobjects, test)

    --[[for k,v in pairs(Distributions[1]) do
        print (k)
    end]]


    
    


                            
    local player = getPlayer()
    -- print ("DIR: " .. player:getDirectionAngle())
    local fetch = ISWorldObjectContextMenu.fetchVars
    local square = fetch.clickedSquare

    local zombie = square:getZombie()
    if not zombie then
        local squareN = square:getN()
        if squareN then
            zombie = squareN:getZombie()
            if not zombie then
                local squareNW = squareN:getW()
                if squareNW then
                    zombie = squareNW:getZombie()
                end
            end
        end
    end

    if zombie and zombie:getVariableBoolean("Bandit") then
        local health = zombie:getHealth()
        if health < 0.8 or zombie:isCrawling() then
            context:addOption("Heal Person", player, BWOMenu.HealPerson, square, zombie)
        end
    end

    print ("-----------------")
    local playerList = IsoPlayer.getPlayers()
    for i=0, playerList:size()-1 do
        local player = playerList:get(i)
        print ("PLAYER")
    end
    print ("-----------------")

    --[[
    -- Add VHS_Retail to player's inventory
    local item = player:getInventory():AddItem("VHS_Retail");
    -- get media Data for the related tape name
    local mediaData = getZomboidRadio():getRecordedMedia():getMediaData("04fe92cb-4a3b-4545-bdb9-7c1f0fb6e343")
    -- set the media data to the item
    item:setRecordedMediaData(mediaData)
    -- Refresh the inventory
    item:getContainer():setDrawDirty(true)]]

    --[[
    BWOSquareLoader.Burn(square)
    
    if BanditUtils.HasZoneType(square:getX(), square:getY(), square:getZ(), "Nav") then

       local objects = square:getObjects()
        for i=0, objects:size()-1 do
            local object = objects:get(i)
            local sprite = object:getSprite()
            if sprite then
                local spriteName = sprite:getName()
                if spriteName:embodies("street") then
                    
                    local rn = ZombRand(3)
                    local overlaySprite
                    if rn < 2  then
                        overlaySprite = "floors_overlay_street_01_" .. ZombRand(44)
                    elseif rn == 2 then
                        overlaySprite = "blends_streetoverlays_01_" .. ZombRand(32)
                    end
                    if overlaySprite then
                        local attachments = object:getAttachedAnimSprite()
                        if not attachments or attachments:size() == 0 then
                            object:setAttachedAnimSprite(ArrayList.new())
                        end
                        object:getAttachedAnimSprite():add(getSprite(overlaySprite):newInstance())
                    end
                    break
                end
            end
        end
    end]]

    --[[local dummy = IsoObject.new(square, "explo_big_01_0", "")
    dummy:setSprite("explo_big_01_0")
    square:AddSpecialObject(dummy)
    dummy:setSprite("explo_big_01_0")]]

    --[[local effect = {}
    effect.x = square:getX()
    effect.y = square:getY()
    effect.z = 0
    effect.offset = 300
    effect.poison = true
    effect.colors = {r=0.1, g=0.7, b=0.2, a=0.2}
    effect.name = "mist_01"
    effect.frameCnt = 60
    effect.frameRnd = true
    effect.repCnt = 10
    table.insert(BWOEffects.tab, effect)]]

    --[[
    BWOVehicles.FindSpawnPoint(player)
    local vehicle = square:getVehicleContainer()
    if vehicle then
        -- NORTH x: -180 y: z: 180
        -- SOUTH x: 0 y: 0 z: 0
        -- EAST x: -125 y: 90 z: 125
        -- WEST x: -125, y: -90, z: -125
        print ("X:" .. vehicle:getAngleX() .. " Y: ".. vehicle:getAngleY() .. " Z: " .. vehicle:getAngleZ())
        local radioPart = vehicle:getPartById("Radio")
        if radioPart then
            local dd = radioPart:getDeviceData()
            if dd then
                dd:setIsTurnedOn(true)
                dd:setChannel(98400)
                dd:setDeviceVolume(1)
            end
        end
    end]]

    local player = getSpecificPlayer(playerID)
    print (player:getDescriptor():getProfession())
    if isDebugEnabled() or isAdmin() then
        -- player:playSound("197ddd73-7662-41d5-81e0-63b83a58ab60")
        local eventsOption = context:addOption("BWO Event")
        local eventsMenu = context:getNew(context)
        context:addSubMenu(eventsOption, eventsMenu)

        eventsMenu:addOption("Army", player, BWOMenu.EventArmy)
        eventsMenu:addOption("Army Patrol", player, BWOMenu.EventArmyPatrol)
        eventsMenu:addOption("Arson", player, BWOMenu.EventArson)
        eventsMenu:addOption("Bandits", player, BWOMenu.EventBandits)
        eventsMenu:addOption("Bikers", player, BWOMenu.EventBikers)
        eventsMenu:addOption("Bomb Drop", player, BWOMenu.EventBombDrop)
        eventsMenu:addOption("Bomb Run", player, BWOMenu.EventBombRun)
        eventsMenu:addOption("Criminals", player, BWOMenu.EventCriminals)
        eventsMenu:addOption("Entertainer", player, BWOMenu.EventEntertainer)
        eventsMenu:addOption("Final Solution", player, BWOMenu.EventFinalSolution)
        eventsMenu:addOption("Gas Drop", player, BWOMenu.EventGasDrop)
        eventsMenu:addOption("Gas Run", player, BWOMenu.EventGasRun)
        eventsMenu:addOption("House Party", player, BWOMenu.EventParty)
        eventsMenu:addOption("Jetfighter", player, BWOMenu.EventJetFighter)
        eventsMenu:addOption("Jetfighter Run", player, BWOMenu.EventJetFighterRun)
        eventsMenu:addOption("Nuke", player, BWOMenu.EventNuke)
        eventsMenu:addOption("Rolice Riot", player, BWOMenu.EventPoliceRiot)
        eventsMenu:addOption("Protest", player, BWOMenu.EventProtest)
        eventsMenu:addOption("Start event", player, BWOMenu.EventStart)
        
        local spawnOption = context:addOption("BWO Spawn")
        local spawnMenu = context:getNew(context)
        context:addSubMenu(spawnOption, spawnMenu)
        
        spawnMenu:addOption("Fireman", player, BWOMenu.SpawnWave, square, "Fireman")
        spawnMenu:addOption("Gardener", player, BWOMenu.SpawnWave, square, "Gardener")
        spawnMenu:addOption("Inhabitant", player, BWOMenu.SpawnRoom, square, "Inhabitant")
        spawnMenu:addOption("Janitor", player, BWOMenu.SpawnWave, square, "Janitor")
        spawnMenu:addOption("Medic", player, BWOMenu.SpawnWave, square, "Medic")
        spawnMenu:addOption("Postal", player, BWOMenu.SpawnWave, square, "Postal")
        spawnMenu:addOption("Runner", player, BWOMenu.SpawnWave, square, "Runner")
        spawnMenu:addOption("Survivor", player, BWOMenu.SpawnWave, square, "Survivor")
        spawnMenu:addOption("Vandal", player, BWOMenu.SpawnWave, square, "Vandal")
        spawnMenu:addOption("Walker", player, BWOMenu.SpawnWave, square, "Walker")
        
        context:addOption("BWO Deadbodies: Flush", player, BWOMenu.FlushDeadbodies)
        
        local room = square:getRoom()
        if room then
            local roomName = room:getName()
            print ("ROOM: " .. roomName)
            print ("HOME: " .. tostring(BWOBuildings.IsEventBuilding(room:getBuilding(), "home")))
        end
        
        local objects = square:getObjects()
        for i=0, objects:size()-1 do
            local object = objects:get(i)
            if instanceof(object, "IsoRadio") then
                local isPlaying = false
                local t = RadioWavs.getData(object:getDeviceData())
                if t then
                    isPlaying = RadioWavs.isPlaying(t)
                end
                if not isPlaying then
                    local t = RadioWavs.PlaySound("3fee99ec-c8b6-4ebc-9f2f-116043153195", object)
                    if t then
                        print ("ok")
                    end
                end
            end
        end
    end
end

Events.OnPreFillWorldObjectContextMenu.Add(BWOMenu.WorldContextMenuPre)
