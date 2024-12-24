BWOTex = BWOTex or {}

BWOTex.tex = getTexture("media/textures/blast_n.png")
BWOTex.alpha = 0.9
BWOTex.speed = 0.05
BWOTex.screenWidth = getCore():getScreenWidth()
BWOTex.screenHeight = getCore():getScreenHeight()

BWOTex.Blast = function()
    if not isIngameState() then return end
    if BWOTex.alpha == 0 then return end

    local player = getSpecificPlayer(0)
    if player == nil then return end

    -- if not player:isOutside() then return end

    local speed = BWOTex.speed * getGameSpeed()
    local zoom = 1
    -- local zoom = getCore():getZoom(player:getPlayerNum())
    -- zoom = PZMath.clampFloat(zoom, 0.0, 1.0)

    local alpha = BWOTex.alpha
    if alpha > 1 then alpha = 1 end

    UIManager.DrawTexture(BWOTex.tex, 0, 0, BWOTex.screenWidth * zoom, BWOTex.screenHeight * zoom, alpha)
    
    BWOTex.alpha = BWOTex.alpha - speed
    if BWOTex.alpha < 0 then BWOTex.alpha = 0 end
end

BWOTex.SizeChange = function (n, n2, x, y)
    BWOTex.screenWidth = x
    BWOTex.screenHeight = y
end

Events.OnPreUIDraw.Add(BWOTex.Blast)
Events.OnResolutionChange.Add(BWOTex.SizeChange)
