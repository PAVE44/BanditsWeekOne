BWOServer = {}
BWOServer.Commands = {}

BWOServer.Commands.ObjectAdd = function(player, args)
    local gmd = GetBWOModData()
    if not (args.x and args.y and args.z and args.otype) then return end

    local id = math.floor(args.x) .. "-" .. math.floor(args.y) .. "-" ..args.z

    if not gmd.Objects[args.otype] then gmd.Objects[args.otype] = {} end
    gmd.Objects[args.otype][id] = args
end

BWOServer.Commands.ObjectRemove = function(player, args)
    local gmd = GetBWOModData()
    if not (args.x and args.y and args.z and args.otype) then return end

    local id = math.floor(args.x) .. "-" .. math.floor(args.y) .. "-" ..args.z
    if not gmd.Objects[args.otype] then gmd.Objects[args.otype] = {} end

    gmd.Objects[args.otype][id] = nil
end

BWOServer.Commands.EventBuildingAdd = function(player, args)
    local gmd = GetBWOModData()
    if not (args.id and args.event) then return end

    gmd.EventBuildings[args.id] = args
end

BWOServer.Commands.DeadBodyAdd = function(player, args)
    local gmd = GetBWOModData()
    if not (args.x and args.y and args.z) then return end

    local id = math.floor(args.x) .. "-" .. math.floor(args.y) .. "-" ..args.z
    gmd.DeadBodies[id] = args
end

BWOServer.Commands.DeadBodyRemove = function(player, args)
    local gmd = GetBWOModData()
    if not (args.x and args.y and args.z) then return end

    local id = math.floor(args.x) .. "-" .. math.floor(args.y) .. "-" .. args.z
    gmd.DeadBodies[id] = nil
end

BWOServer.Commands.DeadBodyFlush = function(player, args)
    local gmd = GetBWOModData()
    gmd.DeadBodies = {}
    print ("[INFO] All deadbodies info removed!!!")
end

BWOServer.Commands.AddEffect = function(player, args)
    sendServerCommand('BWOEffects', 'Add', args)
end

-- main
local onClientCommand = function(module, command, player, args)
    if BWOServer[module] and BWOServer[module][command] then
        local argStr = ""
        for k, v in pairs(args) do
            argStr = argStr .. " " .. k .. "=" .. tostring(v)
        end
        -- print ("received " .. module .. "." .. command .. " "  .. argStr)
        BWOServer[module][command](player, args)

        if module == "Commands" then
            TransmitBWOModData()
        end
    end
end

-- gc for objects with set ttl
local everyOneMinute = function()
    local toRemove = {}
    local gmd = GetBWOModData()
    for k, obj in pairs(gmd.Objects) do
        if obj.ttl then
            if BanditUtils.GetTime() > obj.ttl then
                table.insert(toRemove, k)
            end
        end
    end

    for _, k in pairs(toRemove) do
        gmd.Objects[k] = nil
    end
end

Events.OnClientCommand.Add(onClientCommand)
Events.EveryOneMinute.Add(everyOneMinute)
