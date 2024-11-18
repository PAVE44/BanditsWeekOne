BWORoomPrograms = BWORoomPrograms or {}

-- this is a collection of subprograms that crerates tasks for npcs based on the room they are currently in.

BWORoomPrograms.livingroom = function(bandit, def)
    local tasks = {}
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()

    local tv = BWOObjects.Find(bandit, def, "Television")
    if tv then
        local dd = tv:getDeviceData()
        if (hour > 5 and hour < 23 and not dd:getIsTurnedOn()) or ((hour < 6 or hour > 22) and dd:getIsTurnedOn()) then
            local square = tv:getSquare()
            local asquare = AdjacentFreeTileFinder.Find(square, bandit)
            if asquare then
                local dist = math.sqrt(math.pow(bandit:getX() - (asquare:getX() + 0.5), 2) + math.pow(bandit:getY() - (asquare:getY() + 0.5), 2))
                if dist > 0.70 then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                    return tasks
                else
                    local task = {action="TelevisionToggle", on=true, anim="Loot", x=square:getX(), y=square:getY(), z=square:getZ(), time=100}
                    table.insert(tasks, task)
                    return tasks
                end
            end
        end
    end
    
    local sittable = BWOObjects.Find(bandit, def, "Couch")
    if not sittable then
        sittable = BWOObjects.Find(bandit, def, "Chair")
    end

    if sittable then
        local square = sittable:getSquare()
        local asquare = AdjacentFreeTileFinder.Find(square, bandit)
        if asquare then
            local dist = math.sqrt(math.pow(bandit:getX() - (square:getX() + 0.5), 2) + math.pow(bandit:getY() - (square:getY() + 0.5), 2))
            if dist > 1.20 then
                table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                return tasks
            else
                local facing = sittable:getSprite():getProperties():Val("Facing")
                local anim = BanditUtils.Choice({"SitInChair", "SitInChairDrink"})
                local task = {action="SitInChair", anim=anim, x=sittable:getX(), y=sittable:getY(), z=sittable:getZ(), facing=facing, time=100}
                table.insert(tasks, task)
                return tasks
            end
        end
    end
    return tasks
end

BWORoomPrograms.hall = BWORoomPrograms.livingroom

BWORoomPrograms.bathroom = function(bandit, def)
    local tasks = {}
    local id = BanditUtils.GetCharacterID(bandit)
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()

    --[[local sittable = BWOObjects.Find(bandit, def, "Toilet")
    if sittable then
        local facing = sittable:getSprite():getProperties():Val("Facing")
        local task = {action="SitInChair", anim="SitInChair", x=sittable:getX(), y=sittable:getY(), z=sittable:getZ(), facing=facing, time=100}
        table.insert(tasks, task)
        return tasks
    end]]

    local sink = BWOObjects.Find(bandit, def, "Sink")
    if sink then
        local square = sink:getSquare()
        local asquare = AdjacentFreeTileFinder.Find(square, bandit)
        if asquare then
            local dist = math.sqrt(math.pow(bandit:getX() - (asquare:getX() + 0.5), 2) + math.pow(bandit:getY() - (asquare:getY() + 0.5), 2))
            if dist > 0.70 then
                table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                return tasks
            else
                local task = {action="Wash", anim="washFace", x=square:getX(), y=square:getY(), z=square:getZ(), time=400}
                table.insert(tasks, task)
                return tasks
            end
        end
    end

    return tasks
end

BWORoomPrograms.bedroom = function(bandit, def)
    local tasks = {}
    local id = BanditUtils.GetCharacterID(bandit)
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()

    local bed = BWOObjects.Find(bandit, def, "Bed")
    if bed then
        local square = bed:getSquare()
        local asquare = AdjacentFreeTileFinder.Find(square, bandit)
        if asquare then
            local dist = math.sqrt(math.pow(bandit:getX() - (square:getX() + 0.5), 2) + math.pow(bandit:getY() - (square:getY() + 0.5), 2))
            if dist > 2.20 then
                table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                return tasks
            else
                local facing = bed:getSprite():getProperties():Val("Facing")
                local anim = "AwakeBed"
                if hour < 6 or hour > 22 then
                    anim = "SleepBed"
                end
                local task = {action="Sleep", anim=anim, x=bed:getX(), y=bed:getY(), z=bed:getZ(), facing=facing, time=100}
                table.insert(tasks, task)
                return tasks
            end
        end
    end

    return tasks
end

BWORoomPrograms.motelroom = BWORoomPrograms.bedroom
BWORoomPrograms.motelroomoccupied = BWORoomPrograms.motelroom

BWORoomPrograms.kitchen = function(bandit, def)
    local tasks = {}
    local id = BanditUtils.GetCharacterID(bandit)
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()
    local outfit = bandit:getOutfitName()
    local m = (id % 3) * 2
    
    if (minute >= m and minute < m+3) or (minute >= m+20 and minute < m+23) or (minute >= m+40 and minute < m+43) then
        local fridge = BWOObjects.Find(bandit, def, "Fridge")
        if fridge then
            local square = fridge:getSquare()
            local asquare = AdjacentFreeTileFinder.Find(square, bandit)
            if asquare then
                local dist = math.sqrt(math.pow(bandit:getX() - (asquare:getX() + 0.5), 2) + math.pow(bandit:getY() - (asquare:getY() + 0.5), 2))
                if dist > 0.70 then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                    return tasks
                else
                    local task = {action="FaceLocation", anim="Loot", sound="TIsnd_FoodM", x=square:getX(), y=square:getY(), z=square:getZ(), time=200}
                    table.insert(tasks, task)
                    return tasks
                end
            end
        end
    elseif (minute >= m+3 and minute < m+6) or (minute >= m+23 and minute < m+26) or (minute >= m+43 and minute < m+46) then
        local sink = BWOObjects.Find(bandit, def, "Sink")
        if sink then
            local square = sink:getSquare()
            local asquare = AdjacentFreeTileFinder.Find(square, bandit)
            if asquare then
                local dist = math.sqrt(math.pow(bandit:getX() - (asquare:getX() + 0.5), 2) + math.pow(bandit:getY() - (asquare:getY() + 0.5), 2))
                if dist > 0.70 then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                    return tasks
                else
                    local task = {action="FaceLocation", anim="Loot", sound="GetWaterFromTap", x=square:getX(), y=square:getY(), z=square:getZ(), time=200}
                    table.insert(tasks, task)
                    return tasks
                end
            end
        end
    elseif (minute >= m+6 and minute < m+12) or (minute >= m+26 and minute < m+32) or (minute >= m+46 and minute < m+52) then
        local counter = BWOObjects.Find(bandit, def, "Counter")
        if counter then
            local square = counter:getSquare()
            local asquare = AdjacentFreeTileFinder.Find(square, bandit)
            if asquare then
                local dist = math.sqrt(math.pow(bandit:getX() - (asquare:getX() + 0.5), 2) + math.pow(bandit:getY() - (asquare:getY() + 0.5), 2))
                if dist > 0.70 then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                    return tasks
                else
                    local sound = BanditUtils.Choice({"TIsnd_Cooking", "TIsnd_CookingM"})
                    local task = {action="FaceLocation", anim="Loot", sound=sound, x=square:getX(), y=square:getY(), z=square:getZ(), time=200}
                    table.insert(tasks, task)
                    return tasks
                end
            end
        end
    elseif (minute >= m+12 and minute < m+15) or (minute >= m+32 and minute < m+35) or (minute >= m+52 and minute < m+55) then
        local oven = BWOObjects.Find(bandit, def, "Oven")
        if oven then
            if (minute > 5 and minute < 15 and not oven:Activated()) or (minute > 45 and minute < 55 and oven:Activated()) then
                local square = oven:getSquare()
                local asquare = AdjacentFreeTileFinder.Find(square, bandit)
                if asquare then
                    local dist = math.sqrt(math.pow(bandit:getX() - (asquare:getX() + 0.5), 2) + math.pow(bandit:getY() - (asquare:getY() + 0.5), 2))
                    if dist > 0.70 then
                        table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                        return tasks
                    else
                        local task = {action="StoveToggle", anim="Loot", x=square:getX(), y=square:getY(), z=square:getZ()}
                        table.insert(tasks, task)
                        return tasks
                    end
                end
            end
        end
    end

    return tasks
end

BWORoomPrograms.restaurantkitchen = function(bandit, def)
    local tasks = {}
    local id = BanditUtils.GetCharacterID(bandit)
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()
    local outfit = bandit:getOutfitName()
    local m = (id % 3) * 2
    
    if (minute >= m and minute < m+3) or (minute >= m+20 and minute < m+23) or (minute >= m+40 and minute < m+43) then
        local fridge = BWOObjects.Find(bandit, def, "Fridge")
        if fridge then
            local square = fridge:getSquare()
            local asquare = AdjacentFreeTileFinder.Find(square, bandit)
            if asquare then
                local dist = math.sqrt(math.pow(bandit:getX() - (asquare:getX() + 0.5), 2) + math.pow(bandit:getY() - (asquare:getY() + 0.5), 2))
                if dist > 0.70 then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                    return tasks
                else
                    local task = {action="FaceLocation", anim="Loot", sound="TIsnd_FoodM", x=square:getX(), y=square:getY(), z=square:getZ(), time=200}
                    table.insert(tasks, task)
                    return tasks
                end
            end
        end
    elseif (minute >= m+3 and minute < m+6) or (minute >= m+23 and minute < m+26) or (minute >= m+43 and minute < m+46) then
        local sink = BWOObjects.Find(bandit, def, "Sink")
        if sink then
            local square = sink:getSquare()
            local asquare = AdjacentFreeTileFinder.Find(square, bandit)
            if asquare then
                local dist = math.sqrt(math.pow(bandit:getX() - (asquare:getX() + 0.5), 2) + math.pow(bandit:getY() - (asquare:getY() + 0.5), 2))
                if dist > 0.70 then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                    return tasks
                else
                    local task = {action="FaceLocation", anim="Loot", sound="GetWaterFromTap", x=square:getX(), y=square:getY(), z=square:getZ(), time=200}
                    table.insert(tasks, task)
                    return tasks
                end
            end
        end
    elseif (minute >= m+6 and minute < m+12) or (minute >= m+26 and minute < m+32) or (minute >= m+46 and minute < m+52) then
        local counter = BWOObjects.Find(bandit, def, "Counter")
        if counter then
            local square = counter:getSquare()
            local asquare = AdjacentFreeTileFinder.Find(square, bandit)
            if asquare then
                local dist = math.sqrt(math.pow(bandit:getX() - (asquare:getX() + 0.5), 2) + math.pow(bandit:getY() - (asquare:getY() + 0.5), 2))
                if dist > 0.70 then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                    return tasks
                else
                    local sound = BanditUtils.Choice({"TIsnd_Cooking", "TIsnd_CookingM"})
                    local task = {action="FaceLocation", anim="Loot", sound=sound, x=square:getX(), y=square:getY(), z=square:getZ(), time=200}
                    table.insert(tasks, task)
                    return tasks
                end
            end
        end
    elseif (minute >= m+12 and minute < m+15) or (minute >= m+32 and minute < m+35) or (minute >= m+52 and minute < m+55) then
        local oven = BWOObjects.Find(bandit, def, "Oven")
        if oven then
            local square = oven:getSquare()
            local asquare = AdjacentFreeTileFinder.Find(square, bandit)
            if asquare then
                local dist = math.sqrt(math.pow(bandit:getX() - (asquare:getX() + 0.5), 2) + math.pow(bandit:getY() - (asquare:getY() + 0.5), 2))
                if dist > 0.70 then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                    return tasks
                else
                    local task = {action="StoveToggle", anim="Loot", x=square:getX(), y=square:getY(), z=square:getZ()}
                    table.insert(tasks, task)
                    return tasks
                end
            end
        end
    end

    return tasks
end

BWORoomPrograms.spiffoskitchen = BWORoomPrograms.restaurantkitchen
BWORoomPrograms.pizzakitchen = BWORoomPrograms.restaurantkitchen
BWORoomPrograms.jayschicken_kitchen = BWORoomPrograms.restaurantkitchen
BWORoomPrograms.gigamartkitchen = BWORoomPrograms.restaurantkitchen
BWORoomPrograms.cafeteriakitchen = BWORoomPrograms.restaurantkitchen
BWORoomPrograms.dinerkitchen = BWORoomPrograms.restaurantkitchen

BWORoomPrograms.church = function(bandit, def)
    local tasks = {}
    local id = BanditUtils.GetCharacterID(bandit)
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()
    local outfit = bandit:getOutfitName()

    if outfit == "Priest" then
        local altar = BWOObjects.Find(bandit, def, "Altar")
        if altar then
            local facing = altar:getSprite():getProperties():Val("Facing")
            local square
            if facing == "S" then square = altar:getSquare():getN() end
            if facing == "N" then square = altar:getSquare():getS() end
            if facing == "E" then square = altar:getSquare():getW() end
            if facing == "W" then square = altar:getSquare():getE() end
            if square then
                local dist = math.sqrt(math.pow(bandit:getX() - (square:getX() + 0.5), 2) + math.pow(bandit:getY() - (square:getY() + 0.5), 2))
                if dist > 0.60 then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, square:getX(), square:getY(), square:getZ(), "Walk", dist, false))
                    return tasks
                else
                    local task = {action="FaceLocation", anim="Yes", x=altar:getX(), y=altar:getY(), z=altar:getZ(), facing=facing, time=100}
                    table.insert(tasks, task)
                    return tasks
                end
            end

        end
    else
        local sittable = BWOObjects.Find(bandit, def, "Pew")

        if sittable then
            local square = sittable:getSquare()
            local asquare = AdjacentFreeTileFinder.Find(square, bandit)
            if asquare then
                local dist = math.sqrt(math.pow(bandit:getX() - (square:getX() + 0.5), 2) + math.pow(bandit:getY() - (square:getY() + 0.5), 2))
                if dist > 1.20 then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                    return tasks
                else
                    local facing = sittable:getSprite():getProperties():Val("Facing")
                    local anim = BanditUtils.Choice({"SitInChair", "SitInChairDrink"})
                    local task = {action="SitInChair", anim=anim, x=sittable:getX(), y=sittable:getY(), z=sittable:getZ(), facing=facing, time=100}
                    table.insert(tasks, task)
                    return tasks
                end
            end
        end
    end
    return tasks
end

BWORoomPrograms.office = function(bandit, def)
    local tasks = {}
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()

    local sittable = BWOObjects.Find(bandit, def, "Chair")
    if not sittable then
        sittable = BWOObjects.Find(bandit, def, "Couch")
    end

    if sittable then
        local square = sittable:getSquare()
        local asquare = AdjacentFreeTileFinder.Find(square, bandit)
        if asquare then
            local dist = math.sqrt(math.pow(bandit:getX() - (square:getX() + 0.5), 2) + math.pow(bandit:getY() - (square:getY() + 0.5), 2))
            if dist > 1.20 then
                table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                return tasks
            else
                local facing = sittable:getSprite():getProperties():Val("Facing")
                local anim = BanditUtils.Choice({"SitInChair", "SitInChairDrink"})
                local task = {action="SitInChair", anim=anim, x=sittable:getX(), y=sittable:getY(), z=sittable:getZ(), facing=facing, time=100}
                table.insert(tasks, task)
                return tasks
            end
        end
    end
    return tasks
end

BWORoomPrograms.meeting = BWORoomPrograms.office

BWORoomPrograms.bookstore = function(bandit, def)
    local tasks = {}
    local id = BanditUtils.GetCharacterID(bandit)
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()
    
    local outfit = bandit:getOutfitName()

    if outfit == "OfficeWorkerSkirt" then
        local register = BWOObjects.Find(bandit, def, "Register")
        if register then
            local facing = register:getSprite():getProperties():Val("Facing")
            local square
            if facing == "S" then square = register:getSquare():getS() end
            if facing == "N" then square = register:getSquare():getN() end
            if facing == "E" then square = register:getSquare():getE() end
            if facing == "W" then square = register:getSquare():getW() end
            if square then
                local dist = math.sqrt(math.pow(bandit:getX() - (square:getX() + 0.5), 2) + math.pow(bandit:getY() - (square:getY() + 0.5), 2))
                if dist > 0.60 then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, square:getX(), square:getY(), square:getZ(), "Walk", dist, false))
                    return tasks
                else
                    local task = {action="FaceLocation", anim="Yes", x=register:getX(), y=register:getY(), z=register:getZ(), facing=facing, time=100}
                    table.insert(tasks, task)
                    return tasks
                end
            end
        end
    else

        if math.abs(id) % 2 == 0 or (minute > 22 and minute < 36) then
            local shelves = BWOObjects.Find(bandit, def, "Shelves")

            if shelves then
                local square = shelves:getSquare()
                local asquare = AdjacentFreeTileFinder.Find(square, bandit)
                if asquare then
                    local dist = math.sqrt(math.pow(bandit:getX() - (asquare:getX() + 0.5), 2) + math.pow(bandit:getY() - (asquare:getY() + 0.5), 2))
                    if dist > 0.50 then
                        table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                        return tasks
                    else
                        local anim = BanditUtils.Choice({"LootLow", "Loot", "LootHigh"})
                        local task = {action="FaceLocation", anim=anim, sound="TIsnd_Literature", x=square:getX(), y=square:getY(), z=square:getZ(), time=200}
                        table.insert(tasks, task)
                        return tasks
                    end
                end
            end
        else
            local task = {action="TimeItem", anim="ReadBook", sound="PageFlipBook", item="Bandits.Book", left=true, time=200}
            table.insert(tasks, task)
        end
    end
    return tasks
end

BWORoomPrograms.library = BWORoomPrograms.bookstore

BWORoomPrograms.zippeestore = function(bandit, def)
    local tasks = {}
    local id = BanditUtils.GetCharacterID(bandit)
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()
    
    local outfit = bandit:getOutfitName()

    if outfit == "OfficeWorkerSkirt" or outfit == "Gas2Go" or outfit == "Thug" or outfit == "Pharmacist" then
        local register = BWOObjects.Find(bandit, def, "Register")
        if register then
            local facing = register:getSprite():getProperties():Val("Facing")
            local square
            if facing == "S" then square = register:getSquare():getS() end
            if facing == "N" then square = register:getSquare():getN() end
            if facing == "E" then square = register:getSquare():getE() end
            if facing == "W" then square = register:getSquare():getW() end
            if square then
                local dist = math.sqrt(math.pow(bandit:getX() - (square:getX() + 0.5), 2) + math.pow(bandit:getY() - (square:getY() + 0.5), 2))
                if dist > 0.60 then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, square:getX(), square:getY(), square:getZ(), "Walk", dist, false))
                    return tasks
                else
                    local task = {action="FaceLocation", anim="Yes", x=register:getX(), y=register:getY(), z=register:getZ(), facing=facing, time=100}
                    table.insert(tasks, task)
                    return tasks
                end
            end
        end
    elseif outfit == "MallSecurity" then
        local anim = BanditUtils.Choice({"ShiftWeight", "ChewNails", "PullAtCollar", "WipeBrow", "WipeHead"})
        local task = {action="Time", anim=anim, time=100}
        table.insert(tasks, task)
        return tasks

    else
        local rack = BWOObjects.Find(bandit, def, "Rack")

        if not rack then
            rack = BWOObjects.Find(bandit, def, "Shelves")
        end

        if rack then
            local square = rack:getSquare()
            local asquare = AdjacentFreeTileFinder.Find(square, bandit)
            if asquare then
                local dist = math.sqrt(math.pow(bandit:getX() - (asquare:getX() + 0.5), 2) + math.pow(bandit:getY() - (asquare:getY() + 0.5), 2))
                if dist > 0.70 then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                    return tasks
                else
                    local task = {action="FaceLocation", anim="Loot", sound="TIsnd_TakingM", x=square:getX(), y=square:getY(), z=square:getZ(), time=200}
                    table.insert(tasks, task)
                    return tasks
                end
            end
        end
    end
    return tasks
end

BWORoomPrograms.clothesstore = BWORoomPrograms.zippeestore
BWORoomPrograms.clothingstore = BWORoomPrograms.zippeestore
BWORoomPrograms.grocery = BWORoomPrograms.zippeestore
BWORoomPrograms.pharmacy = BWORoomPrograms.zippeestore
BWORoomPrograms.pharmacystorage = BWORoomPrograms.pharmacy
BWORoomPrograms.gasstore = BWORoomPrograms.zippeestore
BWORoomPrograms.movierental = BWORoomPrograms.zippeestore
BWORoomPrograms.gigamart = BWORoomPrograms.zippeestore
BWORoomPrograms.liquorstore = BWORoomPrograms.zippeestore
BWORoomPrograms.generalstore = BWORoomPrograms.zippeestore
BWORoomPrograms.conveniencestore = BWORoomPrograms.zippeestore

BWORoomPrograms.medical = function(bandit, def)
    local tasks = {}
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()
    local outfit = bandit:getOutfitName()
    
    local sittable
    if outfit == "Nurse"  then
        sittable = BWOObjects.Find(bandit, def, "Chair")
    elseif outfit == "Doctor" then
        sittable = BWOObjects.Find(bandit, def, "Medical Stool")
    else
        sittable = BWOObjects.Find(bandit, def, "Chairs")
    end

    if sittable then
        local square = sittable:getSquare()
        local asquare = AdjacentFreeTileFinder.Find(square, bandit)
        if asquare then
            local dist = math.sqrt(math.pow(bandit:getX() - (square:getX() + 0.5), 2) + math.pow(bandit:getY() - (square:getY() + 0.5), 2))
            if dist > 1.20 then
                table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                return tasks
            else
                local facing = sittable:getSprite():getProperties():Val("Facing")
                local anim = BanditUtils.Choice({"SitInChair", "SitInChairDrink"})
                local task = {action="SitInChair", anim=anim, x=sittable:getX(), y=sittable:getY(), z=sittable:getZ(), facing=facing, time=100}
                table.insert(tasks, task)
                return tasks
            end
        end
    end
    return tasks
end

BWORoomPrograms.medclinic = BWORoomPrograms.medical

BWORoomPrograms.restaurant = function(bandit, def)
    local tasks = {}
    local id = BanditUtils.GetCharacterID(bandit)
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()
    
    local outfit = bandit:getOutfitName()

    if outfit == "Waiter_Classy" or outfit == "Waiter_Spiffo" or outfit == "Waiter_PizzaWhirled" or outfit == "Waiter_PizzaWhirled" or outfit == "Teacher" then

        local register = BWOObjects.Find(bandit, def, "Register")
        if register and math.abs(id) % 2 == 0 then
            local facing = register:getSprite():getProperties():Val("Facing")
            local square
            if facing == "S" then square = register:getSquare():getS() end
            if facing == "N" then square = register:getSquare():getN() end
            if facing == "E" then square = register:getSquare():getE() end
            if facing == "W" then square = register:getSquare():getW() end
            if square then
                local dist = math.sqrt(math.pow(bandit:getX() - (square:getX() + 0.5), 2) + math.pow(bandit:getY() - (square:getY() + 0.5), 2))
                if dist > 0.60 then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, square:getX(), square:getY(), square:getZ(), "Walk", dist, false))
                    return tasks
                else
                    local task = {action="FaceLocation", anim="Yes", x=register:getX(), y=register:getY(), z=register:getZ(), facing=facing, time=100}
                    table.insert(tasks, task)
                    return tasks
                end
            end
        end


        local task = {action="Time", anim="Yes", time=100}
        table.insert(tasks, task)
        return tasks

    else
        local sittable
        sittable = BWOObjects.Find(bandit, def, "Seat")

        if not sittable then
            sittable = BWOObjects.Find(bandit, def, "Chair")
        end

        if not sittable then
            sittable = BWOObjects.Find(bandit, def, "Picknic Table")
        end
    
        if sittable then
            local square = sittable:getSquare()
            local asquare = AdjacentFreeTileFinder.Find(square, bandit)
            if asquare then
                local dist = math.sqrt(math.pow(bandit:getX() - (square:getX() + 0.5), 2) + math.pow(bandit:getY() - (square:getY() + 0.5), 2))
                if dist > 1.20 then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                    return tasks
                else
                    local facing = sittable:getSprite():getProperties():Val("Facing")
                    local anim = BanditUtils.Choice({"SitInChair", "SitInChairDrink"})
                    local task = {action="SitInChair", anim=anim, x=sittable:getX(), y=sittable:getY(), z=sittable:getZ(), facing=facing, time=100}
                    table.insert(tasks, task)
                    return tasks
                end
            end
        end
    end
    return tasks
end

BWORoomPrograms.dining = BWORoomPrograms.restaurant
BWORoomPrograms.spiffo_dining = BWORoomPrograms.restaurant
BWORoomPrograms.pizzawhirled = BWORoomPrograms.restaurant
BWORoomPrograms.jayschicken_dining = BWORoomPrograms.restaurant
BWORoomPrograms.diningroom = BWORoomPrograms.restaurant
BWORoomPrograms.bakery = BWORoomPrograms.restaurant
BWORoomPrograms.classroom = BWORoomPrograms.restaurant
BWORoomPrograms.daycare = BWORoomPrograms.classroom
BWORoomPrograms.cafe = BWORoomPrograms.restaurant
BWORoomPrograms.cafeteria = BWORoomPrograms.restaurant

BWORoomPrograms.bar = function(bandit, def)
    local tasks = {}
    local id = BanditUtils.GetCharacterID(bandit)
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()
    
    local outfit = bandit:getOutfitName()

    if outfit == "Waiter_Classy" or outfit == "Waiter_Spiffo" or outfit == "Waiter_PizzaWhirled" or outfit == "Waiter_PizzaWhirled" or outfit == "Teacher" then

        local register = BWOObjects.Find(bandit, def, "Register")
        if register and math.abs(id) % 2 == 0 then
            local facing = register:getSprite():getProperties():Val("Facing")
            local square
            if facing == "S" then square = register:getSquare():getS() end
            if facing == "N" then square = register:getSquare():getN() end
            if facing == "E" then square = register:getSquare():getE() end
            if facing == "W" then square = register:getSquare():getW() end
            if square then
                local dist = math.sqrt(math.pow(bandit:getX() - (square:getX() + 0.5), 2) + math.pow(bandit:getY() - (square:getY() + 0.5), 2))
                if dist > 0.60 then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, square:getX(), square:getY(), square:getZ(), "Walk", dist, false))
                    return tasks
                else
                    local task = {action="FaceLocation", anim="Yes", x=register:getX(), y=register:getY(), z=register:getZ(), facing=facing, time=100}
                    table.insert(tasks, task)
                    return tasks
                end
            end
        end


        local task = {action="Time", anim="Yes", time=100}
        table.insert(tasks, task)
        return tasks

    elseif outfit == "Biker" then
        local rnd = ZombRand(2)
        if rnd == 0 then
            local task = {action="Smoke", anim="Smoke", item="Bandits.Cigarette", left=true, time=100}
            table.insert(tasks, task)
        else
            local task = {action="TimeItem", anim="Drink", sound="DrinkingFromBottle", item="Bandits.BeerBottle", left=true, time=100}
            table.insert(tasks, task)
        end

        return tasks
    else
        local sittable
        sittable = BWOObjects.Find(bandit, def, "Seat")

        if not sittable then
            sittable = BWOObjects.Find(bandit, def, "Chair")
        end

        if not sittable then
            sittable = BWOObjects.Find(bandit, def, "Picknic Table")
        end
    
        if sittable then
            local square = sittable:getSquare()
            local asquare = AdjacentFreeTileFinder.Find(square, bandit)
            if asquare then
                local dist = math.sqrt(math.pow(bandit:getX() - (square:getX() + 0.5), 2) + math.pow(bandit:getY() - (square:getY() + 0.5), 2))
                if dist > 1.20 then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                    return tasks
                else
                    local facing = sittable:getSprite():getProperties():Val("Facing")
                    local anim = BanditUtils.Choice({"SitInChair", "SitInChairDrink"})
                    local task = {action="SitInChair", anim=anim, x=sittable:getX(), y=sittable:getY(), z=sittable:getZ(), facing=facing, time=100}
                    table.insert(tasks, task)
                    return tasks
                end
            end
        end
    end
    return tasks
end

BWORoomPrograms.mechanic = function(bandit, def)
    local tasks = {}
    local id = BanditUtils.GetCharacterID(bandit)
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()
    
    local outfit = bandit:getOutfitName()


    local shelves = BWOObjects.Find(bandit, def, "Shelves")

    if shelves then
        local square = shelves:getSquare()
        local asquare = AdjacentFreeTileFinder.Find(square, bandit)
        if asquare then
            local dist = math.sqrt(math.pow(bandit:getX() - (asquare:getX() + 0.5), 2) + math.pow(bandit:getY() - (asquare:getY() + 0.5), 2))
            if dist > 0.50 then
                table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                return tasks
            else
                local anim = BanditUtils.Choice({"LootLow", "Loot", "LootHigh"})
                local task = {action="FaceLocation", anim=anim, sound="TIsnd_Tool", x=square:getX(), y=square:getY(), z=square:getZ(), time=200}
                table.insert(tasks, task)
                return tasks
            end
        end
    end

    return tasks
end

BWORoomPrograms.gym = function(bandit, def)
    local tasks = {}
    local id = BanditUtils.GetCharacterID(bandit)
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()
    
    local outfit = bandit:getOutfitName()

    local task1 = {action="PushUp", time=2000}
    table.insert(tasks, task1)
    
    local anim2 = BanditUtils.Choice({"WipeBrow", "WipeHead"})
    local task2 = {action="Time", anim=anim, time=100}
    table.insert(tasks, task2)

    local anim3 = BanditUtils.Choice({"WipeBrow", "WipeHead"})
    local task3 = {action="Time", anim=anim, time=100}
    table.insert(tasks, task3)

    return tasks
end

BWORoomPrograms.aesthetic = function(bandit, def)
    local tasks = {}
    local id = BanditUtils.GetCharacterID(bandit)
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()
    
    local outfit = bandit:getOutfitName()

    if outfit == "DressShort" then

        local task = {action="Time", anim="Yes", time=100}
        table.insert(tasks, task)
        return tasks


    else
        local sittable
        sittable = BWOObjects.Find(bandit, def, "Seat")

        if not sittable then
            sittable = BWOObjects.Find(bandit, def, "Chair")
        end
    
        if sittable then
            local square = sittable:getSquare()
            local asquare = AdjacentFreeTileFinder.Find(square, bandit)
            if asquare then
                local dist = math.sqrt(math.pow(bandit:getX() - (square:getX() + 0.5), 2) + math.pow(bandit:getY() - (square:getY() + 0.5), 2))
                if dist > 1.20 then
                    table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                    return tasks
                else
                    local facing = sittable:getSprite():getProperties():Val("Facing")
                    local anim = BanditUtils.Choice({"SitInChair", "SitInChairDrink"})
                    local task = {action="SitInChair", anim=anim, x=sittable:getX(), y=sittable:getY(), z=sittable:getZ(), facing=facing, time=100}
                    table.insert(tasks, task)
                    return tasks
                end
            end
        end
    end
    return tasks
end

BWORoomPrograms.breakroom = BWORoomPrograms.livingroom

--[[
BWORoomPrograms.breakroom = function(bandit, def)
    local tasks = {}
    local id = BanditUtils.GetCharacterID(bandit)
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()
    
    local outfit = bandit:getOutfitName()

    local task1 = {action="TimeItem", anim="Smoke", item="Bandits.Cigarette", left=true, time=500}
    table.insert(tasks, task1)
    
    local anim2 = BanditUtils.Choice({"WipeBrow", "WipeHead"})
    local task2 = {action="Time", anim=anim, time=100}
    table.insert(tasks, task2)

    local anim3 = BanditUtils.Choice({"WipeBrow", "WipeHead"})
    local task3 = {action="Time", anim=anim, time=100}
    table.insert(tasks, task3)

    return tasks
end
]]