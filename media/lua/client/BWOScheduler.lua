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

    local worldAge = (day * 24 + hour) - (startDay * 24 + startHour)
    
    -- debug to jump to a certain hour
    worldAge = worldAge + 73

    BWOScheduler.WorldAge = worldAge
    
    -- building emmiters
    if worldAge < 72 then

        -- church
        if hour >=6 and hour < 19 then
            if minute == 0 then
                local church = BWOBuildings.FindBuildingWithRoom("church")
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
                local school = BWOBuildings.FindBuildingWithRoom("education")
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

    local params ={}
    params.x = player:getX()
    params.y = player:getY()
    params.z = player:getZ()

    -- assume day starts at 9.00
    -- D1 09:00 - D2 19:00
    if worldAge < 34 then
        BWOScheduler.SymptomLevel = 0
        BWOPopControl.StreetsNominal = 60
        BWOPopControl.InhabitantsNominal = 70
        BWOPopControl.SurvivorsNominal = 0
        BWOPopControl.ZombieMax = 0

        if worldAge == 0  then
            if minute == 1 then
                BWOScheduler.Add("RegisterBase", params, 100)
                BWOScheduler.Add("Start", params, 120)
            end
        elseif worldAge == 2 then
            if minute == 22 then
                params.intensity = 9
                BWOScheduler.Add("ArmyPatrol", params, 100)
            end
        elseif worldAge == 4 then
            if minute == 15 then
                BWOScheduler.Add("Entertainer", params, 100)
            end
        elseif worldAge == 5 then
            if minute == 44 then
                params.intensity = 9
                BWOScheduler.Add("ArmyPatrol", params, 100)
            end
        elseif worldAge == 6 then
            if minute == 35 then
                BWOScheduler.Add("Entertainer", params, 100)
            end
        elseif worldAge == 7 then
            if minute == 15 then
                BWOScheduler.Add("Entertainer", params, 100)
            end
        elseif worldAge == 11 then
            if minute == 12  then
                BWOScheduler.Add("BuildingParty", params, 100)
            end
        elseif worldAge == 12 then
            if minute == 30  then
                BWOScheduler.Add("BuildingParty", params, 100)
            end
        elseif worldAge == 13 then
            if minute == 5 or minute == 25 then
                BWOScheduler.Add("BuildingParty", params, 100)
            end
        elseif worldAge == 15 then
            if minute == 5 or minute == 25 then
                BWOScheduler.Add("BuildingParty", params, 100)
            end
        elseif worldAge == 16 then
            if minute == 58 then
                BWOScheduler.Add("BuildingParty", params, 100)
            end
        elseif worldAge == 19 then
            if minute == 43 then
                params.intensity = 3
                BWOScheduler.Add("RegisterBase", params, 100)
                BWOScheduler.Add("Thieves", params, 1500)
            end
        elseif worldAge == 24 then
            if minute == 15 then
                BWOScheduler.Add("Entertainer", params, 100)
            end
        elseif worldAge == 25 then
            if minute == 44 then
                params.intensity = 12
                BWOScheduler.Add("ArmyPatrol", params, 100)
            end
        elseif worldAge == 26 then
            if minute == 15 then
                BWOScheduler.Add("Entertainer", params, 100)
            end
        elseif worldAge == 27 then
            if minute == 8 then
                params.intensity = 12
                BWOScheduler.Add("ArmyPatrol", params, 100)
            end
        elseif worldAge == 28 then
            if minute == 33 then
                BWOScheduler.Add("Entertainer", params, 100)
            end
        elseif worldAge == 30 then
            if minute == 33 then
                params.intensity = 9
                BWOScheduler.Add("ArmyPatrol", params, 100)
            end
        end
    end

    -- D2 19:00 - D2 06:00
    if worldAge >= 34 and worldAge < 46 then
        BWOScheduler.SymptomLevel = 1
        BWOPopControl.StreetsNominal = 65
        BWOPopControl.InhabitantsNominal = 75
        BWOPopControl.SurvivorsNominal = 0
        BWOPopControl.ZombieMax = 0

        if worldAge == 35 then
            if minute == 20  then
                BWOScheduler.Add("BuildingParty", params, 100)
            end
        elseif worldAge == 36 then
            if minute == 10 or minute == 60  then
                BWOScheduler.Add("BuildingParty", params, 100)
            end
        elseif worldAge == 37 then
            if minute == 5 or minute == 25 then
                BWOScheduler.Add("BuildingParty", params, 100)
            end
        elseif worldAge == 39 then
            if minute == 2 then
                BWOScheduler.Add("BuildingParty", params, 100)
            end
        elseif worldAge == 42  then
            if minute == 7 then
                BWOScheduler.Add("RegisterBase", params, 100)

                params.intensity = 3
                BWOScheduler.Add("Thieves", params, 1500)
            end
        end

    end

    -- D2 7:00 - D3 21:00
    if worldAge >= 46 and worldAge < 60 then
        BWOScheduler.SymptomLevel = 2
        BWOPopControl.StreetsNominal = 70
        BWOPopControl.InhabitantsNominal = 80
        BWOPopControl.SurvivorsNominal = 0
        BWOPopControl.ZombieMax = 0

        if worldAge == 48 then
            BWOPopControl.ZombieMax = 1
        elseif worldAge == 50 then
            BWOPopControl.StreetsNominal = 50
            BWOPopControl.InhabitantsNominal = 50

        elseif worldAge == 51 then
            BWOPopControl.StreetsNominal = 60
            BWOPopControl.InhabitantsNominal = 40
            if minute == 9 then
                params.sound = "BWOChopperDisperse"
                BWOScheduler.Add("ChopperAlert", params, 100)
            end
        elseif worldAge == 52 then
            BWOPopControl.StreetsNominal = 70
            BWOPopControl.InhabitantsNominal = 30
            BWOPopControl.ZombieMax = 2
            if minute == 5 then
                params.sound = "BWOChopper"
                BWOScheduler.Add("ChopperAlert", params, 100)
            end
        elseif worldAge == 53 then
            BWOPopControl.StreetsNominal = 60
            BWOPopControl.InhabitantsNominal = 40
            BWOPopControl.ZombieMax = 2
            if minute == 1 then
                params.sound = "BWOChopper"
                BWOScheduler.Add("ChopperAlert", params, 100)
            end
        elseif worldAge == 54 then
            BWOPopControl.StreetsNominal = 50
            BWOPopControl.InhabitantsNominal = 30
            BWOPopControl.ZombieMax = 2
            if minute == 28 then
                params.sound = "BWOChopper"
                BWOScheduler.Add("ChopperAlert", params, 100)
            elseif minute == 30 then
                BWOScheduler.Add("Arson", params, 100)
            end
        elseif worldAge == 55 then
            if minute == 11 then
                params.intensity = 2
                BWOScheduler.Add("Criminals", params, 100)
            end
        elseif worldAge == 56 then
            BWOPopControl.ZombieMax = 2
        elseif worldAge == 58 then
            BWOPopControl.ZombieMax = 1
            if minute == 33 then
                params.intensity = 3
                BWOScheduler.Add("Criminals", params, 100)
            end
        elseif worldAge == 59 then
            BWOPopControl.ZombieMax = 1
            if minute == 44 or minute == 55 then
                BWOScheduler.Add("BuildingParty", params, 100)
            end
        end
    end

    -- D2 23:00 - D3 05:00
    if worldAge >= 60 and worldAge < 68 then
        BWOScheduler.SymptomLevel = 2
        BWOPopControl.StreetsNominal = 80
        BWOPopControl.InhabitantsNominal = 90
        BWOPopControl.SurvivorsNominal = 0
        BWOPopControl.ZombieMax = 0

        if worldAge == 63 then
            if minute == 30 then
                params.intensity = 4
                BWOScheduler.Add("Criminals", params, 100)
            end
        elseif worldAge == 65 then
            BWOPopControl.ZombieMax = 1
        elseif worldAge == 66 then
            BWOPopControl.ZombieMax = 1
            if minute == 39 or minute == 41 then
                params.intensity = 3
                BWOScheduler.Add("Criminals", params, 100)
            end
        end
    end

    -- D3 05:00 - D4 13:00
    if worldAge >= 68 and worldAge < 76 then
        BWOScheduler.SymptomLevel = 2
        BWOPopControl.StreetsNominal = 90
        BWOPopControl.InhabitantsNominal = 100
        BWOPopControl.SurvivorsNominal = 0
        BWOPopControl.ZombieMax = 0

        if worldAge == 69 then
            BWOPopControl.ZombieMax = 1
            if minute == 14 then
                BWOScheduler.Add("Defenders", params, 100)
            end
        elseif worldAge == 71 then
            BWOPopControl.ZombieMax = 3
            if minute == 5 or minute == 10 then
                for _, pcoords in pairs(BWOSquareLoader.protests) do 
                    BWOScheduler.Add("Protest", {x=pcoords.x, y=pcoords.y, z=pcoords.z}, 100)
                    params.sound = "BWOChopperDisperse"
                    params.x = pcoords.x
                    params.y = pcoords.y
                    params.z = pcoords.z
                    BWOScheduler.Add("ChopperAlert", params, 4000)
                end
            elseif minute == 21 then
                BWOScheduler.Add("Defenders", params, 100)
            end
        elseif worldAge == 72 then
            BWOPopControl.ZombieMax = 3
            if minute == 2 then
                BWOScheduler.Add("Defenders", params, 100)
            elseif minute == 16 or minute == 45 then
                params.sound = "BWOChopperDisperse"
                BWOScheduler.Add("ChopperAlert", params, 100)
            end
        elseif worldAge == 73 then
            BWOPopControl.ZombieMax = 3
            if minute == 0 then 
                BWOScheduler.Add("Siren", params, 100)
            elseif minute == 11 then
                params.intensity = 12
                params.hostile = true
                BWOScheduler.Add("PoliceRiot", params, 100)
            elseif minute == 12 or minute == 44 then
                params.sound = "BWOChopperDisperse"
                BWOScheduler.Add("ChopperAlert", params, 100)
            elseif minute == 15 or minute == 17 then
                params.intensity = 12
                params.hostile = true
                BWOScheduler.Add("PoliceRiot", params, 100)
            end
        elseif worldAge == 74 then
            BWOPopControl.ZombieMax = 3
            if minute == 27 then
                BWOScheduler.Add("Arson", params, 100)
            elseif minute == 33 or minute == 39 then
                params.intensity = 4
                BWOScheduler.Add("Criminals", params, 100)
            end
        elseif worldAge == 75 then
            if minute == 2 then
                params.intensity = 12
                params.hostile = true
                BWOScheduler.Add("PoliceRiot", params, 100)
                params.sound = "BWOChopperDisperse"
                BWOScheduler.Add("ChopperAlert", params, 100)
            end
        end
    end

    -- D4 13:00 - D4 06:00
    if worldAge >= 76 and worldAge < 93 then
        BWOScheduler.SymptomLevel = 3
        BWOPopControl.StreetsNominal = 70
        BWOPopControl.InhabitantsNominal = 80
        BWOPopControl.SurvivorsNominal = 0
        BWOPopControl.ZombieMax = 0

        if worldAge == 76 then
            BWOPopControl.ZombieMax = 1
            if minute == 7 or minute == 57 then
                BWOScheduler.Add("Defenders", params, 100)
            end
        elseif worldAge == 77 then
            if minute == 22 then
                BWOScheduler.Add("Arson", params, 100)
            elseif minute == 33 or minute == 39 then
                params.intensity = 4
                BWOScheduler.Add("Criminals", params, 100)
            end
        elseif worldAge == 78 then
            BWOPopControl.ZombieMax = 1
            if minute == 51 then
                BWOScheduler.Add("Defenders", params, 100)
            end
        elseif worldAge == 79 then
            if minute == 55 then
                BWOScheduler.Add("Arson", params, 100)
            elseif minute == 14 or minute == 15 then
                params.intensity = 3
                BWOScheduler.Add("Criminals", params, 100)
            end
        elseif worldAge == 80 then
            BWOPopControl.ZombieMax = 1
            if minute == 41 then
                BWOScheduler.Add("Defenders", params, 100)
            end
        elseif worldAge == 83 then
            BWOPopControl.ZombieMax = 3
            if minute == 35 then
                BWOScheduler.Add("RegisterBase", params, 100)

                params.intensity = 4
                BWOScheduler.Add("Thieves", 1500)
            elseif minute == 2 or minute == 33 then
                params.sound = "BWOChopper"
                BWOScheduler.Add("ChopperAlert", params, 100)
            end
        elseif worldAge == 87 then
            BWOPopControl.ZombieMax = 3
            if minute == 27 then
                BWOScheduler.Add("Arson", params, 100)
            elseif minute == 33 or minute == 50 then
                params.intensity = 4
                BWOScheduler.Add("Criminals", params, 100)
            end
        elseif worldAge == 88 then
            BWOPopControl.ZombieMax = 3
            if minute == 44 or minute == 46 or minute == 47 then
                params.intensity = 3
                BWOScheduler.Add("Criminals", params, 100)
            end
        elseif worldAge == 89 then
            if minute == 35 then
                BWOScheduler.Add("Defenders", params, 100)
            elseif minute == 52 then
                BWOScheduler.Add("Arson", params, 100)
            elseif minute == 58 then
                BWOScheduler.Add("RegisterBase", params, 100)

                params.intensity = 5
                BWOScheduler.Add("Thieves", params, 1500)
            end
        elseif worldAge == 90 then
            BWOPopControl.ZombieMax = 1
            if minute == 6 then
                BWOScheduler.Add("Defenders", params, 100)
            end
        elseif worldAge == 91 then
            BWOPopControl.ZombieMax = 5
            if minute == 4 then
                BWOScheduler.Add("Arson", params, 100)
            elseif minute == 23 then
                params.intensity = 4
                BWOScheduler.Add("Bandits", params, 100)
            end
        elseif worldAge == 92 then
            BWOPopControl.ZombieMax = 12
        end
    end

    -- D4 06:00 - 09:00
    if worldAge >= 93 and worldAge < 97 then
        BWOScheduler.SymptomLevel = 4
        
        if worldAge == 93 then
            BWOPopControl.StreetsNominal = 75
            BWOPopControl.InhabitantsNominal = 70
            BWOPopControl.SurvivorsNominal = 1
            BWOPopControl.ZombieMax = 100
        elseif worldAge == 94 then
            BWOPopControl.StreetsNominal = 80
            BWOPopControl.InhabitantsNominal = 50
            BWOPopControl.SurvivorsNominal = 2
            BWOPopControl.ZombieMax = 200
            if minute == 31 then
                BWOScheduler.Add("Defenders", params, 100)
            elseif minute == 33 or minute == 37 then
                params.intensity = 5
                BWOScheduler.Add("Criminals", params, 100)
            end
        elseif worldAge == 95 then
            BWOPopControl.StreetsNominal = 100
            BWOPopControl.InhabitantsNominal = 40
            BWOPopControl.SurvivorsNominal = 3
            BWOPopControl.ZombieMax = 300
            if minute == 22 then
                params.intensity = 5
                BWOScheduler.Add("Bandits", params, 100)
            elseif minute == 33 or minute == 37 then
                params.intensity = 6
                BWOScheduler.Add("Criminals", params, 100)
            end
        elseif worldAge == 96 then
            BWOPopControl.StreetsNominal = 130
            BWOPopControl.InhabitantsNominal = 35
            BWOPopControl.SurvivorsNominal = 5
            BWOPopControl.ZombieMax = 400
            if minute == 15 then
                params.intensity = 8
                BWOScheduler.Add("Army", params, 100)
            end
        end
    end

    -- D5 09:00 - 13:00
    if worldAge >= 97 and worldAge < 100 then
        BWOScheduler.SymptomLevel = 5
        BWOPopControl.ZombieMax = 1000
        if worldAge == 97 then
            BWOPopControl.StreetsNominal = 160
            BWOPopControl.InhabitantsNominal = 55
            BWOPopControl.SurvivorsNominal = 6
            if minute == 0 then 
                BWOScheduler.Add("Siren", params, 100)
            elseif minute == 8 or minute == 24 or minute == 49 then
                params.intensity = 10
                BWOScheduler.Add("GasRun", params, 100)
            elseif minute == 2 then
                BWOScheduler.Add("Defenders", params, 100)
                params.intensity = 12
                BWOScheduler.Add("Bikers", params, 100)
            end
        elseif worldAge == 98 then
            BWOPopControl.StreetsNominal = 80
            BWOPopControl.InhabitantsNominal = 45
            BWOPopControl.SurvivorsNominal = 8
            if minute == 11 then
                params.intensity = 8
                BWOScheduler.Add("Army", params, 100)
            elseif minute == 8 or minute == 24 or minute == 49 then
                params.intensity = 16
                BWOScheduler.Add("GasRun", params, 100)
            end
        elseif worldAge == 99 then
            BWOPopControl.StreetsNominal = 35
            BWOPopControl.InhabitantsNominal = 40
            BWOPopControl.SurvivorsNominal = 10
            if minute == 2 then
                BWOScheduler.Add("Defenders", params, 100)
            elseif minute == 8 or minute == 24 then
                params.intensity = 14 
                BWOScheduler.Add("GasRun", params, 100)
            end
        end
    end

    -- D5 03:00 - D6 01:00
    if worldAge >= 100 and worldAge < 136 then
        BWOScheduler.SymptomLevel = 5
        BWOPopControl.StreetsNominal = 10
        BWOPopControl.InhabitantsNominal = 10
        BWOPopControl.SurvivorsNominal = 8
        BWOPopControl.ZombieMax = 1000
        if worldAge == 100 then
            if minute == 44 or minute == 46 then
                params.intensity = 5
                BWOScheduler.Add("Army", params, 100)
            end
        elseif worldAge == 105 then
            if minute == 52 then
                BWOScheduler.Add("Defenders", params, 100)
            end
        elseif worldAge == 112 then
            if minute == 0 then 
                BWOScheduler.Add("Arson", params, 100)
            elseif minute == 11 or minute == 44 then
                BWOScheduler.Add("Arson", params, 100)

                params.intensity = 6
                BWOScheduler.Add("Bandits", params, 300)
            elseif minute == 55 then
                BWOScheduler.Add("Defenders", params, 100)

                params.intensity = 3
                BWOScheduler.Add("Bikers", params, 100)
                BWOScheduler.Add("Bikers", params, 200)
                BWOScheduler.Add("Bikers", params, 300)
            end
        elseif worldAge == 113 then
            if minute == 31 then
                BWOScheduler.Add("Defenders", params, 100)
            elseif minut == 22 then
                BWOScheduler.Add("Arson", params, 200)
            elseif minute == 33 or minute == 35 or minute == 36 then
                params.intensity = 5
                BWOScheduler.Add("Criminals", params, 100)

                params.intensity = 4
                BWOScheduler.Add("Bandits", params, 500)
            end
        elseif worldAge == 116 then
            if minute == 15 then
                BWOScheduler.Add("Defenders", params, 100)

                params.intensity = 6
                BWOScheduler.Add("Thieves", params, 100)
            end
        elseif worldAge == 117 then
            if minute == 15 then
                params.intensity = 6
                BWOScheduler.Add("Thieves", params, 100)
            end
        elseif worldAge == 118 then
            if minute == 0 then 
                BWOScheduler.Add("Siren", params, 100)
            elseif minute == 5 or minute == 25 or minute == 45 then
                params.intensity = 1
                BWOScheduler.Add("JetFighterRun", params, 100)
            end
        elseif worldAge == 120 then
            if minute == 0 then 
                BWOScheduler.Add("Siren", params, 100)
            elseif minute == 5 or minute == 25 or minute == 45 then
                params.intensity = 1
                BWOScheduler.Add("JetFighterRun", params, 100)
            end
        elseif worldAge == 122 then
            if minute == 0 then 
                BWOScheduler.Add("Siren", params, 100)
            elseif minute == 5 or minute == 25 or minute == 45 then
                params.intensity = 1
                BWOScheduler.Add("JetFighterRun", params, 100)
            end
        elseif worldAge == 124 then
            if minute == 0 then 
                BWOScheduler.Add("Siren", params, 100)
            elseif minute == 5 or minute == 25 or minute == 45 then
                params.intensity = 1
                BWOScheduler.Add("JetFighterRun", params, 100)
            end
        elseif worldAge == 128 then
            if minute == 0 then 
                BWOScheduler.Add("Siren", params, 100)
            elseif minute == 5 or minute == 25 or minute == 45 then
                params.intensity = 1
                BWOScheduler.Add("JetFighterRun", params, 100)
            end
        elseif worldAge == 130 then
            if minute == 0 then 
                BWOScheduler.Add("Siren", params, 100)
            elseif minute == 25 or minute == 35 or minute == 59 then
                params.intensity = 1
                BWOScheduler.Add("JetFighterRun", params, 100)
            end
        elseif worldAge == 132 then
            if minute == 0 then 
                BWOScheduler.Add("Siren", params, 100)
            elseif minute == 15 or minute == 35 or minute == 55 then
                params.intensity = 1
                BWOScheduler.Add("JetFighterRun", params, 100)
            end
        elseif worldAge == 134 then
            if minute == 0 then 
                BWOScheduler.Add("Siren", params, 100)
            elseif minute == 5 or minute == 25 or minute == 45 then
                params.intensity = 1
                BWOScheduler.Add("JetFighterRun", params, 100)
            end
        end
    end

    -- D6 01:00 - D7 09.00
    if worldAge >= 125 and worldAge < 144 then
        BWOScheduler.SymptomLevel = 5
        BWOPopControl.StreetsNominal = 5
        BWOPopControl.InhabitantsNominal = 5
        BWOPopControl.SurvivorsNominal = 6
        BWOPopControl.ZombieMax = 1000

        if worldAge == 125 then
            if minute == 2 then
                params.intensity = 10
                BWOScheduler.Add("Arson", params, 200)
                BWOScheduler.Add("Asylum", params, 100)
            elseif minute == 5 then
                BWOScheduler.Add("Arson", params, 200)
            end
        elseif worldAge == 128 then
            if minute == 14 then
                params.intensity = 12
                BWOScheduler.Add("Army", params, 100)
            elseif minute == 16 or minute == 27 then 
                params.intensity = 18
                BWOScheduler.Add("Arson", params, 200)
                BWOScheduler.Add("Inmates", params, 100)
            elseif minute == 58 then
                BWOScheduler.Add("Arson", params, 200)
            end
        elseif worldAge == 130 then
            if minute == 15 then
                params.intensity = 12
                BWOScheduler.Add("Army", params, 100)
            end
        elseif worldAge == 132 then
            if minute == 11 then
                params.intensity = 12
                BWOScheduler.Add("Arson", params, 200)
                BWOScheduler.Add("Army", params, 100)
            end
        elseif worldAge == 135 then
            if minute % 10 == 0 then
                params.intensity = 4
                BWOScheduler.Add("Bandits", params, 100)
            end
        elseif worldAge == 136 then
            if minute == 12 or minute == 14 then
                params.intensity = 10
                BWOScheduler.Add("Army", params, 100)
            elseif minute == 13 then
                params.intensity = 6
                BWOScheduler.Add("Bandits", params, 100)
                BWOScheduler.Add("Arson", params, 200)
            end
        elseif worldAge == 138 then
            if minute % 8 == 0 then
                params.intensity = 3
                BWOScheduler.Add("Bandits", params, 100)
            end
            if minute == 33 then
                params.intensity = 6
                BWOScheduler.Add("Army", params, 100)
            end
        end
    end

    -- D7 09.00
    if worldAge >= 144 and worldAge < 167 then
        BWOScheduler.SymptomLevel = 5
        BWOPopControl.StreetsNominal = 0
        BWOPopControl.InhabitantsNominal = 0
        BWOPopControl.SurvivorsNominal = 4
        BWOPopControl.ZombieMax = 1000
        
        if minute == 0 then 
            BWOScheduler.Add("Siren", params, 100)
        elseif minute == 8 or minute == 24 or minute == 49 then
            params.intensity = 20 + worldAge - 145
            BWOScheduler.Add("BombRun", params, 100)
        end

    end

    -- 167 is the hour of silence

    -- D8 09.00 and for the grand finale
    if worldAge == 168 then
        if minute == 0 then 
            BWOScheduler.Add("Siren", params, 100)
        elseif minute == 9 then
            BWOScheduler.Add("FinalSolution", params, 100)
        end
    end

    -- general services control
    BWOPopControl.Police.On = false
    BWOPopControl.SWAT.On = false
    BWOPopControl.Security.On = false
    BWOPopControl.Medics.On = false
    BWOPopControl.Hazmats.On = false
    BWOPopControl.Fireman.On = false

    if worldAge < 40 then
        BWOPopControl.Medics.On = true
    end

    if worldAge < 72 then
        BWOPopControl.Hazmats.On = true
    end

    if worldAge < 78 then
        BWOPopControl.Police.On = true
        BWOPopControl.SWAT.On = true
        BWOPopControl.Security.On = true
        BWOPopControl.Fireman.On = true
    end
end

function BWOScheduler.Add(eventName, params, delay)
    event = {}
    event.start = BanditUtils.GetTime() + delay
    event.phase = eventName
    event.params = params
    table.insert(BWOScheduler.Schedule, event)
end

-- processes schedule phases
function BWOScheduler.CheckSchedule()
    local player = getPlayer()
    local ct = BanditUtils.GetTime()
    for i, event in pairs(BWOScheduler.Schedule) do
        if event.start < ct then
            if BWOEvents[event.phase] then
                BWOEvents[event.phase](event.params)
            end
            table.remove(BWOScheduler.Schedule, i)
            break
        end
    end
end

Events.OnTick.Add(BWOScheduler.CheckSchedule)
Events.EveryOneMinute.Add(BWOScheduler.MasterControl)
