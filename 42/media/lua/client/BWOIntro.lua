BWOIntro = {}
BWOIntro.test = true

local function onGameBoot()
    getCore():setOptionMusicVolume(0)
    -- getSoundManager():playUISound("BWOMusic1")
end

local function onMainMenuEnter()
    
end

local function onPreMapLoad()
    local sm = getSoundManager()
    if sm:isPlayingMusic() then
        sm:StopMusic()
    end
    sm:setMusicVolume(0)
    -- sm:stopUISound(133824517)
end

local function onGameStart()
    local sm = getSoundManager()
    sm:stopUISound(133824517)
end

Events.OnGameBoot.Add(onGameBoot)
Events.OnMainMenuEnter.Add(onMainMenuEnter)
Events.OnPreMapLoad.Add(onPreMapLoad)
Events.OnGameStart.Add(onGameStart)