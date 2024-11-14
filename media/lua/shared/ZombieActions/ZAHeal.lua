ZombieActions = ZombieActions or {}

ZombieActions.Heal = {}
ZombieActions.Heal.onStart = function(zombie, task)
    return true
end

ZombieActions.Heal.onWorking = function(zombie, task)
    if task.time <= 0 then
        return true
    else
        local bumpType = zombie:getBumpType()
        if bumpType ~= task.anim then 
            -- zombie:playSound("Smoke")
            zombie:setBumpType(task.anim)
            if not zombie:getEmitter():isPlaying("ZSDefib") then
                zombie:playSound("ZSDefib")
            end
        end
    end
end

ZombieActions.Heal.onComplete = function(zombie, task)
    local square = getCell():getGridSquare(task.x, task.y, task.z)
    if square then
        local corpse = square:getDeadBody()
        if corpse then
            local result = ZombRand(10)
            if result == 0 then
                corpse:reanimateNow()
                square:removeCorpse(corpse, true)
                square:AddWorldInventoryItem(corpse:getItem(), 0.5, 0.5, 0)
                ISInventoryPage.dirtyUI()
            else
                local itemName = "Bandits.Corpse"
                square:removeCorpse(corpse, true)
                square:AddWorldInventoryItem(itemName, ZombRandFloat(0.3, 0.7), ZombRandFloat(0.3, 0.7), 0)
                ISInventoryPage.dirtyUI()
            end
        end
    end
end