ZombieActions = ZombieActions or {}

ZombieActions.BoomboxToggle = {}
ZombieActions.BoomboxToggle.onStart = function(zombie, task)
    return true
end

ZombieActions.BoomboxToggle.onWorking = function(zombie, task)
    if not zombie:getVariableString("BumpAnimFinished") then
        return false
    else
        return true
    end
end

ZombieActions.BoomboxToggle.onComplete = function(zombie, task)
    local square = zombie:getCell():getGridSquare(task.x, task.y, task.z)
    if square then
        local objects = square:getObjects()
        for i=0, objects:size()-1 do
            local object = objects:get(i)
            if instanceof(object, "IsoRadio") then
                local dd = object:getDeviceData()
                
                dd:setIsTurnedOn(task.on)

                local musicId = nil
                musicId = "#" .. object:getX() .. "-" .. object:getY() .. "-" .. object:getZ()

                if not task.on and object:getModData().tcmusic.isPlaying then -- dd:isPlayingMedia()
                    object:getModData().tcmusic.isPlaying = false 
                    if dd:getEmitter() then
                        dd:getEmitter():stopAll()
                    end
                    ModData.getOrCreate("trueMusicData")["now_play"][musicId] = nil
                end

                if (task.on and not object:getModData().tcmusic.isPlaying) then
                    getSoundManager():StopMusic()
                    object:getModData().tcmusic.isPlaying = true
                    -- print("playSound WO PLAYER")
                    -- print(dd:getParent())
                    dd:getEmitter():stopAll()
                    dd:setNoTransmit(false)
                    dd:playSound(object:getModData().tcmusic.mediaItem, dd:getDeviceVolume() * 0.4, false)
                    
                    ModData.getOrCreate("trueMusicData")["now_play"][musicId] = {
                        volume = dd:getDeviceVolume(),
                        headphone = dd:getHeadphoneType() >= 0,
                        timestamp = "update",
                        musicName = object:getModData().tcmusic.mediaItem,
                    }
                    if object:getModData().tcmusic.deviceType == "InventoryItem" then
                        ModData.getOrCreate("trueMusicData")["now_play"][musicId]["itemid"] = object:getID()
                    end
                end
                object:transmitModData()
                if isClient() then ModData.transmit("trueMusicData") end
                
            end
        end
    end
    return true
end

