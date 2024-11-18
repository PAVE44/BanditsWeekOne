BWOSquareLoader = BWOSquareLoader or {}
BWOSquareLoader.map = {}

-- x
-- siatka naprzemieninie:
-- 1x fencing_01_88
-- 1x fencing_01_89
-- y+1:
-- 2x carpentry_02_13 - sandbags
-- 1x fencing_01_96 - pudlo ze zwirem
-- sign:
-- 1xlocation_military_generic_01_19
-- 1xlocation_military_generic_01_20
-- lighting_outdoor_01_49

-- y
-- siatka naprzemieninie:
-- 1x fencing_01_90
-- 1x fencing_01_91
-- y+1:
-- 2x carpentry_02_12 - sandbags
-- 1x fencing_01_96 - pudlo ze zwirem
-- sign:
-- 1xlocation_military_generic_01_27
-- 1xlocation_military_generic_01_28

-- x:10583, y:10679
-- x:10583, y:9332

-- mulgraugh west
for y=10678, 9300, -1 do
    local x
    local z = 0
    local id 
    local sprite
    
    x = 10584
    id = x .. "-" .. y .. "-" .. z
    if y % 2 == 0 then
        sprite = "fencing_01_90"
    else
        sprite = "fencing_01_91"
    end
    BWOSquareLoader.map[id] = {}
    table.insert(BWOSquareLoader.map[id], sprite)

    x = 10583
    id = x .. "-" .. y .. "-" .. z
    if y % 3 == 0 then
        sprite = "fencing_01_96"
    else
        sprite = "carpentry_02_12"
    end
    BWOSquareLoader.map[id] = {}
    table.insert(BWOSquareLoader.map[id], sprite)
end

-- muldraugh south
for x=10584, 11018 do
    local y
    local z = 0
    local id 
    local sprite1
    local sprite2
    
    if x >= 10588 and x <= 10595 then
    elseif x >= 10786 and x <= 10793 then
    else
        y = 10679
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

-- muldraugh east
for y=10678, 9332, -1 do
    local x
    local z = 0
    local id 
    local sprite1
    local sprite2
    
    if y >= 10327 and y <= 10330 then
    elseif y >= 9565 and y <= 9570 then
    elseif y >= 9398 and y <= 9401 then
    else
        if y >= 9428 then
            x = 11019
        else
            x = 11013
        end
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

-- ...
for x=11018, 11013, -1 do
    local y
    local z = 0
    local id 
    local sprite1
    local sprite2
    
    y = 9429
    id = x .. "-" .. y .. "-" .. z
    if x % 2 == 0 then
        sprite1 = "fencing_01_88"
    else
        sprite1 = "fencing_01_89"
    end
    BWOSquareLoader.map[id] = {}
    table.insert(BWOSquareLoader.map[id], sprite1)

    y = 9328
    id = x .. "-" .. y .. "-" .. z
    if x % 3 == 0 then
        sprite2 = "fencing_01_96"
    else
        sprite2 = "carpentry_02_13"
    end
    BWOSquareLoader.map[id] = {}
    table.insert(BWOSquareLoader.map[id], sprite2)
end

-- muldraugh north
for x=10584, 11018 do
    local y
    local z = 0
    local id 
    local sprite1
    local sprite2
    
    if x >= 10588 and x <= 10595 then
    elseif x >= 11044 and x <= 11050 then
    else
        y = 9332
        id = x .. "-" .. y .. "-" .. z
        if x % 2 == 0 then
            sprite1 = "fencing_01_88"
        else
            sprite1 = "fencing_01_89"
        end
        BWOSquareLoader.map[id] = {}
        table.insert(BWOSquareLoader.map[id], sprite1)

        y = 9331
        id = x .. "-" .. y .. "-" .. z
        if x % 3 == 0 then
            sprite2 = "fencing_01_96"
        else
            sprite2 = "carpentry_02_13"
        end
        BWOSquareLoader.map[id] = {}
        table.insert(BWOSquareLoader.map[id], sprite2)
    end
end

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
    if BWOSquareLoader.map[id] then
        BWOSquareLoader.Clear(square)
        BWOSquareLoader.Add(square, BWOSquareLoader.map[id])
        BWOSquareLoader.map[id] = nil
    end

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

    if BWOScheduler.WorldAge < 72 then
        local spriteMap = {}
        spriteMap["location_business_bank_01_64"] = "atm"
        spriteMap["location_business_bank_01_65"] = "atm"
        spriteMap["location_business_bank_01_66"] = "atm"
        spriteMap["location_business_bank_01_67"] = "atm"
        spriteMap["FIXME"] = "mailbox"
        spriteMap["FIXME"] = "mailbox"

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
            end
        end
    end

end

Events.LoadGridsquare.Add(BWOSquareLoader.OnLoad)