BWOEventsPlace = BWOEventsPlace or {}

local protestAreas = {}
table.insert(protestAreas, {x=10590, y=10670, z=0}) --muldraugh n blockade
table.insert(protestAreas, {x=10590, y=9172, z=0}) --muldraugh s blockade
table.insert(protestAreas, {x=10590, y=9737, z=0}) --muldraugh middle road
table.insert(protestAreas, {x=10653, y=9940, z=0}) --muldraugh cafeteria, liquorstore, slothing store complex
table.insert(protestAreas, {x=10740, y=10340, z=0}) --muldraugh offices
table.insert(protestAreas, {x=10760, y=10160, z=0}) --muldraugh church
table.insert(protestAreas, {x=10634, y=10431, z=0}) --muldraugh police
table.insert(protestAreas, {x=12160, y=6900, z=0}) --westpoint e traintack
table.insert(protestAreas, {x=12050, y=6883, z=0}) --westpoint gigamart
table.insert(protestAreas, {x=11955, y=6805, z=0}) --westpoint spiffos
table.insert(protestAreas, {x=11927, y=6893, z=0}) --westpoint townhall
table.insert(protestAreas, {x=11109, y=6898, z=0}) --westpoint barricade w
table.insert(protestAreas, {x=11920, y=6963, z=0}) --westpoint police
table.insert(protestAreas, {x=6992, y=5468, z=0}) --riverside blockade e
table.insert(protestAreas, {x=6399, y=5427, z=0}) --riverside school
table.insert(protestAreas, {x=6381, y=5283, z=0}) --riverside central road
table.insert(protestAreas, {x=6090, y=5280, z=0}) --riverside police
table.insert(protestAreas, {x=6545, y=5261, z=0}) --riverside community centre
table.insert(protestAreas, {x=5881, y=5445, z=0}) --riverside blockade w
table.insert(protestAreas, {x=8100, y=11740, z=0}) --rosewood police
table.insert(protestAreas, {x=8100, y=11645, z=0}) --rosewood court of justice
table.insert(protestAreas, {x=8093, y=11363, z=0}) --rosewood spiffos
table.insert(protestAreas, {x=8313, y=15583, z=0}) --rosewood school
table.insert(protestAreas, {x=10362, y=12416, z=0}) --marchridge exit
table.insert(protestAreas, {x=10007, y=12692, z=0}) --marchridge crossroads
table.insert(protestAreas, {x=10326, y=12768, z=0}) --marchridge church
BWOEventsPlace.ProtestAreas = protestAreas

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
