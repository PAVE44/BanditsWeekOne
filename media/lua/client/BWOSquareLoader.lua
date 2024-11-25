BWOSquareLoader = BWOSquareLoader or {}
BWOSquareLoader.map = {}
BWOSquareLoader.events = {}

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

addBarricadeSouth(10775, 10805, 10715)
table.insert(BWOSquareLoader.events, {phase="ArmyGuards", x=10790, y=10706, z=0})

addBarricadeWest(9306, 9329, 11097)
table.insert(BWOSquareLoader.events, {phase="ArmyGuards", x=11091, y=9317, z=0})

addBarricadeNorth(10950, 10970, 8928)
table.insert(BWOSquareLoader.events, {phase="ArmyGuards", x=10962, y=8932, z=0})

addBarricadeNorth(10570, 10608, 9148)
table.insert(BWOSquareLoader.events, {phase="ArmyGuards", x=10591, y=9152, z=0})

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

BWOSquareLoader.Clear = function(square)
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

BWOSquareLoader.Add = function(square, objectList)
    for _, sprite in pairs(objectList) do
        local obj = IsoObject.new(square, sprite, "")
        square:AddSpecialObject(obj)
        obj:transmitCompleteItemToServer()
        print ("added")
    end
end

BWOSquareLoader.OnLoad = function(square)
    local test = BWOSquareLoader.map
	local x = square:getX()
    local y = square:getY()
    local z = square:getZ()
    local id = x .. "-" .. y .. "-" .. z

    -- spawn map objects
    if BWOSquareLoader.map[id] then
        BWOSquareLoader.Clear(square)
        BWOSquareLoader.Add(square, BWOSquareLoader.map[id])
        BWOSquareLoader.map[id] = nil
    end

    -- remove burnt / smashed vehicles
    if BWOScheduler.WorldAge < 48 then
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
    if BWOScheduler.WorldAge < 72 then
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

                if object:getType() == IsoObjectType.wall then
                    if props:Is(IsoFlagType.canPathN) then
                        props:UnSet(IsoFlagType.canPathN)
                    elseif props:Is(IsoFlagType.canPathW) then
                        props:UnSet(IsoFlagType.canPathW)
                    end
                end
            end
        end
    end
end

BWOSquareLoader.LocationEvents = function()
    local tab = BWOSquareLoader.events
    local player = getPlayer()
    local cell = getCell()
    for i, event in pairs(tab) do
        local square = cell:getGridSquare(event.x, event.y, event.z)
        if square then
            if BanditUtils.DistToManhattan(player:getX(), player:getY(), event.x, event.y) < 70 then
                if BWOEventsPlace[event.phase] then
                    BWOEventsPlace[event.phase](event.x, event.y, event.z)
                end
                table.remove(BWOSquareLoader.events, i)
                break
            end
        end
    end
end

Events.LoadGridsquare.Add(BWOSquareLoader.OnLoad)
Events.EveryOneMinute.Add(BWOSquareLoader.LocationEvents)