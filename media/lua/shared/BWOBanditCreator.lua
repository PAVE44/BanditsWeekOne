BanditCreator = BanditCreator or {}

function BanditCreator.MakeFromRoom(room)
    local bandit = {}
    
    -- this always generates bandits of clan 0 - citizens
    local clan = BanditCreator.GroupMap[0]

    -- properties to be rewritten from clan file to bandit instance
    bandit.clan = clan.id
    bandit.health = clan.health
    bandit.femaleChance = clan.femaleChance
    bandit.eatBody = clan.eatBody
    bandit.accuracyBoost = clan.accuracyBoost

    -- weapon config
    config = {}
    config.hasRifleChance = 0
    config.hasPistolChance = 7
    config.rifleMagCount = 0
    config.pistolMagCount = 3
    config.clanId = 0

    if BWOScheduler.SymptomLevel >= 3 then
        config.hasRifleChance = 5
        config.hasPistolChance = 40
        config.rifleMagCount = 2
        config.pistolMagCount = 3
    end

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
    elseif building:containsRoom("medclinic") or building:containsRoom("medical") or building:containsRoom("clinic") or building:containsRoom("medclinic") then
        bandit.outfit = BanditUtils.Choice({"Nurse", "Doctor", "HospitalPatient"})
        bandit.weapons.melee = "Base.Scalpel"
    elseif building:containsRoom("mechanic") then
        bandit.outfit = "Mechanic"
        bandit.femaleChance = 0
        bandit.weapons.melee = "Base.Wrench"
    else
        
        local roomName = room:getName()

        -- residential
        if  roomName == "livingroom" or 
            roomName == "diningroom" then

            bandit.outfit = BanditUtils.Choice({"Generic01", "Generic02", "Generic03", "Generic04", "AuthenticFat02", "AuthenticFat03"})
            bandit.weapons.melee = "Base.SmashedBottle"
        
        elseif roomName == "kitchen" then
            bandit.outfit = BanditUtils.Choice({"Generic01", "Generic02", "Waiter_PileOCrepe", "Generic05", "AuthenticMaid"}) 
            bandit.weapons.melee = BanditUtils.Choice({"Base.BareHands", "Base.KitchenKnife", "Base.BreadKnife", "Base.ButterKnife", "Base.Pan", "Base.GridlePan", "Base.MeatCleaver"})
            bandit.femaleChance = 100

        elseif  roomName == "bedroom" or 
                roomName == "motelroom" or 
                roomName == "motelroomoccupied" then

            if ZombRand(9) == 1 then
                bandit.outfit = BanditUtils.Choice({"StripperBlack", "StripperNaked", "StripperPink"})
                bandit.femaleChance = 100
            else
                bandit.outfit = "Bedroom"
            end
            bandit.weapons.melee = "Base.BareHands"


        -- commercial office 
        elseif  roomName == "office" or 
                roomName == "meeting" or 
                roomName == "meetingroom" then -- also a room in house

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

        -- commercial shopping
        elseif  roomName == "gasstore" or 
                roomName == "gasstorage" or 
                roomName == "fossoil" then 

            bandit.outfit = BanditUtils.Choice({"Gas2Go", "Generic01", "Generic02"})
            bandit.weapons.melee = "Base.BareHands"

        elseif roomName == "liquorstore" then 

            bandit.outfit = BanditUtils.Choice({"Redneck", "Generic01", "Generic02", "Punk"})
            bandit.weapons.melee = "Base.SmashedBottle"

        -- female stores
        elseif  roomName == "clothingstore" or 
                roomName == "clothesstore" or 
                roomName == "shoestore" or 
                roomName == "giftstore" or 
                roomName == "lingeriestore" then

            if ZombRand(4) == 1 then
                bandit.outfit = "OfficeWorkerSkirt"
                bandit.femaleChance = 100
            else
                bandit.outfit = BanditUtils.Choice({"DressShort", "DressNormal", "DressLong"})
                bandit.femaleChance = 100
            end
            bandit.weapons.melee = "Base.BareHands"

        elseif  roomName == "clothingstorage" or 
                roomName == "clothesstorestorage" or 
                roomName == "shoestorage" or 
                roomName == "giftstorage" then

                bandit.outfit = BanditUtils.Choice({"DressShort", "DressNormal", "DressLong"})
                bandit.femaleChance = 100
                bandit.weapons.melee = "Base.BareHands"

        -- stores
        elseif  roomName == "zippeestore" or 
                roomName == "sportstorage" or 
                roomName == "bakery" or 
                roomName == "butcher" or 
                roomName == "conveniencestore" or 
                roomName == "cornerstore" or 
                roomName == "grocery" or 
                roomName == "candystore" or 
                roomName == "generalstore" or 
                roomName == "artstore" or 
                roomName == "camerastore" or 
                roomName == "departmentstore" then

            if ZombRand(20) == 1 then
                bandit.outfit = "OfficeWorkerSkirt"
                bandit.femaleChance = 100
            end
            bandit.weapons.melee = "Base.BareHands"

        elseif  roomName == "cornerstorestorage" or
                roomName == "grocerystorage" or 
                roomName == "generalstorestorage" or
                roomName == "departmentstorage" then
                
                bandit.outfit = "OfficeWorkerSkirt"
                bandit.femaleChance = 100
                bandit.weapons.melee = "Base.BareHands"

        -- stores with security
        elseif  roomName == "gigamart" or 
                roomName == "jewelrystore" or 
                roomName == "jewelrystorage" then

            local rn = ZombRand(9)
            if rn == 1 then
                bandit.outfit = "OfficeWorkerSkirt"
                bandit.femaleChance = 100
                bandit.weapons.melee = "Base.BareHands"
            elseif rn == 2 then
                bandit.outfit = "MallSecurity"
                bandit.femaleChance = 0
                config.hasPistolChance = 100
                config.pistolMagCount = 2
                bandit.weapons = BanditCreator.MakeWeapons(config, clan)
                bandit.weapons.melee = "Base.Nightstick"
            else
                bandit.weapons.melee = "Base.BareHands"
            end

        elseif roomName == "pharmacy" then

            bandit.outfit = BanditUtils.Choice({"Generic02", "Generic03", "Generic04", "Pharmacist"})
            bandit.weapons.melee = "Base.BareHands"

        elseif roomName == "pharmacystorage" then

            bandit.outfit = BanditUtils.Choice({"Pharmacist"})
            bandit.weapons.melee = "Base.BareHands"

        elseif  roomName == "bookstore" or 
                roomName == "library" then

            bandit.outfit = BanditUtils.Choice({"Generic02", "Generic03", "Teacher"})
            bandit.weapons.melee = "Base.BareHands"

        -- restaurants
        elseif  roomName == "restaurant" or 
                roomName == "cafe" or 
                roomName == "italianrestaurant" or 
                roomName == "restaurant_dining" then 

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

        elseif  roomName == "jayschicken_dining" or 
                roomName == "icecream" or 
                roomName == "pileocrepe" or 
                roomName == "chineserestaurant" or 
                roomName == "donut_dining" then

            bandit.outfit = BanditUtils.Choice({"Young", "Generic04", "Waiter_Market"})
            bandit.weapons.melee = "Base.BareHands"

        elseif roomName == "bar" or roomName == "beergarden" then
            bandit.outfit = BanditUtils.Choice({"Thug", "Punk", "Biker", "Redneck"})
            bandit.weapons.melee = "Base.SmashedBottle"

        -- restaurant kitchens
        elseif  roomName == "icecreamkitchen" or 
                roomName == "italiankitchen" or 
                roomName == "gigamartkitchen" or 
                roomName == "bakerykitchen" or 
                roomName == "fishchipskitchen" or 
                roomName == "burgerkitchen" or 
                roomName == "dinerkitchen" or 
                roomName == "restaurantkitchen" or 
                roomName == "pizzakitchen" or 
                roomName == "cafeteriakitchen" or 
                roomName == "cafekitchen" or 
                roomName == "jayschicken_kitchen" or 
                roomName == "kitchen_crepe" then

            bandit.outfit = BanditUtils.Choice({"Cook_Generic", "Chef"})
            bandit.weapons.melee = BanditUtils.Choice({"Base.BareHands", "Base.KitchenKnife", "Base.BreadKnife", "Base.ButterKnife", "Base.Pan", "Base.GridlePan", "Base.MeatCleaver"})

        elseif roomName == "spiffoskitchen" then
            bandit.outfit = BanditUtils.Choice({"Cook_Spiffos", "Chef"})
            bandit.weapons.melee = BanditUtils.Choice({"Base.BareHands", "Base.KitchenKnife", "Base.BreadKnife", "Base.ButterKnife", "Base.Pan", "Base.GridlePan", "Base.MeatCleaver"})

        elseif roomName == "barkitchen" or roomName == "barstorage" then
            bandit.outfit = BanditUtils.Choice({"Waiter_Classy", "Waiter_Stripper"})
            bandit.weapons.melee = "Base.SmashedBottle"

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

        elseif roomName == "aesthetic" or roomName == "aestheticstorage" then 
            bandit.outfit = BanditUtils.Choice({"Classy", "Young", "DressShort"})
            bandit.femaleChance = 100
            bandit.weapons.melee = "Base.BareHands"




        elseif roomName == "warehouse" or roomName == "electronicsstore" or roomName == "electronicsstorage" or roomName == "factory" or roomName == "factorystorage" or roomName == "radiofactory" or roomName == "radioshipping" or roomName == "radiostorage" then
            bandit.outfit = BanditUtils.Choice({"Foreman", "Metalworker"})
            bandit.femaleChance = 0
            bandit.weapons.melee = BanditUtils.Choice({"Base.BareHands", "Base.MetalPipe", "Base.MetalBar", "Base.Crowbar"})

        elseif roomName == "farmstorage" or roomName == "potatostorage" or roomName == "producestorage" then
            bandit.outfit = BanditUtils.Choice({"Farmer"})
            bandit.femaleChance = 50
            bandit.weapons.melee = BanditUtils.Choice({"Base.BareHands", "Base.HandScythe"})

        elseif roomName == "classroom" or roomName == "schoolstorage" then
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

            
        elseif roomName == "bank" or roomName == "bankstorage" then
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

        elseif roomName == "armyhanger" or roomName == "armystorage" or roomName == "armysurplus" then
            bandit.outfit = "ArmyCamoGreen"
            bandit.femaleChance = 0
            config.hasRifleChance = 70
            config.hasPistolChance = 100
            config.rifleMagCount = 4
            config.pistolMagCount = 2
            bandit.weapons = BanditCreator.MakeWeapons(config, clan)

        elseif roomName == "gunstore" or roomName == "gunstorestorage" then
            bandit.outfit = "Veteran"
            bandit.femaleChance = 0
            config.hasPistolChance = 100
            config.pistolMagCount = 3
            bandit.weapons = BanditCreator.MakeWeapons(config, clan)

        elseif roomName == "cell" or roomName == "prisoncells" then
            bandit.outfit = "Inmate"
            bandit.femaleChance = 0
            bandit.weapons.melee = "Base.BareHands"

        elseif roomName == "loggingfactory" or roomName == "loggingtruck" then
            bandit.outfit = "Woodcut"
            bandit.femaleChance = 0
            bandit.weapons.melee = "Base.WoodAxe"

        else
            return false
        end
    end

    return bandit
end
