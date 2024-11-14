ZombieActions = ZombieActions or {}

ZombieActions.Barricade = {}
ZombieActions.Barricade.onStart = function(zombie, task)

    local fx, fy
    local square = zombie:getCell():getGridSquare(task.x, task.y, task.z)
    if square then
        local objects = square:getObjects()
        for i=0, objects:size()-1 do
            local object = objects:get(i)
            local properties = object:getProperties()

            if instanceof(object, "IsoWindow") then
                task.idx = object:getObjectIndex()
                if properties:Is(IsoFlagType.WindowN) then
                    fx = square:getX()
                    fy = square:getY() - 0.5
                else
                    fx = square:getX() - 0.5
                    fy = square:getY()
                end
                break
                
            elseif instanceof(object, "IsoDoor") then
                task.idx = object:getObjectIndex()
                if properties:Is(IsoFlagType.doorN) then
                    fx = square:getX()
                    fy = square:getY() - 0.5
                else
                    fx = square:getX() - 0.5
                    fy = square:getY()
                end
                break
            end
            
        end
    end

    task.fx = fx
    task.fy = fy
    Bandit.UpdateTask(zombie, task)

    zombie:playSound("Hammering")

    return true
end

ZombieActions.Barricade.onWorking = function(zombie, task)
    if task.fx and task.fy then
        zombie:faceLocationF(task.fx, task.fy)
    end

    if task.time <= 0 then
        return true
    else
        local bumpType = zombie:getBumpType()
        if bumpType ~= task.anim then 
            zombie:setBumpType(task.anim)
        end
    end
end

ZombieActions.Barricade.onComplete = function(zombie, task)

    --zombie:getEmitter():stopAll()
    if task.idx then
        zombie:getEmitter():stopAll()
        zombie:playSound("RemoveBarricadePlank")

        if BanditUtils.IsController(zombie) then
            local args = {x=task.x, y=task.y, z=task.z, index=task.idx, condition=100}
            sendClientCommand(getPlayer(), 'Commands', 'Barricade', args)
        end
    end

    return true
end