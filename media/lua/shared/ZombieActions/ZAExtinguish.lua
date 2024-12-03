ZombieActions = ZombieActions or {}

ZombieActions.Extinguish = {}
ZombieActions.Extinguish.onStart = function(zombie, task)
    if task.item then
        local fakeItem = InventoryItemFactory.CreateItem(task.item)
        if not task.left then
            zombie:setPrimaryHandItem(fakeItem)
        end
        if not task.right then
            zombie:setSecondaryHandItem(fakeItem)
        end
    end

    local effect = {}
    effect.x = task.x
    effect.y = task.y
    effect.z = task.z
    effect.offset = 300
    effect.name = "mist"
    effect.frameCnt = 60
    effect.frameRnd = false
    effect.repCnt = 2
    effect.r = 0.82
    effect.g = 0.94
    effect.b = 0.97
    if isClient() then
        sendClientCommand(getPlayer(), 'Schedule', 'AddEffect', effect)
    else
        table.insert(BanditEffects.tab, effect)
    end

    --[[
    local effect2 = {}
    effect2.x = zombie:getX()
    effect2.y = zombie:getY()
    effect2.z = zombie:getZ()
    effect2.offset = 300
    effect2.name = "mist"
    effect2.frameCnt = 60
    effect2.frameRnd = false
    effect2.repCnt = 2
    effect2.r = 0.82
    effect2.g = 0.94
    effect2.b = 0.97

    if isClient() then
        sendClientCommand(getPlayer(), 'Schedule', 'AddEffect', effect2)
    else
        table.insert(BanditEffects.tab, effect2)
    end]]

    return true
end

ZombieActions.Extinguish.onWorking = function(zombie, task)
    zombie:faceLocation(task.x, task.y)
    if task.time <= 0 then
        return true
    else
        local bumpType = zombie:getBumpType()
        if bumpType ~= task.anim then 
            zombie:setBumpType(task.anim)

            if task.sound then
                local emitter = zombie:getEmitter()
                if not emitter:isPlaying(task.sound) then
                    emitter:playSound(task.sound)
                end
            end
            
        end
    end
end

ZombieActions.Extinguish.onComplete = function(zombie, task)
    if ZombRand(2) == 0 then
        local cell = getCell()
        local square = cell:getGridSquare(task.x, task.y, task.z)
        if square then
            square:stopFire()
        end
    end
    if task.item then
        if task.left then
            zombie:setSecondaryHandItem(nil)
        else
            zombie:setPrimaryHandItem(nil)
        end
    end
    return true
end