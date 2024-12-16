BWOSquareLoader = BWOSquareLoader or {}

-- table for objects to be added to the map
BWOSquareLoader.map = {}

-- table for objects to be removed from the map
BWOSquareLoader.remove = {}

-- table of coordinates of location based events
BWOSquareLoader.events = {}

-- table of nuclear strike coordinates
BWOSquareLoader.nukes = {}

-- table of protest gathering point coordinates
BWOSquareLoader.protests = {}

-- table of exclusion zones where certain events are removed or modified
BWOSquareLoader.exclusions = {}

-- populating tables
local addBarricadeNorth = function(x1, x2, y)
    for x=x1, x2 do
        local z = 0
        local id 
        local sprite1
        local sprite2
        
        id = x .. "-" .. y .. "-" .. z
        if x % 2 == 0 then
            sprite1 = "fencing_01_88"
        else
            sprite1 = "fencing_01_89"
        end
        BWOSquareLoader.map[id] = {}
        table.insert(BWOSquareLoader.map[id], sprite1)

        id = x .. "-" .. (y - 1) .. "-" .. z
        if x % 3 == 0 then
            sprite2 = "fencing_01_96"
        else
            sprite2 = "carpentry_02_13"
        end
        BWOSquareLoader.map[id] = {}
        table.insert(BWOSquareLoader.map[id], sprite2)
    end
end

local addBarricadeSouth = function(x1, x2, y)
    for x=x1, x2 do
        local z = 0
        local id 
        local sprite1
        local sprite2
    
        id = x .. "-" .. y .. "-" .. z
        if x % 2 == 0 then
            sprite1 = "fencing_01_88"
        else
            sprite1 = "fencing_01_89"
        end
    
        if x % 3 == 0 then
            sprite2 = "fencing_01_96"
        else
            sprite2 = "carpentry_02_13"
        end
        BWOSquareLoader.map[id] = {}
        table.insert(BWOSquareLoader.map[id], sprite1)
        table.insert(BWOSquareLoader.map[id], sprite2)
    end
end

local addBarricadeWest = function(y1, y2, x)
    for y=y1, y2 do
        local z = 0
        local id 
        local sprite
        
        id = x .. "-" .. y .. "-" .. z
        if y % 2 == 0 then
            sprite = "fencing_01_90"
        else
            sprite = "fencing_01_91"
        end
        BWOSquareLoader.map[id] = {}
        table.insert(BWOSquareLoader.map[id], sprite)
    
        id = (x - 1) .. "-" .. y .. "-" .. z
        if y % 3 == 0 then
            sprite = "fencing_01_96"
        else
            sprite = "carpentry_02_12"
        end
        BWOSquareLoader.map[id] = {}
        table.insert(BWOSquareLoader.map[id], sprite)
    end
end

local addBarricadeEast = function(y1, y2, x)
    for y=y1, y2 do
        local z = 0
        local id 
        local sprite1
        local sprite2
    
        id = x .. "-" .. y .. "-" .. z
        if y % 2 == 0 then
            sprite1 = "fencing_01_90"
        else
            sprite1 = "fencing_01_91"
        end

        if y % 3 == 0 then
            sprite2 = "fencing_01_96"
        else
            sprite2 = "carpentry_02_12"
        end
        BWOSquareLoader.map[id] = {}
        table.insert(BWOSquareLoader.map[id], sprite1)
        table.insert(BWOSquareLoader.map[id], sprite2)
    end
end

-- muldrough road blocks
addBarricadeSouth(10576, 10602, 10679)
table.insert(BWOSquareLoader.events, {phase="ArmyGuards", x=10592, y=10675, z=0})

for i = 0, 14 do
    table.insert(BWOSquareLoader.events, {phase="AbandonedVehicle", x=10587, y=10660 - (i * 6), z=0, dir=IsoDirections.S}) 
end

for i = 0, 3 do
    table.insert(BWOSquareLoader.events, {phase="AbandonedVehicle", x=10597, y=10685 + (i * 6), z=0, dir=IsoDirections.N})
end

addBarricadeSouth(10775, 10805, 10715)
table.insert(BWOSquareLoader.events, {phase="ArmyGuards", x=10790, y=10706, z=0})

addBarricadeWest(9306, 9329, 11097)
table.insert(BWOSquareLoader.events, {phase="ArmyGuards", x=11091, y=9317, z=0})

addBarricadeNorth(10950, 10970, 8928)
table.insert(BWOSquareLoader.events, {phase="ArmyGuards", x=10962, y=8932, z=0})

addBarricadeNorth(10570, 10608, 9148)
table.insert(BWOSquareLoader.events, {phase="ArmyGuards", x=10591, y=9152, z=0})

for i = 0, 4 do
    table.insert(BWOSquareLoader.events, {phase="AbandonedVehicle", x=10587, y=9140 - (i * 6), z=0, dir=IsoDirections.S}) 
end

for i = 0, 10 do
    table.insert(BWOSquareLoader.events, {phase="AbandonedVehicle", x=10597, y=9153 + (i * 6), z=0, dir=IsoDirections.N})
end

addBarricadeEast(9726, 9744, 10576)
table.insert(BWOSquareLoader.events, {phase="ArmyGuards", x=10579, y=9736, z=0})

-- march ridge road blocks
addBarricadeNorth(10345, 10380, 12414)
table.insert(BWOSquareLoader.events, {phase="ArmyGuards", x=10361, y=12419, z=0})
table.insert(BWOSquareLoader.events, {phase="ArmyGuards", x=10363, y=12397, z=0})

-- dixie
addBarricadeWest(8750, 8776, 11400)
table.insert(BWOSquareLoader.events, {phase="ArmyGuards", x=11405, y=8764, z=0})

addBarricadeNorth(11628, 11656, 8690)
table.insert(BWOSquareLoader.events, {phase="ArmyGuards", x=11643, y=8694, z=0})

-- westpoint
addBarricadeSouth(11680, 11750, 7157)
table.insert(BWOSquareLoader.events, {phase="ArmyGuards", x=11753, y=7182, z=0})

addBarricadeWest(7157, 7200, 11750)
table.insert(BWOSquareLoader.events, {phase="ArmyGuards", x=11708, y=7147, z=0})

addBarricadeWest(6890, 6925, 11090)
table.insert(BWOSquareLoader.events, {phase="ArmyGuards", x=11094, y=6900, z=0})

addBarricadeEast(7159, 7205, 12172)
table.insert(BWOSquareLoader.events, {phase="ArmyGuards", x=12165, y=7182, z=0})

addBarricadeEast(6890, 6908, 12172)
table.insert(BWOSquareLoader.events, {phase="ArmyGuards", x=12166, y=6899, z=0})

-- riverside
addBarricadeEast(5440, 5500, 7000)
addBarricadeSouth(6515, 6540, 5615)
addBarricadeSouth(5872, 5888, 5460)
addBarricadeWest(5385, 5394, 5710)

-- remove fence in westpoint gunshop
BWOSquareLoader.remove["12072-6759-0"] = {}
BWOSquareLoader.remove["12072-6760-0"] = {}

-- protests
local protests = {}
table.insert(protests, {x=10590, y=10670, z=0}) --muldraugh n blockade
table.insert(protests, {x=10590, y=9172, z=0}) --muldraugh s blockade
table.insert(protests, {x=10590, y=9737, z=0}) --muldraugh middle road
table.insert(protests, {x=10653, y=9940, z=0}) --muldraugh cafeteria, liquorstore, slothing store complex
table.insert(protests, {x=10740, y=10340, z=0}) --muldraugh offices
table.insert(protests, {x=10760, y=10160, z=0}) --muldraugh church
table.insert(protests, {x=10634, y=10431, z=0}) --muldraugh police
table.insert(protests, {x=12160, y=6900, z=0}) --westpoint e traintack
table.insert(protests, {x=12050, y=6883, z=0}) --westpoint gigamart
table.insert(protests, {x=11955, y=6805, z=0}) --westpoint spiffos
table.insert(protests, {x=11927, y=6893, z=0}) --westpoint townhall
table.insert(protests, {x=11933, y=6871, z=0}) --westpoint townhall inside
table.insert(protests, {x=11109, y=6898, z=0}) --westpoint barricade w
table.insert(protests, {x=11920, y=6963, z=0}) --westpoint police
table.insert(protests, {x=6992, y=5468, z=0}) --riverside blockade e
table.insert(protests, {x=6399, y=5427, z=0}) --riverside school
table.insert(protests, {x=6381, y=5283, z=0}) --riverside central road
table.insert(protests, {x=6090, y=5280, z=0}) --riverside police
table.insert(protests, {x=6545, y=5261, z=0}) --riverside community centre
table.insert(protests, {x=5881, y=5445, z=0}) --riverside blockade w
table.insert(protests, {x=8100, y=11740, z=0}) --rosewood police
table.insert(protests, {x=8100, y=11645, z=0}) --rosewood court of justice
table.insert(protests, {x=8093, y=11363, z=0}) --rosewood spiffos
table.insert(protests, {x=8313, y=15583, z=0}) --rosewood school
table.insert(protests, {x=10362, y=12416, z=0}) --marchridge exit
table.insert(protests, {x=10007, y=12692, z=0}) --marchridge crossroads
table.insert(protests, {x=10326, y=12768, z=0}) --marchridge church
BWOSquareLoader.protests = protests

-- nukes
local addNuke = function(x, y, r)
    table.insert(BWOSquareLoader.nukes, {x=x, y=y, r=r})
end

addNuke(10800, 9800, 700) -- muldraugh
addNuke(10040, 12760, 700) -- march ridge
addNuke(8160, 11550, 700) -- rosewood
addNuke(7267, 8320, 700) -- doe valley
addNuke(6350, 5430, 700) -- riverside
addNuke(11740, 6900, 700) -- westpoint

-- exclusion zones
table.insert(BWOSquareLoader.exclusions, {x1=5000, y1=12000, x2=6200, y2=13000}) -- military research lab

-- mechanic cars - abandoned idea because var cannot spawn inside auto repair shops
--[[
table.insert(BWOSquareLoader.events, {phase="CarMechanic", x=5467, y=9652, z=0, directions=IsoDirections.E}) -- riverside
table.insert(BWOSquareLoader.events, {phase="CarMechanic", x=5467, y=9661, z=0, directions=IsoDirections.E}) -- riverside
table.insert(BWOSquareLoader.events, {phase="CarMechanic", x=10608, y=9404, z=0, directions=IsoDirections.E}) -- muldraugh
table.insert(BWOSquareLoader.events, {phase="CarMechanic", x=10608, y=9409, z=0, directions=IsoDirections.E}) -- muldraugh
table.insert(BWOSquareLoader.events, {phase="CarMechanic", x=10180, y=10936, z=0, directions=IsoDirections.W}) -- muldraugh
table.insert(BWOSquareLoader.events, {phase="CarMechanic", x=10180, y=10945, z=0, directions=IsoDirections.W}) -- muldraugh
table.insert(BWOSquareLoader.events, {phase="CarMechanic", x=5429, y=5960, z=0, directions=IsoDirections.E}) -- riverside
table.insert(BWOSquareLoader.events, {phase="CarMechanic", x=5429, y=5964, z=0, directions=IsoDirections.E}) -- riverside
table.insert(BWOSquareLoader.events, {phase="CarMechanic", x=8151, y=11322, z=0, directions=IsoDirections.W}) -- rosewood
table.insert(BWOSquareLoader.events, {phase="CarMechanic", x=8151, y=11331, z=0, directions=IsoDirections.W}) -- rosewood
table.insert(BWOSquareLoader.events, {phase="CarMechanic", x=11897, y=6809, z=0, directions=IsoDirections.N}) -- westpoint
table.insert(BWOSquareLoader.events, {phase="CarMechanic", x=12283, y=6927, z=0, directions=IsoDirections.W}) -- westpoint
table.insert(BWOSquareLoader.events, {phase="CarMechanic", x=12283, y=6934, z=0, directions=IsoDirections.W}) -- westpoint
]]



-- checks if a point is inside any exclusion zone
BWOSquareLoader.IsInExclusion = function(x, y)
    for _, exclusion in pairs(BWOSquareLoader.exclusions) do
        if x > exclusion.x1 and x < exclusion.x2 and y > exclusion.y1 and y < exclusion.y2 then
            return true
        end
    end
    return false
end

-- updates square to implement prepandemic world and manage add/remove objects
BWOSquareLoader.OnLoad = function(square)

    local clearObjects = function(square)
        local objects = square:getObjects()
        local destroyList = {}
        local legalSprites = {}
        table.insert(legalSprites, "fencing_01_88")
        table.insert(legalSprites, "fencing_01_90")
        table.insert(legalSprites, "fencing_01_90")
        table.insert(legalSprites, "fencing_01_91")
        table.insert(legalSprites, "carpentry_02_13")
        table.insert(legalSprites, "carpentry_02_12")
        table.insert(legalSprites, "fencing_01_96")
    
        for i=0, objects:size()-1 do
            local object = objects:get(i)
            if object then
                local sprite = object:getSprite()
                if sprite then 
                    local spriteName = sprite:getName()
                    local spriteProps = sprite:getProperties()
    
                    local isSolidFloor = spriteProps:Is(IsoFlagType.solidfloor)
                    local isAttachedFloor = spriteProps:Is(IsoFlagType.attachedFloor)
    
                    isLegalSprite = false
                    --[[
                    for _, sp in pairs(legalSprites) do
                        if sp == spriteName then
                            isLegalSprite = true
                            break
                        end
                    end
                    ]]
    
                    if not isSolidFloor and not isLegalSprite then
                        table.insert(destroyList, object)
                    end
                end
            end
        end
    
        for k, obj in pairs(destroyList) do
            if isClient() then
                sledgeDestroy(obj);
            else
                square:transmitRemoveItemFromSquare(obj)
            end
        end
    end

    local addObject = function(square, objectList)
        for _, sprite in pairs(objectList) do
            local obj = IsoObject.new(square, sprite, "")
            square:AddSpecialObject(obj)
            obj:transmitCompleteItemToServer()
            print ("added")
        end
    end

    local isInCircle = function(x, y, cx, cy, r)
        local d2 = ((x - cx) * (x - cx)) + ((y - cy) * (y - cy))
        return d2 <= r * r
    end

	local x = square:getX()
    local y = square:getY()
    local z = square:getZ()
    local md = square:getModData()
    local id = x .. "-" .. y .. "-" .. z

    -- spawn map objects
    if BWOSquareLoader.map[id] then
        clearObjects(square)
        addObject(square, BWOSquareLoader.map[id])
        BWOSquareLoader.map[id] = nil
    end

    -- remove map objects
    if BWOScheduler.WorldAge < 64 then
        if BWOSquareLoader.remove[id] then
            clearObjects(square)
            BWOSquareLoader.remove[id] = nil
        end
    end

    -- remove deadbodies
    if BWOScheduler.WorldAge < 48 then
        local corpse = square:getDeadBody()
        local gmd = GetBWOModData()
        local id = x .. "-" .. y .. "-" .. z
        if corpse and not gmd.DeadBodies[id] then
            -- local args = {x=x, y=y, z=z}
            -- sendClientCommand(getPlayer(), 'Commands', 'DeadBodyAdd', args)
            square:removeCorpse(corpse, true)
            -- sq:AddWorldInventoryItem(corpse:getItem(), 0.5, 0.5, 0)
        end

        if square:haveBlood() then
            square:removeBlood(false, false)
        end
    end

    -- register global objects
    if BWOScheduler.WorldAge < 90 and square:isOutside() then
        local spriteMap = {}
        spriteMap["location_business_bank_01_64"] = "atm"
        spriteMap["location_business_bank_01_65"] = "atm"
        spriteMap["location_business_bank_01_66"] = "atm"
        spriteMap["location_business_bank_01_67"] = "atm"
        spriteMap["street_decoration_01_18"] = "mailbox"
        spriteMap["street_decoration_01_19"] = "mailbox"
        spriteMap["street_decoration_01_20"] = "mailbox"
        spriteMap["street_decoration_01_21"] = "mailbox"

        local customNameMap = {}
        customNameMap["Flowerbed"] = "flowerbed"
        customNameMap["Trash"] = "trash"
        customNameMap["Bench"] = "sittable"
        customNameMap["Chair"] = "sittable"
        -- customNameMap["Machine"] = "machine"

        local objects = square:getObjects()
        for i=0, objects:size()-1 do
            local object = objects:get(i)
            if instanceof(object, "IsoBarbecue") then
                local args = {x=x, y=y, z=z, otype="barbecue"}
                sendClientCommand(getPlayer(), 'Commands', 'ObjectAdd', args)
                break
            end

            local sprite = object:getSprite()
            if sprite then
                local spriteName = sprite:getName()
                if spriteMap[spriteName] then 
                    local args = {x=x, y=y, z=z, otype=spriteMap[spriteName]}
                    sendClientCommand(getPlayer(), 'Commands', 'ObjectAdd', args)
                    break
                end

                local props = sprite:getProperties()
                if props:Is("CustomName") then
                    local customName = props:Val("CustomName")
                    if customNameMap[customName] then 
                        local args = {x=x, y=y, z=z, otype=customNameMap[customName]}
                        sendClientCommand(getPlayer(), 'Commands', 'ObjectAdd', args)
                        break
                    end
                end

                -- this makes npcs disregard windows for pathfinding
                -- unfortunately will impact zombies aswell
                if object:getType() == IsoObjectType.wall then
                    if square:getWindow() then
                        if props:Is(IsoFlagType.canPathN) then
                            props:UnSet(IsoFlagType.canPathN)
                        elseif props:Is(IsoFlagType.canPathW) then
                            props:UnSet(IsoFlagType.canPathW)
                        end
                    end
                end
            end

            local attachments = object:getAttachedAnimSprite()
            if attachments then
                for i=0, attachments:size()-1 do
                    local attachment = attachments:get(i)
                    if attachment and attachment:getName():embodies("blood") then
                        object:clearAttachedAnimSprite()
                        break
                    end
                end
            end
        end
    end

    -- post nuke world destroyer
    if BWOScheduler.WorldAge >= 168 then
        if not md.BWO then md.BWO = {} end

        if not md.BWO.burnt then
            local nukes = BWOSquareLoader.nukes
            for _, nuke in pairs(nukes) do
                if isInCircle(x, y, nuke.x, nuke.y, nuke.r) then
                    BWOSquareLoader.Burn(square)
                end
            end
            md.BWO.burnt = true
        end
    end
end

-- spawns location events when player is near
BWOSquareLoader.LocationEvents = function(ticks)
    if ticks % 10 > 0 then return end

    local tab = BWOSquareLoader.events
    local player = getPlayer()
    local cell = getCell()
    for i, event in pairs(tab) do
        local square = cell:getGridSquare(event.x, event.y, event.z)
        if square then
            if BanditUtils.DistToManhattan(player:getX(), player:getY(), event.x, event.y) < 70 then
                if BWOEventsPlace[event.phase] then
                    BWOEventsPlace[event.phase](event)
                end
                table.remove(BWOSquareLoader.events, i)
                break
            end
        end
    end
end

-- removes burnt / smashed vehicles
-- apparently vehicle loading is deffered relative to square load, so this needs to be handled separately
BWOSquareLoader.VehicleFixOrRemove = function()
    if BWOScheduler.WorldAge > 90 then return end

    local vehicleList = getCell():getVehicles()
    local toDelete = {}
    for i=0, vehicleList:size()-1 do
        local vehicle = vehicleList:get(i)
        if vehicle then
            local md = vehicle:getModData()
            if not md.BWO then md.BWO = {} end

            if not md.BWO.wasRepaired then
                local scriptName = vehicle:getScriptName()
                local engine = vehicle:getPartById("Engine")
                if scriptName:embodies("Burnt") or scriptName:embodies("Smashed") or (engine and engine:getCondition() < 50) then
                    table.insert(toDelete, vehicle)
                else
                    vehicle:repair()
                    vehicle:setTrunkLocked(true)
                    for i=0, vehicle:getMaxPassengers() -1 do 
                        local part = vehicle:getPassengerDoor(i)
                        if part then 
                            local door = part:getDoor()
                            if door then
                                door:setLocked(true)
                            end
                        end
                    end

                    local gasTank = vehicle:getPartById("GasTank")
                    if gasTank then
                        local max = gasTank:getContainerCapacity() * 0.8
                        gasTank:setContainerContentAmount(ZombRandFloat(0, max))
                    end
                    md.BWO.wasRepaired = true
                end
            end
        end
    end

    for _, vehicle in pairs(toDelete) do
        if isClient() then
            sendClientCommand(getPlayer(), "vehicle", "remove", { vehicle = vehicle:getId() })
        else
            vehicle:permanentlyRemove()
        end
    end
end

Events.LoadGridsquare.Add(BWOSquareLoader.OnLoad)
Events.OnTick.Add(BWOSquareLoader.LocationEvents)
Events.EveryOneMinute.Add(BWOSquareLoader.VehicleFixOrRemove)