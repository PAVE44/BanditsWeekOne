BanditActionInterceptor = BanditActionInterceptor or {}

local function predicateMoney(item)
    return item:getType() == "Money"
end

local function activateWitness(character)
    local activatePrograms = {"Inhabitant", "Walker", "Runner", "Postal", "Janitor", "Gardener", "Entertainer"}
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

    -- taken from floor, i guess it's ok
    if not object then return end

    -- this is when player puts something in, not take 
    if instanceof(object, "IsoPlayer") then return end

    local square = object:getSquare()
    local building = square:getBuilding()

    -- you can take outside buildings or from vehicles
    if not building then return end

    local canTake, shouldPay = BWOBuildings.TakeIntention(building)

    -- the building type and player profession allow taking items
    if canTake then return end

    -- party house is open for everyone
    if BWOBuildings.IsEventBuilding(building, "party") then return end

    -- player house - can take whatever want
    local base = BanditPlayerBase.GetBase(character)
    if base then return end

    if shouldPay then
        local inventory = character:getInventory()
        local items = ArrayList.new()

        inventory:getAllEvalRecurse(predicateMoney, items)
        if items:size() > 0 then
            character:addLineChatElement("Paid: -$1.00", 0, 1, 0)
            inventory:RemoveOneOf("Money", false)
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