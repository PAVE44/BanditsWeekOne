BanditActionInterceptor = BanditActionInterceptor or {}
BanditActionInterceptor.tick = 0
BanditActionInterceptor.aimTime = 0

local function onTimedAction(data)
   
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
        BWOPlayer.ActivateWitness(character, 15)
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
                if BanditActionInterceptor.aimTime > 4 then 
                    BWOPlayer.ActivateTargets(player, max)
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