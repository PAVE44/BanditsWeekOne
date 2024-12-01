BWOMenu = BWOMenu or {}

BWOMenu.Spawn = function(player, square)

    local groundType = BanditUtils.GetGroundType(square) 

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
    event.program.name = "Walker"
    event.program.stage = "Prepare"
    event.x = square:getX()
    event.y = square:getY()
    event.bandits = {}

    if square:isOutside() then
        local bandit = BanditCreator.MakeFromWave(config)
        if groundType == "street" then
            if ZombRand(10) == 1 then
                bandit.outfit = BanditUtils.Choice({"StreetSports"})
                event.program.name = "Runner"
                event.program.stage = "Prepare"
            else
                bandit.outfit = BanditUtils.Choice({"AuthenticHomeless"})
                bandit.weapons.melee = "Base.Broom"
                event.program.name = "Walker"
                event.program.stage = "Prepare"
            end
        end
        table.insert(event.bandits, bandit)
    else
        event.program.name = "Inhabitant"
        event.program.stage = "Prepare"

        local room = square:getRoom()
        if room then
            local roomDef = room:getRoomDef()
            if roomDef then

                local roomSize = (roomDef:getX2() - roomDef:getX()) * (roomDef:getY2() - roomDef:getY())
                local pop = 1
                if roomSize >= 400 then
                    pop = 8
                elseif roomSize >= 225 then
                    pop = 4
                elseif roomSize >= 100 then
                    pop = 2
                end
                
                local roomName = room:getName()
                for i=1, pop do
                    local spawnSquare = roomDef:getFreeSquare()
                    if spawnSquare then
                        event.x = spawnSquare:getX()
                        event.y = spawnSquare:getY()
                        event.z = spawnSquare:getZ()
                        event.bandits = {}
                        local bandit = BanditCreator.MakeFromRoom(room)
                        if bandit then
                            table.insert(event.bandits, bandit)
                            sendClientCommand(player, 'Commands', 'SpawnGroup', event)
                        end
                    end
                end
            end
        end
    end

    

    sendClientCommand(player, 'Commands', 'SpawnGroup', event)
end

BWOMenu.SpawnPedestrian = function(player, square)
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
    event.program.name = "Walker"
    event.program.stage = "Prepare"
    event.x = square:getX()
    event.y = square:getY()
    event.bandits = {}
   
    local bandit = BanditCreator.MakeFromWave(config)
    bandit.outfit = BanditUtils.Choice({"Generic02", "Generic01"})
    table.insert(event.bandits, bandit)

    sendClientCommand(player, 'Commands', 'SpawnGroup', event)
end

BWOMenu.SpawnFireman = function(player, square)
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
    event.x = square:getX()
    event.y = square:getY()
    event.bandits = {}
   
    local bandit = BanditCreator.MakeFromWave(config)
    bandit.outfit = BanditUtils.Choice({"FiremanFullSuit"})
    table.insert(event.bandits, bandit)

    sendClientCommand(player, 'Commands', 'SpawnGroup', event)
end

BWOMenu.SpawnMedic = function(player, square)
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
    event.x = square:getX()
    event.y = square:getY()
    event.bandits = {}
   
    local bandit = BanditCreator.MakeFromWave(config)
    bandit.outfit = BanditUtils.Choice({"Doctor"})
    table.insert(event.bandits, bandit)

    sendClientCommand(player, 'Commands', 'SpawnGroup', event)
end

BWOMenu.SpawnEntertainer = function(player)
    local params ={}
    params.x = player:getX()
    params.y = player:getY()
    params.z = player:getZ()
    BWOScheduler.Add("EventEntertainer", params, 100)
end

BWOMenu.FlushDeadbodies = function(player)
    local args = {a=1}
    sendClientCommand(getPlayer(), 'Commands', 'DeadBodyFlush', args)
end

BWOMenu.EventArson = function(player)
    local params ={}
    params.x = player:getX()
    params.y = player:getY()
    params.z = player:getZ()
    BWOScheduler.Add("Arson", params, 100)
end

BWOMenu.EventProtest = function(player)
    local params ={}
    params.x = player:getX()
    params.y = player:getY()
    params.z = player:getZ()
    BWOScheduler.Add("Protest", params, 100)
end

function BWOMenu.WorldContextMenuPre(playerID, context, worldobjects, test)
    local player = getPlayer()
    local square = clickedSquare

    BWOVehicles.FindSpawnPoint(player)
    local vehicle = square:getVehicleContainer()
    if vehicle then
        -- NORTH x: -180 y: z: 180
        -- SOUTH x: 0 y: 0 z: 0
        -- EAST x: -125 y: 90 z: 125
        -- WEST x: -125, y: -90, z: -125
        print ("X:" .. vehicle:getAngleX() .. " Y: ".. vehicle:getAngleY() .. " Z: " .. vehicle:getAngleZ())
        
        vehicle:setAngles(-125, 90, 125)
    end

    local player = getSpecificPlayer(playerID)
    print (player:getDescriptor():getProfession())
    if isDebugEnabled() or isAdmin() then
        context:addOption("[DGB] BWO: Event: Arson", player, BWOMenu.EventArson)
        context:addOption("[DGB] BWO: Event: Protest", player, BWOMenu.EventProtest)
        context:addOption("[DGB] BWO: Event: Entertainer", player, BWOMenu.SpawnEntertainer)

        context:addOption("[DGB] BWO: Spawn: By Location", player, BWOMenu.Spawn, square)
        context:addOption("[DGB] BWO: Spawn: Walker", player, BWOMenu.SpawnPedestrian, square)
        context:addOption("[DGB] BWO: Spawn: Fireman", player, BWOMenu.SpawnFireman, square)
        context:addOption("[DGB] BWO: Spawn: Medic", player, BWOMenu.SpawnMedic, square)
        
        context:addOption("[DGB] BWO: Deadbodies: Flush", player, BWOMenu.FlushDeadbodies)
        
        
        local room = square:getRoom()
        if room then
            local roomName = room:getName()
            print ("ROOM: " .. roomName)
        end
            
    end
end

Events.OnPreFillWorldObjectContextMenu.Add(BWOMenu.WorldContextMenuPre)
