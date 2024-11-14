BWOObjects = BWOObjects or {}

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
            distBest = dist
            result.dist = dist
            result.x = deadBody.x
            result.y = deadBody.y
            result.z = deadBody.z
        end
    end

    return result
end