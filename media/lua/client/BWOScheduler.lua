BWOScheduler = BWOScheduler or {}

-- queue of event tasks to be processed
BWOScheduler.Schedule = {}

-- general symptoms level 0 - 4
BWOScheduler.SymptomLevel = 0

-- how old is the world
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

    -- building emmiters
    if worldAge < 72 then

        -- church
        if hour >=6 and hour < 19 then
            if minute == 0 then
                local church = BWOBuildings.FindBuildingType("church")
                if church then
                    local def = church:getDef()
                    local x = (def:getX() + def:getX2()) / 2
                    local y = (def:getY() + def:getY2()) / 2
                    local emitter = getWorld():getFreeEmitter(x, y, 0)
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

    -- general control - adjusting world parameters and firing events based on world age

    -- assume day starts at 9.00
    -- D1 09:00 - D2 19:00
    if worldAge < 34 then
        BWOScheduler.SymptomLevel = 0
        BWOPopControl.StreetsNominal = 45
        BWOPopControl.InhabitantsNominal = 45
        BWOPopControl.SurvivorsNominal = 0
        BWOPopControl.ZombieMax = 0

        if worldAge == 0  then
            if minute == 1 or minute == 4 then
                BWOScheduler.Add("RegisterBase", 100)
            elseif minute == 2 then 
                BWOScheduler.Add("FixVehicles", 100)
            end
        elseif worldAge == 4 then
            if minute == 15 then
                BWOScheduler.Add("EventMusician", 100)
            end
        elseif worldAge == 6 then
            if minute == 35 then
                BWOScheduler.Add("EventMusician", 100)
            end
        elseif worldAge == 7 then
            if minute == 15 then
                BWOScheduler.Add("EventMusician", 100)
            end
        elseif worldAge == 11 then
            if minute == 12  then
                BWOScheduler.Add("EventBuildingParty", 100)
            end
        elseif worldAge == 12 then
            if minute == 30  then
                BWOScheduler.Add("EventBuildingParty", 100)
            end
        elseif worldAge == 13 then
            if minute == 5 or minute == 25 then
                BWOScheduler.Add("EventBuildingParty", 100)
            end
        elseif worldAge == 15 then
            if minute == 5 or minute == 25 then
                BWOScheduler.Add("EventBuildingParty", 100)
            end
        elseif worldAge == 16 then
            if minute == 58 then
                BWOScheduler.Add("EventBuildingParty", 100)
            end
        elseif worldAge == 24 then
            if minute == 15 then
                BWOScheduler.Add("EventMusician", 100)
            end
        elseif worldAge == 26 then
            if minute == 15 then
                BWOScheduler.Add("EventMusician", 100)
            end
        elseif worldAge == 28 then
            if minute == 33 then
                BWOScheduler.Add("EventMusician", 100)
            end
        end
    end

    -- D2 19:00 - D2 06:00
    if worldAge >= 34 and worldAge < 46 then
        BWOScheduler.SymptomLevel = 1
        BWOPopControl.StreetsNominal = 45
        BWOPopControl.InhabitantsNominal = 45
        BWOPopControl.SurvivorsNominal = 0
        BWOPopControl.ZombieMax = 0

        if worldAge == 35 then
            if minute == 20  then
                BWOScheduler.Add("EventBuildingParty", 100)
            end
        elseif worldAge == 36 then
            if minute == 10 or minute == 60  then
                BWOScheduler.Add("EventBuildingParty", 100)
            end
        elseif worldAge == 37 then
            if minute == 5 or minute == 25 then
                BWOScheduler.Add("EventBuildingParty", 100)
            end
        elseif worldAge == 39 then
            if minute == 2 then
                BWOScheduler.Add("EventBuildingParty", 100)
            end
        elseif worldAge == 42  then
            if minute == 7 then
                BWOScheduler.Add("RegisterBase", 100)
                BWOScheduler.Add("Thieves", 1500)
            end
        end

    end

    -- day 2
    -- D2 7:00 - D3 21:00
    if worldAge >= 46 and worldAge < 60 then
        BWOScheduler.SymptomLevel = 2
        BWOPopControl.StreetsNominal = 40
        BWOPopControl.InhabitantsNominal = 50
        BWOPopControl.SurvivorsNominal = 0
        BWOPopControl.ZombieMax = 0

        if worldAge == 48 then
            BWOPopControl.ZombieMax = 1
        elseif worldAge == 52 then
            BWOPopControl.ZombieMax = 1
        elseif worldAge == 55 then
            if minute == 11 then
                BWOScheduler.Add("Criminals", 100)
            end
        elseif worldAge == 58 then
            BWOPopControl.ZombieMax = 1
            if minute == 33 then
                BWOScheduler.Add("Criminals", 100)
            end
        elseif worldAge == 59 then
            BWOPopControl.ZombieMax = 1
            if minute == 44 or minute == 55 then
                BWOScheduler.Add("EventBuildingParty", 100)
            end
        end
    end


    -- D2 23:00 - D3 05:00
    if worldAge >= 60 and worldAge < 68 then
        BWOScheduler.SymptomLevel = 3
        BWOPopControl.StreetsNominal = 35
        BWOPopControl.InhabitantsNominal = 55
        BWOPopControl.SurvivorsNominal = 1
        BWOPopControl.ZombieMax = 0

        if worldAge == 63 then
            if minute == 30 then
                BWOScheduler.Add("Criminals", 100)
            end
        elseif worldAge == 65 then
            BWOPopControl.ZombieMax = 1
        elseif worldAge == 66 then
            BWOPopControl.ZombieMax = 1
            if minute == 39 or minute == 41 then
                BWOScheduler.Add("Criminals", 100)
            end
        end
    end

    -- D3 05:00 - D4 13:00
    if worldAge >= 68 and worldAge < 76 then
        BWOScheduler.SymptomLevel = 3
        BWOPopControl.StreetsNominal = 30
        BWOPopControl.InhabitantsNominal = 60
        BWOPopControl.SurvivorsNominal = 0
        BWOPopControl.ZombieMax = 0

        if worldAge == 69 then
            BWOPopControl.ZombieMax = 1
            if minute == 14 then
                BWOScheduler.Add("Defenders", 100)
            end
        end

        if worldAge == 71 then
            BWOPopControl.ZombieMax = 3
            if minute == 21 then
                BWOScheduler.Add("Defenders", 100)
            end
        end

        if worldAge == 74 then
            BWOPopControl.ZombieMax = 3
            if minute == 2 then
                BWOScheduler.Add("Defenders", 100)
            end
        end

    end

    -- D4 13:00 - D4 06:00
    if worldAge >= 76 and worldAge < 93 then
        BWOScheduler.SymptomLevel = 3
        BWOPopControl.StreetsNominal = 25
        BWOPopControl.InhabitantsNominal = 60
        BWOPopControl.SurvivorsNominal = 0
        BWOPopControl.ZombieMax = 0

        if worldAge == 77 then
            BWOPopControl.ZombieMax = 1
            if minute == 7 or minute == 57 then
                BWOScheduler.Add("Defenders", 100)
            elseif minute == 10 or minute == 30 then
                BWOScheduler.Add("ChopperAlert", 100)
            end
        elseif worldAge == 80 then
            BWOPopControl.ZombieMax = 1
            if minute == 41 then
                BWOScheduler.Add("Defenders", 100)
            end
        elseif worldAge == 83 then
            BWOPopControl.ZombieMax = 3
            if minute == 35 then
                BWOScheduler.Add("RegisterBase", 100)
                BWOScheduler.Add("Thieves", 1500)
            elseif minute == 2 or minute == 33 then
                BWOScheduler.Add("ChopperAlert", 100)
            end
        elseif worldAge == 87 then
            BWOPopControl.ZombieMax = 3
            if minute == 27 then
                BWOScheduler.Add("Arson", 100)
            elseif minute == 33 or minute == 50 then
                BWOScheduler.Add("Criminals", 100)
            end
        elseif worldAge == 88 then
            BWOPopControl.ZombieMax = 3
            if minute == 44 or minute == 46 or minute == 47 then
                BWOScheduler.Add("Criminals", 100)
            end
        elseif worldAge == 89 then
            if minute == 35 then
                BWOScheduler.Add("Defenders", 100)
            elseif minute == 52 then
                BWOScheduler.Add("Arson", 100)
            elseif minute == 58 then
                BWOScheduler.Add("RegisterBase", 100)
                BWOScheduler.Add("Thieves", 1500)
            end
        elseif worldAge == 90 then
            BWOPopControl.ZombieMax = 1
            if minute == 6 then
                BWOScheduler.Add("Defenders", 100)
            end
        elseif worldAge == 91 then
            BWOPopControl.ZombieMax = 5
            if minute == 4 then
                BWOScheduler.Add("Arson", 100)
            elseif minute == 23 then
                BWOScheduler.Add("Bandits", 100)
            end
        elseif worldAge == 92 then
            BWOPopControl.ZombieMax = 25
        end
    end

    -- D4 06:00 - D5 03:00
    if worldAge >= 93 and worldAge < 100 then
        BWOScheduler.SymptomLevel = 4
        BWOPopControl.StreetsNominal = 10
        BWOPopControl.InhabitantsNominal = 55
        BWOPopControl.SurvivorsNominal = 5
        BWOPopControl.ZombieMax = 100

        if worldAge == 93 then
            if minute == 0 then 
                BWOScheduler.Add("Siren", 100)
            elseif minute == 11 then
                BWOScheduler.Add("PoliceRiot", 100)
            elseif minute == 12 or minute == 44 then
                BWOScheduler.Add("ChopperAlert", 100)
            end
        elseif worldAge == 94 then
            if minute == 31 then
                BWOScheduler.Add("Defenders", 100)
            elseif minute == 33 or minute == 37 then
                BWOScheduler.Add("Criminals", 100)
            end
        elseif worldAge == 95 then
            if minute == 22 then
                BWOScheduler.Add("Bandits", 100)
            elseif minute == 24 then
                BWOScheduler.Add("PoliceRiot", 100)
            elseif minute == 33 or minute == 37 then
                BWOScheduler.Add("Criminals", 100)
            end
        elseif worldAge == 96 then
            if minute == 2 then
                BWOScheduler.Add("Defenders", 100)
                BWOScheduler.Add("Bikers", 100)
            elseif minute == 11 then
                BWOScheduler.Add("PoliceRiot", 100)
            end
        elseif worldAge == 99 then
            if minute == 2 then
                BWOScheduler.Add("Defenders", 100)
            end
        end
    end

    -- D5 03:00 - D6 01:00
    if worldAge >= 100 and worldAge < 136 then
        BWOScheduler.SymptomLevel = 4
        BWOPopControl.StreetsNominal = 5
        BWOPopControl.InhabitantsNominal = 45
        BWOPopControl.SurvivorsNominal = 10
        BWOPopControl.ZombieMax = 1000
        if worldAge == 105 then
            if minute == 52 then
                BWOScheduler.Add("Defenders", 100)
            end
        elseif worldAge == 112 then
            if minute == 0 then 
                BWOScheduler.Add("Arson", 100)
            elseif minute == 11 or minute == 44 then
                BWOScheduler.Add("Arson", 100)
                BWOScheduler.Add("Bandits", 300)
            elseif minute == 55 then
                BWOScheduler.Add("Defenders", 100)
                BWOScheduler.Add("Bikers", 100)
                BWOScheduler.Add("Bikers", 200)
                BWOScheduler.Add("Bikers", 300)
            end
        elseif worldAge == 113 then
            if minute == 31 then
                BWOScheduler.Add("Defenders", 100)
            elseif minut == 22 then
                BWOScheduler.Add("Arson", 200)
            elseif minute == 33 or minute == 35 or minute == 36 then
                BWOScheduler.Add("Criminals", 100)
                BWOScheduler.Add("Bandits", 500)
            end
        elseif worldAge == 116 then
            if minute == 15 then
                BWOScheduler.Add("Defenders", 100)
                BWOScheduler.Add("Thieves", 100)
            end
        elseif worldAge == 117 then
            if minute == 15 then
                BWOScheduler.Add("Thieves", 100)
            end
        end
    end

    -- D6 01:00 - ?
    if worldAge >= 136 then
        BWOPopControl.StreetsNominal = 0
        BWOPopControl.InhabitantsNominal = 0
        BWOPopControl.SurvivorsNominal = 50
        BWOPopControl.ZombieMax = 1000

        if worldAge == 125 then
            if minute == 2 then
                BWOScheduler.Add("Asylum", 100)
            end
        elseif worldAge == 128 then
            if minute == 14 then
                BWOScheduler.Add("Inmates", 100)
            end
        end
    end

    -- general services control
    BWOPopControl.Police.On = false
    BWOPopControl.SWAT.On = false
    BWOPopControl.Security.On = false
    BWOPopControl.Medics.On = false
    BWOPopControl.Hazmats.On = false

    if worldAge < 40 then
        BWOPopControl.Medics.On = true
    end

    if worldAge < 72 then
        BWOPopControl.Hazmats.On = true
    end

    if worldAge < 86 then
        BWOPopControl.Police.On = true
        BWOPopControl.SWAT.On = true
        BWOPopControl.Security.On = true
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