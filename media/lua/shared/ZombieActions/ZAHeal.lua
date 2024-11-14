ZombieActions = ZombieActions or {}

ZombieActions.Heal = {}
ZombieActions.Heal.onStart = function(zombie, task)
    return true
end

ZombieActions.Heal.onWorking = function(zombie, task)
    zombie:faceLocationF(task.x, task.y)
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
    return false
end

ZombieActions.Heal.onComplete = function(zombie, task)
    local square = getCell():getGridSquare(task.x, task.y, task.z)
    if square then
        local corpse = square:getDeadBody()
        if corpse then
            local result = ZombRand(2)
            if result == 0 then
                Bandit.Say(zombie, "CPRFAILED")
                -- corpse:reanimateNow()
                -- square:removeCorpse(corpse, true)
                -- square:AddWorldInventoryItem(corpse:getItem(), 0.5, 0.5, 0)
                -- ISInventoryPage.dirtyUI()
                
                -- unregister dead body
                local args = {x=zombie:getX(), y=zombie:getY(), z=zombie:getZ()}
                sendClientCommand(getPlayer(), 'Commands', 'DeadBodyRemove', args)
            end
        end
    end
    return true
end