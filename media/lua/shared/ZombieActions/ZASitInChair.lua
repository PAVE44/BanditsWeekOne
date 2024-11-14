ZombieActions = ZombieActions or {}

ZombieActions.SitInChair = {}
ZombieActions.SitInChair.onStart = function(zombie, task)
    local anim = "SitInChair1"
    local aox = 0
    local aoy = 0
    local r = ZombRand(3)
    
    local fakeItem = InventoryItemFactory.CreateItem("Bandits.BeerBottle")
    zombie:setSecondaryHandItem(fakeItem)

    if r == 1 then
        anim = "SitInChair2"
        aox = 0.5
        aoy = 0.5
    elseif r == 2 then
        anim = "SitInChairDrink"
        aox = 0.5
        aoy = 0.5
    end

    task.anim = anim
    task.aox = aox
    task.aoy = aoy
    Bandit.UpdateTask(zombie, task)
    zombie:setBumpType(anim)
    return true
end

ZombieActions.SitInChair.onWorking = function(zombie, task)

    if task.x and task.y and task.z then
        local dx = 0
        local dy = 0
        local fx = 0 
        local fy = 0
        if task.facing then
            if task.facing == "S" then
                dx = 0.4
                dy = 0.8 
                fy = 20
            elseif task.facing == "N" then
                dx = 0.5
                dy = 0.2
                fy = -20
            elseif task.facing == "E" then
                dx = 0.8
                dy = 0.4
                fx = 20
            elseif task.facing == "W" then
                dx = 0.2
                dy = 0.5
                fx = -20    
            end
        end

        zombie:setX(task.x + dx)
        zombie:setY(task.y + dy)
        zombie:setZ(task.z)
        zombie:faceLocationF(task.x + fx, task.y + fy)
    end
    
    local bumpType = zombie:getBumpType()
    if bumpType ~= task.anim then return true end

    if not zombie:getVariableString("BumpAnimFinished") then
        return false
    else
        return true
    end

    return false
end

ZombieActions.SitInChair.onComplete = function(zombie, task)
    zombie:setSecondaryHandItem(nil)
    return true
end