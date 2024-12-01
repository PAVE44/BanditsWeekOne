BanditActionInterceptor = BanditActionInterceptor or {}

BanditActionInterceptor.BWOMain = function(data)
    local character = data.character
    if not character then return end

    local action = data.action:getMetaType()
    if not action then return end

    local activatePrograms = {"Inhabitant", "Walker", "Runner", "Postal", "Janitor", "Gardener", "Entertainer"}

    -- illegal actions intercepted hre
    if action == "ISSmashWindow" or action == "ISSmashVehicleWindow" then
        local witnessList = BanditZombie.GetAllB()
        for id, witness in pairs(witnessList) do
            if not witness.brain.hostile then
                local dist = math.sqrt(math.pow(character:getX() - witness.x, 2) + math.pow(character:getY() - witness.y, 2))
                if dist < 15 then
                    local actor = BanditZombie.GetInstanceById(witness.id)
                    local canSee = actor:CanSee(character)
                    if canSee or dist < 10 then
                        -- witnessing civilians need to change peaceful behavior to active
                        
                        for _, prg in pairs(activatePrograms) do
                            if witness.brain.program.name == prg then 
                                Bandit.SetProgram(actor, "Active", {})
                                Bandit.ClearTasks(actor)
                                if ZombRand(5) == 0 then
                                    Bandit.SetHostile(actor, true)
                                    Bandit.Say(actor, "SPOTTED")
                                else
                                    if ZombRand(3) == 0 then
                                        Bandit.Say(actor, "SPOTTED")
                                    end
                                end
                                local brain = BanditBrain.Get(actor)
                                if brain then
                                    local syncData = {}
                                    syncData.id = brain.id
                                    syncData.hostile = brain.hostile
                                    syncData.program = brain.program
                                    Bandit.ForceSyncPart(actor, syncData)
                                end
                                
                            end
                        end
                    end
                end
            end
        end
    end
end

Events.OnTimedActionPerform.Add(BanditActionInterceptor.BWOMain)