BWOPlayer = BWOPlayer or {}

BWOPlayer.tick = 0

-- time spent on aiming after aim start
BWOPlayer.aimTime = 0

-- a flag that get set when the player is sleeping to be later used as a pseudo trigger
BWOPlayer.wasSleeping = false

-- make npcs react to actual crime
BWOPlayer.ActivateWitness = function(character, min)
    local activatePrograms = {"Patrol", "Police", "Inhabitant", "Walker", "Runner", "Postal", "Janitor", "Gardener", "Entertainer"}
    local witnessList = BanditZombie.GetAllB()
    for id, witness in pairs(witnessList) do
        if not witness.brain.hostile then
            local dist = math.sqrt(math.pow(character:getX() - witness.x, 2) + math.pow(character:getY() - witness.y, 2))
            if dist < min then
                local actor = BanditZombie.GetInstanceById(witness.id)
                local canSee = actor:CanSee(character)
                if canSee or dist < 3 then
                    -- witnessing civilians need to change peaceful behavior to active
                    
                    for _, prg in pairs(activatePrograms) do
                        if witness.brain.program.name == prg then
                            Bandit.ClearTasks(actor)
                            local outfit = actor:getOutfitName()
                            if outfit == "Police" or outfit == "MallSecurity" or outfit == "ZSArmySpecialOps" then
                                Bandit.SetProgram(actor, "Police", {})
                                Bandit.SetHostile(actor, true)
                                Bandit.Say(actor, "SPOTTED")
                            else
                                Bandit.SetProgram(actor, "Active", {})
                                if ZombRand(5) == 0 then
                                    Bandit.SetHostile(actor, true)
                                    Bandit.Say(actor, "SPOTTED")
                                else
                                    if ZombRand(3) == 0 then
                                        Bandit.Say(actor, "SPOTTED")
                                    end
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

-- make npcs react to threat possibility (player aiming weapon)
BWOPlayer.ActivateTargets = function(character, min)
    local activatePrograms = {"Patrol", "Police", "Inhabitant", "Walker", "Runner", "Postal", "Janitor", "Gardener", "Entertainer", "Vandal"}
    local witnessList = BanditZombie.GetAllB()
    local shouldActivate = true
    local activateList = {}
    for id, witness in pairs(witnessList) do
    
        local dist = math.sqrt(math.pow(character:getX() - witness.x, 2) + math.pow(character:getY() - witness.y, 2))
        if dist < min then
            if witness.brain.clan > 0 then
                shouldActivate = false
                break
            else
                local actor = BanditZombie.GetInstanceById(witness.id)
                local canSee1 = actor:CanSee(character)
                local canSee2 = character:CanSee(actor)
                if canSee1 and canSee2 then
                    for _, prg in pairs(activatePrograms) do
                        if witness.brain.program.name == prg then
                            table.insert(activateList, actor)
                        end
                    end
                end
            end
        end
    end

    if shouldActivate then
        for _, actor in pairs(activateList) do
            Bandit.ClearTasks(actor)
            local outfit = actor:getOutfitName()
            if outfit == "Police" or outfit == "MallSecurity" or outfit == "ZSArmySpecialOps" then
                Bandit.SetProgram(actor, "Police", {})
                Bandit.SetHostile(actor, true)
                Bandit.Say(actor, "SPOTTED")
            else
                Bandit.SetProgram(actor, "Active", {})
                if ZombRand(7) == 0 then
                    Bandit.SetHostile(actor, true)
                    Bandit.Say(actor, "SPOTTED")
                else
                    if ZombRand(3) == 0 then
                        Bandit.Say(actor, "SPOTTED")
                    end
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
        BWOPlayer.ActivateWitness(character, 15)
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
        if instanceof(attacker, "IsoPlayer") and not attacker:isNPC() then
            local profession = player:getDescriptor():getProfession()
            if BWOScheduler.Anarchy.Transactions and profession == "policeofficer" then
                BWOPlayer.Earn(player, 5)
            end
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

-- detecting crime based on who got killed by player
local onHitZombie = function(zombie, attacker, bodyPartType, handWeapon)
    checkHostility(zombie, attacker)
end

-- detecting crime based on who got hit by player
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

--INTERCEPTORS

-- intercepting player actions
local onTimedAction = function(data)
   
    local character = data.character
    if not character then return end

    local profession = character:getDescriptor():getProfession()

    local action = data.action:getMetaType()
    if not action then return end

    -- illegal actions intercepted here
    if BWOScheduler.Anarchy.IllegalMinorCrime and action == "ISSmashWindow" or action == "ISSmashVehicleWindow" or action == "ISHotwireVehicle" then
        BWOPlayer.ActivateWitness(character, 15)
        return
    end

    if not BWOScheduler.Anarchy.Transactions then return end

    -- trash collecting and littering
    if action == "ISMoveablesAction" then
        local mode = data.mode
        local origSpriteName = data.origSpriteName
        if mode and origSpriteName then
            
            if origSpriteName:embodies("trash") then

                -- earn by collecting trash
                if mode == "pickup" then
                    BWOPlayer.Earn(character, 1)

                -- littering
                elseif mode == "place" then
                    BWOPlayer.Pay(character, 1)
                    BWOPlayer.ActivateWitness(character, 15)
                end
            end
        end
        return
    end

    -- fireman
    if profession == "fireofficer" then
        if action == "ISPutOutFire" then
            BWOPlayer.Earn(character, 25)
        end
        return
    end

    -- mechanic
    if profession == "mechanics" then
        if action == "ISFixVehiclePartAction" then
        
            local vehiclePart = data.vehiclePart
            local vehicle = vehiclePart:getVehicle()
            local md = vehicle:getModData()
            if md.BWO and md.BWO.client then
                local skill = character:getPerkLevel(Perks.MetalWelding)
                BWOPlayer.Earn(character, skill * 5)
            end
        elseif action == "ISRepairEngine" then
            local vehicle = data.vehicle
            local md = vehicle:getModData()
            if md.BWO and md.BWO.client then
                local skill = character:getPerkLevel(Perks.Mechanics)
                BWOPlayer.Earn(character, skill * 20)
            end
        elseif action == "ISInstallVehiclePart" then
            local vehiclePart = data.part
            local vehicle = vehiclePart:getVehicle()
            local md = vehicle:getModData()
            if md.BWO and md.BWO.client then
                local id = vehiclePart:getScriptPart():getId()
                local idx
                for k, v in pairs(BWOVehicles.parts) do
                    if id == v then
                        idx = k
                    end
                end

                if idx then
                    local item = data.item
                    local oldCondition = md.BWO.parts[idx]
                    local newCondition = item:getCondition()
                    BWOPlayer.Earn(character, math.ceil((newCondition - oldCondition) * item:getWeight() / 5))
                    md.BWO.parts[idx] = newCondition
                end
            end
        end
        return
    end
end

-- inventory transfer player action needs to intercepted sparately to have access the necessary data
local onInventoryTransferAction = function(data)

    if not BWOScheduler.Anarchy.Transactions then return end

    local character = data.character
    if not character then return end

    local profession = character:getDescriptor():getProfession()

    local container = data.srcContainer
    if not container then return end

    local destContainer = data.destContainer
    local descContainerType = destContainer:getType()

    local item = data.item
    local itemType = item:getFullType()
    local md = item:getModData()
    if not md.BWO then
        md.BWO = {} 
        md.BWO.stolen = false
        md.BWO.bought = false
    end

    local object = container:getParent()

    local square
    if object then 
        -- taking from trashcans is not buying
        local sprite = object:getSprite()
        if sprite then
            local props = sprite:getProperties()
            if props:Is("CustomName") then
                local customName = props:Val("CustomName")
                if customName == "Trash" or customName == "Garbage" then
                    return
                end
            end
        end

        -- selling
        if instanceof(object, "IsoPlayer") then 

            -- lumberjack
            if not md.BWO.stolen then
                if profession == "lumberjack" then
                    if itemType == "Base.Log" and descContainerType == "logs" then
                        BWOPlayer.Earn(character, 10)
                    elseif itemType == "Base.Plank" and descContainerType == "crate" then
                        BWOPlayer.Earn(character, 6)
                    end
                end
            end
            return
        end

        square = object:getSquare()
    else
        square = character:getSquare()
    end

    -- transfering to non player containers is not buying
    local destObject = destContainer:getCharacter()
    if not destObject then return end

    local room = square:getRoom()

    -- you can take outside buildings or from vehicles
    if not room then return end

    local canTake, shouldPay = BWORooms.TakeIntention(room)

    -- taking money is not buying
    if data.item:getType() == "Money" then
        canTake = false
        shouldPay = false
    end

    if canTake then return end

    if shouldPay then
        local itemType = data.item:getFullType()
        local category = data.item:getDisplayCategory()
        local weight = data.item:getWeight()
        local price = math.floor(weight * SandboxVars.BanditsWeekOne.PriceMultiplier * 10)
        if price == 0 then price = 1 end

        md.BWO.bought = true

        BWOPlayer.Pay(character, price)

    elseif not canTake then
        md.BWO.stolen = true
        BWOPlayer.ActivateWitness(character, 15)
    end

end

-- other interceptors 
local onPlayerUpdate = function(player)

    -- tick update
    if BWOPlayer.tick > 15 then
        BWOPlayer.tick = 0
    end

    -- intercepting end of sleep
    if not player:isAsleep() and BWOPlayer.wasSleeping then
        BWOPlayer.wasSleeping = false
        local params = {}
        params.night = getGameTime():getNightsSurvived()
        BWOScheduler.Add("Dream", params, 600)
    end

    -- intercepting player aiming
    if BWOScheduler.Anarchy.IllegalMinorCrime and BWOPlayer.tick == 0 then
        if player:IsAiming() and not BanditPlayer.IsGhost(player)  then 
            local primaryItem = player:getPrimaryHandItem()

            local max
            if primaryItem and primaryItem:IsWeapon() then
                local primaryItemType = WeaponType.getWeaponType(primaryItem)
                if primaryItemType == WeaponType.firearm then
                    max = 12
                elseif primaryItemType == WeaponType.handgun then
                    max = 8
                elseif primaryItemType == WeaponType.heavy then
                    max = 3
                elseif primaryItemType == WeaponType.onehanded then
                    max = 3
                elseif primaryItemType == WeaponType.knife then
                    max = 3
                elseif primaryItemType == WeaponType.spear then
                    max = 3
                elseif primaryItemType == WeaponType.twohanded then
                    max = 3
                elseif primaryItemType == WeaponType.throwing then
                    max = 12
                elseif primaryItemType == WeaponType.chainsaw then
                    max = 4
                end
            end

            if max then
                if BWOPlayer.aimTime > 4 then 
                    BWOPlayer.ActivateTargets(player, max)
                end
                BWOPlayer.aimTime = BWOPlayer.aimTime + 1
            end
        else
            BWOPlayer.aimTime = 0
        end
    end

    BWOPlayer.tick = BWOPlayer.tick + 1
end

-- intercepting player swinging weapon
local onWeaponSwing = function(character, handWeapon)
    if not BWOScheduler.Anarchy.IllegalMinorCrime then return end
	if not instanceof(character, "IsoPlayer") then return end

    local primaryItemType = WeaponType.getWeaponType(handWeapon)
    if primaryItemType == WeaponType.barehand  then return end

    BWOPlayer.ActivateTargets(character, 15)
end

-- OTHER

-- sleep detector to init dreams
local everyHours = function()
	local player = getPlayer()
    if player:isAsleep() then
        BWOPlayer.wasSleeping = true
    end
end

LuaEventManager.AddEvent("OnInventoryTransferActionPerform")

Events.OnHitZombie.Add(onHitZombie)
Events.OnZombieDead.Add(onZombieDead)
Events.OnTimedActionPerform.Add(onTimedAction)
Events.OnInventoryTransferActionPerform.Add(onInventoryTransferAction)
Events.OnPlayerUpdate.Add(onPlayerUpdate)
Events.OnWeaponSwing.Add(onWeaponSwing)
Events.EveryHours.Add(everyHours)