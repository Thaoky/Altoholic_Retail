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
	-- https://www.wowhead.com/items?filter=166:88:217;5:1:1;0:0:0

	-- 1.0 Classic
	[774] = SetReagent(0, e.Jewelcrafting), -- Malachite
	[818] = SetReagent(0, e.Jewelcrafting), -- Tigerseye
	[1206] = SetReagent(0, e.Jewelcrafting), -- Moss Agate
	[1210] = SetReagent(0, e.Jewelcrafting), -- Shadowgem
	[1529] = SetReagent(0, e.Jewelcrafting), -- Jade
	[1705] = SetReagent(0, e.Jewelcrafting), -- Lesser Moonstone
	[3864] = SetReagent(0, e.Jewelcrafting), -- Citrine
	[7909] = SetReagent(0, e.Jewelcrafting), -- Aquamarine
	[7910] = SetReagent(0, e.Jewelcrafting), -- Star Ruby
	[12361] = SetReagent(0, e.Jewelcrafting), -- Blue Sapphire
	[12363] = SetReagent(0, e.Jewelcrafting), -- Arcane Crystal
	[12364] = SetReagent(0, e.Jewelcrafting), -- Huge Emerald
	[12799] = SetReagent(0, e.Jewelcrafting), -- Large Opal
	[12800] = SetReagent(0, e.Jewelcrafting), -- Azerothian Diamond
	
	[20816] = SetReagent(0, e.Jewelcrafting, 1), -- Delicate Copper Wire
	[20817] = SetReagent(0, e.Jewelcrafting, 50), -- Bronze Setting
	[20963] = SetReagent(0, e.Jewelcrafting, 150), -- Mithril Filigree
	[21752] = SetReagent(0, e.Jewelcrafting, 225), -- Thorium Setting
	
	-- 2.0 BC
	[21929] = SetReagent(1, e.Jewelcrafting), -- Flame Spessarite
	[23077] = SetReagent(1, e.Jewelcrafting), -- Blood Garnet
	[23079] = SetReagent(1, e.Jewelcrafting), -- Deep Peridot
	[23107] = SetReagent(1, e.Jewelcrafting), -- Shadow Draenite
	[23112] = SetReagent(1, e.Jewelcrafting), -- Golden Draenite
	[23117] = SetReagent(1, e.Jewelcrafting), -- Azure Moonstone
	[23436] = SetReagent(1, e.Jewelcrafting), -- Living Ruby
	[23437] = SetReagent(1, e.Jewelcrafting), -- Talasite
	[23438] = SetReagent(1, e.Jewelcrafting), -- Star of Elune
	[23439] = SetReagent(1, e.Jewelcrafting), -- Noble Topaz
	[23440] = SetReagent(1, e.Jewelcrafting), -- Dawnstone
	[23441] = SetReagent(1, e.Jewelcrafting), -- Nightseye
	[24243] = SetReagent(1, e.Jewelcrafting), -- Adamantite Powder
	[24479] = SetReagent(1, e.Jewelcrafting), -- Shadow Pearl
	[32227] = SetReagent(1, e.Jewelcrafting), -- Crimson Spinel
	[32228] = SetReagent(1, e.Jewelcrafting), -- Empyrean Sapphire
	[32229] = SetReagent(1, e.Jewelcrafting), -- Lionseye
	[32230] = SetReagent(1, e.Jewelcrafting), -- Shadowsong Amethyst
	[32231] = SetReagent(1, e.Jewelcrafting), -- Pyrestone
	[32249] = SetReagent(1, e.Jewelcrafting), -- Seaspray Emerald
	
	[31079] = SetReagent(1, e.Jewelcrafting, 25), -- Mercurial Adamantite
	
	-- 3.0 WotLK
	[36783] = SetReagent(2, e.Jewelcrafting), -- Northsea Pearl
	[36917] = SetReagent(2, e.Jewelcrafting), -- Bloodstone
	[36918] = SetReagent(2, e.Jewelcrafting), -- Scarlet Ruby
	[36920] = SetReagent(2, e.Jewelcrafting), -- Sun Crystal
	[36921] = SetReagent(2, e.Jewelcrafting), -- Autumn's Glow
	[36923] = SetReagent(2, e.Jewelcrafting), -- Chalcedony
	[36924] = SetReagent(2, e.Jewelcrafting), -- Sky Sapphire
	[36926] = SetReagent(2, e.Jewelcrafting), -- Shadow Crystal
	[36927] = SetReagent(2, e.Jewelcrafting), -- Twilight Opal
	[36929] = SetReagent(2, e.Jewelcrafting), -- Huge Citrine
	[36930] = SetReagent(2, e.Jewelcrafting), -- Monarch Topaz
	[36932] = SetReagent(2, e.Jewelcrafting), -- Dark Jade
	[36933] = SetReagent(2, e.Jewelcrafting), -- Forest Emerald
	[42225] = SetReagent(2, e.Jewelcrafting), -- Dragon's Eye
	
	-- 4.0 Cataclysm
	[52177] = SetReagent(3, e.Jewelcrafting), -- Carnelian
	[52178] = SetReagent(3, e.Jewelcrafting), -- Zephyrite
	[52179] = SetReagent(3, e.Jewelcrafting), -- Alicite
	[52180] = SetReagent(3, e.Jewelcrafting), -- Nightstone
	[52181] = SetReagent(3, e.Jewelcrafting), -- Hessonite
	[52182] = SetReagent(3, e.Jewelcrafting), -- Jasper
	[52188] = SetReagent(3, e.Jewelcrafting), -- Jeweler's Setting
	[52196] = SetReagent(3, e.Jewelcrafting), -- Chimera's Eye
	
	[71805] = SetReagent(3, e.Jewelcrafting), -- Queen's Garnet
	[71806] = SetReagent(3, e.Jewelcrafting), -- Lightstone
	[71807] = SetReagent(3, e.Jewelcrafting), -- Deepholm Iolite
	[71808] = SetReagent(3, e.Jewelcrafting), -- Lava Coral
	[71809] = SetReagent(3, e.Jewelcrafting), -- Shadow Spinel
	[71810] = SetReagent(3, e.Jewelcrafting), -- Elven Peridot
	
	-- 5.0 Mists of Pandaria
	[76130] = SetReagent(4, e.Jewelcrafting), -- Tiger Opal
	[76132] = SetReagent(4, e.Jewelcrafting), -- Primal Diamond
	[76133] = SetReagent(4, e.Jewelcrafting), -- Lapis Lazuli
	[76134] = SetReagent(4, e.Jewelcrafting), -- Sunstone
	[76135] = SetReagent(4, e.Jewelcrafting), -- Roguestone
	[76136] = SetReagent(4, e.Jewelcrafting), -- Pandarian Garnet
	[76137] = SetReagent(4, e.Jewelcrafting), -- Alexandrite
	[76734] = SetReagent(4, e.Jewelcrafting), -- Serpent's Eye
	[90407] = SetReagent(4, e.Jewelcrafting), -- Sparkling Shard	
	
	-- 6.0 Warlords of Draenor
	-- WoD did jewelcrafting differently ..
	[115524] = SetReagent(5, e.Jewelcrafting), -- Taladite Crystal
	
	-- 7.0 Legion
	[129100] = SetReagent(6, e.Jewelcrafting), -- Gem Chip
	[130172] = SetReagent(6, e.Jewelcrafting), -- Sangrite
	[130173] = SetReagent(6, e.Jewelcrafting), -- Deep Amber
	[130174] = SetReagent(6, e.Jewelcrafting), -- Azsunite
	[130175] = SetReagent(6, e.Jewelcrafting), -- Chaotic Spinel
	[130176] = SetReagent(6, e.Jewelcrafting), -- Skystone
	[130177] = SetReagent(6, e.Jewelcrafting), -- Queen's Opal
	[130178] = SetReagent(6, e.Jewelcrafting), -- Furystone
	[130179] = SetReagent(6, e.Jewelcrafting), -- Eye of Prophecy
	[130180] = SetReagent(6, e.Jewelcrafting), -- Dawnlight
	[130181] = SetReagent(6, e.Jewelcrafting), -- Pandemonite
	[130182] = SetReagent(6, e.Jewelcrafting), -- Maelstrom Sapphire
	[130183] = SetReagent(6, e.Jewelcrafting), -- Shadowruby
	[130245] = SetReagent(6, e.Jewelcrafting), -- Saber's Eye
	[151579] = SetReagent(6, e.Jewelcrafting), -- Labradorite
	[151718] = SetReagent(6, e.Jewelcrafting), -- Argulite
	[151719] = SetReagent(6, e.Jewelcrafting), -- Lightsphene
	[151720] = SetReagent(6, e.Jewelcrafting), -- Chemirine
	[151721] = SetReagent(6, e.Jewelcrafting), -- Hesselian
	[151722] = SetReagent(6, e.Jewelcrafting), -- Florid Malachite
	
	-- 8.0 Battle for Azeroth
	[153700] = SetReagent(7, e.Jewelcrafting), -- Golden Beryl
	[153701] = SetReagent(7, e.Jewelcrafting), -- Rubellite
	[153702] = SetReagent(7, e.Jewelcrafting), -- Kubiline
	[153703] = SetReagent(7, e.Jewelcrafting), -- Solstone
	[153704] = SetReagent(7, e.Jewelcrafting), -- Viridium
	[153705] = SetReagent(7, e.Jewelcrafting), -- Kyanite
	[153706] = SetReagent(7, e.Jewelcrafting), -- Kraken's Eye
	[154120] = SetReagent(7, e.Jewelcrafting), -- Owlseye
	[154121] = SetReagent(7, e.Jewelcrafting), -- Scarlet Diamond
	[154122] = SetReagent(7, e.Jewelcrafting), -- Tidal Amethyst
	[154123] = SetReagent(7, e.Jewelcrafting), -- Amberblaze
	[154124] = SetReagent(7, e.Jewelcrafting), -- Laribole
	[154125] = SetReagent(7, e.Jewelcrafting), -- Royal Quartz
	[168635] = SetReagent(7, e.Jewelcrafting), -- Leviathan's Eye
	[168188] = SetReagent(7, e.Jewelcrafting), -- Sage Agate
	[168189] = SetReagent(7, e.Jewelcrafting), -- Dark Opal
	[168190] = SetReagent(7, e.Jewelcrafting), -- Lava Lazuli
	[168191] = SetReagent(7, e.Jewelcrafting), -- Sea Currant
	[168192] = SetReagent(7, e.Jewelcrafting), -- Sand Spinel
	[168193] = SetReagent(7, e.Jewelcrafting), -- Azsharine
	
	-- 9.0 Shadowlands
	[173108] = SetReagent(8, e.Jewelcrafting), -- Oriblase
	[173109] = SetReagent(8, e.Jewelcrafting), -- Angerseye
	[173110] = SetReagent(8, e.Jewelcrafting), -- Umbryl
	[173168] = SetReagent(8, e.Jewelcrafting), -- Laestrite Setting
	[173170] = SetReagent(8, e.Jewelcrafting), -- Essence of Rebirth
	[173171] = SetReagent(8, e.Jewelcrafting), -- Essence of Torment
	[173172] = SetReagent(8, e.Jewelcrafting), -- Essence of Servitude
	[173173] = SetReagent(8, e.Jewelcrafting), -- Essence of Valor
	
	-- 10.0 Dragonflight
	[200860] = SetReagent(9, e.Jewelcrafting), -- Draconic Stopper
	[192833] = SetReagent(9, e.Jewelcrafting), -- Misshapen Filigree
	[192872] = SetReagent(9, e.Jewelcrafting), -- Fractured Glass
	[198397] = SetReagent(9, e.Jewelcrafting), -- Rainbow Pearl
	[200863] = SetReagent(9, e.Jewelcrafting), -- Glimmering Nozdorite Cluster
	[200864] = SetReagent(9, e.Jewelcrafting), -- Glimmering Alexstraszite Cluster
	[200865] = SetReagent(9, e.Jewelcrafting), -- Glimmering Ysemerald Cluster
	[200866] = SetReagent(9, e.Jewelcrafting), -- Glimmering Malygite Cluster
	[200867] = SetReagent(9, e.Jewelcrafting), -- Glimmering Neltharite Cluster
	
	[193950] = SetReagent(9, e.Jewelcrafting), -- Abrasive Polishing Cloth 1
	[193951] = SetReagent(9, e.Jewelcrafting), -- Abrasive Polishing Cloth 2
	[193952] = SetReagent(9, e.Jewelcrafting), -- Abrasive Polishing Cloth 3
	[193953] = SetReagent(9, e.Jewelcrafting), -- Vibrant Polishing Cloth 1
	[193954] = SetReagent(9, e.Jewelcrafting), -- Vibrant Polishing Cloth 2
	[193955] = SetReagent(9, e.Jewelcrafting), -- Vibrant Polishing Cloth 3
	
	[192852] = SetReagent(9, e.Jewelcrafting), -- Alexstraszite 1
	[192853] = SetReagent(9, e.Jewelcrafting), -- Alexstraszite 2
	[192855] = SetReagent(9, e.Jewelcrafting), -- Alexstraszite 3
	[192889] = SetReagent(9, e.Jewelcrafting), -- Dreamer's Vision 1
	[202049] = SetReagent(9, e.Jewelcrafting), -- Dreamer's Vision 2
	[202055] = SetReagent(9, e.Jewelcrafting), -- Dreamer's Vision 3
	[192891] = SetReagent(9, e.Jewelcrafting), -- Earthwarden's Prize 1
	[202051] = SetReagent(9, e.Jewelcrafting), -- Earthwarden's Prize 2
	[202057] = SetReagent(9, e.Jewelcrafting), -- Earthwarden's Prize 3
	[192849] = SetReagent(9, e.Jewelcrafting), -- Eternity Ember 1
	[192850] = SetReagent(9, e.Jewelcrafting), -- Eternity Ember 2
	[192851] = SetReagent(9, e.Jewelcrafting), -- Eternity Ember 3
	[192876] = SetReagent(9, e.Jewelcrafting), -- Frameless Lens 1
	[192877] = SetReagent(9, e.Jewelcrafting), -- Frameless Lens 2
	[192878] = SetReagent(9, e.Jewelcrafting), -- Frameless Lens 3
	[192883] = SetReagent(9, e.Jewelcrafting), -- Glossy Stone 1
	[192884] = SetReagent(9, e.Jewelcrafting), -- Glossy Stone 2
	[192885] = SetReagent(9, e.Jewelcrafting), -- Glossy Stone 3
	[192869] = SetReagent(9, e.Jewelcrafting), -- Illimited Diamond 1
	[192870] = SetReagent(9, e.Jewelcrafting), -- Illimited Diamond 2
	[192871] = SetReagent(9, e.Jewelcrafting), -- Illimited Diamond 3
	[192893] = SetReagent(9, e.Jewelcrafting), -- Jeweled Dragon's Heart 1
	[202053] = SetReagent(9, e.Jewelcrafting), -- Jeweled Dragon's Heart 2
	[202059] = SetReagent(9, e.Jewelcrafting), -- Jeweled Dragon's Heart 3
	[192890] = SetReagent(9, e.Jewelcrafting), -- Keeper's Glory 1
	[202050] = SetReagent(9, e.Jewelcrafting), -- Keeper's Glory 2
	[202056] = SetReagent(9, e.Jewelcrafting), -- Keeper's Glory 3
	[192856] = SetReagent(9, e.Jewelcrafting), -- Malygite 1
	[192857] = SetReagent(9, e.Jewelcrafting), -- Malygite 2
	[192858] = SetReagent(9, e.Jewelcrafting), -- Malygite 3
	[192840] = SetReagent(9, e.Jewelcrafting), -- Mystic Sapphire 1
	[192841] = SetReagent(9, e.Jewelcrafting), -- Mystic Sapphire 2
	[192842] = SetReagent(9, e.Jewelcrafting), -- Mystic Sapphire 3
	[192862] = SetReagent(9, e.Jewelcrafting), -- Neltharite 1
	[192863] = SetReagent(9, e.Jewelcrafting), -- Neltharite 2
	[192865] = SetReagent(9, e.Jewelcrafting), -- Neltharite 3
	[192866] = SetReagent(9, e.Jewelcrafting), -- Nozdorite 1
	[192867] = SetReagent(9, e.Jewelcrafting), -- Nozdorite 2
	[192868] = SetReagent(9, e.Jewelcrafting), -- Nozdorite 3
	[193029] = SetReagent(9, e.Jewelcrafting), -- Projection Prism 1
	[193030] = SetReagent(9, e.Jewelcrafting), -- Projection Prism 2
	[193031] = SetReagent(9, e.Jewelcrafting), -- Projection Prism 3
	[192888] = SetReagent(9, e.Jewelcrafting), -- Queen's Gift 1
	[202048] = SetReagent(9, e.Jewelcrafting), -- Queen's Gift 2
	[202054] = SetReagent(9, e.Jewelcrafting), -- Queen's Gift 3
	[192837] = SetReagent(9, e.Jewelcrafting), -- Queen's Ruby 1
	[192838] = SetReagent(9, e.Jewelcrafting), -- Queen's Ruby 2
	[192839] = SetReagent(9, e.Jewelcrafting), -- Queen's Ruby 3
	[192834] = SetReagent(9, e.Jewelcrafting), -- Shimmering Clasp 1
	[192835] = SetReagent(9, e.Jewelcrafting), -- Shimmering Clasp 2
	[192836] = SetReagent(9, e.Jewelcrafting), -- Shimmering Clasp 3
	[193368] = SetReagent(9, e.Jewelcrafting), -- Silken Gemdust 1
	[193369] = SetReagent(9, e.Jewelcrafting), -- Silken Gemdust 2
	[193370] = SetReagent(9, e.Jewelcrafting), -- Silken Gemdust 3
	[192846] = SetReagent(9, e.Jewelcrafting), -- Sundered Onyx 1
	[192847] = SetReagent(9, e.Jewelcrafting), -- Sundered Onyx 2
	[192848] = SetReagent(9, e.Jewelcrafting), -- Sundered Onyx 3
	[192892] = SetReagent(9, e.Jewelcrafting), -- Timewatcher's Patience 1
	[202052] = SetReagent(9, e.Jewelcrafting), -- Timewatcher's Patience 2
	[202058] = SetReagent(9, e.Jewelcrafting), -- Timewatcher's Patience 3
	[192843] = SetReagent(9, e.Jewelcrafting), -- Vibrant Emerald 1
	[192844] = SetReagent(9, e.Jewelcrafting), -- Vibrant Emerald 2
	[192845] = SetReagent(9, e.Jewelcrafting), -- Vibrant Emerald 3
	[192859] = SetReagent(9, e.Jewelcrafting), -- Ysemerald 1
	[192860] = SetReagent(9, e.Jewelcrafting), -- Ysemerald 2
	[192861] = SetReagent(9, e.Jewelcrafting), -- Ysemerald 3
	
	-- 11.0 The War Within
	[212498] = SetReagent(10, e.Jewelcrafting), -- Ambivalent Amber
	[212514] = SetReagent(10, e.Jewelcrafting), -- Blasphemite
	[212505] = SetReagent(10, e.Jewelcrafting), -- Extravagant Emerald
	[213399] = SetReagent(10, e.Jewelcrafting), -- Glittering Glass
	[213398] = SetReagent(10, e.Jewelcrafting), -- Handful of Pebbles
	[212511] = SetReagent(10, e.Jewelcrafting), -- Ostentatious Onyx
	[212495] = SetReagent(10, e.Jewelcrafting), -- Radiant Ruby
	[212508] = SetReagent(10, e.Jewelcrafting), -- Stunning Sapphire
	[215236] = SetReagent(10, e.Jewelcrafting), -- Vicious Bloodstone
	
	[213219] = SetReagent(10, e.Jewelcrafting), -- Crushed Gemstones 1
	[213220] = SetReagent(10, e.Jewelcrafting), -- Crushed Gemstones 2
	[213221] = SetReagent(10, e.Jewelcrafting), -- Crushed Gemstones 3
	[213753] = SetReagent(10, e.Jewelcrafting), -- Decorative Lens 1
	[213754] = SetReagent(10, e.Jewelcrafting), -- Decorative Lens 2
	[213755] = SetReagent(10, e.Jewelcrafting), -- Decorative Lens 3
	[213750] = SetReagent(10, e.Jewelcrafting), -- Engraved Gemcutter 1
	[213751] = SetReagent(10, e.Jewelcrafting), -- Engraved Gemcutter 2
	[213752] = SetReagent(10, e.Jewelcrafting), -- Engraved Gemcutter 3
	[213759] = SetReagent(10, e.Jewelcrafting), -- Inverted Prism 1
	[213760] = SetReagent(10, e.Jewelcrafting), -- Inverted Prism 2
	[213761] = SetReagent(10, e.Jewelcrafting), -- Inverted Prism 3
	[213756] = SetReagent(10, e.Jewelcrafting), -- Marbled Stone 1
	[213757] = SetReagent(10, e.Jewelcrafting), -- Marbled Stone 2
	[213758] = SetReagent(10, e.Jewelcrafting), -- Marbled Stone 3
	
})