BWOEventsPlace = BWOEventsPlace or {}

function BWOEventsPlace.ArmyGuards(params)
    config = {}
    config.clanId = 0
    config.hasRifleChance = 100
    config.hasPistolChance = 100
    config.rifleMagCount = 6
    config.pistolMagCount = 3

    local event = {}
    event.hostile = false
    event.occured = false
    event.program = {}
    event.program.name = "ArmyGuard"
    event.program.stage = "Prepare"

    event.x = params.x
    event.y = params.y
    event.bandits = {}
    
    local bandit = BanditCreator.MakeFromWave(config)
    bandit.hairStyle = BanditUtils.Choice({"Bald", "Fresh", "Demi", "FlatTop", "MohawkShort"})
    bandit.accuracyBoost = 1.6
    bandit.femaleChance = 0
    bandit.health = 6
    bandit.outfit = "ZSArmySpecialOps"
    bandit.weapons.melee = "Base.HuntingKnife"

    local intensity = 4
    if intensity > 0 then
        for i=1, intensity do
            table.insert(event.bandits, bandit)
        end
        sendClientCommand(getPlayer(), 'Commands', 'SpawnGroup', event)
    end

    if SandboxVars.Bandits.General_ArrivalIcon then
        local icon = "media/ui/raid.png"
        local color = {r=0, g=1, b=0} -- green
        BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, event.x, event.y, color)
    end
end

function BWOEventsPlace.CarMechanic(params)

    local cell = getCell()
    local square = getCell():getGridSquare(params.x, params.y, 0)
    if not square then return end

    local vtype = BanditUtils.Choice(BWOVehicles.carChoices)

    local vehicle = addVehicleDebug(vtype, params.directions, nil, square)
    if not vehicle then return end

    --[[local vehicle = BaseVehicle.new(cell)
    vehicle:setScriptName(vtype)
    vehicle:setScript()
    vehicle:setDir(params.directions)
    vehicle:setX(params.x)
    vehicle:setY(params.y)
    vehicle:setZ(0)
    vehicle:setSquare(square)
    VehiclesDB2.instance:addVehicle(vehicle)
    -- vehicle:addToWorld()
    -- vehicle:setRust(0)]]

    if params.directions == IsoDirections.N then
        vehicle:setAngles(0, 180, 0)
    elseif params.directions == IsoDirections.S then
        vehicle:setAngles(0, 0, 0)
    elseif params.directions == IsoDirections.E then
        vehicle:setAngles(0, 90, 0)
    elseif params.directions == IsoDirections.W then
        -- vehicle:setAngles(-125, -90, -125)
        vehicle:setAngles(0, -90, 0)
    end

    for i = 0, vehicle:getPartCount() - 1 do
        local container = vehicle:getPartByIndex(i):getItemContainer()
        if container then
            container:removeAllItems()
        end
    end

    if params.dx then
        vehicle:setX(params.x + params.dx)
    end

    vehicle:getModData().BWO = {}
    vehicle:getModData().BWO.wasRepaired = true
    vehicle:repair()
    vehicle:setColor(0, 0, 0)
    vehicle:setGeneralPartCondition(80, 100)
    vehicle:putKeyInIgnition(vehicle:createVehicleKey())
    -- vehicle:tryStartEngine(true)
    -- vehicle:engineDoStartingSuccess()
    -- vehicle:engineDoRunning()
    -- vehicle:setHeadlightsOn(true)
    -- vehicle:setLightbarLightsMode(3)

end