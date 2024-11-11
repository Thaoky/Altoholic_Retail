--	*** LibItemInfo ***
-- Written by : Thaoky, EU-Marécages de Zangar
-- March 2021
-- This list was manually curated (source: mostly Wowhead + in-game).
-- Non-commercial use is permitted as long as credits are preserved, and that Blizzard's terms of services are respected.

local lib = LibStub("LibItemInfo-1.0")

local e = lib.Enum.ReagentTypes
local bag = lib.Enum.BagTypes
local SetReagent = lib.SetReagent

lib:RegisterItems({
	-- 1.0 Classic
	[1288] = SetReagent(0, e.Alchemy), -- Large Venom Sac
	[1475] = SetReagent(0, e.Alchemy), -- Small Venom Sac
	[3371] = SetReagent(0, e.Alchemy), -- Crystal Vial
	[9262] = SetReagent(0, e.Alchemy), -- Black Vitriol
	[19441] = SetReagent(0, e.Alchemy), -- Huge Venom Sac
	
	[6370] = SetReagent(0, e.Alchemy, 80), -- Blackmouth Oil
	[6371] = SetReagent(0, e.Alchemy, 130), -- Fire Oil
	[9061] = SetReagent(0, e.Alchemy, 225, bag.EngineeringBag), -- Goblin Rocket Fuel
	[12655] = SetReagent(0, e.Alchemy, 250, bag.MiningBag), -- Enchanted Thorium Bar
	[13423] = SetReagent(0, e.Alchemy, 250), -- Stonescale Oil
	[9210] = SetReagent(0, e.Alchemy, 260), -- Ghost Dye
	[7076] = SetReagent(0, e.Alchemy, 275), -- Essence of Earth
	[7078] = SetReagent(0, e.Alchemy, 275), -- Essence of Fire
	[7080] = SetReagent(0, e.Alchemy, 275), -- Essence of Water
	[7082] = SetReagent(0, e.Alchemy, 275), -- Essence of Air
	[12803] = SetReagent(0, e.Alchemy, 275), -- Living Essence
	[12808] = SetReagent(0, e.Alchemy, 275, bag.EnchantingBag), -- Essence of Undeath
	[12360] = SetReagent(0, e.Alchemy, 300, bag.MiningBag), -- Arcanite Bar	
	
	-- 2.0 BC
	[21884] = SetReagent(1, e.Alchemy, 65), -- Primal Fire
	[21885] = SetReagent(1, e.Alchemy, 65), -- Primal Water
	[21886] = SetReagent(1, e.Alchemy, 75), -- Primal Life
	[22451] = SetReagent(1, e.Alchemy, 65), -- Primal Air
	[22452] = SetReagent(1, e.Alchemy, 65), -- Primal Earth
	[22456] = SetReagent(1, e.Alchemy, 75), -- Primal Shadow
	[22457] = SetReagent(1, e.Alchemy, 75), -- Primal Mana
	[22572] = SetReagent(1, e.Alchemy), -- Mote of Air
	[22573] = SetReagent(1, e.Alchemy), -- Mote of Earth
	[22574] = SetReagent(1, e.Alchemy), -- Mote of Fire
	[22575] = SetReagent(1, e.Alchemy), -- Mote of Life
	[22576] = SetReagent(1, e.Alchemy), -- Mote of Mana
	[22577] = SetReagent(1, e.Alchemy), -- Mote of Shadow
	[22578] = SetReagent(1, e.Alchemy), -- Mote of Water
	[23571] = SetReagent(1, e.Alchemy, 65), -- Primal Might
	[25867] = SetReagent(1, e.Alchemy, 65), -- Earthstorm Diamond
	[25868] = SetReagent(1, e.Alchemy, 65), -- Skyfire Diamond

	-- 3.0 WotLK
	[40195] = SetReagent(2, e.Alchemy, 1), -- Pygmy Oil
	[44958] = SetReagent(2, e.Alchemy, 1), -- Ethereal Oil
	
	[35622] = SetReagent(2, e.Alchemy, 30), -- Eternal Water
	[35623] = SetReagent(2, e.Alchemy, 30), -- Eternal Air
	[35624] = SetReagent(2, e.Alchemy, 30), -- Eternal Earth
	[35625] = SetReagent(2, e.Alchemy, 30), -- Eternal Life
	[35627] = SetReagent(2, e.Alchemy, 30), -- Eternal Shadow
	[36860] = SetReagent(2, e.Alchemy, 30), -- Eternal Fire
	[37700] = SetReagent(2, e.Alchemy), -- Crystallized Air
	[37701] = SetReagent(2, e.Alchemy), -- Crystallized Earth
	[37702] = SetReagent(2, e.Alchemy), -- Crystallized Fire
	[37703] = SetReagent(2, e.Alchemy), -- Crystallized Shadow
	[37704] = SetReagent(2, e.Alchemy), -- Crystallized Life
	[37705] = SetReagent(2, e.Alchemy), -- Crystallized Water
	
	-- Actually jewelcrafting
	-- [36919] = SetReagent(2, e.Alchemy, 65, bag.GemBag), -- Cardinal Ruby
	-- [36922] = SetReagent(2, e.Alchemy, 65, bag.GemBag), -- King's Amber
	-- [36925] = SetReagent(2, e.Alchemy, 65, bag.GemBag), -- Majestic Zircon
	-- [36928] = SetReagent(2, e.Alchemy, 65, bag.GemBag), -- Dreadstone
	-- [36934] = SetReagent(2, e.Alchemy, 65, bag.GemBag), -- Eye of Zul
	-- [36931] = SetReagent(2, e.Alchemy, 65, bag.GemBag), -- Ametrine
	[41266] = SetReagent(2, e.Alchemy, 65, bag.GemBag), -- Skyflare Diamond
	[41334] = SetReagent(2, e.Alchemy, 65, bag.GemBag), -- Earthsiege Diamond
	
	-- 4.0 Cataclysm
	[65892] = SetReagent(3, e.Alchemy), -- Pyrium-Laced Crystalline Vial
	[56850] = SetReagent(3, e.Alchemy, 20), -- Deepstone Oil
	
	-- Actually jewelcrafting
	-- [52190] = SetReagent(3, e.Alchemy, 75, bag.GemBag), -- Inferno Ruby
	-- [52191] = SetReagent(3, e.Alchemy, 70, bag.GemBag), -- Ocean Sapphire
	-- [52192] = SetReagent(3, e.Alchemy, 60, bag.GemBag), -- Dream Emerald
	-- [52193] = SetReagent(3, e.Alchemy, 65, bag.GemBag), -- Ember Topaz
	-- [52194] = SetReagent(3, e.Alchemy, 70, bag.GemBag), -- Demonseye
	-- [52195] = SetReagent(3, e.Alchemy, 75, bag.GemBag), -- Amberjewel
	
	[52303] = SetReagent(3, e.Alchemy, 75, bag.GemBag), -- Shadowspirit Diamond
	[58480] = SetReagent(3, e.Alchemy, 75, bag.MiningBag), -- Truegold
	
	-- 5.0 Mists of Pandaria
	[87872] = SetReagent(4, e.Alchemy, 15), -- Desecrated Oil
	
	-- Actually jewelcrafting
	-- [76131] = SetReagent(4, e.Alchemy, 75, bag.GemBag), -- Primordial Ruby
	-- [76138] = SetReagent(4, e.Alchemy, 75, bag.GemBag), -- River's Heart
	-- [76139] = SetReagent(4, e.Alchemy, 75, bag.GemBag), -- Wild Jade
	-- [76140] = SetReagent(4, e.Alchemy, 75, bag.GemBag), -- Vermilion Onyx
	-- [76141] = SetReagent(4, e.Alchemy, 75, bag.GemBag), -- Imperial Amethyst
	-- [76142] = SetReagent(4, e.Alchemy, 75, bag.GemBag), -- Sun's Radiance
	
	[72104] = SetReagent(4, e.Alchemy, 75, bag.MiningBag), -- Living Steel
	
	-- 6.0 Warlords of Draenor
	[118700] = SetReagent(5, e.Alchemy, 1), -- Secrets of Draenor Alchemy
	[108996] = SetReagent(5, e.Alchemy, 1), -- Alchemical Catalyst
	[109123] = SetReagent(5, e.Alchemy, 1), -- Crescent Oil
	[118472] = SetReagent(5, e.Alchemy, 5), -- Savage Blood
	
	[113261] = SetReagent(5, e.Alchemy, 100), -- Sorcerous Fire
	[113262] = SetReagent(5, e.Alchemy, 100), -- Sorcerous Water
	[113263] = SetReagent(5, e.Alchemy, 100), -- Sorcerous Earth
	[113264] = SetReagent(5, e.Alchemy, 100), -- Sorcerous Air
	
	-- 7.0 Legion
	[137595] = SetReagent(6, e.Alchemy), -- Viscous Transmutagen
	[137596] = SetReagent(6, e.Alchemy), -- Black Transmutagen
	[137597] = SetReagent(6, e.Alchemy), -- Oily Transmutagen
	[124124] = SetReagent(6, e.Alchemy, 20), -- Blood of Sargeras
	[151568] = SetReagent(6, e.Alchemy, 20), -- Primal Sargerite
	
	-- 8.0 Battle for Azeroth
	
	-- 9.0 Shadowlands
	[180732] = SetReagent(8, e.Alchemy), -- Runed Etched Vial
	[183950] = SetReagent(8, e.Alchemy), -- Distilled Death Extract
	[171287] = SetReagent(8, e.Alchemy, 15), -- Ground Death Blossom
	[171291] = SetReagent(8, e.Alchemy, 20), -- Ground Rising Glory
	[171290] = SetReagent(8, e.Alchemy, 45), -- Ground Marrowroot
	[171292] = SetReagent(8, e.Alchemy, 75), -- Ground Nightshade
	[171288] = SetReagent(8, e.Alchemy, 80), -- Ground Vigil's Torch
	[171289] = SetReagent(8, e.Alchemy, 105), -- Ground Widowbloom
	[180457] = SetReagent(8, e.Alchemy, 175), -- Shadestone
	
	-- 10.0 Dragonflight
	[191520] = SetReagent(9, e.Alchemy), -- Agitating Potion Augmentation 1
	[191521] = SetReagent(9, e.Alchemy), -- Agitating Potion Augmentation 2
	[191522] = SetReagent(9, e.Alchemy), -- Agitating Potion Augmentation 3
	[191523] = SetReagent(9, e.Alchemy), -- Reactive Phial Embellishment 1
	[191524] = SetReagent(9, e.Alchemy), -- Reactive Phial Embellishment 2
	[191525] = SetReagent(9, e.Alchemy), -- Reactive Phial Embellishment 3
})