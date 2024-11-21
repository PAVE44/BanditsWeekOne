ZombiePrograms = ZombiePrograms or {}

ZombiePrograms.Musician = {}
ZombiePrograms.Musician.Stages = {}

ZombiePrograms.Musician.Init = function(bandit)
end

ZombiePrograms.Musician.GetCapabilities = function()
    -- capabilities are program decided
    local capabilities = {}
    capabilities.melee = true
    capabilities.shoot = true
    capabilities.smashWindow = false
    capabilities.openDoor = true
    capabilities.breakDoor = false
    capabilities.breakObjects = false
    capabilities.unbarricade = false
    capabilities.disableGenerators = false
    capabilities.sabotageCars = false
    return capabilities
end

ZombiePrograms.Musician.Prepare = function(bandit)
    local tasks = {}
    local world = getWorld()
    local cell = getCell()
    local cm = world:getClimateManager()
    local dls = cm:getDayLightStrength()

    Bandit.ForceStationary(bandit, false)

    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Musician.Main = function(bandit)
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

    -- ideas : soda machine, trashman
    -- bench sitters
    -- workshop hammering
    -- road block on roads instead of around the city, protest at the blockade with army and cars and a car crushing into it. 


    local outfit = bandit:getOutfitName()
    if outfit == "Student" then
        local task = {action="TimeItem", item="Base.Violin", left=true, anim="InstrumentViolin", sound="BWOInstrumentViolinPaganini", time=200}
        table.insert(tasks, task)
        return {status=true, next="Main", tasks=tasks}
    elseif outfit == "Rocker" then
        local task = {action="TimeItem", item="Base.GuitarElectricRed", left=true, anim="InstrumentGuitarElectric", sound="BWOInstrumentViolinPaganini", time=200}
        table.insert(tasks, task)
        return {status=true, next="Main", tasks=tasks}
    end
    
    -- fallback
    local anim = BanditUtils.Choice({"ShiftWeight", "ChewNails", "PullAtCollar", "WipeBrow", "WipeHead"})
    local task = {action="Time", anim=anim, time=100}
    table.insert(tasks, task)

    return {status=true, next="Main", tasks=tasks}
end

