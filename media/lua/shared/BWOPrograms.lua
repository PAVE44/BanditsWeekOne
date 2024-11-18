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

BanditPrograms.CrimeScene = function(bandit)
    local tasks = {}
    local cell = bandit:getCell()

    local target = BWOObjects.FindDeadBody(bandit)
    if target.x and target.y and target.z then
        if target.dist >= 3 and target.dist < 20 then
            local walkType = "Run"
            table.insert(tasks, BanditUtils.GetMoveTask(0, target.x, target.y, target.z, walkType, target.dist, false))
            return tasks
        elseif target.dist < 3 then
            local square = cell:getGridSquare(target.x, target.y, target.z)
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

BanditPrograms.Talk = function(bandit)
    local tasks = {}
    local neighborBandit = BanditUtils.GetClosestBanditLocation(bandit)
    local neighborPlayer = BanditUtils.GetClosestPlayerLocation(bandit, true)

    local neighbor = neighborBandit
    if neighborPlayer.dist < neighborBandit.dist then
        neighbor = neighborPlayer
    end

    if neighbor.dist < 3 and ZombRand(2) == 1 then
        if not bandit:getSquare():isSomethingTo(getCell():getGridSquare(neighbor.x, neighbor.y, neighbor.z)) then
            Bandit.Say(bandit, "STREETCHAT")
            local anim = BanditUtils.Choice({"WaveHi", "Yes", "No", "Talk1", "Talk2", "Talk3", "Talk4", "Talk5"})
            local task = {action="FaceLocation", anim=anim, x=neighbor.x, y=neighbor.y, z=neighbor.z, time=100}
            table.insert(tasks, task)
            return tasks
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
            if square then
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

    local rnd = math.abs(id % 4)
    local dx = 0
    local dy = 0
    if rnd == 0 then
        dx = 10
    elseif rnd == 1 then
        dy = 10
    elseif rnd == 2 then
        dx = -10
    elseif rnd == 3 then
        dy = -10
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