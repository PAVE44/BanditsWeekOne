BWOBuildings = BWOBuildings or {}

-- RoomPop defines a nominal numbers of npcs within a room
BWOBuildings.RoomPop = {church=17, 
                         bank=10,
                         gigamart=16, generalstore=8, grocery=5, zippeestore=5, liquorstore=5, movierental=5, gasstore=4, clothingstore=3, clothesstore=4,
                         bookstore=5, library=5,
                         restaurant=14, dining=14, spiffo_dining=15, pizzawhirled=16, diningroom=12, cafeteria=10, cafe=8, bakery=5,
                         classroom=14, 
                         motelroom=1, motelroomoccupied=2,
                         bedroom=1,
                         restaurantkitchen=2, pizzakitchen=2, jayschicken_kitchen=2, gigamartkitchen=2, 
                         mechanic=1, kitchen=1, bathroom=1,
                         gym=5,
                         aesthetic=5,
                         medclinic=3, medical=3,
                         breakroom=2}

-- OpenHours defines opening hours for a given type of a building
BWOBuildings.OpenHours = {}

BWOBuildings.OpenHours.unknown = {}
BWOBuildings.OpenHours.unknown.open = 0
BWOBuildings.OpenHours.unknown.close = 0

BWOBuildings.OpenHours.commercial = {}
BWOBuildings.OpenHours.commercial.open = 8
BWOBuildings.OpenHours.commercial.close = 18

BWOBuildings.OpenHours.bank = BWOBuildings.OpenHours.commercial
BWOBuildings.OpenHours.mechanic = BWOBuildings.OpenHours.commercial
BWOBuildings.OpenHours.industrial = BWOBuildings.OpenHours.commercial
BWOBuildings.OpenHours.gunstore = BWOBuildings.OpenHours.commercial

BWOBuildings.OpenHours.residential = {}
BWOBuildings.OpenHours.residential.open = 0
BWOBuildings.OpenHours.residential.close = 0
BWOBuildings.OpenHours.prison = BWOBuildings.OpenHours.residential

BWOBuildings.OpenHours.motel = {}
BWOBuildings.OpenHours.motel.open = 0
BWOBuildings.OpenHours.motel.close = 24

BWOBuildings.OpenHours.dining = {}
BWOBuildings.OpenHours.dining.open = 11
BWOBuildings.OpenHours.dining.close = 24

BWOBuildings.OpenHours.education = {}
BWOBuildings.OpenHours.education.open = 0
BWOBuildings.OpenHours.education.close = 24

BWOBuildings.OpenHours.church = {}
BWOBuildings.OpenHours.church.open = 6
BWOBuildings.OpenHours.church.close = 20

BWOBuildings.OpenHours.police = {}
BWOBuildings.OpenHours.police.open = 0
BWOBuildings.OpenHours.police.close = 24

BWOBuildings.OpenHours.firestation = BWOBuildings.OpenHours.police
BWOBuildings.OpenHours.medical = BWOBuildings.OpenHours.police
BWOBuildings.OpenHours.gasstation = BWOBuildings.OpenHours.police

BWOBuildings.OpenHours.church = {}
BWOBuildings.OpenHours.church.open = 0
BWOBuildings.OpenHours.church.close = 24

-- Hmap defines buidling population intensity modifier based on the game hour
BWOBuildings.Hmap = {}

BWOBuildings.Hmap.unknown = {}
BWOBuildings.Hmap.unknown[0] = 0
BWOBuildings.Hmap.unknown[1] = 0
BWOBuildings.Hmap.unknown[2] = 0
BWOBuildings.Hmap.unknown[3] = 0
BWOBuildings.Hmap.unknown[4] = 0
BWOBuildings.Hmap.unknown[5] = 0
BWOBuildings.Hmap.unknown[6] = 0
BWOBuildings.Hmap.unknown[7] = 0
BWOBuildings.Hmap.unknown[8] = 0
BWOBuildings.Hmap.unknown[9] = 0
BWOBuildings.Hmap.unknown[10] = 0
BWOBuildings.Hmap.unknown[11] = 0
BWOBuildings.Hmap.unknown[12] = 0
BWOBuildings.Hmap.unknown[13] = 0
BWOBuildings.Hmap.unknown[14] = 0
BWOBuildings.Hmap.unknown[15] = 0
BWOBuildings.Hmap.unknown[16] = 0
BWOBuildings.Hmap.unknown[17] = 0
BWOBuildings.Hmap.unknown[18] = 0
BWOBuildings.Hmap.unknown[19] = 0
BWOBuildings.Hmap.unknown[20] = 0
BWOBuildings.Hmap.unknown[21] = 0
BWOBuildings.Hmap.unknown[22] = 0
BWOBuildings.Hmap.unknown[23] = 0

BWOBuildings.Hmap.commercial = {}
BWOBuildings.Hmap.commercial[0] = 0
BWOBuildings.Hmap.commercial[1] = 0
BWOBuildings.Hmap.commercial[2] = 0
BWOBuildings.Hmap.commercial[3] = 0
BWOBuildings.Hmap.commercial[4] = 0
BWOBuildings.Hmap.commercial[5] = 0
BWOBuildings.Hmap.commercial[6] = 0
BWOBuildings.Hmap.commercial[7] = 0
BWOBuildings.Hmap.commercial[8] = 0.7
BWOBuildings.Hmap.commercial[9] = 1.0
BWOBuildings.Hmap.commercial[10] = 0.7
BWOBuildings.Hmap.commercial[11] = 0.3
BWOBuildings.Hmap.commercial[12] = 0.3
BWOBuildings.Hmap.commercial[13] = 0.3
BWOBuildings.Hmap.commercial[14] = 0.3
BWOBuildings.Hmap.commercial[15] = 0.5
BWOBuildings.Hmap.commercial[16] = 0.9
BWOBuildings.Hmap.commercial[17] = 1.0
BWOBuildings.Hmap.commercial[18] = 1.0
BWOBuildings.Hmap.commercial[19] = 0.7
BWOBuildings.Hmap.commercial[20] = 0
BWOBuildings.Hmap.commercial[21] = 0
BWOBuildings.Hmap.commercial[22] = 0
BWOBuildings.Hmap.commercial[23] = 0
BWOBuildings.Hmap.bank = BWOBuildings.Hmap.commercial
BWOBuildings.Hmap.mechanic = BWOBuildings.Hmap.commercial
BWOBuildings.Hmap.industrial = BWOBuildings.Hmap.commercial
BWOBuildings.Hmap.gunstore = BWOBuildings.Hmap.commercial

BWOBuildings.Hmap.residential = {}
BWOBuildings.Hmap.residential[0] = 1.5
BWOBuildings.Hmap.residential[1] = 1.5
BWOBuildings.Hmap.residential[2] = 1.5
BWOBuildings.Hmap.residential[3] = 1.5
BWOBuildings.Hmap.residential[4] = 1.5
BWOBuildings.Hmap.residential[5] = 1.5
BWOBuildings.Hmap.residential[6] = 1.4
BWOBuildings.Hmap.residential[7] = 1.3
BWOBuildings.Hmap.residential[8] = 1.1
BWOBuildings.Hmap.residential[9] = 1
BWOBuildings.Hmap.residential[10] = 0.9
BWOBuildings.Hmap.residential[11] = 0.6
BWOBuildings.Hmap.residential[12] = 0.6
BWOBuildings.Hmap.residential[13] = 0.6
BWOBuildings.Hmap.residential[14] = 0.6
BWOBuildings.Hmap.residential[15] = 0.7
BWOBuildings.Hmap.residential[16] = 0.8
BWOBuildings.Hmap.residential[17] = 0.9
BWOBuildings.Hmap.residential[18] = 1
BWOBuildings.Hmap.residential[19] = 1.1
BWOBuildings.Hmap.residential[20] = 1.2
BWOBuildings.Hmap.residential[21] = 1.3
BWOBuildings.Hmap.residential[22] = 1.4
BWOBuildings.Hmap.residential[23] = 1.5
BWOBuildings.Hmap.motel = BWOBuildings.Hmap.residential

BWOBuildings.Hmap.dining = {}
BWOBuildings.Hmap.dining[0] = 0
BWOBuildings.Hmap.dining[1] = 0
BWOBuildings.Hmap.dining[2] = 0
BWOBuildings.Hmap.dining[3] = 0
BWOBuildings.Hmap.dining[4] = 0
BWOBuildings.Hmap.dining[5] = 0
BWOBuildings.Hmap.dining[6] = 0
BWOBuildings.Hmap.dining[7] = 0
BWOBuildings.Hmap.dining[8] = 0
BWOBuildings.Hmap.dining[9] = 0
BWOBuildings.Hmap.dining[10] = 0
BWOBuildings.Hmap.dining[11] = 0.3
BWOBuildings.Hmap.dining[12] = 1
BWOBuildings.Hmap.dining[13] = 1
BWOBuildings.Hmap.dining[14] = 0.5
BWOBuildings.Hmap.dining[15] = 0.2
BWOBuildings.Hmap.dining[16] = 0.2
BWOBuildings.Hmap.dining[17] = 0.3
BWOBuildings.Hmap.dining[18] = 0.8
BWOBuildings.Hmap.dining[19] = 0.9
BWOBuildings.Hmap.dining[20] = 1
BWOBuildings.Hmap.dining[21] = 1
BWOBuildings.Hmap.dining[22] = 1
BWOBuildings.Hmap.dining[23] = 1

BWOBuildings.Hmap.gasstation = {}
BWOBuildings.Hmap.gasstation[0] = 0.4
BWOBuildings.Hmap.gasstation[1] = 0.3
BWOBuildings.Hmap.gasstation[2] = 0.2
BWOBuildings.Hmap.gasstation[3] = 0.1
BWOBuildings.Hmap.gasstation[4] = 0.1
BWOBuildings.Hmap.gasstation[5] = 0.3
BWOBuildings.Hmap.gasstation[6] = 0.6
BWOBuildings.Hmap.gasstation[7] = 0.7
BWOBuildings.Hmap.gasstation[8] = 0.8
BWOBuildings.Hmap.gasstation[9] = 1
BWOBuildings.Hmap.gasstation[10] = 1
BWOBuildings.Hmap.gasstation[11] = 1
BWOBuildings.Hmap.gasstation[12] = 1
BWOBuildings.Hmap.gasstation[13] = 1
BWOBuildings.Hmap.gasstation[14] = 1
BWOBuildings.Hmap.gasstation[15] = 1
BWOBuildings.Hmap.gasstation[16] = 1
BWOBuildings.Hmap.gasstation[17] = 1
BWOBuildings.Hmap.gasstation[18] = 1
BWOBuildings.Hmap.gasstation[19] = 1
BWOBuildings.Hmap.gasstation[20] = 1
BWOBuildings.Hmap.gasstation[21] = 1
BWOBuildings.Hmap.gasstation[22] = 0.7
BWOBuildings.Hmap.gasstation[23] = 0.5

BWOBuildings.Hmap.education = {}
BWOBuildings.Hmap.education[0] = 0
BWOBuildings.Hmap.education[1] = 0
BWOBuildings.Hmap.education[2] = 0
BWOBuildings.Hmap.education[3] = 0
BWOBuildings.Hmap.education[4] = 0
BWOBuildings.Hmap.education[5] = 0
BWOBuildings.Hmap.education[6] = 0
BWOBuildings.Hmap.education[7] = 0.3
BWOBuildings.Hmap.education[8] = 1
BWOBuildings.Hmap.education[9] = 1
BWOBuildings.Hmap.education[10] = 1
BWOBuildings.Hmap.education[11] = 1
BWOBuildings.Hmap.education[12] = 1
BWOBuildings.Hmap.education[13] = 1
BWOBuildings.Hmap.education[14] = 0.9
BWOBuildings.Hmap.education[15] = 0.5
BWOBuildings.Hmap.education[16] = 0.2
BWOBuildings.Hmap.education[17] = 0
BWOBuildings.Hmap.education[18] = 0
BWOBuildings.Hmap.education[19] = 0
BWOBuildings.Hmap.education[20] = 0
BWOBuildings.Hmap.education[21] = 0
BWOBuildings.Hmap.education[22] = 0
BWOBuildings.Hmap.education[23] = 0

BWOBuildings.Hmap.church = {}
BWOBuildings.Hmap.church[0] = 0
BWOBuildings.Hmap.church[1] = 0
BWOBuildings.Hmap.church[2] = 0
BWOBuildings.Hmap.church[3] = 0
BWOBuildings.Hmap.church[4] = 0
BWOBuildings.Hmap.church[5] = 0.1
BWOBuildings.Hmap.church[6] = 1 -- mass
BWOBuildings.Hmap.church[7] = 0.1
BWOBuildings.Hmap.church[8] = 0.1
BWOBuildings.Hmap.church[9] = 0.1
BWOBuildings.Hmap.church[10] = 1 -- mass
BWOBuildings.Hmap.church[11] = 0.1
BWOBuildings.Hmap.church[12] = 1 -- mass
BWOBuildings.Hmap.church[13] = 0.1
BWOBuildings.Hmap.church[14] = 0.1
BWOBuildings.Hmap.church[15] = 0.1
BWOBuildings.Hmap.church[16] = 0.1
BWOBuildings.Hmap.church[17] = 0.1
BWOBuildings.Hmap.church[18] = 1 -- mass
BWOBuildings.Hmap.church[19] = 0.1
BWOBuildings.Hmap.church[20] = 0
BWOBuildings.Hmap.church[21] = 0
BWOBuildings.Hmap.church[22] = 0
BWOBuildings.Hmap.church[23] = 0

BWOBuildings.Hmap.police = {}
BWOBuildings.Hmap.police[0] = 0.5
BWOBuildings.Hmap.police[1] = 0.5
BWOBuildings.Hmap.police[2] = 0.5
BWOBuildings.Hmap.police[3] = 0.5
BWOBuildings.Hmap.police[4] = 0.5
BWOBuildings.Hmap.police[5] = 0.5
BWOBuildings.Hmap.police[6] = 0.8
BWOBuildings.Hmap.police[7] = 1
BWOBuildings.Hmap.police[8] = 1
BWOBuildings.Hmap.police[9] = 1
BWOBuildings.Hmap.police[10] = 1
BWOBuildings.Hmap.police[11] = 0.9
BWOBuildings.Hmap.police[12] = 0.7
BWOBuildings.Hmap.police[13] = 0.8
BWOBuildings.Hmap.police[14] = 1
BWOBuildings.Hmap.police[15] = 1
BWOBuildings.Hmap.police[16] = 1
BWOBuildings.Hmap.police[17] = 1
BWOBuildings.Hmap.police[18] = 0.8 
BWOBuildings.Hmap.police[19] = 0.6
BWOBuildings.Hmap.police[20] = 0.5
BWOBuildings.Hmap.police[21] = 0.5
BWOBuildings.Hmap.police[22] = 0.5
BWOBuildings.Hmap.police[23] = 0.5
BWOBuildings.Hmap.firestation = BWOBuildings.Hmap.police
BWOBuildings.Hmap.prison = BWOBuildings.Hmap.police

BWOBuildings.Hmap.medical = {}
BWOBuildings.Hmap.medical[0] = 0.5
BWOBuildings.Hmap.medical[1] = 0.5
BWOBuildings.Hmap.medical[2] = 0.5
BWOBuildings.Hmap.medical[3] = 0.5
BWOBuildings.Hmap.medical[4] = 0.5
BWOBuildings.Hmap.medical[5] = 0.5
BWOBuildings.Hmap.medical[6] = 1
BWOBuildings.Hmap.medical[7] = 1
BWOBuildings.Hmap.medical[8] = 1
BWOBuildings.Hmap.medical[9] = 1
BWOBuildings.Hmap.medical[10] = 1
BWOBuildings.Hmap.medical[11] = 1
BWOBuildings.Hmap.medical[12] = 1
BWOBuildings.Hmap.medical[13] = 1
BWOBuildings.Hmap.medical[14] = 1
BWOBuildings.Hmap.medical[15] = 1
BWOBuildings.Hmap.medical[16] = 1
BWOBuildings.Hmap.medical[17] = 1
BWOBuildings.Hmap.medical[18] = 0.8 
BWOBuildings.Hmap.medical[19] = 0.6
BWOBuildings.Hmap.medical[20] = 0.5
BWOBuildings.Hmap.medical[21] = 0.5
BWOBuildings.Hmap.medical[22] = 0.5
BWOBuildings.Hmap.medical[23] = 0.5

-- guesses the type of a building bassed on room composition
-- works badly for modular buildings where there are multiple business
-- establishments
BWOBuildings.GetType = function(building)
    local btype = "unknown"
    if building:containsRoom("policestorage") then
        btype = "police"
    elseif building:containsRoom("cell") then
        btype = "prison"
    elseif building:containsRoom("firestorage") then
        btype = "firestation"
    elseif building:containsRoom("church") then
        btype = "church"
    elseif building:containsRoom("medclinic") or building:containsRoom("medical")  or building:containsRoom("pharmacy")  then
        btype = "medical"
    elseif building:containsRoom("gunstore") then
        btype = "gunstore"
    elseif building:containsRoom("mechanic") then
        btype = "mechanic"
    elseif building:containsRoom("classroom") then
        btype = "education"
    elseif building:containsRoom("bank") then
        btype = "bank"
    elseif building:containsRoom("gasstore") or building:containsRoom("gasstorage") then
        btype = "gasstation"
    elseif building:containsRoom("grocery") or building:containsRoom("liquorstore") or building:containsRoom("clothingstore") or building:containsRoom("clothesstore") or building:containsRoom("grocery") or building:containsRoom("gigamart") or building:containsRoom("zippeestore") or building:containsRoom("movierental") or building:containsRoom("bookstore") or building:containsRoom("aesthetic") then
        btype = "commercial"
    elseif building:containsRoom("bar") or building:containsRoom("restaurant") or building:containsRoom("pizzawhirled") or building:containsRoom("spiffo_dining")  or building:containsRoom("jayschicken_dining") then
        btype = "dining"
    elseif building:containsRoom("motelroom") or building:containsRoom("motelroomoccupied") then
        btype = "motel"
    elseif building:containsRoom("warehouse") then
        btype = "industrial"
    elseif building:containsRoom("bedroom") and building:containsRoom("kitchen") and building:containsRoom("bathroom") then
        btype = "residential"
    end
    return btype
end

BWOBuildings.GetSize = function(building)
    local def = building:getDef()
    local roomSize = (def:getX2() - def:getX()) * (def:getY2() - def:getY())
    return roomSize
end

BWOBuildings.GetRoomPop = function(room)
    local pop = 1
    local roomName = room:getName()
    
    if BWOBuildings.RoomPop[roomName] then
        pop = BWOBuildings.RoomPop[roomName]
    else
        local roomDef = room:getRoomDef()
        local roomSize = (roomDef:getX2() - roomDef:getX()) * (roomDef:getY2() - roomDef:getY())
        if roomSize >= 400 then
            pop = 8
        elseif roomSize >= 144 then
            pop = 4
        elseif roomSize >= 64 then
            pop = 3
        elseif roomSize >= 25 then
            pop = 2
        end
    end
    return pop
end

BWOBuildings.IsEventBuilding = function(building, event)
    local gmd = GetBWOModData()
    local buildingDef = building:getDef()
    local id = buildingDef:getKeyId()
    if gmd.EventBuildings[id] then
        if gmd.EventBuildings[id].event == event then
            return true
        end
    end
    return false
end

BWOBuildings.IsGuest = function(building)
    local gmd = GetBWOModData()
    local buildingDef = building:getDef()
    local id = buildingDef:getKeyId()
    if gmd.EventBuildings[id] then
        return true
    end
    return false
end

BWOBuildings.IsIntrusion = function(building, room)
    local player = getPlayer()
    local profession = player:getDescriptor():getProfession()
    local btype = BWOBuildings.GetType(building)
    local roomName = room:getName()

    -- available professions types: 
    -- unemployed, fireofficer, policeofficer, parkranger, constructionworker, securityguard, carpenter, burglar, chef, farmer, fisherman
    -- doctor, veteran, nurse, lumberjack, fitnessinstructor, burgerflipper, electrician, metalworker, mechanics

    if btype == "residential" then return true end

    if roomName == "armystorage" and profession ~= "veteran" then return true end
    if roomName == "gunstorestorage" and profession ~= "veteran" then return true end
    if roomName == "policestorage" and profession ~= "policeofficer" then return true end
    if roomName == "security" and (profession ~= "policeofficer" and profession ~= "securityguard") then return true end
    
    if roomName == "firestorage" and profession ~= "fireofficer" then return true end
    if roomName == "farmstorage" and profession ~= "farmer" then return true end
    if roomName == "potatostorage" and profession ~= "farmer" then return true end
    if roomName == "producestorage" and profession ~= "farmer" then return true end
    if roomName == "electronicsstorage" and profession ~= "electrician" then return true end
    if roomName == "radiostorage" and profession ~= "electrician" then return true end
    if roomName == "dentiststorage" and (profession ~= "doctor" and profession ~= "nurse") then return true end
    if roomName == "hospitalstorage" and (profession ~= "doctor" and profession ~= "nurse") then return true end
    if roomName == "medicalstorage" and (profession ~= "doctor" and profession ~= "nurse") then return true end
    if roomName == "pharmacystorage" and (profession ~= "doctor" and profession ~= "nurse") then return true end
    if roomName == "burgerstorage" and (profession ~= "chef" and profession ~= "burgerflipper") then return true end
    if roomName == "fishingstorage" and (profession ~= "chef" and profession ~= "fisherman") then return true end

    local otherStorage = {"aestheticstorage", "batstorage", "barstorage", "batterystorage", "brewerystorage", "campingstorage", "candystorage", "clothingstorage", 
                          "cornerstorestorage", "departmentstorage", "dogfoodstorage", "donut_kitchenstorage", "factorystorage", "furniturestorage", 
                          "gasstorage", "generalstorestorage", "giftstorage", "grocerystorage", "jewelrystorage", "newspaperstorage", "pawnshopstorage", 
                          "poststorage", "schoolstorage", "sewingstorage", "spiffosstorage", "sportstorage", "theatrestorage", "toolstorestorage",
                          "toystorestorage", "zippeestorage"}

    for _, storage in pairs(otherStorage) do
        if roomName == storage then return true end
    end

    return false
end

BWOBuildings.GetPopMultiplier = function(building)
    local btype = BWOBuildings.GetType(building)
    local roomCnt = building:getRoomsNumber()
    local worldAge = BWOScheduler.WorldAge
    local symptomLevel = BWOScheduler.SymptomLevel
    local gameTime = getGameTime()
    local hour = gameTime:getHour()

    local intensity = BWOBuildings.Hmap[btype][hour]

    if symptomLevel > 0 then
        if btype == "medical" or btype == "church" then
            intensity = intensity + (1 * symptomLevel)
        elseif btype == "residential" then
            intensity = intensity + (0.6 * symptomLevel)
        else
            intensity = intensity -- - (0.1 * symptomLevel)
        end
    end

    -- intensity = math.floor(intensity * BWOBuildings.GetSize(building) / 10)

    return intensity
end

BWOBuildings.FindBuildingType = function(bsearch)
    local player = getPlayer()
    local cell = player:getCell()
    local rooms = cell:getRoomList()
    local buildings = {}
    for i = 0, rooms:size() - 1 do
        local room = rooms:get(i)

        local building = room:getBuilding()
        if building then
            local def = building:getDef()
            local key = def:getKeyId()

            if not buildings[key] then
                buildings[key] = building
            end
        end
    end

    -- shuffle (Fisher-Yates)
    for i = #buildings, 2, -1 do
        local j = ZombRand(i) + 1
        buildings[i], buildings[j] = buildings[j], buildings[i]
    end
    
    for key, building in pairs(buildings) do
        local btype = BWOBuildings.GetType(building)
        if bsearch == btype then
            return building
        end
    end
end

BWOBuildings.FindBuildingDist = function(min, max)
    local player = getPlayer()
    local px, py = player:getX(), player:getY()
    local cell = player:getCell()
    local rooms = cell:getRoomList()
    local buildings = {}
    for i = 0, rooms:size() - 1 do
        local room = rooms:get(i)

        local building = room:getBuilding()
        if building then
            local def = building:getDef()
            local key = def:getKeyId()

            if not buildings[key] then
                buildings[key] = building
            end
        end
    end

    -- shuffle (Fisher-Yates)
    for i = #buildings, 2, -1 do
        local j = ZombRand(i) + 1
        buildings[i], buildings[j] = buildings[j], buildings[i]
    end

    for key, building in pairs(buildings) do
        local def = building:getDef()
        local mx = (def:getX() + def:getX2()) / 2
        local my = (def:getY() + def:getY2()) / 2
        local dist = BanditUtils.DistTo(px, py, mx, my)

        if dist > min and dist < max then
            return building
        end
    end
end

