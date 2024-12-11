ZombieActions = ZombieActions or {}

ZombieActions.TimeFace = {}
ZombieActions.TimeFace.onStart = function(zombie, task)
    return true
end

ZombieActions.TimeFace.onWorking = function(zombie, task)
    zombie:faceLocation(task.x, task.y)
    local bumpType = zombie:getBumpType()
    if bumpType ~= task.anim then
        return true
    end

end

ZombieActions.TimeFace.onComplete = function(zombie, task)
    return true
end