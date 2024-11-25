ZombiePrograms = ZombiePrograms or {}

ZombiePrograms.Entertainer = {}
ZombiePrograms.Entertainer.Stages = {}

ZombiePrograms.Entertainer.Init = function(bandit)
end

ZombiePrograms.Entertainer.GetCapabilities = function()
    -- capabilities are program decided
    local capabilities = {}
    capabilities.melee = true
    capabilities.shoot = true
    capabilities.smashWindow = not BWOPopControl.Police.On
    capabilities.openDoor = true
    capabilities.breakDoor = not BWOPopControl.Police.On
    capabilities.breakObjects = not BWOPopControl.Police.On
    capabilities.unbarricade = false
    capabilities.disableGenerators = false
    capabilities.sabotageCars = false
    return capabilities
end

ZombiePrograms.Entertainer.Prepare = function(bandit)
    local tasks = {}
    local world = getWorld()
    local cell = getCell()
    local cm = world:getClimateManager()
    local dls = cm:getDayLightStrength()

    Bandit.ForceStationary(bandit, false)

    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Entertainer.Main = function(bandit)
    local tasks = {}

    local id = BanditUtils.GetCharacterID(bandit)
    local bx = bandit:getX()
    local by = bandit:getY()
    local bz = bandit:getZ()
    local world = getWorld()
    local cell = getCell()
    local cm = world:getClimateManager()
    local dls = cm:getDayLightStrength()
    local square = bandit:getSquare()
    local room = square:getRoom()
    local building = square:getBuilding()
    local gameTime = getGameTime()
    local hour = gameTime:getHour()
    local minute = gameTime:getMinutes()

    local walkType = "Walk"
    local endurance = 0
    
    local health = bandit:getHealth()
    if health < 0.8 then
        walkType = "Limp"
        endurance = 0
    end 

    -- if outside building change program
    if hour < 9 or hour > 22 then
        Bandit.ClearTasks(bandit)
        Bandit.SetProgram(bandit, "Walker", {})

        local brain = BanditBrain.Get(bandit)
        local syncData = {}
        syncData.id = brain.id
        syncData.program = brain.program
        Bandit.ForceSyncPart(bandit, syncData)
        return {status=true, next="Main", tasks=tasks}
    end

    -- ideas : soda machine, trashman
    -- bench sitters
    -- workshop hammering
    -- road block on roads instead of around the city, protest at the blockade with army and cars and a car crushing into it. 
    -- cheerloaders
    -- mime / clown on street
    -- breakdance on street

    local outfit = bandit:getOutfitName()

    -- musicians
    local musicianTab = {}
    -- playTab.AuthenticBiker = {item="Base.GuitarElectricRed",       anim="InstrumentGuitarElectric", sound=nil}
    musicianTab.Dean           = {item="Base.GuitarElectricBassBlack", anim="InstrumentGuitarBass",     sound="BWOInstrumentBassGuitar1"}
    musicianTab.Rocker             = {item="Base.GuitarElectricBassBlack", anim="InstrumentGuitarBass",     sound="BWOInstrumentBassGuitar1"}
    -- playTab.Rocker         = {item="Base.GuitarAcoustic",          anim="InstrumentGuitarAcoustic", sound=nil}
    musicianTab.Joan           = {item="Base.Violin",                  anim="InstrumentViolin",         sound="BWOInstrumentViolinPaganini"}
    musicianTab.John           = {item="Base.Saxophone",               anim="InstrumentSaxophone",      sound="BWOInstrumentSax" .. tostring((id % 3) + 1)}
    -- playTab.Duke           = {item="Base.Flute",                   anim="InstrumentFlute",          sound=nil}

    for o, tab in pairs(musicianTab) do
        if o == outfit then
            local task = {action="TimeEvent", x=bx, y=by, z=bz, event="entertainer", item=tab.item, left=true, anim=tab.anim, sound=tab.sound}
            table.insert(tasks, task)
            return {status=true, next="Main", tasks=tasks}
        end
    end

    -- street performers
    local performerTab = {}
    performerTab.AuthenticClown = {anim=BanditUtils.Choice({"DanceRocketteKick", "DanceHokeyPokey", "DanceChicken"})}
    performerTab.AuthenticClownObese = {anim=BanditUtils.Choice({"DanceRocketteKick", "DanceHokeyPokey", "DanceChicken"})}

    for o, tab in pairs(performerTab) do
        if o == outfit then
            local task = {action="TimeEvent", x=bx, y=by, z=bz, event="entertainer", anim=tab.anim, time=500}
            table.insert(tasks, task)
            return {status=true, next="Main", tasks=tasks}
        end
    end

    -- street dancing
    local dancerTab = {}
    dancerTab.Young = {cassette="CassetteBanditBreakdance01", anim="DanceBreakdance" .. tostring(1 + ZombRand(3))}
    for o, tab in pairs(dancerTab) do
        if o == outfit then

            local boombox = BWOObjects.FindAround(bandit, 7, "Boombox")
            if boombox then
                local dd = boombox:getDeviceData()
                if not dd:getIsTurnedOn() or not boombox:getModData().tcmusic.isPlaying then
                    local square = boombox:getSquare()
                    local asquare = AdjacentFreeTileFinder.Find(square, bandit)
                    if asquare then
                        local dist = math.sqrt(math.pow(bandit:getX() - (asquare:getX() + 0.5), 2) + math.pow(bandit:getY() - (asquare:getY() + 0.5), 2))
                        if dist > 0.70 then
                            table.insert(tasks, BanditUtils.GetMoveTask(0, asquare:getX(), asquare:getY(), asquare:getZ(), "Walk", dist, false))
                            return {status=true, next="Main", tasks=tasks}
                        else
                            local task = {action="BoomboxToggle", on=true, anim="Loot", x=square:getX(), y=square:getY(), z=square:getZ(), time=100}
                            table.insert(tasks, task)
                            return {status=true, next="Main", tasks=tasks}
                        end
                    end
                end

                local task = {action="TimeEvent", x=bx, y=by, z=bz, event="entertainer", anim=tab.anim, time=500}
                table.insert(tasks, task)
                return {status=true, next="Main", tasks=tasks}

            end
        end
    end
    
    -- fallback
    local anim = BanditUtils.Choice({"ShiftWeight", "ChewNails", "PullAtCollar", "WipeBrow", "WipeHead"})
    local task = {action="Time", anim=anim, time=100}
    table.insert(tasks, task)

    return {status=true, next="Main", tasks=tasks}
end

