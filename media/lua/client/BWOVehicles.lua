BWOVehicles = BWOVehicles or {}

BWOVehicles.tab = {}

BWOVehicles.Register = function(vehicle)
    local id = vehicle:getId()
    BWOVehicles.tab[id] = vehicle
end

local ManageVehicles = function(ticks)
    if ticks % 6 > 0 then return end
    local cell = getCell()
    local vehicleList = BWOVehicles.tab
    for id, vehicle in pairs(vehicleList) do

        local driver = vehicle:getDriver()
        if driver then
            if driver:isNPC() then 
                vehicle:setRegulator(true)
                vehicle:setRegulatorSpeed(50)

                local x = vehicle:getX()
                local y = vehicle:getY()
                local a = vehicle:getAngleY() - 90
                -- print ("VEH DEBUG: ID: " .. id .. " X: " .. x .. " Y: " .. y .. " A:" .. a)

                if a < -180 then a = a + 180 end
        
                local angle = a * math.pi * 0.00555555

                --- print ("VX: " .. vx .. " VY:" .. vy)

                local step = 0.2
                for i = 0, 14 do
                    for j=-1, 1, 2 do
                        local newangle = angle + (i * j * step)
                        if newangle > 6.283185304 then newangle = newangle - 6.283185304 end

                        local vx = x + math.floor(5 * math.cos(newangle) + 0.5)
                        local vy = y + math.floor(5 * math.sin(newangle) + 0.5)
                        local vz = 0

                        local square = cell:getGridSquare(vx, vy, vz)
                        if square then
                            local groundType = BanditUtils.GetGroundType(square)
                            if groundType == "street" then
                                local new = math.deg(newangle) + 90
                                if new > 180 then
                                    new = new - 360
                                elseif new < -180 then
                                    new = new + 360
                                end
                                if ticks % 200 == 0 then
                                    -- print ("VX: " .. math.floor(vx) .. " VY:" .. math.floor(vy))
                                    print ("A:" .. new)
                                    vehicle:setAngles(vehicle:getAngleX(), new, vehicle:getAngleZ())
                                end
                               
                                return
                            end
                        end
                    end
                end

                
            end
        else
            local npcAesthetics = SurvivorFactory.CreateSurvivor(SurvivorType.Neutral, false)
            npcAesthetics:setForename("Driver")
            npcAesthetics:setSurname("Driver")
            npcAesthetics:dressInNamedOutfit("Police")

            local npcVisuals = npcAesthetics:getHumanVisual()
            npcVisuals:setHairModel("OverEye")

            local hairColor = ImmutableColor.new(0, 0, 0)
            npcVisuals:setHairColor(hairColor)
            npcVisuals:setSkinTextureIndex(1)

            local driver = IsoPlayer.new(getWorld():getCell(), npcAesthetics, square:getX()+10, square:getY()+10, square:getZ())

            driver:setSceneCulled(false)
            driver:setNPC(true)
            driver:setGodMod(false)
            driver:setInvisible(false)

            local vx = driver:getForwardDirection():getX()
            local vy = driver:getForwardDirection():getY()
            local forwardVector = Vector3f.new(vx, vy, 0)
            
            driver:enterVehicle(vehicle, 0, forwardVector)

            vehicle:tryStartEngine(true)
            vehicle:engineDoStartingSuccess()
            vehicle:engineDoRunning()
        end
    end
end

Events.OnTick.Add(ManageVehicles)
