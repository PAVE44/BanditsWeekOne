ZombieActions = ZombieActions or {}

ZombieActions.Smoke = {}
ZombieActions.Smoke.onStart = function(zombie, task)
    local fakeItem = InventoryItemFactory.CreateItem("Bandits.Cigarette")
    zombie:setSecondaryHandItem(fakeItem)

    return true
end

ZombieActions.Smoke.onWorking = function(zombie, task)
    if task.time <= 0 then
        return true
    elseif math.floor(task.time) == 12 then
        local effect = {}
        effect.x = zombie:getX()
        effect.y = zombie:getY()
        effect.z = zombie:getZ()
        effect.offset = 300
        effect.name = "mist"
        effect.frameCnt = 60
        effect.frameRnd = false
        effect.repCnt = 2
        effect.r = 0.6
        effect.g = 0.6
        effect.b = 0.6
        if isClient() then
            sendClientCommand(getPlayer(), 'Commands', 'AddEffect', effect)
        else
            table.insert(BanditEffects.tab, effect)
        end
    else
        local bumpType = zombie:getBumpType()
        if bumpType ~= task.anim then 
            -- zombie:playSound("Smoke")
            zombie:setBumpType(task.anim)
        end
    end
end

ZombieActions.Smoke.onComplete = function(zombie, task)
    zombie:setSecondaryHandItem(nil)
    return true
end