BanditActionInterceptor = BanditActionInterceptor or {}
BanditActionInterceptor.tick = 0
BanditActionInterceptor.aimTime = 0

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

local function onTimedAction(data)

   
    local character = data.character
    if not character then return end

    local action = data.action:getMetaType()
    if not action then return end

    -- illegal actions intercepted here
    if BWOScheduler.Anarchy.IllegalMinorCrime and action == "ISSmashWindow" or action == "ISSmashVehicleWindow" or action == "ISHotwireVehicle" then
        activateWitness(character, 15)
        return
    end

    -- trash collecting and littering
    if BWOScheduler.Anarchy.Transactions and action == "ISMoveablesAction" then
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
                    activateWitness(character, 15)
                end
            end
        end
        return
    end

    -- extinguishing fire
    if BWOScheduler.Anarchy.Transactions and action == "ISPutOutFire" then
        local profession = character:getDescriptor():getProfession()
        if profession == "fireofficer" then
            BWOPlayer.Earn(character, 25)
        end
    end
end

local function onInventoryTransferAction(data)

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
        activateWitness(character, 15)
    end

end

local function onPlayerUpdate(player)
    if not BWOScheduler.Anarchy.IllegalMinorCrime then return end

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

Events.OnTimedActionPerform.Add(onTimedAction)
Events.OnInventoryTransferActionPerform.Add(onInventoryTransferAction)
Events.OnPlayerUpdate.Add(onPlayerUpdate)