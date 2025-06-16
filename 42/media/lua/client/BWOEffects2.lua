BWOEffects2 = BWOEffects2 or {}

BWOEffects2.tab = {}
BWOEffects2.tick = 0

BWOEffects2.immuneList = {
    "cfccfa27-f256-47a0-bd7c-b2d12b369c6d", -- medic with hazmats
    "9bf4882b-0622-4e77-82c1-feee90b566b4", -- sweepers with hazmats
    "ce526bd8-a230-4d21-a1f8-5e30790b366f", -- army with gas masks
    "989f4faf-53f2-4f8f-9603-496fb3efcb6a", -- firemen
}

BWOEffects2.Add = function(effect)
    table.insert(BWOEffects2.tab, effect)
end

BWOEffects2.Process = function()
    if not isIngameState() then return end
    if isServer() then return end

    local player = getSpecificPlayer(0)
    if player == nil then return end
    local playerNum = player:getPlayerNum()
    local zoom = getCore():getZoom(playerNum)
    local immuneList = BWOEffects2.immuneList

    local cell = getCell()
    for i = #BWOEffects2.tab, 1, -1 do
        local effect = BWOEffects2.tab[i]

        local square = cell:getGridSquare(effect.x, effect.y, effect.z)
        if square then

            if effect.repCnt == nil then effect.repCnt = 1 end
            if effect.rep == nil then effect.rep = 1 end

            local size = effect.size / zoom
            local offset = size / 2
            local tx = isoToScreenX(playerNum, effect.x, effect.y, effect.z) - offset
            local ty = isoToScreenY(playerNum, effect.x, effect.y, effect.z) - offset

            if not effect.frame then 
                if effect.frameRnd then
                    effect.frame = 1 + ZombRand(effect.frameCnt)
                else
                    effect.frame = 1
                end
            end

            if effect.frame > effect.frameCnt and effect.rep >= effect.repCnt then
                table.remove(BWOEffects2.tab, i)
            else
                if effect.frame > effect.frameCnt then
                    effect.rep = effect.rep + 1
                    effect.frame = 1
                end

                local alpha = (1 + effect.repCnt - effect.rep) / effect.repCnt

                local frameStr = string.format("%03d", effect.frame)
                local tex = getTexture("media/textures/FX/" .. effect.name .. "/" .. frameStr .. ".png")
                if tex then
                    UIManager.DrawTexture(tex, tx, ty, size, size, alpha)
                end

                effect.frame = effect.frame + 1

                if effect.poison then
                    -- effect.object:setCustomColor(0.1,0.7,0.2, alpha)
                    if effect.frame % 10 == 1 then
                        local actors = BanditZombie.GetAll()
                        for _, actor in pairs(actors) do
                            local dx, dy = actor.x - effect.x, actor.y - effect.y
                            local distSq = dx * dx + dy * dy
                            if distSq < 9 then  -- 3^2
                                local character = BanditZombie.GetInstanceById(actor.id)
                                local immune = false
                                local brain = BanditBrain.Get(character)
                                if brain and brain.cid then
                                    for _, cid in pairs(immuneList) do
                                        if brain.cid == cid then
                                            immune = true
                                            break
                                        end
                                    end
                                end
                                if not immune then
                                    character:setHealth(character:getHealth() - 0.12)
                                end
                            end
                        end
                        local immune = false
                        local mask = player:getWornItem("MaskEyes")
                        if mask then
                            if mask:getFullType() == "Base.Hat_GasMask" then 
                                immune = true 
                            end
                        end
                        local suit = player:getWornItem("FullSuitHead")
                        if suit then
                            if suit:getFullType() == "Base.HazmatSuit" then 
                                immune = true 
                            end
                        end
                        if not immune then
                            local dist = math.sqrt(math.pow(player:getX() - effect.x, 2) + math.pow(player:getY() - effect.y, 2))
                            if dist < 3 then
                                local bodyDamage = player:getBodyDamage()
                                local sick = bodyDamage:getFoodSicknessLevel()
                                bodyDamage:setFoodSicknessLevel(sick + 2)

                                local stats = player:getStats()
                                local drunk = stats:getDrunkenness()
                                stats:setDrunkenness(drunk + 4)
                            end
                        end
                    end
                end
            end
        else
            table.remove(BWOEffects2.tab, i)
        end
    end
end

local onServerCommand = function(mod, command, args)
    if mod == "BWOEffects" then
        BWOEffects[command](args)
    end
end

Events.OnServerCommand.Add(onServerCommand)
Events.OnPreUIDraw.Add(BWOEffects2.Process)