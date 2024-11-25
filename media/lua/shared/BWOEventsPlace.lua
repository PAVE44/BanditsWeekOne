BWOEventsPlace = BWOEventsPlace or {}

function BWOEventsPlace.ArmyGuards(x, y, z)
    config = {}
    config.clanId = 16
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

    event.x = x
    event.y = y
    event.bandits = {}
    
    local bandit = BanditCreator.MakeFromWave(config)
    local intensity = 4
    if intensity > 0 then
        for i=1, intensity do
            table.insert(event.bandits, bandit)
        end
        sendClientCommand(getPlayer(), 'Commands', 'SpawnGroup', event)
    end

    if SandboxVars.Bandits.General_ArrivalIcon then
        local icon = "media/ui/raid.png"
        local color = {r=0, g=1, b=0} -- orange
        BanditEventMarkerHandler.setOrUpdate(getRandomUUID(), icon, 10, event.x, event.y, color)
    end
end
