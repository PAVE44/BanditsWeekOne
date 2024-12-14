BanditActionInterceptor = BanditActionInterceptor or {}

local function predicateMoney(item)
    return item:getType() == "Money"
end

local function activateWitness(character, min)
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

local function activateTargets(character, min)
    local activatePrograms = {"Patrol", "Police", "Inhabitant", "Walker", "Runner", "Postal", "Janitor", "Gardener", "Entertainer", "Vandal"}
    local witnessList = BanditZombie.GetAllB()
    local shouldActivate = true
    local activateList = {}
    for id, witness in pairs(witnessList) do
    
        local dist = math.sqrt(math.pow(character:getX() - witness.x, 2) + math.pow(character:getY() - witness.y, 2))
        if dist < min then
            if witness.brain.hostile then
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

BanditActionInterceptor.BWOTimedAction = function(data)
    local character = data.character
    if not character then return end

    local action = data.action:getMetaType()
    if not action then return end

    -- illegal actions intercepted hre
    if action == "ISSmashWindow" or action == "ISSmashVehicleWindow" or action == "ISHotwireVehicle" then
        activateWitness(character, 15)
    end
end

BanditActionInterceptor.BWOInventoryTransferAction = function(data)
    local character = data.character
    if not character then return end

    local container = data.srcContainer
    if not container then return end

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

        -- this is when player puts something in, not take 
        if instanceof(object, "IsoPlayer") then return end

        square = object:getSquare()
    else
        square = character:getSquare()
    end

    -- transfering to non player containers is not buying
    local destContainer = data.destContainer
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
        local price = math.floor(weight * 10)
        if price == 0 then price = 1 end

        local inventory = character:getInventory()
        local items = ArrayList.new()

        inventory:getAllEvalRecurse(predicateMoney, items)
        if items:size() >= price then
            character:addLineChatElement("Paid: -$" .. price .. ".00", 0, 1, 0)
            for i=0, price do
                inventory:RemoveOneOf("Money", true)
            end
        else
            character:addLineChatElement("No money, item stolen!", 1, 0, 0)
            activateWitness(character, 15)
        end
    elseif not canTake then
        activateWitness(character, 15)
    end
end

BanditActionInterceptor.tick = 0
BanditActionInterceptor.aimTime = 0

BanditActionInterceptor.OnPlayerUpdate = function(player)

    if BanditActionInterceptor.tick > 15 then
        BanditActionInterceptor.tick = 0
    end
    

    if BanditActionInterceptor.tick == 0 then
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
                print ("aimtime: " .. BanditActionInterceptor.aimTime .. " dist:" .. max)
                if BanditActionInterceptor.aimTime > 4 then 
                    activateTargets(player, max)
                end
                BanditActionInterceptor.aimTime = BanditActionInterceptor.aimTime + 1
            end
        else
            BanditActionInterceptor.aimTime = 0
        end
    end

    BanditActionInterceptor.tick = BanditActionInterceptor.tick + 1
end

LuaEventManager.AddEvent("OnInventoryTransferActionPerform")

Events.OnTimedActionPerform.Add(BanditActionInterceptor.BWOTimedAction)
Events.OnInventoryTransferActionPerform.Add(BanditActionInterceptor.BWOInventoryTransferAction)
Events.OnPlayerUpdate.Add(BanditActionInterceptor.OnPlayerUpdate)