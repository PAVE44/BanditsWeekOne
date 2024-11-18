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
