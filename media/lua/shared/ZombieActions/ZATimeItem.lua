ZombieActions = ZombieActions or {}

ZombieActions.TimeItem = {}
ZombieActions.TimeItem.onStart = function(zombie, task)
    if task.item then
        local fakeItem = InventoryItemFactory.CreateItem(task.item)
        if task.left then
            zombie:setSecondaryHandItem(fakeItem)
        else
            zombie:setPrimaryHandItem(fakeItem)
        end
    end
    return true
end

ZombieActions.TimeItem.onWorking = function(zombie, task)
    if task.time <= 0 then
        return true
    else
        local bumpType = zombie:getBumpType()
        if bumpType ~= task.anim then 
            zombie:playSound(task.sound)
            zombie:setBumpType(task.anim)
        end
    end
end

ZombieActions.TimeItem.onComplete = function(zombie, task)
    if task.item then
        if task.left then
            zombie:setSecondaryHandItem(nil)
        else
            zombie:setPrimaryHandItem(nil)
        end
    end
    return true
end