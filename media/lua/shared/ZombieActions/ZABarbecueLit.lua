ZombieActions = ZombieActions or {}

ZombieActions.BarbecueLit = {}
ZombieActions.BarbecueLit.onStart = function(zombie, task)
    return true
end

ZombieActions.BarbecueLit.onWorking = function(zombie, task)
    zombie:faceLocationF(task.x, task.y)
    if not zombie:getVariableString("BumpAnimFinished") then
        return false
    else
        return true
    end
end

ZombieActions.BarbecueLit.onComplete = function(zombie, task)
    local square = zombie:getCell():getGridSquare(task.x, task.y, task.z)
    if square then
        local objects = square:getObjects()
        for i=0, objects:size()-1 do
            local object = objects:get(i)
            if instanceof(object, "IsoBarbecue") then
                if not object:isLit() then
                    if object:isPropaneBBQ() and object:hasFuel() then
                        local args = {x=object:getX(), y=object:getY(), z=object:getZ()}
                        sendClientCommand(getPlayer(), 'bbq', 'toggle', args)
                    else
                        local args = {x=object:getX(), y=object:getY(), z=object:getZ(), fuelAmt = 40}
                        sendClientCommand(getPlayer(), 'bbq', 'light', args)
                    end
                end
            end
        end
    end

    return true
end