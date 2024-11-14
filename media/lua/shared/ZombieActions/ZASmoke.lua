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