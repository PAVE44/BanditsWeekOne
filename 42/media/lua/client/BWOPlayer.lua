BWOPlayer = BWOPlayer or {}

-- adds money from player inventory
BWOPlayer.Earn = function(character, cnt)
    local inventory = character:getInventory()
    for i=1, cnt do
        local item = instanceItem("Base.Money")
        inventory:AddItem(item)
    end
    character:addLineChatElement("Earn: +$" .. cnt .. ".00", 0, 1, 0)
end

-- substracts money from player inventory
BWOPlayer.Pay = function(character, cnt)

    local function predicateMoney(item)
        return item:getType() == "Money"
    end

    local inventory = character:getInventory()
    local items = ArrayList.new()

    inventory:getAllEvalRecurse(predicateMoney, items)
    if items:size() >= cnt then
        character:addLineChatElement("Paid: -$" .. cnt .. ".00", 0, 1, 0)
        for i=0, cnt do
            inventory:RemoveOneOf("Money", true)
        end
    else
        character:addLineChatElement("No money, item stolen!", 1, 0, 0)
        activateWitness(character, 15)
    end
end

-- controls npc reaction to player violence
local checkHostility = function(bandit, attacker)

    if not attacker then return end

    local player = getPlayer()
    
    -- attacking zombies is ok!
    local brain = BanditBrain.Get(bandit)
    if not bandit:getVariableBoolean("Bandit") then return end

    -- killing bandits is ok!
    if brain.clan > 0 then 
        local profession = player:getDescriptor():getProfession()
        if BWOScheduler.Anarchy.Transactions and profession == "policeofficer" then
            BWOPlayer.Earn(player, 5)
        end
        return
    end

    -- to weak to respond
    -- local infection = Bandit.GetInfection(bandit)
    -- if infection > 0 then return end

    -- who saw this changes program
    local witnessList = BanditZombie.GetAllB()
    for id, witness in pairs(witnessList) do
        if not witness.brain.hostile then
            local dist = math.sqrt(math.pow(bandit:getX() - witness.x, 2) + math.pow(bandit:getY() - witness.y, 2))
            if dist < 15 then
                local actor = BanditZombie.GetInstanceById(witness.id)
                if actor:CanSee(bandit) then

                    local params = {}
                    params.x = bandit:getX()
                    params.y = bandit:getY()
                    params.z = bandit:getZ()

                    local wasPlayerFault = false
                    if instanceof(attacker, "IsoPlayer") and not attacker:isNPC() and brain.clan == 0 and brain.program.name ~= "Thief" then
                        wasPlayerFault = true
                        if brain.id ~= id then
                            local outfit = bandit:getOutfitName()
                            if outfit == "Police" then
                                if BWOPopControl.SWAT.On then
                                    params.hostile = true
                                    BWOScheduler.Add("CallSWAT", params, 19500)
                                end
                            else
                                if BWOPopControl.Police.On then
                                    params.hostile = true
                                    BWOScheduler.Add("CallCops", params, 12000)
                                end
                            end
                        end
                    else
                        -- call friendly police
                        if BWOPopControl.Police.On then
                            params.hostile = false
                            BWOScheduler.Add("CallCops", params, 12000)
                        end
                    end

                    -- witnessing civilians need to change peaceful behavior to active
                    local activatePrograms = {"Patrol", "Police", "Inhabitant", "Walker", "Runner", "Postal", "Janitor", "Gardener", "Entertainer", "Vandal"}
                    for _, prg in pairs(activatePrograms) do
                        if witness.brain.program.name == prg then 
                            local outfit = actor:getOutfitName()
                            if outfit == "Police" or outfit == "Security" or outfit == "MallSecurity" or outfit == "ZSArmySpecialOps" then
                                Bandit.ClearTasks(actor)
                                Bandit.SetProgram(actor, "Police", {})
                                if wasPlayerFault then
                                    Bandit.SetHostile(actor, true)
                                end
                            else
                                if ZombRand(4) > 0 then
                                    Bandit.ClearTasks(actor)
                                    Bandit.SetProgram(actor, "Active", {})
                                    if wasPlayerFault and ZombRand(2) == 0 then
                                        Bandit.SetHostile(actor, true)
                                    end
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

local onHitZombie = function(zombie, attacker, bodyPartType, handWeapon)
    checkHostility(zombie, attacker)
end

local onZombieDead = function(zombie)

    if not zombie:getVariableBoolean("Bandit") then return end
        
    local bandit = zombie

    local attacker = bandit:getAttackedBy()
    if not attacker then
        attacker = bandit:getTarget()
    end

    checkHostility(bandit, attacker)

    -- register dead body
    local args = {x=bandit:getX(), y=bandit:getY(), z=bandit:getZ()}
    sendClientCommand(getPlayer(), 'Commands', 'DeadBodyAdd', args)

    local params ={}
    params.x = bandit:getX()
    params.y = bandit:getY()
    params.z = bandit:getZ()
    params.hostile = false

    -- call medics
    if BWOPopControl.Medics.On then
        BWOScheduler.Add("CallMedics", params, 15000)
    elseif BWOPopControl.Hazmats.On then
        BWOScheduler.Add("CallHazmats", params, 15500)
    end

    -- deprovision bandit (bandit main function is no longer doing that for clan 0)
    Bandit.Say(bandit, "DEAD", true)

    local id = BanditUtils.GetCharacterID(bandit)
    local brain = BanditBrain.Get(bandit)

    bandit:setUseless(false)
    bandit:setReanim(false)
    bandit:setVariable("Bandit", false)
    bandit:setPrimaryHandItem(nil)
    bandit:clearAttachedItems()
    bandit:resetEquippedHandsModels()
    -- bandit:getInventory():clear()

    args = {}
    args.id = id
    sendClientCommand(getPlayer(), 'Commands', 'BanditRemove', args)
    BanditBrain.Remove(bandit)
end

Events.OnHitZombie.Add(onHitZombie)
Events.OnZombieDead.Add(onZombieDead)