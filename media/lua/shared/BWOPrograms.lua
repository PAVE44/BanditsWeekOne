BanditPrograms = BanditPrograms or {}

-- this is a collection of universal subprograms that are shared by main npc programs.

BanditPrograms.Symptoms = function(bandit)
    local tasks = {}

    local id = BanditUtils.GetCharacterID(bandit)
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()

    local combined = math.abs(id) + (hour * 60) + minute
    if combined > 1000000000 then combined = math.floor(combined / 100) end
    local pseudoRandom = (combined * 137) % 60

    if BWOScheduler.SymptomLevel == 1 or BWOScheduler.SymptomLevel == 2 then

        if pseudoRandom < 5 then
            local rn = ZombRand(2)
            if rn == 0 then
                local sound
                if bandit:isFemale() then
                    sound = "ZSCoughF" .. (1 + ZombRand(4))
                else
                    sound = "ZSCoughM" .. (1 + ZombRand(4))
                end
                local task = {action="Time", anim="Cough", sound=sound, time=100}
                table.insert(tasks, task)
                return tasks
            else
                local task = {action="Time", anim="Sneeze", time=100}
                table.insert(tasks, task)
                return tasks
            end
        end
    elseif BWOScheduler.SymptomLevel == 2 then
        if pseudoRandom < 11 then
            local rn = ZombRand(10)
            if rn < 7 then
                local sound
                if bandit:isFemale() then
                    sound = "ZSCoughF" .. (1 + ZombRand(4))
                else
                    sound = "ZSCoughM" .. (1 + ZombRand(4))
                end
                local task = {action="Time", anim="Cough", sound=sound, time=100}
                table.insert(tasks, task)
                return tasks
            elseif rn == 7 then
                local task = {action="Time", anim="PainTorso", time=100}
                table.insert(tasks, task)
                return tasks
            elseif rn == 8 then
                local task = {action="Time", anim="PainStomach1", time=100}
                table.insert(tasks, task)
                return tasks
            elseif rn == 9 then
                local task = {action="Time", anim="PainStomach2", time=100}
                table.insert(tasks, task)
                return tasks
            end
        end
    elseif BWOScheduler.SymptomLevel == 3 then
        if pseudoRandom < 15 then
            local rn = ZombRand(20)
            if rn < 14 then
                local sound 
                if bandit:isFemale() then
                    sound = "ZSCoughF" .. (1 + ZombRand(4))
                else
                    sound = "ZSCoughM" .. (1 + ZombRand(4))
                end
                local task = {action="Time", anim="Cough", sound=sound, time=100}
                table.insert(tasks, task)
                return tasks
            elseif rn == 14 then
                local task = {action="Time", anim="PainTorso", time=100}
                table.insert(tasks, task)
                return tasks
            elseif rn == 15 then
                local task = {action="Time", anim="PainStomach1", time=100}
                table.insert(tasks, task)
                return tasks
            elseif rn == 16 then
                local task = {action="Time", anim="PainStomach2", time=100}
                table.insert(tasks, task)
                return tasks
            elseif rn == 17 then
                Bandit.UpdateInfection(bandit, pseudoRandom + 30)
                local task = {action="Time", anim="FeelFeint", time=100}
                table.insert(tasks, task)
                return tasks
            else
                local sound = "ZSVomit" .. (1 + ZombRand(4))
                local task = {action="Vomit", anim="Vomit", sound=sound, time=100}
                table.insert(tasks, task)
                return tasks
            end
        end
    elseif BWOScheduler.SymptomLevel == 4 then
        if pseudoRandom < 20 then
            local rn = ZombRand(20)
            if rn < 10 then
                local sound 
                if bandit:isFemale() then
                    sound = "ZSCoughF" .. (1 + ZombRand(4))
                else
                    sound = "ZSCoughM" .. (1 + ZombRand(4))
                end
                local task = {action="Vomit", anim="Scramble", sound=sound, time=100}
                table.insert(tasks, task)
                return tasks
            elseif rn < 14 then
                -- let's get the party started!!!
                Bandit.UpdateInfection(bandit, pseudoRandom + 30)
            else
                local sound = "ZSVomit" .. (1 + ZombRand(4))
                local task = {action="Vomit", anim="Scramble", sound=sound, time=100}
                table.insert(tasks, task)
                return tasks
            end
        end
    end
    return tasks
end

BanditPrograms.Events = function(bandit)
    local tasks = {}
    local cell = bandit:getCell()
    local id = BanditUtils.GetCharacterID(bandit)

    if BWOScheduler.WorldAge > 64 then return tasks end

    local target = BWOObjects.FindDeadBody(bandit)
    if target.x and target.y and target.z then
        local square = cell:getGridSquare(target.x, target.y, target.z)
        if square and BanditUtils.LineClear(bandit, square) then
            if target.dist >= 3 and target.dist < 15 then
                local walkType = "Run"
                table.insert(tasks, BanditUtils.GetMoveTask(0, target.x, target.y, target.z, walkType, target.dist, false))
                return tasks
            elseif target.dist < 3 then
                if square then
                    deadbody = square:getDeadBody()
                    if deadbody then
                        Bandit.Say(bandit, "CORPSE")
                        local anim = BanditUtils.Choice({"SmellBad", "SmellGag", "PainHead", "ChewNails", "No", "No", "WipeBrow"})
                        local task = {action="FaceLocation", anim=anim, time=100, x=deadbody:getX(), y=deadbody:getY(), z=deadbody:getZ()}
                        table.insert(tasks, task)
                        return tasks
                    end
                end
            end
        end
    end

    local target = BWOObjects.FindGMD(bandit, "protest")
    if target.x and target.y and target.z then
        local square = cell:getGridSquare(target.x, target.y, target.z)
        if square and BanditUtils.LineClear(bandit, square) then
            if target.dist >= 9 and target.dist < 80 then
                local walkType = "Walk"
                table.insert(tasks, BanditUtils.GetMoveTask(0, target.x, target.y, target.z, walkType, target.dist, false))
                return tasks
            elseif target.dist < 9 then
                -- Bandit.Say(bandit, "ADMIRE")
                local rnd = math.abs(id) % 3

                local anim
                local sound
                local item
                if rnd == 0 then
                    anim = "Protest1"
                elseif rnd == 1 then
                    anim = "Protest2"
                elseif rnd == 2 then
                    anim = "Protest3"
                    item = "AuthenticZClothing.Stop_Sign"
                else
                    anim = "Clap"
                end

                local task = {action="TimeItem", sound=sound, soundDistMax=12, anim=anim, item=item, x=target.x, y=target.y, z=target.z, time=200}
                table.insert(tasks, task)
                return tasks
            end
        end
    end

    local target = BWOObjects.FindGMD(bandit, "preacher")
    if target.x and target.y and target.z then
        local square = cell:getGridSquare(target.x, target.y, target.z)
        if square and BanditUtils.LineClear(bandit, square) then
            if target.dist >= 4 and target.dist < 30 then
                local walkType = "Walk"
                table.insert(tasks, BanditUtils.GetMoveTask(0, target.x, target.y, target.z, walkType, target.dist, false))
                return tasks
            elseif target.dist < 4 then
                local ententainer = BanditUtils.GetClosestBanditLocationProgram(bandit, "Entertainer")

                if ententainer.id then
                    -- Bandit.Say(bandit, "ADMIRE")
                    local anim = "Yes"
                    local sound 
                    local task = {action="TimeEvent", sound=sound, soundDistMax=12, anim=anim, x=target.x, y=target.y, z=target.z, time=200}
                    table.insert(tasks, task)
                    return tasks
                else
                    local args = {x=target.x, y=target.y, z=target.z}
                    sendClientCommand(getPlayer(), 'Commands', 'ObjectRemove', args)
                end
            end
        end
    end

    local target = BWOObjects.FindGMD(bandit, "entertainer")
    if target.x and target.y and target.z then
        local square = cell:getGridSquare(target.x, target.y, target.z)
        if square and BanditUtils.LineClear(bandit, square) then
            if target.dist >= 6 and target.dist < 30 then
                local walkType = "Walk"
                table.insert(tasks, BanditUtils.GetMoveTask(0, target.x, target.y, target.z, walkType, target.dist, false))
                return tasks
            elseif target.dist < 6 then
                local ententainer = BanditUtils.GetClosestBanditLocationProgram(bandit, "Entertainer")

                if ententainer.id then
                    Bandit.Say(bandit, "ADMIRE")
                    local anim = "Clap"
                    local sound = "BWOClap" .. tostring(1 + ZombRand(13))
                    local task = {action="TimeEvent", sound=sound, soundDistMax=12, anim=anim, x=target.x, y=target.y, z=target.z, time=200}
                    table.insert(tasks, task)
                    return tasks
                else
                    local args = {x=target.x, y=target.y, z=target.z}
                    sendClientCommand(getPlayer(), 'Commands', 'ObjectRemove', args)
                end
            end
        end
    end
    return tasks
end

BanditPrograms.Bench = function(bandit)
    local tasks = {}

    if BWOScheduler.WorldAge > 64 then return tasks end

    local cell = bandit:getCell()

    local target = BWOObjects.FindGMD(bandit, "sittable")
    if target.x and target.y and target.z and target.dist < 10 then
        local square = cell:getGridSquare(target.x, target.y, target.z)
        if square and square:isOutside() and BanditUtils.LineClear(bandit, square) then
            local id = BanditUtils.GetCharacterID(bandit)
            local zombie = square:getZombie()
            if (not zombie or BanditUtils.GetCharacterID(zombie) == id) then
                local objects = square:getObjects()
                local bench
                local facing
                for i=0, objects:size()-1 do
                    local object = objects:get(i)
                    local sprite = object:getSprite()
                    if sprite then
                        local props = sprite:getProperties()
                        if props:Is("CustomName") then
                            local customName = props:Val("CustomName")
                            if customName == "Bench" or customName == "Chair" then
                                bench = object
                                facing = props:Val("Facing")
                                break
                            end
                        end
                    end
                end

                if bench then
                    local dist = BanditUtils.DistTo(bandit:getX(), bandit:getY(), square:getX() + 0.5, square:getY() + 0.5)
                    if dist > 1.6 then
                        table.insert(tasks, BanditUtils.GetMoveTask(0, square:getX() + 0.5, square:getY() + 0.5, square:getZ(), "Walk", dist, false))
                        return tasks
                    else
                        local anim = BanditUtils.Choice({"SitInChair"})
                        local task = {action="SitInChair", anim=anim, x=square:getX(), y=square:getY(), z=square:getZ(), facing=facing, time=100}
                        table.insert(tasks, task)
                        return tasks
                    end
                end
            end
        end
    end

    return tasks
end

BanditPrograms.ATM = function(bandit)
    local tasks = {}
    local cell = bandit:getCell()

    if BWOScheduler.WorldAge < 69 or BWOScheduler.WorldAge > 82 then return tasks end

    local target = BWOObjects.FindGMD(bandit, "atm")      
    if target.x and target.y and target.z and target.dist < 25 then
        local square = cell:getGridSquare(target.x, target.y, target.z)
        if square and BanditUtils.LineClear(bandit, square) then
            local objects = square:getObjects()
            local atm
            local standSquare
            local fx = 0
            local fy = 0
            for i=0, objects:size()-1 do
                local object = objects:get(i)
                local sprite = object:getSprite()
                if sprite then
                    local spriteName = sprite:getName()
                    if spriteName == "location_business_bank_01_67" then
                        atm = object
                        standSquare = square
                        fy = -1.5
                    elseif spriteName == "location_business_bank_01_66" then
                        atm = object
                        standSquare = square
                        fx = -1.5
                    elseif spriteName == "location_business_bank_01_65" then
                        atm = object
                        standSquare = square:getS()
                        fx = -1.5
                    elseif spriteName == "location_business_bank_01_64" then
                        atm = object
                        standSquare = square:getE()
                        fx = -1.5
                    end
                end
            end

            if atm then
                local dist = BanditUtils.DistTo(bandit:getX(), bandit:getY(), standSquare:getX() + 0.5, standSquare:getY() + 0.5)
                if dist > 0.4 then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, standSquare:getX(), standSquare:getY(), standSquare:getZ(), "Walk", dist, false))
                    return tasks
                else
                    Bandit.Say(bandit, "ATMFAIL")
                    local task = {action="FaceLocation", anim="Loot", sound="ZSObjectATMFail", x=target.x+fx, y=target.y+fy, z=target.z, time=300}
                    table.insert(tasks, task)
                    return tasks
                end
            end
        end
    end
    return tasks
end

BanditPrograms.Talk = function(bandit)
    local tasks = {}

    if BWOScheduler.WorldAge > 57 then return tasks end

    local neighborBandit = BanditUtils.GetClosestBanditLocation(bandit)
    local neighborPlayer = BanditUtils.GetClosestPlayerLocation(bandit, true)

    local neighbor = neighborBandit
    if neighborPlayer.dist < neighborBandit.dist then
        neighbor = neighborPlayer
    end

    if neighbor.dist < 3 then
        local square = getCell():getGridSquare(neighbor.x, neighbor.y, neighbor.z)
        if square and BanditUtils.LineClear(bandit, square) then
            if ZombRand(2) == 0 then
                if BWOScheduler.WorldAge < 34 then
                    Bandit.Say(bandit, "STREETCHAT1")
                else
                    Bandit.Say(bandit, "STREETCHAT2")
                end

                local anim = BanditUtils.Choice({"WaveHi", "Yes", "No", "Talk1", "Talk2", "Talk3", "Talk4", "Talk5"})
                local task = {action="FaceLocation", anim=anim, x=neighbor.x, y=neighbor.y, z=neighbor.z, time=100}
                table.insert(tasks, task)
                return tasks
            end
        end
    end
    return tasks
end

BanditPrograms.FollowRoad = function(bandit, walkType)
    local tasks = {}
    local cell = bandit:getCell()
    local bx = bandit:getX()
    local by = bandit:getY()
    local bz = bandit:getZ()
    local direction = bandit:getForwardDirection()
    local angle = direction:getDirection()
    direction:setLength(8)

    local step = 0.785398163 / 2 -- 22.5 deg
    for i = 0, 14 do
        for j=-1, 1, 2 do
            local newangle = angle + (i * j * step)
            if newangle > 6.283185304 then newangle = newangle - 6.283185304 end
            direction:setDirection(newangle)

            local vx = bx + direction:getX()
            local vy = by + direction:getY()
            local vz = bz
            local square = cell:getGridSquare(vx, vy, vz)
            if square and square:isOutside() then
                local groundType = BanditUtils.GetGroundType(square)
                if groundType == "street" then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, vx, vy, vz, walkType, 2, false))
                    return tasks
                end
            end
        end
    end
    return tasks
end

BanditPrograms.GoSomewhere = function(bandit, walkType)
    local tasks = {}
    local bx = bandit:getX()
    local by = bandit:getY()
    local bz = bandit:getZ()
    local id = BanditUtils.GetCharacterID(bandit)

    local rnd = math.abs(id) % 4
    local dx = 0
    local dy = 0
    if rnd == 0 then
        dx = 8 + ZombRand(5)
    elseif rnd == 1 then
        dy = 8 + ZombRand(5)
    elseif rnd == 2 then
        dx = -(8 + ZombRand(5))
    elseif rnd == 3 then
        dy = -(8 + ZombRand(5))
    end

    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    if hour % 2 == 0 then
        dx = -dx
        dy = -dy
    end

    table.insert(tasks, BanditUtils.GetMoveTask(0, bx + dx, by + dy, 0, walkType, 10, false))
    return tasks
end

BanditPrograms.Fallback = function(bandit)
    local tasks = {}
    local rnd = ZombRand(2)

    if rnd == 0 then
        local task = {action="Smoke", anim="Smoke", item="Bandits.Cigarette", left=true, time=100}
        table.insert(tasks, task)
    else
        local anim = BanditUtils.Choice({"WipeBrow", "WipeHead"})
        local task = {action="Time", anim=anim, time=100}
        table.insert(tasks, task)
    end
    return tasks
end