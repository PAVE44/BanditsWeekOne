ZombieActions = ZombieActions or {}

ZombieActions.SitInChair = {}
ZombieActions.SitInChair.onStart = function(zombie, task)
    return true
end

ZombieActions.SitInChair.onWorking = function(zombie, task)
    local anim = "SitInChair"
    local aox = 0
    local aoy = 0
    local r = ZombRand(2)
    if r == 1 then
        anim = "SitInChairDrink"
        aoy = 0.5
        aox = 0.5
    end

    zombie:setBumpType(anim)

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
                dy = 0.2 + aoy
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
    return false
end

ZombieActions.SitInChair.onComplete = function(zombie, task)
    return true
end