BanditActionInterceptor = BanditActionInterceptor or {}

local function predicateMoney(item)
    return item:getType() == "Money"
end

local function activateWitness(character)
    local activatePrograms = {"Police", "Inhabitant", "Walker", "Runner", "Postal", "Janitor", "Gardener", "Entertainer"}
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
                            Bandit.ClearTasks(actor)
                            local outfit = actor:getOutfitName()
                            if outfit == "Police" then
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

BanditActionInterceptor.BWOTimedAction = function(data)
    local character = data.character
    if not character then return end

    local action = data.action:getMetaType()
    if not action then return end

    -- illegal actions intercepted hre
    if action == "ISSmashWindow" or action == "ISSmashVehicleWindow" or action == "ISHotwireVehicle" then
        activateWitness(character)
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
                if customName == "Trash" then
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

    -- transfering to floor is not yet buying
    local destContainer = data.destContainer
    local destObject = destContainer:getParent()
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
                inventory:RemoveOneOf("Money", false)
            end
        else
            character:addLineChatElement("No money, item stolen!", 1, 0, 0)
            activateWitness(character)
        end
    elseif not canTake then
        activateWitness(character)
    end
end

LuaEventManager.AddEvent("OnInventoryTransferActionPerform")

Events.OnTimedActionPerform.Add(BanditActionInterceptor.BWOTimedAction)
Events.OnInventoryTransferActionPerform.Add(BanditActionInterceptor.BWOInventoryTransferAction)