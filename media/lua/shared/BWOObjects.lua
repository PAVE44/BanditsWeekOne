BWOObjects = BWOObjects or {}

-- this is a collection of functions resonsible for finding a particular map object that is required
-- by various npc programs

BWOObjects.Find = function (bandit, def, objName)
    local cell = getCell()
    local bid = BanditUtils.GetCharacterID(bandit)
    local bx = bandit:getX()
    local by = bandit:getY()
    local bz = bandit:getZ()
    local foundDist = math.huge
    local foundObj
    for x=def:getX(), def:getX2() do
        for y=def:getY(), def:getY2() do
            local square = cell:getGridSquare(x, y, def:getZ())
            if square then
                local zombie = square:getZombie()
                if not zombie or BanditUtils.GetCharacterID(zombie) == bid then
                    local objects = square:getObjects()
                    for i=0, objects:size()-1 do
                        local object = objects:get(i)
                        local sprite = object:getSprite()
                        if sprite then
                            local props = sprite:getProperties()
                            if props:Is("CustomName") then
                                local name = props:Val("CustomName")
                                if name == objName then
                                    local dist = math.sqrt(math.pow(x - bx, 2) + math.pow(y - by, 2))
                                    if dist < foundDist then
                                        foundObj = object
                                        foundDist = dist
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return foundObj
end

BWOObjects.FindAround = function (bandit, r, objName)
    local cell = getCell()
    local bid = BanditUtils.GetCharacterID(bandit)
    local bx = bandit:getX()
    local by = bandit:getY()
    local bz = bandit:getZ()
    local foundDist = math.huge
    local foundObj
    for x=bx-r, bx+r do
        for y=by-r, by+r do
            local square = cell:getGridSquare(x, y, bz)
            if square then
                local zombie = square:getZombie()
                if not zombie or BanditUtils.GetCharacterID(zombie) == bid then
                    local objects = square:getObjects()
                    for i=0, objects:size()-1 do
                        local object = objects:get(i)
                        local sprite = object:getSprite()
                        if sprite then
                            local props = sprite:getProperties()
                            if props:Is("CustomName") then
                                local name = props:Val("CustomName")
                                if name == objName then
                                    local dist = math.sqrt(math.pow(x - bx, 2) + math.pow(y - by, 2))
                                    if dist < foundDist then
                                        foundObj = object
                                        foundDist = dist
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return foundObj
end

BWOObjects.FindFire = function (bandit, r)
    local cell = getCell()
    local bid = BanditUtils.GetCharacterID(bandit)
    local bx = bandit:getX()
    local by = bandit:getY()
    local bz = bandit:getZ()
    local foundDist = math.huge
    local foundObj
    for x=bx-r, bx+r do
        for y=by-r, by+r do
            local square = cell:getGridSquare(x, y, bz)
            if square then
                if square:haveFire() then
                    local dist = math.sqrt(math.pow(x - bx, 2) + math.pow(y - by, 2))
                    if dist < foundDist then
                        foundObj = square
                        foundDist = dist
                    end
                end
            end
        end
    end
    return foundObj
end

BWOObjects.FindBarricadable = function (bandit, def)
    local cell = getCell()
    local bid = BanditUtils.GetCharacterID(bandit)
    local bx = bandit:getX()
    local by = bandit:getY()
    local bz = bandit:getZ()
    local foundDist = math.huge
    local foundObj
    for x=def:getX(), def:getX2() + 1 do
        for y=def:getY(), def:getY2() + 1 do
            local square = cell:getGridSquare(x, y, def:getZ())
            if square then
                local zombie = square:getZombie()
                if not zombie or BanditUtils.GetCharacterID(zombie) == bid then
                    local objects = square:getObjects()
                    for i=0, objects:size()-1 do
                        local object = objects:get(i)
                        if instanceof(object, "IsoWindow") or instanceof(object, "IsoDoor") then
                            local oppositeSquare = object:getOppositeSquare()
                            if oppositeSquare then
                                if square:isOutside() ~= oppositeSquare:isOutside() then
                                    
                                    local numPlanks = 0
                                    local barricade = object:getBarricadeOnSameSquare()
                                    if barricade then
                                        numPlanks = numPlanks + barricade:getNumPlanks()
                                    end

                                    local barricade2 = object:getBarricadeOnOppositeSquare()
                                    if barricade2 then
                                        numPlanks = numPlanks + barricade2:getNumPlanks()
                                    end

                                    if numPlanks < 4 then
                                        local dist = math.sqrt(math.pow(x - bx, 2) + math.pow(y - by, 2))
                                        if dist < foundDist then
                                            foundObj = object
                                            foundDist = dist
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
    return foundObj
end

BWOObjects.FindExteriorDoor = function (bandit, def)
    local cell = getCell()
    local bid = BanditUtils.GetCharacterID(bandit)
    local bx = bandit:getX()
    local by = bandit:getY()
    local bz = bandit:getZ()
    local foundDist = math.huge
    local foundObj
    for x=def:getX(), def:getX2() + 1 do
        for y=def:getY(), def:getY2() + 1 do
            local square = cell:getGridSquare(x, y, def:getZ())
            if square then
                local zombie = square:getZombie()
                if not zombie or BanditUtils.GetCharacterID(zombie) == bid then
                    local objects = square:getObjects()
                    for i=0, objects:size()-1 do
                        local object = objects:get(i)
                        if instanceof(object, "IsoDoor") then
                            if object:isExterior() then
                                local dist = math.sqrt(math.pow(x - bx, 2) + math.pow(y - by, 2))
                                if dist < foundDist then
                                    foundObj = object
                                    foundDist = dist
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return foundObj
end

BWOObjects.FindLightSwitch = function (bandit, def)
    local cell = getCell()
    local bid = BanditUtils.GetCharacterID(bandit)
    local bx = bandit:getX()
    local by = bandit:getY()
    local bz = bandit:getZ()
    local foundDist = math.huge
    local foundObj
    for x=def:getX(), def:getX2() do
        for y=def:getY(), def:getY2() do
            local square = cell:getGridSquare(x, y, def:getZ())
            if square and not square:isOutside() then
                local objects = square:getObjects()
                for i=0, objects:size()-1 do
                    local object = objects:get(i)
                    if instanceof(object, "IsoLightSwitch") then
                        local dist = math.sqrt(math.pow(x - bx, 2) + math.pow(y - by, 2))
                        if dist < foundDist then
                            foundObj = object
                            foundDist = dist
                        end
                    end
                end
            end
        end
    end
    return foundObj
end

BWOObjects.FindDeadBody = function (bandit)
    local gmd = GetBWOModData()
    local bx, by = bandit:getX(), bandit:getY()

    local result = {}
    result.dist = math.huge
    result.x = false
    result.y = false
    result.z = false

    for id, deadBody in pairs(gmd.DeadBodies) do
        local dist = BanditUtils.DistTo(bx, by, deadBody.x, deadBody.y)
        if dist < result.dist then
            result.dist = dist
            result.x = deadBody.x
            result.y = deadBody.y
            result.z = deadBody.z
        end
    end

    return result
end

BWOObjects.FindGMD = function (bandit, otype)
    local gmd = GetBWOModData()
    local bx, by = bandit:getX(), bandit:getY()

    local result = {}
    result.dist = math.huge
    result.x = false
    result.y = false
    result.z = false

    for id, object in pairs(gmd.Objects) do
        if object.otype == otype then
            local dist = BanditUtils.DistTo(bx, by, object.x, object.y)
            if dist < result.dist then
                result.dist = dist
                result.x = object.x
                result.y = object.y
                result.z = object.z
            end
        end
    end

    return result
end