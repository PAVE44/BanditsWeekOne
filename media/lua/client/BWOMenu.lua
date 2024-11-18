BWOMenu = BWOMenu or {}

BWOMenu.Spawn = function(player, square)

    local groundType = BanditUtils.GetGroundType(square) 

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
                bandit.outfit = BanditUtils.Choice({"Generic02", "Generic01"})
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
    config.clanId = 1
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

BWOMenu.SpawnRunner = function(player, square)
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
    event.program.name = "Runner"
    event.program.stage = "Prepare"
    event.x = square:getX()
    event.y = square:getY()
    event.bandits = {}
   
    local bandit = BanditCreator.MakeFromWave(config)
    bandit.outfit = BanditUtils.Choice({"StreetSports"})
    table.insert(event.bandits, bandit)

    sendClientCommand(player, 'Commands', 'SpawnGroup', event)
end

BWOMenu.FlushDeadbodies = function(player)
    local args = {a=1}
    sendClientCommand(getPlayer(), 'Commands', 'DeadBodyFlush', args)
end

BWOMenu.EventArson = function(player)
    BWOScheduler.Add("Arson", 100)
end

function BWOMenu.WorldContextMenuPre(playerID, context, worldobjects, test)
    local square = clickedSquare
    -- print (square:getBuilding():isResidential())
    -- local zone = getWorld():getMetaGrid():getZoneAt(square:getX(), square:getY(), square:getZ())
    -- local building = getWorld():getMetaGrid():getBuildingAt(square:getX(), square:getY(), square:getZ())
    -- local test1 = zone:getName()
    -- local test2 = zone:getOriginalName()
    -- local test3 = zone:getType()
    -- local test4 = zone:getZombieDensity()

    -- local profs = ProfessionFactory.getProfessions()
    -- for i=0, profs:size()-1 do
    --    local p = profs:get(i)
    --    print (p:getType())
    -- end

    --[[
    local vehicle = square:getVehicleContainer()
    if vehicle then
        local scriptName = vehicle:getScriptName()
        if scriptName:embodies("Burnt") or scriptName:embodies("Smashed") then
            if isClient() then
                sendClientCommand(getPlayer(), "vehicle", "remove", { vehicle = vehicle:getId() })
            else
                vehicle:permanentlyRemove()
            end
        else
             vehicle:repair()
        end
    end]]

    context:addOption("[DGB] BWO: Event: Arson", player, BWOMenu.EventArson)
    context:addOption("[DGB] BWO: Deadbodies: Flush", player, BWOMenu.FlushDeadbodies)

    local player = getSpecificPlayer(playerID)
    print (player:getDescriptor():getProfession())
    if isDebugEnabled() or isAdmin() then
        context:addOption("[DGB] BWO: Spawn By Location", player, BWOMenu.Spawn, square)
        context:addOption("[DGB] BWO: Spawn Pedestrian", player, BWOMenu.SpawnPedestrian, square)
        context:addOption("[DGB] BWO: Spawn Runner", player, BWOMenu.SpawnRunner, square)
        
        local room = square:getRoom()
        if room then
            local roomName = room:getName()
            print ("ROOM: " .. roomName)
        end
            
    end
end

Events.OnPreFillWorldObjectContextMenu.Add(BWOMenu.WorldContextMenuPre)
