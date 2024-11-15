BWOScheduler = BWOScheduler or {}
 
BWOScheduler.Schedule = {}

BWOScheduler.SymptomLevel = 0

BWOScheduler.WorldAge = 0

function BWOScheduler.MasterControl()

    local player = getPlayer()
    local gametime = getGameTime()

    local startHour = gametime:getStartTimeOfDay()
    local startDay = gametime:getStartDay()
    local startMonth = gametime:getStartMonth()
    local startYear = gametime:getStartYear()

    local day = gametime:getDay()
    local hour = gametime:getHour()
    local minute = gametime:getMinutes()
    local month = gametime:getMonth()
    local year = gametime:getYear()

    -- in multiplayer getStartDay and getDay returns bullshit value, so this needs to be corrected
    local gamemode = getWorld():getGameMode()
    if gamemode == "Multiplayer" then 
        startDay = startDay - 13
        startYear = startYear - 19
        month = month + 1
        day = day + 1
    end

    local worldAge = (day * 24 + hour) - (startDay * 24 + startHour)
    BWOScheduler.WorldAge = worldAge

    -- building emmiters (churchbells, school)
    if worldAge < 48 then

        -- church
        if hour >=6 and hour < 19 then
            if minute == 0 then
                local church = BWOBuildings.FindBuildingType("church")
                if church then
                    local def = church:getDef()
                    local emitter = getWorld():getFreeEmitter((def:getX() + def:getX2()) / 2, (def:getY() + def:getY2()) / 2, 0)
                    emitter:setVolumeAll(0.5)
                    emitter:playSound("ZSBuildingChurch")
                end
            end
        end

        -- school
        if hour >=8 and hour < 17 then
            if minute == 10 or minute == 45 then
                local school = BWOBuildings.FindBuildingType("education")
                if school then
                    local def = school:getDef()
                    local emitter = getWorld():getFreeEmitter((def:getX() + def:getX2()) / 2, (def:getY() + def:getY2()) / 2, 0)
                    emitter:setVolumeAll(0.8)
                    emitter:playSound("ZSBuildingSchool")
                end
            end
        end
    end

    -- general pop control
    -- day 1
    -- 9.00
    if worldAge < 10 then
        BWOScheduler.SymptomLevel = 0
        BWOPopControl.StreetsNominal = 45
        BWOPopControl.InhabitantsNominal = 45
        BWOPopControl.SurvivorsNominal = 0
        BWOPopControl.ZombieMax = 0
    end

    -- 19.00
    if worldAge >= 10 and worldAge < 22 then
        BWOScheduler.SymptomLevel = 1
        BWOPopControl.StreetsNominal = 45
        BWOPopControl.InhabitantsNominal = 45
        BWOPopControl.SurvivorsNominal = 0
        BWOPopControl.ZombieMax = 0
    end

    -- day 2
    -- 7.00
    if worldAge >= 22 and worldAge < 36 then
        BWOScheduler.SymptomLevel = 2
        BWOPopControl.StreetsNominal = 50
        BWOPopControl.InhabitantsNominal = 40
        BWOPopControl.SurvivorsNominal = 0
        BWOPopControl.ZombieMax = math.floor(worldAge / 2) - 11 -- 0, 1, 1, 2, 2 ... 7

        if worldAge == 27 or worldAge == 30 or worldAge == 33 then
            if minute == hour * 2 then
                BWOScheduler.Add("ChopperAlert", 100)
            end
        end
    end


    -- 21.00
    if worldAge >= 36 and worldAge < 43 then
        BWOScheduler.SymptomLevel = 3
        BWOPopControl.StreetsNominal = 70
        BWOPopControl.InhabitantsNominal = 30
        BWOPopControl.SurvivorsNominal = 1
        BWOPopControl.ZombieMax = math.floor(worldAge / 1.2) - 22 -- 8 - 13

        if worldAge % 3 == 0 then
            if minute == hour * 2 then
                BWOScheduler.Add("ChopperAlert", 100)
            end
        end

        if worldAge == 40 then
            if minute == 30 then
                BWOScheduler.Add("Criminals", 100)
            end
        end

        if worldAge == 42 then
            if minute == 44 then
                BWOScheduler.Add("Criminals", 100)
            end
        end
    end

    -- day 3
    -- 5.00
    if worldAge >= 44 and worldAge < 52 then
        BWOScheduler.SymptomLevel = 3
        BWOPopControl.StreetsNominal = 50
        BWOPopControl.InhabitantsNominal = 30
        BWOPopControl.SurvivorsNominal = 2
        BWOPopControl.ZombieMax = math.floor(worldAge) - 28 -- 16,17 .. 24

        if worldAge == 45 then
            if minute == 14 then
                BWOScheduler.Add("Defenders", 100)
            end
        end

        if worldAge == 47 then
            if minute == 21 then
                BWOScheduler.Add("Defenders", 100)
            end
        end

        if worldAge == 50 then
            if minute == 2 then
                BWOScheduler.Add("Defenders", 100)
            end
        end

    end

    -- 15.00
    if worldAge >= 52 and worldAge < 72 then
        BWOScheduler.SymptomLevel = 3
        BWOPopControl.StreetsNominal = 30
        BWOPopControl.InhabitantsNominal = 60
        BWOPopControl.SurvivorsNominal = 10
        BWOPopControl.ZombieMax = math.floor(worldAge * 2) - 80 -- 24, 26 .. 64

        if worldAge == 53 then
            if minute == 7 or minute == 57 then
                BWOScheduler.Add("Defenders", 100)
            end
        elseif worldAge == 56 then
            if minute == 41 then
                BWOScheduler.Add("Defenders", 100)
            end
        elseif worldAge == 63 then
            if minute == 27 then
                BWOScheduler.Add("Arson", 100)
            end
        elseif worldAge == 64 then
            if minute == 44 or minute == 46 then
                BWOScheduler.Add("Criminals", 100)
            end
        elseif worldAge == 64 then
            if minute == 44 or minute == 46 then
                BWOScheduler.Add("Criminals", 100)
            end
        elseif worldAge == 65 then
            if minute == 52 then
                BWOScheduler.Add("Arson", 100)
            elseif minute == 58 then
                BWOScheduler.Add("Defenders", 100)
            end
        elseif worldAge == 66 then
            if minute == 6 then
                BWOScheduler.Add("Defenders", 100)
            end
        elseif worldAge == 67 then
            if minute == 13 then
                BWOScheduler.Add("Bandits", 100)
            end
        end
    end

    -- day 4
    -- 05.00
    if worldAge >= 68 and worldAge < 90 then
        BWOScheduler.SymptomLevel = 4
        BWOPopControl.StreetsNominal = 2
        BWOPopControl.InhabitantsNominal = 2
        BWOPopControl.SurvivorsNominal = 20
        BWOPopControl.ZombieMax = math.floor(worldAge * 3) - 153 -- 66, 69 .. 117

        if worldAge == 69 then
            if minute == 50 then
                BWOScheduler.Add("PoliceRiot", 100)
            end
        elseif worldAge == 70 then
            if minute == 31 then
                BWOScheduler.Add("Defenders", 100)
            end
        elseif worldAge == 71 then
            if minute == 22 then
                BWOScheduler.Add("Bandits", 100)
            elseif minute == 24 then
                BWOScheduler.Add("PoliceRiot", 100)
            end
        elseif worldAge == 72 then
            if minute == 2 then
                BWOScheduler.Add("Bikers", 100)
            elseif minute == 11 then
                BWOScheduler.Add("PoliceRiot", 100)
            end
        end
    end

    if worldAge >= 90 then
        BWOScheduler.SymptomLevel = 4
        BWOPopControl.StreetsNominal = 0
        BWOPopControl.InhabitantsNominal = 0
        BWOPopControl.SurvivorsNominal = 50
        BWOPopControl.ZombieMax = math.floor(worldAge * 5) - 335 -- 120, 125 .. n
    end

    -- general services control
    BWOPopControl.Police.On = false
    BWOPopControl.SWAT.On = false
    BWOPopControl.Security.On = false
    BWOPopControl.Medics.On = false
    BWOPopControl.Hazmats.On = false

    if worldAge < 32 then
        BWOPopControl.Medics.On = true
    end

    if worldAge < 48 then
        BWOPopControl.Police.On = true
        BWOPopControl.SWAT.On = true
        BWOPopControl.Security.On = true
    end

    if worldAge < 80 then
        BWOPopControl.Hazmats.On = true
    end

end

function BWOScheduler.Add(eventName, delay)
    event = {}
    event.start = BWOUtils.GetTime() + delay
    event.phase = eventName
    table.insert(BWOScheduler.Schedule, event)
end

-- processes schedule phases
function BWOScheduler.CheckSchedule()
    local player = getPlayer()
    local ct = BWOUtils.GetTime()
    for i, event in pairs(BWOScheduler.Schedule) do
        if event.start < ct then
            if BWOEvents[event.phase] then
                BWOEvents[event.phase](player)
            end
            table.remove(BWOScheduler.Schedule, i)
            break
        end
    end
end

Events.OnTick.Add(BWOScheduler.CheckSchedule)
Events.EveryOneMinute.Add(BWOScheduler.MasterControl)