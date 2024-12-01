BanditClan = BanditClan or {}

BanditClan.Civilians = BanditClan.Civilians or {}

-- The unique id of the clan, ids 1-16 are reserved for waves
BanditClan.Civilians.id = 0

-- Name of the clan
BanditClan.Civilians.name = "Civilians"

-- % chance of a clan member to be a female. Outfit must support it.
BanditClan.Civilians.femaleChance = 40

-- health ranges from 1 - 14. Higher values may produce unexpected results,
BanditClan.Civilians.health = 2

-- if the bandit will eat player's body after death
BanditClan.Civilians.eatBody = false

-- Ranged weapon accuracy multiplayer (1=default)
BanditClan.Civilians.accuracyBoost = 0.8

-- Favorite zones 
BanditClan.Civilians.favoriteZones = {}
BanditClan.Civilians.avoidZones = {"Vegitation", "Forest", "DeepForest"}

-- available outfits
BanditClan.Civilians.Outfits = BanditClan.Civilians.Outfits or {}
table.insert(BanditClan.Civilians.Outfits, "Bathrobe")
table.insert(BanditClan.Civilians.Outfits, "Generic06")
table.insert(BanditClan.Civilians.Outfits, "Generic05")
table.insert(BanditClan.Civilians.Outfits, "Generic04")
table.insert(BanditClan.Civilians.Outfits, "Generic03")
table.insert(BanditClan.Civilians.Outfits, "Generic02")
table.insert(BanditClan.Civilians.Outfits, "Generic01")
table.insert(BanditClan.Civilians.Outfits, "Punk")
table.insert(BanditClan.Civilians.Outfits, "Rocker")
table.insert(BanditClan.Civilians.Outfits, "Tourist")
table.insert(BanditClan.Civilians.Outfits, "BaseballFan_KY")
table.insert(BanditClan.Civilians.Outfits, "BaseballFan_Rangers")
table.insert(BanditClan.Civilians.Outfits, "BaseballFan_Z")
table.insert(BanditClan.Civilians.Outfits, "Bedroom")
table.insert(BanditClan.Civilians.Outfits, "Chef")
table.insert(BanditClan.Civilians.Outfits, "Cyclist")
table.insert(BanditClan.Civilians.Outfits, "Doctor")
table.insert(BanditClan.Civilians.Outfits, "Fireman")
table.insert(BanditClan.Civilians.Outfits, "Fossoil")
table.insert(BanditClan.Civilians.Outfits, "Gas2Go")
table.insert(BanditClan.Civilians.Outfits, "GigaMart_Employee")
table.insert(BanditClan.Civilians.Outfits, "Hobbo")
table.insert(BanditClan.Civilians.Outfits, "Pharmacist")
table.insert(BanditClan.Civilians.Outfits, "ShellSuit_Black")
table.insert(BanditClan.Civilians.Outfits, "ShellSuit_Blue")
table.insert(BanditClan.Civilians.Outfits, "ShellSuit_Green")
table.insert(BanditClan.Civilians.Outfits, "ShellSuit_Pink")
table.insert(BanditClan.Civilians.Outfits, "ShellSuit_Teal")
table.insert(BanditClan.Civilians.Outfits, "SportsFan")
table.insert(BanditClan.Civilians.Outfits, "Varsity")

if getActivatedMods():contains("Authentic Z - Current") then
    table.insert(BanditClan.Civilians.Outfits, "AuthenticHomeless")
    table.insert(BanditClan.Civilians.Outfits, "AuthenticElderly")
    table.insert(BanditClan.Civilians.Outfits, "AuthenticSurvivorCovid")
end

-- available melee weapons
BanditClan.Civilians.Melee = BanditClan.Civilians.Melee or {}
table.insert(BanditClan.Civilians.Melee, "Base.BreadKnife")
table.insert(BanditClan.Civilians.Melee, "Base.Pan")
table.insert(BanditClan.Civilians.Melee, "Base.RollingPin")
table.insert(BanditClan.Civilians.Melee, "Base.SmashedBottle")
table.insert(BanditClan.Civilians.Melee, "Base.HandScythe")
table.insert(BanditClan.Civilians.Melee, "Base.WoodenLance")
table.insert(BanditClan.Civilians.Melee, "Base.Banjo")
table.insert(BanditClan.Civilians.Melee, "Base.ChairLeg")
table.insert(BanditClan.Civilians.Melee, "Base.GardenFork")
table.insert(BanditClan.Civilians.Melee, "Base.GridlePan")
table.insert(BanditClan.Civilians.Melee, "Base.Hammer")
table.insert(BanditClan.Civilians.Melee, "Base.HockeyStick")
table.insert(BanditClan.Civilians.Melee, "Base.IceHockeyStick")
table.insert(BanditClan.Civilians.Melee, "Base.MetalPipe")
table.insert(BanditClan.Civilians.Melee, "Base.PipeWrench")
table.insert(BanditClan.Civilians.Melee, "Base.Plunger")
table.insert(BanditClan.Civilians.Melee, "Base.GuitarElectricRed")
table.insert(BanditClan.Civilians.Melee, "Base.Saucepan")
table.insert(BanditClan.Civilians.Melee, "Base.TableLeg")
table.insert(BanditClan.Civilians.Melee, "Base.Wrench")
table.insert(BanditClan.Civilians.Melee, "Base.Plank")
table.insert(BanditClan.Civilians.Melee, "Base.LeadPipe")
table.insert(BanditClan.Civilians.Melee, "Base.WoodenMallet")
table.insert(BanditClan.Civilians.Melee, "Base.Broom")

-- available primary weapons
BanditClan.Civilians.Primary = BanditClan.Civilians.Primary or BanditWeapons.Primary

-- available secondary weapons
BanditClan.Civilians.Secondary = BanditClan.Civilians.Secondary or BanditWeapons.Secondary

-- loot table
BanditClan.Civilians.Loot = BanditClan.Civilians.Loot or {}
table.insert(BanditClan.Civilians.Loot, BanditLoot.MakeItem("Base.WaterBottleFull", 30))
table.insert(BanditClan.Civilians.Loot, BanditLoot.MakeItem("Base.Gum", 5))
table.insert(BanditClan.Civilians.Loot, BanditLoot.MakeItem("Base.Peppermint", 2))
table.insert(BanditClan.Civilians.Loot, BanditLoot.MakeItem("Base.GummyWorms", 1))
table.insert(BanditClan.Civilians.Loot, BanditLoot.MakeItem("Base.Jujubes", 1))
table.insert(BanditClan.Civilians.Loot, BanditLoot.MakeItem("Base.HiHis", 1))
table.insert(BanditClan.Civilians.Loot, BanditLoot.MakeItem("Base.CandyFruitSlices", 1))
table.insert(BanditClan.Civilians.Loot, BanditLoot.MakeItem("Base.Crisps", 1))
table.insert(BanditClan.Civilians.Loot, BanditLoot.MakeItem("Base.Crisps2", 1))
table.insert(BanditClan.Civilians.Loot, BanditLoot.MakeItem("Base.Crisps3", 1))

-- register this clan for spawn system
BanditCreator.ClanMap = BanditCreator.GroupMap or {}
BanditCreator.ClanMap[0] = BanditClan.Civilians
