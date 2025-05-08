require "MainScreen"

local mainScreenPrerender = MainScreen.prerender

function MainScreen:prerender()
    mainScreenPrerender(self)

    if self.ingame then return end
    
    if isIngameState() then return end
    
    if getPlayer() then return end

    local options = PZAPI.ModOptions:getOptions("BanditsWeekOne")
    local musicIdx = options:getOption("INTROMUSIC"):getValue()

    local soundName
    local musicList = BWOOptions.IntroMusic
    local musicCnt = -2 -- skip first 2 options: none and random
    for k, v in pairs(musicList) do
        musicCnt = musicCnt + 1
    end

    local sm = getSoundManager()
    local emitter = getSoundManager():getUIEmitter()
    if musicIdx == 1 then
        if BWOIntro.CustomMusic then
            sm:stopUISound(BWOIntro.CustomMusic)
            BWOIntro.CustomMusic = nil
        end
        emitter:stopSoundByName("UIBWOMusic1")
        emitter:stopSoundByName("UIBWOMusic2")
        emitter:stopSoundByName("UIBWOMusic3")
        emitter:stopSoundByName("UIBWOMusic4")
        -- sm:stopUISound(133824517)
    elseif musicIdx == 2 then
        local r = 3 + ZombRand(musicCnt)
        local i = 1
        for k, v in pairs(musicList) do
            if i == r then
                soundName = k
                break
            end
            i = i + 1
        end
    else
        local i = 1
        for k, v in pairs(musicList) do
            if i == musicIdx then
                soundName = k
                break
            end
            i = i + 1
        end
    end

    if soundName then
        if sm:isPlayingMusic() then
            sm:StopMusic()
        end
        sm:setMusicVolume(0)
        if not BWOIntro.CustomMusic then
            -- MainScreenState.preloadBackgroundTextures()
            -- local ms = MainScreenState.getInstance()
            -- ms:renderBackground()
            emitter:setPos(0, 0, 0)
            BWOIntro.CustomMusic = sm:playUISound(soundName)
        end
    end
    --[[
    MainScreenState.preloadBackgroundTextures()
    local ms = MainScreenState.getInstance()
    ms:renderBackground()]]

end
