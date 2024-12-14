BWOMenu = BWOMenu or {}

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
        bandit.outfit = BanditUtils.Choice({"Hobbo"})
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

BWOMenu.EventBombDrop = function(player)
    local params = {}
    params.x = player:getX()
    params.y = player:getY()
    params.z = player:getZ()
    params.outside = player:isOutside()
    params.intensity = 5
    BWOScheduler.Add("BombDrop", params, 100)
end

BWOMenu.EventBombRun = function(player)
    local params = {}
    params.x = player:getX()
    params.y = player:getY()
    params.z = player:getZ()
    params.outside = player:isOutside()
    BWOScheduler.Add("BombRun", params, 100)
end

BWOMenu.EventNuke = function(player)
    local params = {}
    params.x = player:getX()
    params.y = player:getY()
    BWOScheduler.Add("Nuke", params, 100)
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
    local player = getPlayer()
    print ("DIR: " .. player:getDirectionAngle())
    local square = clickedSquare

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
        local eventsOption = context:addOption("BWO Event")
        local eventsMenu = context:getNew(context)
        context:addSubMenu(eventsOption, eventsMenu)

        eventsMenu:addOption("Army Patrol", player, BWOMenu.EventArmyPatrol)
        eventsMenu:addOption("Arson", player, BWOMenu.EventArson)
        eventsMenu:addOption("Bandits", player, BWOMenu.EventBandits)
        eventsMenu:addOption("Bikers", player, BWOMenu.EventBikers)
        eventsMenu:addOption("Bomb Drop", player, BWOMenu.EventBombDrop)
        eventsMenu:addOption("Bomb Run", player, BWOMenu.EventBombRun)
        eventsMenu:addOption("Criminals", player, BWOMenu.EventCriminals)
        eventsMenu:addOption("Entertainer", player, BWOMenu.EventEntertainer)
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
        end
            
    end
end

Events.OnPreFillWorldObjectContextMenu.Add(BWOMenu.WorldContextMenuPre)
