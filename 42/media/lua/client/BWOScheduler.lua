BWOScheduler = BWOScheduler or {}

-- queue of evenst added from schedule to be processed
BWOScheduler.Events = {}

-- general symptoms level 0 - 4
BWOScheduler.SymptomLevel = 0

-- how old is the world
BWOScheduler.WorldAge = 0

-- flags tables
BWOScheduler.World = {}
BWOScheduler.NPC = {}
BWOScheduler.Anarchy = {}

-- schedule 
local generateSchedule = function()
    local tab = {}
    for wa=0, 200 do
        tab[wa] = {}
        for m=0, 59 do
            tab[wa][m] = {}
        end
    end
    
    -- {eventName, {params}}
    -- DAY 1 09.00
    tab[0][1]  = {"StartDay", {day="thursday"}}
    tab[0][2]   = {"Start", {}}
    tab[0][3]   = {"RegisterBase", {}}
    tab[2][22]  = {"ArmyPatrol", {intensity=9}}
    tab[4][15]  = {"Entertainer", {}}
    tab[5][44]  = {"ArmyPatrol", {intensity=9}}
    tab[6][35]  = {"Entertainer", {}}
    tab[7][15]  = {"Entertainer", {}}
    tab[8][5]   = {"Defenders", {occupation="policeofficer"}}
    tab[8][5]   = {"Arson", {occupation="fireofficer"}}

    tab[11][12] = {"BuildingParty", {}}
    tab[12][30] = {"BuildingParty", {}}
    tab[13][5]  = {"BuildingParty", {}}
    tab[13][25] = {"BuildingParty", {}}
    tab[15][5]  = {"BuildingParty", {}}
    tab[15][25] = {"BuildingParty", {}}
    tab[16][58] = {"BuildingParty", {}}
    tab[19][42] = {"RegisterBase", {}}
    tab[19][43] = {"Thieves", {intensity=3}}
    
    -- DAY 2 09.00
    tab[24][0]  = {"StartDay", {day="friday"}}
    tab[24][15] = {"Entertainer", {}}
    tab[25][44] = {"ArmyPatrol", {intensity=12}}
    tab[26][20] = {"Entertainer", {}}
    tab[26][21] = {"SetHydroPower", {on=false}}
    tab[26][22] = {"SetHydroPower", {on=true}}
    tab[27][8]  = {"ArmyPatrol", {intensity=12}}
    tab[28][33] = {"Entertainer", {}}
    tab[30][33] = {"ArmyPatrol", {intensity=9}}
    tab[35][20] = {"BuildingParty", {}}
    tab[36][10] = {"BuildingParty", {}}
    tab[37][5]  = {"BuildingParty", {}}
    tab[37][25] = {"BuildingParty", {}}
    tab[39][2]  = {"BuildingParty", {}}
    tab[39][14] = {"Defenders", {occupation="policeofficer"}}
    tab[39][14] = {"Arson", {occupation="fireofficer"}}
    tab[42][6]  = {"RegisterBase", {}}
    tab[42][7]  = {"Thieves", {intensity=4}}

    -- DAY 3 09.00
    tab[48][0]  = {"StartDay", {day="saturday"}}
    tab[51][9]  = {"ChopperAlert", {sound="BWOChopper"}}
    tab[52][5]  = {"ChopperAlert", {sound="BWOChopper"}}
    tab[52][11] = {"Criminals", {intensity=2}}
    tab[53][1]  = {"ChopperAlert", {sound="BWOChopper"}}
    tab[54][28] = {"ChopperAlert", {sound="BWOChopper"}}
    tab[54][30] = {"Arson", {}}
    tab[55][11] = {"Criminals", {intensity=2}}
    tab[58][33] = {"Criminals", {intensity=3}}
    tab[59][44] = {"BuildingParty", {}}
    tab[59][55] = {"BuildingParty", {}}
    tab[63][30] = {"Criminals", {intensity=4}}
    tab[66][39] = {"Criminals", {intensity=3}}
    tab[66][41] = {"Criminals", {intensity=3}}
    tab[69][14] = {"Defenders", {}}
    tab[71][21] = {"Defenders", {}}

    -- DAY 4 09.00
    tab[72][0]  = {"StartDay", {day="sunday"}}
    tab[72][2]  = {"Defenders", {}}
    tab[76][7]  = {"Defenders", {}}
    tab[76][57] = {"Defenders", {}}
    tab[77][22] = {"Arson", {}}
    tab[77][33] = {"Criminals", {intensity=4}}
    tab[77][39] = {"Criminals", {intensity=4}}
    tab[78][51] = {"Defenders", {}}
    tab[79][14] = {"Criminals", {intensity=3}}
    tab[79][15] = {"Criminals", {intensity=3}}
    tab[79][55] = {"Arson", {}}
    tab[80][41] = {"Defenders", {}}
    tab[83][35] = {"RegisterBase", {}}
    tab[83][36] = {"Thieves", {intensity=4}}
    tab[83][2]  = {"ChopperAlert", {sound="BWOChopper"}}
    tab[83][33] = {"ChopperAlert", {sound="BWOChopper"}}
    tab[87][27] = {"Arson", {}}
    tab[87][33] = {"Criminals", {intensity=4}}
    tab[87][50] = {"Criminals", {intensity=5}}
    tab[88][44] = {"Criminals", {intensity=6}}
    tab[88][46] = {"Criminals", {intensity=7}}
    tab[88][47] = {"Criminals", {intensity=6}}
    tab[89][35] = {"Defenders", {}}
    tab[89][52] = {"Arson", {}}
    tab[89][58] = {"RegisterBase", {}}
    tab[89][59] = {"Thieves", {intensity=5}}
    tab[90][6]  = {"Defenders", {}}
    tab[91][4]  = {"Arson", {}}
    tab[91][23] = {"Bandits", {intensity=4}}
    tab[94][31] = {"Defenders", {}}
    tab[94][33] = {"Criminals", {intensity=5}}
    tab[94][37] = {"Criminals", {intensity=6}}
    tab[95][22] = {"Bandits", {intensity=4}}
    tab[95][33] = {"Criminals", {intensity=5}}
    tab[95][37] = {"Criminals", {intensity=4}}

    -- DAY 5 09.00
    tab[96][0]  = {"StartDay", {day="monday"}}
    tab[96][15] = {"Army", {intensity=8}}
    tab[97][2]  = {"Defenders", {}}
    tab[97][3]  = {"Bikers", {intensity=12}}
    tab[98][10] = {"Defenders", {}}
    tab[103][10] = {"Defenders", {}}
    tab[105][52] = {"Defenders", {}}
    tab[112][0]  = {"Arson", {}}
    tab[112][11] = {"Arson", {}}
    tab[112][12] = {"Bandits", {intensity=6}}
    tab[112][44] = {"Arson", {}}
    tab[112][45] = {"Bandits", {intensity=6}}
    tab[112][55] = {"Defenders", {}}
    tab[112][56] = {"Bikers", {intensity=9}}
    tab[113][31] = {"Defenders", {}}
    tab[113][22] = {"Arson", {}}
    tab[113][33] = {"Criminals", {intensity=4}}
    tab[113][35] = {"Criminals", {intensity=5}}
    tab[113][36] = {"Bandits", {intensity=6}}
    tab[113][37] = {"Criminals", {intensity=5}}
    tab[113][38] = {"Bandits", {intensity=5}}
    tab[113][39] = {"Bandits", {intensity=2}}
    tab[116][15] = {"Defenders", {}}
    tab[116][16] = {"RegisterBase", {}}
    tab[116][17] = {"Thieves", {intensity=6}}
    tab[117][15] = {"Thieves", {intensity=6}}

    -- DAY 6 09.00
    tab[120][0]  = {"StartDay", {day="tuesday"}}
    tab[125][2]  = {"Arson", {}}
    tab[125][3]  = {"Asylum", {intensity=12}}
    tab[125][5]  = {"Arson", {}}
    tab[128][14] = {"Army", {intensity=12}}
    tab[128][16] = {"Arson", {}}
    tab[128][27] = {"Arson", {}}
    tab[130][0]  = {"Siren", {}}
    tab[130][25] = {"Army", {intensity=12}}

    tab[132][0]  = {"Siren", {}}
    tab[132][11] = {"Army", {intensity=12}}

    tab[135][0]  = {"Bandits", {intensity=4}}
    tab[135][1] = {"SetHydroPower", {on=false}}
    tab[135][2] = {"SetHydroPower", {on=true}}
    tab[135][8]  = {"SetHydroPower", {on=false}}
    tab[135][10] = {"Bandits", {intensity=4}}
    tab[135][20] = {"Bandits", {intensity=4}}
    tab[135][30] = {"Bandits", {intensity=4}}
    tab[135][32] = {"SetHydroPower", {on=true}}
    tab[135][40] = {"Bandits", {intensity=4}}
    tab[135][50] = {"Bandits", {intensity=4}}
    tab[136][12] = {"Army", {intensity=10}}
    tab[136][14] = {"Army", {intensity=10}}
    tab[138][2]  = {"Bandits", {intensity=3}}

    -- DAY 7 09.00
    tab[144][0]  = {"StartDay", {day="wednesday"}}

    tab[147][2]  = {"ProtestAll", {}}
    tab[147][16] = {"ChopperAlert", {sound="BWOChopperDisperse"}}
    tab[147][45] = {"ChopperAlert", {sound="BWOChopperDisperse"}}
    tab[147][0]  = {"Siren", {}}
    tab[148][11] = {"PoliceRiot", {intensity=12, hostile=true}}
    tab[148][12] = {"ChopperAlert", {sound="BWOChopperDisperse"}}
    tab[148][15] = {"PoliceRiot", {intensity=12, hostile=true}}
    tab[148][17] = {"PoliceRiot", {intensity=12, hostile=true}}
    tab[148][44] = {"ChopperAlert", {sound="BWOChopperDisperse"}}
    tab[149][27] = {"Arson", {}}
    tab[149][33] = {"Criminals", {intensity=4}}
    tab[149][39] = {"Criminals", {intensity=4}}
    tab[149][41] = {"ChopperAlert", {sound="BWOChopperDisperse"}}
    tab[149][45] = {"PoliceRiot", {intensity=12, hostile=true}}

    tab[150][0]  = {"Siren", {}}
    tab[150][5]  = {"JetFighterRun", {intensity=1}}
    tab[150][25] = {"JetFighterRun", {intensity=1}}
    tab[150][45] = {"JetFighterRun", {intensity=1}}
    tab[150][54] = {"Army", {intensity=5}}

    tab[151][8]  = {"GasRun", {intensity=4}}
    tab[151][24] = {"GasRun", {intensity=4}}
    tab[151][28] = {"Army", {intensity=5}}
    tab[151][49] = {"GasRun", {intensity=4}}
    tab[152][8]  = {"GasRun", {intensity=4}}
    tab[152][9]  = {"Army", {intensity=10}}
    tab[152][50] = {"Bandits", {intensity=5}}
    tab[152][24] = {"GasRun", {intensity=4}}
    tab[152][49] = {"GasRun", {intensity=6}}
    tab[153][8]  = {"Defenders", {}}
    tab[153][12] = {"GasRun", {intensity=8}}
    tab[153][24] = {"GasRun", {intensity=6}}
    tab[153][44] = {"Army", {intensity=5}}
    tab[153][45] = {"Bandits", {intensity=5}}
    tab[153][46] = {"Army", {intensity=5}}
    tab[153][50] = {"GasRun", {intensity=4}}

    tab[154][25] = {"Army", {intensity=2}}
    tab[154][26] = {"Inmates", {intensity = 12}}

    tab[155][5]  = {"JetFighterRun", {intensity=1}}
    tab[155][15] = {"JetFighterRun", {intensity=1}}
    tab[153][16] = {"Bandits", {intensity=3}}
    tab[153][17] = {"Bandits", {intensity=3}}
    tab[153][18] = {"Bandits", {intensity=3}}
    tab[155][25] = {"JetFighterRun", {intensity=1}}
    tab[155][26] = {"Army", {intensity=10}}

    tab[156][5]  = {"GasRun", {intensity=8}}
    tab[156][10] = {"Bandits", {intensity=12}}
    tab[156][15] = {"GasRun", {intensity=10}}
    tab[156][25] = {"GasRun", {intensity=8}}
    tab[156][26] = {"Army", {intensity=10}}

    tab[158][0]  = {"Siren", {}}
    tab[158][8]  = {"BombRun", {intensity=6}}
    tab[156][9]  = {"Bandits", {intensity=9}}
    tab[158][24] = {"BombRun", {intensity=20}}
    tab[158][49] = {"BombRun", {intensity=18}}
    tab[158][51] = {"SetHydroPower", {on=false}}
    tab[158][52] = {"SetHydroPower", {on=true}}

    tab[159][8]  = {"BombRun", {intensity=6}}
    tab[159][9]  = {"SetHydroPower", {on=false}}
    tab[159][10] = {"SetHydroPower", {on=true}}
    tab[159][24] = {"BombRun", {intensity=20}}
    tab[159][25] = {"SetHydroPower", {on=false}}
    tab[159][27] = {"SetHydroPower", {on=true}}
    tab[159][49] = {"BombRun", {intensity=18}}

    tab[160][8]  = {"BombRun", {intensity=6}}
    tab[160][9]  = {"Bandits", {intensity=9}}
    tab[160][24] = {"BombRun", {intensity=20}}
    tab[160][25] = {"SetHydroPower", {on=false}}
    tab[160][26] = {"SetHydroPower", {on=true}}
    tab[160][49] = {"BombRun", {intensity=18}}
    tab[160][51] = {"SetHydroPower", {on=false}}
    tab[160][53] = {"SetHydroPower", {on=true}}

    tab[161][8]  = {"BombRun", {intensity=6}}
    tab[161][24] = {"BombRun", {intensity=20}}
    tab[161][49] = {"BombRun", {intensity=18}}
    tab[161][51] = {"SetHydroPower", {on=false}}
    tab[161][58] = {"SetHydroPower", {on=true}}

    tab[162][8]  = {"BombRun", {intensity=6}}
    tab[162][24] = {"BombRun", {intensity=20}}
    tab[162][49] = {"BombRun", {intensity=18}}
    tab[162][50] = {"SetHydroPower", {on=false}}
    tab[162][51] = {"SetHydroPower", {on=true}}
    tab[163][8]  = {"BombRun", {intensity=6}}
    tab[163][15] = {"Bandits", {intensity=5}}
    tab[163][24] = {"BombRun", {intensity=20}}
    tab[163][49] = {"BombRun", {intensity=18}}
    tab[164][8]  = {"BombRun", {intensity=6}}
    tab[164][10] = {"SetHydroPower", {on=false}}
    tab[164][13] = {"SetHydroPower", {on=true}}
    tab[164][24] = {"BombRun", {intensity=20}}
    tab[164][49] = {"BombRun", {intensity=18}}

    -- DAY 8 09.00
    tab[168][0]  = {"StartDay", {day="thursday"}}
    tab[168][4]  = {"Siren", {}}
    tab[168][24] = {"FinalSolution", {}}
    tab[168][29] = {"SetHydroPower", {on=false}}

    return tab
end

BWOScheduler.Schedule = generateSchedule()

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
    -- worldAge = worldAge -1

    BWOScheduler.WorldAge = worldAge
    
    -- set flags based on world age that control various aspects of the game

    -- world flags
    BWOScheduler.World = {}

    -- removes objects that conflict stylistically with prepandemic world
    BWOScheduler.World.ObjectRemover = false
    if BWOScheduler.WorldAge < 64 then BWOScheduler.World.ObjectRemover = true end

    -- removed initial deadbodies
    BWOScheduler.World.DeadBodyRemover = false
    if BWOScheduler.WorldAge < 48 then BWOScheduler.World.DeadBodyRemover = true end

    -- registers certain exterior objects positions that npcs can interacts with
    BWOScheduler.World.GlobalObjectAdder = false
    if BWOScheduler.WorldAge < 90 then BWOScheduler.World.GlobalObjectAdder = true end

    -- transforms the world appearance to simulate post-nuclear strike
    BWOScheduler.World.PostNuclearTransformator = false
    if BWOScheduler.WorldAge >= 169 then BWOScheduler.World.PostNuclearTransformator = true end

    -- either fixes the car or removes burned or smashed cars for prepademic world
    BWOScheduler.World.VehicleFixer = false
    if BWOScheduler.WorldAge < 90 then BWOScheduler.World.VehicleFixer = true end

    -- npc logic flags
    BWOScheduler.NPC = {}

    -- controls if npcs will react to protests events
    BWOScheduler.NPC.ReactProtests = false
    if BWOScheduler.WorldAge < 154 then BWOScheduler.NPC.ReactProtests = true end

    -- controls if npcs will react to protests events
    BWOScheduler.NPC.ReactDeadBody = false
    if BWOScheduler.WorldAge < 78 then BWOScheduler.NPC.ReactDeadBody = true end

    -- controls if npcs will react to street preachers
    BWOScheduler.NPC.ReactPreacher = false
    if BWOScheduler.WorldAge < 71 then BWOScheduler.NPC.ReactPreacher = true end

    -- controls if npcs will react to street entertainers
    BWOScheduler.NPC.ReactEntertainers = false
    if BWOScheduler.WorldAge < 65 then BWOScheduler.NPC.ReactEntertainers = true end

    -- controls if npcs will sit on exterior benches
    BWOScheduler.NPC.SitBench = false
    if BWOScheduler.WorldAge < 65 then BWOScheduler.NPC.SitBench = true end

    -- controls the period in which npc will run the atms
    BWOScheduler.NPC.BankRun = false
    if BWOScheduler.WorldAge > 67 and BWOScheduler.WorldAge < 87 then BWOScheduler.NPC.BankRun = true end

    -- controls if npcs will sit on exterior benches
    BWOScheduler.NPC.Talk = false
    if BWOScheduler.WorldAge < 58 then BWOScheduler.NPC.Talk = true end

    -- controls when npc start running instead of walking by default, also cars not stopping
    BWOScheduler.NPC.Run = false
    if BWOScheduler.WorldAge > 80 then BWOScheduler.NPC.Run = true end

    -- controls when npcbarricade their homes
    BWOScheduler.NPC.Barricade = false
    if BWOScheduler.WorldAge > 72 then BWOScheduler.NPC.Barricade = true end

    -- controls functionalities that diminish during the anarchy
    BWOScheduler.Anarchy = {}

    -- if buildings emit sounds like if they are operational (church / school)
    BWOScheduler.Anarchy.BuildingOperational = true
    if BWOScheduler.WorldAge > 72 then BWOScheduler.Anarchy.BuildingOperational = false end

    -- controls if buying and earning is still possible
    BWOScheduler.Anarchy.Transactions = true
    if BWOScheduler.WorldAge > 80 then BWOScheduler.Anarchy.Transactions = false end
    
    -- controls minor crime has consequences (breaking windows)
    BWOScheduler.Anarchy.IllegalMinorCrime = true
    if BWOScheduler.WorldAge > 100 then BWOScheduler.Anarchy.IllegalMinorCrime = false end

    -- building emmiters
    if BWOScheduler.Anarchy.BuildingOperational then

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

        -- gigamart
        --[[
        if hour >=8 and hour < 24 then
            if minute == 0 then
                local shop = BWOBuildings.FindBuildingWithRoom("gigamart")
                if shop then
                    local def = shop:getDef()
                    local emitter = getWorld():getFreeEmitter((def:getX() + def:getX2()) / 2, (def:getY() + def:getY2()) / 2, 0)
                    emitter:setVolumeAll(0.8)
                    emitter:playSound("ZSBuildingGigamart")
                end
            end
        end
        ]]
    end

    -- general sickness control
    if worldAge < 34 then 
        BWOScheduler.SymptomLevel = 0
    elseif worldAge < 60 then
        BWOScheduler.SymptomLevel = 1
    elseif worldAge < 130 then
        BWOScheduler.SymptomLevel = 2
    elseif worldAge < 151 then
        BWOScheduler.SymptomLevel = 3
    elseif worldAge < 153 then
        BWOScheduler.SymptomLevel = 4
    else    
        BWOScheduler.SymptomLevel = 5
    end

    -- general services control
    BWOPopControl.Police.On = false
    BWOPopControl.SWAT.On = false
    BWOPopControl.Security.On = false
    BWOPopControl.Medics.On = false
    BWOPopControl.Hazmats.On = false
    BWOPopControl.Fireman.On = false

    if worldAge < 90 then
        BWOPopControl.Medics.On = true
    end

    if worldAge < 120 then
        BWOPopControl.Hazmats.On = true
    end

    if worldAge < 100 then
        BWOPopControl.Police.On = true
        BWOPopControl.SWAT.On = true
        BWOPopControl.Security.On = true
        BWOPopControl.Fireman.On = true
    end

    -- schedule processing
    -- basic parameters for all events, will be enriched by event specific params
    local params ={}
    params.x = player:getX()
    params.y = player:getY()
    params.z = player:getZ()

    if worldAge < 200 then
        local event = BWOScheduler.Schedule[worldAge][minute]
        if event[1] and event[2] then
            local eventName = event[1]
            local eventParams = event[2]
            for k, v in pairs(eventParams) do
                params[k] = v
            end
            BWOScheduler.Add(eventName, params, 100)
        end
    end

end

function BWOScheduler.Add(eventName, params, delay)
    event = {}
    event.start = BanditUtils.GetTime() + delay
    event.phase = eventName
    event.params = params
    table.insert(BWOScheduler.Events, event)
end

-- event processor
function BWOScheduler.CheckEvents()
    local player = getPlayer()
    local ct = BanditUtils.GetTime()
    for i, event in pairs(BWOScheduler.Events) do
        if event.start < ct then
            if BWOEvents[event.phase] then
                local profession = player:getDescriptor():getProfession()
                if not event.profession or event.profession == profession then
                    BWOEvents[event.phase](event.params)
                end
            end
            table.remove(BWOScheduler.Events, i)
            break
        end
    end
end

Events.OnTick.Add(BWOScheduler.CheckEvents)
Events.EveryOneMinute.Add(BWOScheduler.MasterControl)
