--	*** LibItemInfo ***
-- Written by : Thaoky, EU-Marécages de Zangar
-- March 2021
-- This list was manually curated (source: mostly Wowhead + in-game).
-- Non-commercial use is permitted as long as credits are preserved, and that Blizzard's terms of services are respected.

local lib = LibStub("LibItemInfo-1.0")

local e = lib.Enum.ReagentTypes
local SetReagent = lib.SetReagent

lib:RegisterItems({
	-- https://www.wowhead.com/items?filter=166:70:217;9:1:1;0:0:0
	
	-- 1.0 Classic
	[765] = SetReagent(0, e.Herbalism), -- Silverleaf
	[785] = SetReagent(0, e.Herbalism), -- Mageroyal
	[2447] = SetReagent(0, e.Herbalism), -- Peacebloom
	[2449] = SetReagent(0, e.Herbalism), -- Earthroot
	[2450] = SetReagent(0, e.Herbalism), -- Briarthorn
	[2452] = SetReagent(0, e.Herbalism), -- Swiftthistle
	[2453] = SetReagent(0, e.Herbalism), -- Bruiseweed
	[3355] = SetReagent(0, e.Herbalism), -- Wild Steelbloom
	[3356] = SetReagent(0, e.Herbalism), -- Kingsblood
	[3357] = SetReagent(0, e.Herbalism), -- Liferoot
	[3358] = SetReagent(0, e.Herbalism), -- Khadgar's Whisker
	[3369] = SetReagent(0, e.Herbalism), -- Grave Moss
	[3818] = SetReagent(0, e.Herbalism), -- Fadeleaf
	[3819] = SetReagent(0, e.Herbalism), -- Dragon's Teeth
	[3820] = SetReagent(0, e.Herbalism), -- Stranglekelp
	[3821] = SetReagent(0, e.Herbalism), -- Goldthorn
	[4625] = SetReagent(0, e.Herbalism), -- Firebloom
	[8153] = SetReagent(0, e.Herbalism), -- Wildvine
	[8831] = SetReagent(0, e.Herbalism), -- Purple Lotus
	[8836] = SetReagent(0, e.Herbalism), -- Arthas' Tears
	[8838] = SetReagent(0, e.Herbalism), -- Sungrass
	[8839] = SetReagent(0, e.Herbalism), -- Blindweed
	[8845] = SetReagent(0, e.Herbalism), -- Ghost Mushroom
	[8846] = SetReagent(0, e.Herbalism), -- Gromsblood
	[13463] = SetReagent(0, e.Herbalism), -- Dreamfoil
	[13464] = SetReagent(0, e.Herbalism), -- Golden Sansam
	[13465] = SetReagent(0, e.Herbalism), -- Mountain Silversage
	[13466] = SetReagent(0, e.Herbalism), -- Sorrowmoss
	[13467] = SetReagent(0, e.Herbalism), -- Icecap
	[13468] = SetReagent(0, e.Herbalism), -- Black Lotus
	[108323] = SetReagent(0, e.Herbalism), -- Wild Steelbloom Petal
	[108324] = SetReagent(0, e.Herbalism), -- Kingsblood Petal
	[108325] = SetReagent(0, e.Herbalism), -- Liferoot Stem
	[108326] = SetReagent(0, e.Herbalism), -- Khadgar's Whisker Stem
	[108327] = SetReagent(0, e.Herbalism), -- Grave Moss Leaf
	[108328] = SetReagent(0, e.Herbalism), -- Fadeleaf Petal
	[108329] = SetReagent(0, e.Herbalism), -- Dragon's Teeth Stem
	[108330] = SetReagent(0, e.Herbalism), -- Stranglekelp Blade
	[108331] = SetReagent(0, e.Herbalism), -- Goldthorn Bramble
	[108332] = SetReagent(0, e.Herbalism), -- Firebloom Petal
	[108333] = SetReagent(0, e.Herbalism), -- Purple Lotus Petal
	[108335] = SetReagent(0, e.Herbalism), -- Sungrass Stalk
	[108336] = SetReagent(0, e.Herbalism), -- Blindweed Stem
	[108337] = SetReagent(0, e.Herbalism), -- Ghost Mushroom Cap
	[108338] = SetReagent(0, e.Herbalism), -- Gromsblood Leaf
	[108339] = SetReagent(0, e.Herbalism), -- Dreamfoil Blade
	[108340] = SetReagent(0, e.Herbalism), -- Golden Sansam Leaf
	[108341] = SetReagent(0, e.Herbalism), -- Mountain Silversage Stalk
	[108342] = SetReagent(0, e.Herbalism), -- Sorrowmoss Leaf
	[108343] = SetReagent(0, e.Herbalism), -- Icecap Petal
	
	-- 2.0 BC
	[22785] = SetReagent(1, e.Herbalism), -- Felweed
	[22786] = SetReagent(1, e.Herbalism), -- Dreaming Glory
	[22787] = SetReagent(1, e.Herbalism), -- Ragveil
	[22789] = SetReagent(1, e.Herbalism), -- Terocone
	[22790] = SetReagent(1, e.Herbalism), -- Ancient Lichen
	[22791] = SetReagent(1, e.Herbalism), -- Netherbloom
	[22792] = SetReagent(1, e.Herbalism), -- Nightmare Vine
	[22793] = SetReagent(1, e.Herbalism), -- Mana Thistle
	[22794] = SetReagent(1, e.Herbalism), -- Fel Lotus
	[108344] = SetReagent(1, e.Herbalism), -- Felweed Stalk
	[108345] = SetReagent(1, e.Herbalism), -- Dreaming Glory Petal
	[108346] = SetReagent(1, e.Herbalism), -- Ragveil Cap
	[108347] = SetReagent(1, e.Herbalism), -- Terocone Leaf
	[108348] = SetReagent(1, e.Herbalism), -- Ancient Lichen Petal
	[108349] = SetReagent(1, e.Herbalism), -- Netherbloom Leaf
	[108350] = SetReagent(1, e.Herbalism), -- Nightmare Vine Stem
	[108351] = SetReagent(1, e.Herbalism), -- Mana Thistle Leaf
	
	-- 3.0 WotLK
	[36901] = SetReagent(2, e.Herbalism), -- Goldclover
	[36903] = SetReagent(2, e.Herbalism), -- Adder's Tongue
	[36904] = SetReagent(2, e.Herbalism), -- Tiger Lily
	[36905] = SetReagent(2, e.Herbalism), -- Lichbloom
	[36906] = SetReagent(2, e.Herbalism), -- Icethorn
	[36907] = SetReagent(2, e.Herbalism), -- Talandra's Rose
	[36908] = SetReagent(2, e.Herbalism), -- Frost Lotus
	[37921] = SetReagent(2, e.Herbalism), -- Deadnettle
	[39970] = SetReagent(2, e.Herbalism), -- Fire Leaf
	[108352] = SetReagent(2, e.Herbalism), -- Goldclover Leaf
	[108353] = SetReagent(2, e.Herbalism), -- Adder's Tongue Stem
	[108354] = SetReagent(2, e.Herbalism), -- Tiger Lily Petal
	[108355] = SetReagent(2, e.Herbalism), -- Lichbloom Stalk
	[108356] = SetReagent(2, e.Herbalism), -- Icethorn Bramble
	[108357] = SetReagent(2, e.Herbalism), -- Talandra's Rose Petal
	[108359] = SetReagent(2, e.Herbalism), -- Fire Leaf Bramble
	
	-- 4.0 Cataclysm
	[52983] = SetReagent(3, e.Herbalism), -- Cinderbloom
	[52984] = SetReagent(3, e.Herbalism), -- Stormvine
	[52985] = SetReagent(3, e.Herbalism), -- Azshara's Veil
	[52986] = SetReagent(3, e.Herbalism), -- Heartblossom
	[52987] = SetReagent(3, e.Herbalism), -- Twilight Jasmine
	[52988] = SetReagent(3, e.Herbalism), -- Whiptail
	[108360] = SetReagent(3, e.Herbalism), -- Cinderbloom Petal
	[108361] = SetReagent(3, e.Herbalism), -- Stormvine Stalk
	[108362] = SetReagent(3, e.Herbalism), -- Azshara's Veil Stem
	[108363] = SetReagent(3, e.Herbalism), -- Heartblossom Petal
	[108364] = SetReagent(3, e.Herbalism), -- Twilight Jasmine Petal
	[108365] = SetReagent(3, e.Herbalism), -- Whiptail Stem
	
	-- 5.0 Mists of Pandaria
	[72234] = SetReagent(4, e.Herbalism), -- Green Tea Leaf
	[72235] = SetReagent(4, e.Herbalism), -- Silkweed
	[72237] = SetReagent(4, e.Herbalism), -- Rain Poppy
	[72238] = SetReagent(4, e.Herbalism), -- Golden Lotus
	[79010] = SetReagent(4, e.Herbalism), -- Snow Lily
	[79011] = SetReagent(4, e.Herbalism), -- Fool's Cap
	[89639] = SetReagent(4, e.Herbalism), -- Desecrated Herb
	[97619] = SetReagent(4, e.Herbalism), -- Torn Green Tea Leaf
	[97620] = SetReagent(4, e.Herbalism), -- Rain Poppy Petal
	[97621] = SetReagent(4, e.Herbalism), -- Silkweed Stem
	[97622] = SetReagent(4, e.Herbalism), -- Snow Lily Petal
	[97623] = SetReagent(4, e.Herbalism), -- Fool's Cap Spores
	[97624] = SetReagent(4, e.Herbalism), -- Desecrated Herb Pod
	
	-- 6.0 Warlords of Draenor
	[116053] = SetReagent(5, e.Herbalism), -- Draenic Seeds
	[109124] = SetReagent(5, e.Herbalism), -- Frostweed
	[109125] = SetReagent(5, e.Herbalism), -- Fireweed
	[109126] = SetReagent(5, e.Herbalism), -- Gorgrond Flytrap
	[109127] = SetReagent(5, e.Herbalism), -- Starflower
	[109128] = SetReagent(5, e.Herbalism), -- Nagrand Arrowbloom
	[109129] = SetReagent(5, e.Herbalism), -- Talador Orchid
	[109624] = SetReagent(5, e.Herbalism), -- Broken Frostweed Stem
	[109625] = SetReagent(5, e.Herbalism), -- Broken Fireweed Stem
	[109626] = SetReagent(5, e.Herbalism), -- Gorgrond Flytrap Ichor
	[109627] = SetReagent(5, e.Herbalism), -- Starflower Petal
	[109628] = SetReagent(5, e.Herbalism), -- Nagrand Arrowbloom Petal
	[109629] = SetReagent(5, e.Herbalism), -- Talador Orchid Petal
	
	-- 7.0 Legion
	[124101] = SetReagent(6, e.Herbalism), -- Aethril
	[124102] = SetReagent(6, e.Herbalism), -- Dreamleaf
	[124103] = SetReagent(6, e.Herbalism), -- Foxflower
	[128304] = SetReagent(6, e.Herbalism), -- Yseralline Seed
	[124105] = SetReagent(6, e.Herbalism), -- Starlight Rose
	[124106] = SetReagent(6, e.Herbalism), -- Felwort
	[124104] = SetReagent(6, e.Herbalism), -- Fjarnskaggl
	[129284] = SetReagent(6, e.Herbalism), -- Aethril Seed
	[129285] = SetReagent(6, e.Herbalism), -- Dreamleaf Seed
	[129286] = SetReagent(6, e.Herbalism), -- Foxflower Seed
	[129287] = SetReagent(6, e.Herbalism), -- Fjarnskaggl Seed
	[129288] = SetReagent(6, e.Herbalism), -- Starlight Rose Seed
	[129289] = SetReagent(6, e.Herbalism), -- Felwort Seed
	[151565] = SetReagent(6, e.Herbalism), -- Astral Glory
	
	-- 8.0 Battle for Azeroth
	[152505] = SetReagent(7, e.Herbalism), -- Riverbud
	[152506] = SetReagent(7, e.Herbalism), -- Star Moss
	[152507] = SetReagent(7, e.Herbalism), -- Akunda's Bite
	[152508] = SetReagent(7, e.Herbalism), -- Winter's Kiss
	[152509] = SetReagent(7, e.Herbalism), -- Siren's Pollen
	[152510] = SetReagent(7, e.Herbalism), -- Anchor Weed
	[152511] = SetReagent(7, e.Herbalism), -- Sea Stalk
	[168487] = SetReagent(7, e.Herbalism), -- Zin'anthid
	
	-- 9.0 Shadowlands
	[168583] = SetReagent(8, e.Herbalism), -- Widowbloom
	[168586] = SetReagent(8, e.Herbalism), -- Rising Glory
	[168589] = SetReagent(8, e.Herbalism), -- Marrowroot
	[169701] = SetReagent(8, e.Herbalism), -- Death Blossom
	[170554] = SetReagent(8, e.Herbalism), -- Vigil's Torch
	[171315] = SetReagent(8, e.Herbalism), -- Nightshade
	[187699] = SetReagent(8, e.Herbalism), -- First Flower

	-- 10.0 Dragonflight
	[191460] = SetReagent(9, e.Herbalism), -- Hochenblume 1
	[191461] = SetReagent(9, e.Herbalism), -- Hochenblume 2
	[191462] = SetReagent(9, e.Herbalism), -- Hochenblume 3
	[191464] = SetReagent(9, e.Herbalism), -- Saxifrage 1
	[191465] = SetReagent(9, e.Herbalism), -- Saxifrage 2
	[191466] = SetReagent(9, e.Herbalism), -- Saxifrage 3
	[191467] = SetReagent(9, e.Herbalism), -- Bubble Poppy 1
	[191468] = SetReagent(9, e.Herbalism), -- Bubble Poppy 2
	[191469] = SetReagent(9, e.Herbalism), -- Bubble Poppy 3
	[191470] = SetReagent(9, e.Herbalism), -- Writhebark 1
	[191471] = SetReagent(9, e.Herbalism), -- Writhebark 2
	[191472] = SetReagent(9, e.Herbalism), -- Writhebark 3

})