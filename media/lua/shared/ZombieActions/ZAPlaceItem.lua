ZombieActions = ZombieActions or {}

ZombieActions.PlaceItem = {}
ZombieActions.PlaceItem.onStart = function(zombie, task)
    return true
end

ZombieActions.PlaceItem.onWorking = function(zombie, task)
    zombie:faceLocation(task.x, task.y)
    if not zombie:getVariableString("BumpAnimFinished") then
        return false
    else
        return true
    end
end

ZombieActions.PlaceItem.onComplete = function(zombie, task)
    if task.item and BanditUtils.IsController(zombie) then
        local item = InventoryItemFactory.CreateItem(task.item)
        if item then
            local square = getCell():getGridSquare(task.x, task.y, task.z)
            if square then
                local surfaceOffset = BanditUtils.GetSurfaceOffset(task.x, task.y, task.z)
                square:AddWorldInventoryItem(item, ZombRandFloat(0.2, 0.8), ZombRandFloat(0.2, 0.8), surfaceOffset)
            end
        end
    end
    
    return true
end

