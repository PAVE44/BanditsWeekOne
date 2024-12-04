ZombieActions = ZombieActions or {}

ZombieActions.SitInChair = {}
ZombieActions.SitInChair.onStart = function(zombie, task)
    local anim = "SitInChair1"
    local aox = 0
    local aoy = 0
    local r = ZombRand(7)

    local fakeItem
    local right = false
    local left = false

    if r == 1 then
        anim = "SitInChair2"
        aox = 0.5
        aoy = 0.5
    elseif r == 2 then
        anim = "SitInChairTalk"
        aox = 0.5
        aoy = 0.5
    elseif r == 3 then
        anim = "SitInChairDrink"
        aox = 0.5
        aoy = 0.5
        fakeItem = InventoryItemFactory.CreateItem("Bandits.BeerBottle")
        right = true
    elseif r == 4 then
        anim = "SitInChairEat"
        aox = 0.5
        aoy = 0.5
        fakeItem = InventoryItemFactory.CreateItem("Base.Fork")
        right = true
    elseif r == 5 then
        anim = "SitInChairSmoke"
        aox = 0.5
        aoy = 0.5
    elseif r == 6 then
        anim = "SitInChairRead"
        aox = 0.5
        aoy = 0.5
        fakeItem = InventoryItemFactory.CreateItem("Bandits.Book")
        left = true
    end

    if fakeItem then
        if not left then
            zombie:setPrimaryHandItem(fakeItem)
        end
        if not right then
            zombie:setSecondaryHandItem(fakeItem)
        end
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
    zombie:setPrimaryHandItem(nil)
    zombie:setSecondaryHandItem(nil)
    return true
end