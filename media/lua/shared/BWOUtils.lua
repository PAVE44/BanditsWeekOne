BanditUtils = BanditUtils or {}

BanditUtils.GetTime = function()
    local world = getWorld()
    local gamemode = world:getGameMode()
    if gamemode == "Multiplayer" then
        --return GameTime:getServerTimeMills()
        return getGameTime():getWorldAgeHours() * 2500000 / 24
    else
        return getGameTime():getWorldAgeHours() * 2500000 / 24
    end
end

function BanditUtils.GetClosestBanditLocationProgram(character, programs)
    local result = {}
    local cid = BanditUtils.GetCharacterID(character)

    result.dist = math.huge
    result.x = false
    result.y = false
    result.z = false
    result.id = false
    
    local cx, cy = character:getX(), character:getY()

    local zombieList = BanditZombie.GetAllB()
    for id, zombie in pairs(zombieList) do
        for _, program in pairs(programs) do
            if zombie.brain.program.name == program then
                if math.abs(zombie.x - cx) < 30 or math.abs(zombie.y - cy) < 30 then
                    local dist = BanditUtils.DistTo(cx, cy, zombie.x, zombie.y)
                    if dist < result.dist and cid ~= id then
                        result.dist = dist
                        result.x = zombie.x
                        result.y = zombie.y
                        result.z = zombie.z
                        result.id = zombie.id
                    end
                end
            end
        end
    end

    return result
end

function BanditUtils.LineClear(obj1, obj2)
    local cell = obj1:getCell()
    local x1, y1, z1 = obj1:getX(), obj1:getY(), obj1:getZ()
    local x2, y2, z2 = obj2:getX(), obj2:getY(), obj2:getZ()
    return tostring(LosUtil.lineClear(cell, x1, y1, z1, x2, y2, z2, false)) ~= "Blocked"
end

function BanditUtils.GetSurfaceOffset(x, y, z)
    local cell = getCell()
    local square = cell:getGridSquare(x, y, z)
    local tileObjects = square:getLuaTileObjectList()
    local squareSurfaceOffset = 0

    -- get the object with the highest offset
    for k, object in pairs(tileObjects) do
        local surfaceOffsetNoTable = object:getSurfaceOffsetNoTable()
        if surfaceOffsetNoTable > squareSurfaceOffset then
            squareSurfaceOffset = surfaceOffsetNoTable
        end

        local surfaceOffset = object:getSurfaceOffset()
        if surfaceOffset > squareSurfaceOffset then
            squareSurfaceOffset = surfaceOffset
        end
    end

    return squareSurfaceOffset / 96
end