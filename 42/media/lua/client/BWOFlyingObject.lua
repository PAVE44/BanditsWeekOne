BWOFlyingObject = BWOFlyingObject or {}

BWOFlyingObject.tab = {}
BWOFlyingObject.tick = 0

-- const
BWOFlyingObject.dopplerCoeff = 46.66667

function oppositeAngle(angle)
    local result = angle + 180
    if result > 180 then
        result = result - 360
    end
    return result
end

BWOFlyingObject.Add = function(effect)
    table.insert(BWOFlyingObject.tab, effect)
end

BWOFlyingObject.Process = function()
    if not isIngameState() then return end
    if isServer() then return end

    local world = getWorld()
    local cm = world:getClimateManager()
    local dls = cm:getDayLightStrength()

    local player = getSpecificPlayer(0)
    if player == nil then return end

    local px = player:getX() -- 10066
    local py = player:getY() -- 10821
    local playerNum = player:getPlayerNum()
    local zoom = getCore():getZoom(playerNum)
    local fr = 1 / (getCore():getOptionUIRenderFPS() / 20)
    local cell = getCell()
    for i, effect in pairs(BWOFlyingObject.tab) do

        if not effect.cycles then effect.cycles = 1 end
        if not effect.rep then effect.rep = 1 end

        -- init
        if not effect.frame then 
            effect.frame = 1
            -- init pos

            local odir = oppositeAngle(effect.dir)
            local theta = odir * 0.0174533
            effect.x = effect.cx + (effect.initDist * math.cos(theta))
            effect.y = effect.cy + (effect.initDist * math.sin(theta))
            effect.z = 0
            effect.dist = math.sqrt(((effect.x - px) * (effect.x - px)) + ((effect.y - py) * (effect.y - py)))

            -- init sound
            if effect.sound then
                local emitter = getWorld():getFreeEmitter(effect.x, effect.y, effect.z)
                local sid = emitter:playSound(effect.sound)
                local sdiff = effect.speed / BWOFlyingObject.dopplerCoeff
                local pitch = 1 + sdiff
                emitter:setPitch(sid, pitch)
                emitter:setVolumeAll(1)
                effect.emitter = emitter
                effect.sid = sid
            end
        end

        if effect.frame > effect.frameCnt and effect.rep >= effect.cycles then
            BWOFlyingObject.tab[i] = nil
            if effect.sound then
                effect.emitter:stopSoundByName(effect.sound)
            end
        else
            if effect.frame > effect.frameCnt then
                effect.rep = effect.rep + 1
                effect.frame = 1
            end
            
            if effect.sound then
                -- doppler effect
                local dist = math.sqrt(((effect.x - px) * (effect.x - px)) + ((effect.y - py) * (effect.y - py)))
                if dist > effect.dist and not effect.passed then
                    local sdiff = effect.speed / BWOFlyingObject.dopplerCoeff
                    local pitch = 1 - sdiff
                    effect.emitter:setPitch(effect.sid, pitch)
                    effect.passed = true
                end
                effect.dist = dist

                effect.emitter:setPos(effect.x, effect.y, effect.z)
            end
            
            -- visual
            if player:getSquare():isOutside() then
                local width = effect.width / zoom
                local offsetX = width / 2

                local height = effect.height / zoom
                local offsetY = height / 2

                local tx = isoToScreenX(playerNum, effect.x, effect.y, effect.z) - offsetX
                local ty = isoToScreenY(playerNum, effect.x, effect.y, effect.z) - offsetY

                local alpha = BanditUtils.Lerp(1-dls, 0, 1, 0, 0.6)

                -- main object texture
                if not effect.tex1 then
                    effect.tex1 = getTexture("media/textures/FO/" .. effect.name .. "/" .. effect.dir .. "/base.png")
                end
                UIManager.DrawTexture(effect.tex1, tx, ty, width, height, 1)

                -- main object darkening mask
                if not effect.tex1Mask then
                    effect.tex1Mask = getTexture("media/textures/FO/" .. effect.name .. "/" .. effect.dir .. "/mask/base.png")
                end
                UIManager.DrawTexture(effect.tex1Mask, tx, ty, width, height, alpha)

                if effect.rotors then
                    -- rotor object texture
                    if not effect.tex2 then
                        effect.tex2 = {}
                    end

                    if not effect.tex2[effect.frame] then
                        local frameStr = string.format("%03d", effect.frame)
                        effect.tex2[effect.frame] = getTexture("media/textures/FO/" .. effect.name .. "/" .. effect.dir .. "/" .. frameStr .. ".png")
                    end
                    UIManager.DrawTexture(effect.tex2[effect.frame], tx, ty, width, height, 1)

                    -- rotor darkening mask
                    if not effect.tex2Mask then
                        effect.tex2Mask = {}
                    end

                    if not effect.tex2Mask[effect.frame] then
                        local frameStr = string.format("%03d", effect.frame)
                        effect.tex2Mask[effect.frame] = getTexture("media/textures/FO/" .. effect.name .. "/" .. effect.dir .. "/mask/" .. frameStr .. ".png")
                    end
                    UIManager.DrawTexture(effect.tex2Mask[effect.frame], tx, ty, width, height, alpha)
                end

                if effect.lights and dls < 0.8 then
                    --lights
                    local theta = effect.dir * 0.0174533
                    local lx = effect.x + (16 * math.cos(theta))
                    local ly = effect.y + (16 * math.sin(theta))
                    local lightSource = IsoLightSource.new(lx, ly, effect.z, 1, 1, 1, 14, 4)
                    getCell():addLamppost(lightSource)

                    -- psudo lightbar
                    if effect.frame == 1 and effect.rep % 7 == 0 then
                        local lx = effect.x + (8 * math.cos(theta))
                        local ly = effect.y + (8 * math.sin(theta))
                        local lightSource = IsoLightSource.new(lx, ly, effect.z, 0.6, 0.6, 1, 32, 1)
                        getCell():addLamppost(lightSource)
                    end
                end
            end

            -- pos update
            local theta = effect.dir * 0.0174533
            effect.x = effect.x + (effect.speed * fr * math.cos(theta))
            effect.y = effect.y + (effect.speed * fr * math.sin(theta))
            -- print ("x: " .. effect.x .. " y:" .. effect.y)
            effect.frame = effect.frame + 1
        end
    end
end

Events.OnPreUIDraw.Add(BWOFlyingObject.Process)