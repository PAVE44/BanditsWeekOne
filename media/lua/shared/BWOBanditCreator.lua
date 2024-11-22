BanditCreator = BanditCreator or {}

function BanditCreator.MakeFromRoom(room)
    local bandit = {}
    
    -- this always generates bandits of clan 1 - citizens
    local clan = BanditCreator.GroupMap[1]

    -- properties to be rewritten from clan file to bandit instance
    bandit.clan = clan.id
    bandit.health = clan.health
    bandit.femaleChance = clan.femaleChance
    bandit.eatBody = clan.eatBody
    bandit.accuracyBoost = clan.accuracyBoost

    -- weapon config
    config = {}
    config.hasRifleChance = 0
    config.hasPistolChance = 4
    config.rifleMagCount = 0
    config.pistolMagCount = 1
    config.clanId = 1

    -- gun weapon choice comes from clan file, weapon probability from wave data
    bandit.weapons = BanditCreator.MakeWeapons(config, clan)

    -- melee weapon choice comes from clan file
    bandit.weapons.melee = BanditUtils.Choice(clan.Melee)

    -- outfit choice comes from clan file
    bandit.outfit = BanditUtils.Choice(clan.Outfits)

    -- hairstyle 
    if clan.hairStyles then
        bandit.hairStyle = BanditUtils.Choice(clan.hairStyles)
    end

    -- loot choice comes from clan file
    bandit.loot = BanditCreator.MakeLoot(clan.Loot)

    local building = room:getBuilding()
    if building:containsRoom("policestorage") then
        bandit.outfit = "Police"
        config.hasPistolChance = 100
        config.pistolMagCount = 3
        bandit.weapons = BanditCreator.MakeWeapons(config, clan)
        bandit.weapons.melee = "Base.Nightstick"

    elseif building:containsRoom("firestorage") then
        bandit.outfit = "Fireman"
        bandit.weapons.melee = "Base.Axe"
    elseif building:containsRoom("church") then
        if ZombRand(20) == 1 then
            bandit.outfit = "Priest"
            bandit.femaleChance = 0
        else
            bandit.outfit = BanditUtils.Choice({"Classy", "AuthenticElderly", "AuthenticFuneralFormal", "AuthenticFuneralCoat"})
        end
        bandit.weapons.melee = "Base.BareHands"
    elseif building:containsRoom("medclinic") or building:containsRoom("medical")  then
        bandit.outfit = BanditUtils.Choice({"Nurse", "Doctor", "HospitalPatient"})
        bandit.weapons.melee = "Base.Scalpel"
    elseif building:containsRoom("mechanic") then
        bandit.outfit = "Mechanic"
        bandit.femaleChance = 0
        bandit.weapons.melee = "Base.Wrench"
    else
        
        local roomDef = room:getRoomDef()
        if roomDef then
            local roomName = room:getName()
            if roomName == "bathroomx" then
                bandit.outfit = BanditUtils.Choice({"Bathrobe", "Naked", "Jewelry"})
                bandit.weapons.melee = "Base.BareHands"

            elseif roomName == "livingroom" then
                bandit.outfit = BanditUtils.Choice({"Generic01", "Generic02", "Generic03", "Generic04", "AuthenticFat02", "AuthenticFat03"})
                bandit.weapons.melee = "Base.SmashedBottle"

            elseif roomName == "bedroom" or roomName == "motelroom" or roomName == "motelroomoccupied" then
                if ZombRand(9) == 1 then
                    bandit.outfit = BanditUtils.Choice({"StripperBlack", "StripperNaked", "StripperPink"})
                    bandit.femaleChance = 100
                else
                    bandit.outfit = "Bedroom"
                end
                bandit.weapons.melee = "Base.BareHands"

            elseif roomName == "kitchen" then
                bandit.outfit = BanditUtils.Choice({"Generic01", "Generic02", "Waiter_PileOCrepe", "Generic05", "AuthenticMaid"}) 
                bandit.weapons.melee = BanditUtils.Choice({"Base.BareHands", "Base.KitchenKnife", "Base.BreadKnife", "Base.ButterKnife", "Base.Pan", "Base.GridlePan", "Base.MeatCleaver"})
                bandit.femaleChance = 100

            elseif roomName == "office" then -- also a room in house
                if ZombRand(2) == 1 then
                    bandit.outfit = "OfficeWorker"
                    bandit.femaleChance = 0
                else
                    bandit.outfit = "OfficeWorkerSkirt"
                    bandit.femaleChance = 100
                end
                bandit.weapons.melee = "Base.BareHands"

            elseif roomName == "daycare" then --kindergarden
                bandit.outfit = "OfficeWorkerSkirt"
                bandit.femaleChance = 100
                bandit.weapons.melee = "Base.BareHands"

            elseif roomName == "gasstore" or roomName == "gasstorage" then 
                bandit.outfit = BanditUtils.Choice({"Gas2Go", "Generic01", "Generic02"})
                bandit.weapons.melee = "Base.BareHands"

            elseif roomName == "liquorstore" then 
                bandit.outfit = BanditUtils.Choice({"Redneck", "Generic01", "Generic02", "Punk"})
                bandit.weapons.melee = "Base.SmashedBottle"

            elseif roomName == "restaurant" or roomName == "cafe" then 
                bandit.outfit = BanditUtils.Choice({"Classy", "Young", "Waiter_Classy"})
                bandit.weapons.melee = "Base.BareHands"

            elseif roomName == "pizzawhirled" then
                bandit.outfit = BanditUtils.Choice({"Generic03", "Young", "Waiter_PizzaWhirled"})
                bandit.weapons.melee = "Base.BareHands"

            elseif roomName == "spiffo_dining" then
                if ZombRand(10) == 0 then
                    bandit.outfit = "Spiffo"
                else
                    bandit.outfit = BanditUtils.Choice({"Generic03", "Generic04", "Waiter_Spiffo"})
                end
                bandit.weapons.melee = "Base.BareHands"

            elseif roomName == "jayschicken_dining" then
                bandit.outfit = BanditUtils.Choice({"Young", "Generic04", "Waiter_Market"})
                bandit.weapons.melee = "Base.BareHands"

            elseif roomName == "dinerkitchen" or roomName == "restaurantkitchen" or roomName == "pizzakitchen" or roomName == "cafeteriakitchen" or roomName == "cafekitchen"  or roomName == "jayschicken_kitchen" or roomName == "kitchen_crepe" then
                bandit.outfit = BanditUtils.Choice({"Cook_Generic", "Chef"})
                bandit.weapons.melee = BanditUtils.Choice({"Base.BareHands", "Base.KitchenKnife", "Base.BreadKnife", "Base.ButterKnife", "Base.Pan", "Base.GridlePan", "Base.MeatCleaver"})

            elseif roomName == "spiffoskitchen" then
                bandit.outfit = BanditUtils.Choice({"Cook_Spiffos", "Chef"})
                bandit.weapons.melee = BanditUtils.Choice({"Base.BareHands", "Base.KitchenKnife", "Base.BreadKnife", "Base.ButterKnife", "Base.Pan", "Base.GridlePan", "Base.MeatCleaver"})

            elseif roomName == "pharmacy" then
                bandit.outfit = BanditUtils.Choice({"Generic02", "Generic03", "Generic04", "Pharmacist"})
                bandit.weapons.melee = "Base.BareHands"

            elseif roomName == "pharmacystorage" then
                bandit.outfit = BanditUtils.Choice({"Pharmacist"})
                bandit.weapons.melee = "Base.BareHands"

            elseif roomName == "clothingstore" or roomName == "clothesstore" then
                if ZombRand(4) == 1 then
                    bandit.outfit = "OfficeWorkerSkirt"
                    bandit.femaleChance = 100
                else
                    bandit.outfit = BanditUtils.Choice({"DressShort", "DressNormal", "DressLong"})
                    bandit.femaleChance = 100
                end
                bandit.weapons.melee = "Base.BareHands"

            elseif roomName == "grocery" or roomName == "gigamart" then
                local rn = ZombRand(9)
                if rn == 1 then
                    bandit.outfit = "OfficeWorkerSkirt"
                    bandit.femaleChance = 100
                elseif rn == 2 then
                    bandit.outfit = "MallSecurity"
                    bandit.femaleChance = 0
                    config.hasPistolChance = 50
                    config.pistolMagCount = 2
                    bandit.weapons = BanditCreator.MakeWeapons(config, clan)
                    bandit.weapons.melee = "Base.Nightstick"
                end
                bandit.weapons.melee = "Base.BareHands"

            elseif roomName == "zippeestore" then
                if ZombRand(20) == 1 then
                    bandit.outfit = "OfficeWorkerSkirt"
                    bandit.femaleChance = 100
                end
                bandit.weapons.melee = "Base.BareHands"

            elseif roomName == "movierental" then
                if ZombRand(4) == 1 then
                    bandit.outfit = "Thug"
                    bandit.femaleChance = 0
                end
                bandit.weapons.melee = "Base.BareHands"

            elseif roomName == "dressingrooms" then
                bandit.outfit = BanditUtils.Choice({"DressShort", "Naked"})
                bandit.femaleChance = 100
                bandit.weapons.melee = "Base.BareHands"

            elseif roomName == "bookstore" or roomName == "library" then
                bandit.outfit = BanditUtils.Choice({"Generic02", "Generic03", "Teacher"})
                bandit.weapons.melee = "Base.BareHands"

            elseif roomName == "aesthetic" then 
                bandit.outfit = BanditUtils.Choice({"Classy", "Young", "DressShort"})
                bandit.femaleChance = 100
                bandit.weapons.melee = "Base.BareHands"

            elseif roomName == "bar" then
                bandit.outfit = BanditUtils.Choice({"Thug", "Punk", "Biker", "Redneck"})
                bandit.weapons.melee = "Base.SmashedBottle"

            elseif roomName == "barkitchen" then
                bandit.outfit = BanditUtils.Choice({"Waiter_Classy", "Waiter_Stripper"})
                bandit.weapons.melee = "Base.SmashedBottle"
                -- obj: Bar
                -- obj: Antique (bartap)

            elseif roomName == "warehouse" then
                bandit.outfit = BanditUtils.Choice({"Foreman", "Metalworker"})
                bandit.femaleChance = 0
                bandit.weapons.melee = BanditUtils.Choice({"Base.BareHands", "Base.MetalPipe", "Base.MetalBar", "Base.Crowbar"})

            elseif roomName == "classroom" or roomName == "cafeteria" then
                if ZombRand(10) == 1 then
                    bandit.outfit = "Teacher"
                else
                    bandit.outfit = "Student"
                end
                bandit.weapons.melee =  BanditUtils.Choice({"Base.BareHands", "Base.Pencil"})

            elseif roomName == "gym" then
                bandit.outfit = "StreetSports"
                bandit.femaleChance = 50
                bandit.weapons.melee = BanditUtils.Choice({"Base.BarBell", "Base.Dumbbell"})

                
            elseif roomName == "bank" then
                if ZombRand(4) == 1 then
                    bandit.outfit = "Security"
                    bandit.femaleChance = 0
                    config.hasPistolChance = 100
                    config.pistolMagCount = 3
                    bandit.weapons = BanditCreator.MakeWeapons(config, clan)
                    bandit.weapons.melee = "Base.Nightstick"
                else
                    bandit.outfit = "Classy"
                    bandit.weapons.melee = "Base.BareHands"
                end
                

            elseif roomName == "security" then
                bandit.outfit = "Security"
                bandit.femaleChance = 0
                config.hasPistolChance = 100
                config.pistolMagCount = 3
                bandit.weapons = BanditCreator.MakeWeapons(config, clan)
                bandit.weapons.melee = "Base.Nightstick"

            elseif roomName == "gunstore" then
                bandit.outfit = "Veteran"
                bandit.femaleChance = 0
                config.hasPistolChance = 100
                config.pistolMagCount = 3
                bandit.weapons = BanditCreator.MakeWeapons(config, clan)

            elseif roomName == "gunstorestorage" then
                bandit.outfit = "Veteran"
                bandit.femaleChance = 0
                config.hasPistolChance = 100
                config.pistolMagCount = 3
                bandit.weapons = BanditCreator.MakeWeapons(config, clan)

            elseif roomName == "cell" then
                bandit.outfit = "Inmate"
                bandit.femaleChance = 0
                bandit.weapons.melee = "Base.BareHands"
            else
                return false
            end
        end
    end

    return bandit
end
