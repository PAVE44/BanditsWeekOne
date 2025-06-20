BWOEmitter = BWOEmitter or {}

BWOEmitter.tab = {}
BWOEmitter.tick = 0

function BWOEmitter.Add(tab)
    table.insert(BWOEmitter.tab, tab)
end

function BWOEmitter.Remove(tab)
    for i, effect in ipairs(BWOEmitter.tab) do
        if effect.x == tab.x and effect.y == tab.y and effect.z == tab.z then
            table.remove(BWOEmitter.tab, i)
            break
        end
    end
end

function BWOEmitter.Process()
    if isServer() then return end

    BWOEmitter.tick = BWOEmitter.tick + 1
    if BWOEmitter.tick >= 16 then
        BWOEmitter.tick = 0
    end

    if BWOEmitter.tick % 2 == 0 then return end

    local cell = getCell()

    for _, effect in ipairs(BWOEmitter.tab) do
        if effect.x and effect.y and effect.z and effect.len then
            local square = cell:getGridSquare(effect.x, effect.y, effect.z)
            if square and (square:haveElectricity() or getWorld():isHydroPowerOn()) then
                if not effect.start then
                    effect.start = getTimestampMs()

                    if effect.sound then
                        effect.emitter = getWorld():getFreeEmitter(effect.x, effect.y, effect.z)
                        if effect.emitter then
                            local volume = effect.volume or 0.2
                            effect.emitter:setVolumeAll(volume)
                            effect.emitter:tick()
                            effect.emitter:playSound(effect.sound)
                        end
                    end

                    if effect.light then
                        local lightSource = IsoLightSource.new(
                            effect.x, effect.y, effect.z,
                            effect.light.r, effect.light.g, effect.light.b,
                            12, effect.light.t
                        )
                        getCell():addLamppost(lightSource)
                    end
                else
                    if getTimestampMs() - effect.start > effect.len then
                        if effect.emitter then
                            effect.emitter:stopAll()
                            effect.emitter = nil
                        end
                        effect.start = nil
                    end
                end
            end
        end
    end
end

Events.OnTick.Add(BWOEmitter.Process)
