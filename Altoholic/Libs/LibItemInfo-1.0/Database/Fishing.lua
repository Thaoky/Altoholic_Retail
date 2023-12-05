--	*** LibItemInfo ***
-- Written by : Thaoky, EU-Marécages de Zangar
-- March 2021
-- This list was manually curated (source: mostly Wowhead + in-game).
-- Non-commercial use is permitted as long as credits are preserved, and that Blizzard's terms of services are respected.

local lib = LibStub("LibItemInfo-1.0")

local e = lib.Enum.ReagentTypes
local SetReagent = lib.SetReagent

lib:RegisterItems({
	-- https://www.wowhead.com/items/quality:1:2:3:4?filter=166:69:217;2:1:1;0:0:0#items;0+14+18
	
	-- 1.0 Classic
	[2674] = SetReagent(0, e.Fishing), -- Crawler Meat
	[4603] = SetReagent(0, e.Fishing), -- Raw Spotted Yellowtail
	[6289] = SetReagent(0, e.Fishing), -- Raw Longjaw Mud Snapper
	[6291] = SetReagent(0, e.Fishing), -- Raw Brilliant Smallfish
	[6303] = SetReagent(0, e.Fishing), -- Raw Slitherskin Mackerel
	[6308] = SetReagent(0, e.Fishing), -- Raw Bristle Whisker Catfish
	[6317] = SetReagent(0, e.Fishing), -- Raw Loch Frenzy
	[6358] = SetReagent(0, e.Fishing), -- Oily Blackmouth
	[6359] = SetReagent(0, e.Fishing), -- Firefin Snapper
	[6361] = SetReagent(0, e.Fishing), -- Raw Rainbow Fin Albacore
	[6362] = SetReagent(0, e.Fishing), -- Raw Rockscale Cod
	[8365] = SetReagent(0, e.Fishing), -- Raw Mithril Head Trout
	[13422] = SetReagent(0, e.Fishing), -- Stonescale Eel
	[13754] = SetReagent(0, e.Fishing), -- Raw Glossy Mightfish
	[13756] = SetReagent(0, e.Fishing), -- Raw Summer Bass
	[13757] = SetReagent(0, e.Fishing), -- Lightning Eel
	[13758] = SetReagent(0, e.Fishing), -- Raw Redgill
	[13759] = SetReagent(0, e.Fishing), -- Raw Nightfin Snapper
	[13760] = SetReagent(0, e.Fishing), -- Raw Sunscale Salmon
	[13888] = SetReagent(0, e.Fishing), -- Darkclaw Lobster
	[13889] = SetReagent(0, e.Fishing), -- Raw Whitescale Salmon
	[21071] = SetReagent(0, e.Fishing), -- Raw Sagefish
	[21153] = SetReagent(0, e.Fishing), -- Raw Greater Sagefish
	[124669] = SetReagent(0, e.Fishing), -- Darkmoon Daggermaw

	-- 2.0 BC
	[27422] = SetReagent(1, e.Fishing), -- Barbed Gill Trout
	[27425] = SetReagent(1, e.Fishing), -- Spotted Feltail
	[27429] = SetReagent(1, e.Fishing), -- Zangarian Sporefish
	[27435] = SetReagent(1, e.Fishing), -- Figluster's Mudfish
	[27437] = SetReagent(1, e.Fishing), -- Icefin Bluefish
	[27438] = SetReagent(1, e.Fishing), -- Golden Darter
	[27439] = SetReagent(1, e.Fishing), -- Furious Crawdad
	[27515] = SetReagent(1, e.Fishing), -- Huge Spotted Feltail
	[27516] = SetReagent(1, e.Fishing), -- Enormous Barbed Gill Trout
	[33823] = SetReagent(1, e.Fishing), -- Bloodfin Catfish
	[33824] = SetReagent(1, e.Fishing), -- Crescent-Tail Skullfish

	-- 3.0 WotLK
	[38625] = SetReagent(2, e.Fishing), -- Northern Icelip
	[39527] = SetReagent(2, e.Fishing), -- Plated Darkfish
	[40199] = SetReagent(2, e.Fishing), -- Pygmy Suckerfish
	[41800] = SetReagent(2, e.Fishing), -- Deep Sea Monsterbelly
	[41801] = SetReagent(2, e.Fishing), -- Moonglow Cuttlefish
	[41802] = SetReagent(2, e.Fishing), -- Imperial Manta Ray
	[41803] = SetReagent(2, e.Fishing), -- Rockfin Grouper
	[41805] = SetReagent(2, e.Fishing), -- Borean Man O' War
	[41806] = SetReagent(2, e.Fishing), -- Musselback Sculpin
	[41807] = SetReagent(2, e.Fishing), -- Dragonfin Angelfish
	[41808] = SetReagent(2, e.Fishing), -- Bonescale Snapper
	[41809] = SetReagent(2, e.Fishing), -- Glacial Salmon
	[41810] = SetReagent(2, e.Fishing), -- Fangtooth Herring
	[41812] = SetReagent(2, e.Fishing), -- Barrelhead Goby
	[41813] = SetReagent(2, e.Fishing), -- Nettlefish
	[41814] = SetReagent(2, e.Fishing), -- Glassfin Minnow

	-- 4.0 Cataclysm
	[53062] = SetReagent(3, e.Fishing), -- Sharptooth
	[53063] = SetReagent(3, e.Fishing), -- Mountain Trout
	[53064] = SetReagent(3, e.Fishing), -- Highland Guppy
	[53065] = SetReagent(3, e.Fishing), -- Albino Cavefish
	[53066] = SetReagent(3, e.Fishing), -- Blackbelly Mudfish
	[53067] = SetReagent(3, e.Fishing), -- Striped Lurker
	[53068] = SetReagent(3, e.Fishing), -- Lavascale Catfish
	[53069] = SetReagent(3, e.Fishing), -- Murglesnout
	[53070] = SetReagent(3, e.Fishing), -- Fathom Eel
	[53071] = SetReagent(3, e.Fishing), -- Algaefin Rockfish
	[53072] = SetReagent(3, e.Fishing), -- Deepsea Sagefish	
	
	-- 5.0 Mists of Pandaria
	[74856] = SetReagent(4, e.Fishing), -- Jade Lungfish
	[74857] = SetReagent(4, e.Fishing), -- Giant Mantis Shrimp
	[74859] = SetReagent(4, e.Fishing), -- Emperor Salmon
	[74860] = SetReagent(4, e.Fishing), -- Redbelly Mandarin
	[74861] = SetReagent(4, e.Fishing), -- Tiger Gourami
	[74863] = SetReagent(4, e.Fishing), -- Jewel Danio
	[74864] = SetReagent(4, e.Fishing), -- Reef Octopus
	[74865] = SetReagent(4, e.Fishing), -- Krasarang Paddlefish
	[74866] = SetReagent(4, e.Fishing), -- Golden Carp
	[83064] = SetReagent(4, e.Fishing), -- Spinefish
	
	-- 6.0 Warlords of Draenor
	[111589] = SetReagent(5, e.Fishing), -- Small Crescent Saberfish
	[111595] = SetReagent(5, e.Fishing), -- Crescent Saberfish
	[111601] = SetReagent(5, e.Fishing), -- Enormous Crescent Saberfish
	[111650] = SetReagent(5, e.Fishing), -- Small Jawless Skulker
	[111651] = SetReagent(5, e.Fishing), -- Small Fat Sleeper
	[111652] = SetReagent(5, e.Fishing), -- Small Blind Lake Sturgeon
	[111656] = SetReagent(5, e.Fishing), -- Small Fire Ammonite
	[111658] = SetReagent(5, e.Fishing), -- Small Sea Scorpion
	[111659] = SetReagent(5, e.Fishing), -- Small Abyssal Gulper Eel
	[111662] = SetReagent(5, e.Fishing), -- Small Blackwater Whiptail
	[111663] = SetReagent(5, e.Fishing), -- Blackwater Whiptail
	[111664] = SetReagent(5, e.Fishing), -- Abyssal Gulper Eel
	[111665] = SetReagent(5, e.Fishing), -- Sea Scorpion
	[111666] = SetReagent(5, e.Fishing), -- Fire Ammonite
	[111667] = SetReagent(5, e.Fishing), -- Blind Lake Sturgeon
	[111668] = SetReagent(5, e.Fishing), -- Fat Sleeper
	[111669] = SetReagent(5, e.Fishing), -- Jawless Skulker
	[111670] = SetReagent(5, e.Fishing), -- Enormous Blackwater Whiptail
	[111671] = SetReagent(5, e.Fishing), -- Enormous Abyssal Gulper Eel
	[111672] = SetReagent(5, e.Fishing), -- Enormous Sea Scorpion
	[111673] = SetReagent(5, e.Fishing), -- Enormous Fire Ammonite
	[111674] = SetReagent(5, e.Fishing), -- Enormous Blind Lake Sturgeon
	[111675] = SetReagent(5, e.Fishing), -- Enormous Fat Sleeper
	[111676] = SetReagent(5, e.Fishing), -- Enormous Jawless Skulker
		
	-- 7.0 Legion
	[124107] = SetReagent(6, e.Fishing), -- Cursed Queenfish
	[124108] = SetReagent(6, e.Fishing), -- Mossgill Perch
	[124109] = SetReagent(6, e.Fishing), -- Highmountain Salmon
	[124110] = SetReagent(6, e.Fishing), -- Stormray
	[124111] = SetReagent(6, e.Fishing), -- Runescale Koi
	[124112] = SetReagent(6, e.Fishing), -- Black Barracuda
	[133607] = SetReagent(6, e.Fishing), -- Silver Mackerel
	
	-- 8.0 Battle for Azeroth
	[152543] = SetReagent(7, e.Fishing), -- Sand Shifter
	[152544] = SetReagent(7, e.Fishing), -- Slimy Mackerel
	[152545] = SetReagent(7, e.Fishing), -- Frenzied Fangtooth
	[152546] = SetReagent(7, e.Fishing), -- Lane Snapper
	[152547] = SetReagent(7, e.Fishing), -- Great Sea Catfish
	[152548] = SetReagent(7, e.Fishing), -- Tiragarde Perch
	[152549] = SetReagent(7, e.Fishing), -- Redtail Loach
	[162515] = SetReagent(7, e.Fishing), -- Midnight Salmon
	[162516] = SetReagent(7, e.Fishing), -- Rasboralus
	[162517] = SetReagent(7, e.Fishing), -- U'taka
	[167562] = SetReagent(7, e.Fishing), -- Ionized Minnow
	[168262] = SetReagent(7, e.Fishing), -- Sentry Fish
	[168302] = SetReagent(7, e.Fishing), -- Viper Fish
	[168646] = SetReagent(7, e.Fishing), -- Mauve Stinger
	[174327] = SetReagent(7, e.Fishing), -- Malformed Gnasher
	[174328] = SetReagent(7, e.Fishing), -- Aberrant Voidfin
	
	-- 9.0 Shadowlands
	[173032] = SetReagent(8, e.Fishing), -- Lost Sole	
	[173033] = SetReagent(8, e.Fishing), -- Iridescent Amberjack
	[173034] = SetReagent(8, e.Fishing), -- Silvergill Pike
	[173035] = SetReagent(8, e.Fishing), -- Pocked Bonefish
	[173036] = SetReagent(8, e.Fishing), -- Spinefin Piranha
	[173037] = SetReagent(8, e.Fishing), -- Elysian Thade
	[187702] = SetReagent(8, e.Fishing), -- Precursor Placoderm
	
	-- 10.0 Dragonflight
	[194730] = SetReagent(9, e.Fishing), -- Scalebelly Mackerel
	[194970] = SetReagent(9, e.Fishing), -- Islefin Dorado
	[198395] = SetReagent(9, e.Fishing), -- Dull Spined Clam
	[194966] = SetReagent(9, e.Fishing), -- Thousandbite Piranha
	[194967] = SetReagent(9, e.Fishing), -- Aileron Seamoth
	[194968] = SetReagent(9, e.Fishing), -- Cerulean Spinefish
	[194969] = SetReagent(9, e.Fishing), -- Temporal Dragonhead
	[199100] = SetReagent(9, e.Fishing), -- Peppersmelt
	[199205] = SetReagent(9, e.Fishing), -- Manasucker
	[199207] = SetReagent(9, e.Fishing), -- Iceback Sculpin
	[199212] = SetReagent(9, e.Fishing), -- Clubfish
	[199213] = SetReagent(9, e.Fishing), -- Lakkamuk Blenny
	[199344] = SetReagent(9, e.Fishing), -- Magma Thresher
	[199346] = SetReagent(9, e.Fishing), -- Rotten Rimefin Tuna
	[199832] = SetReagent(9, e.Fishing), -- Smoked Seaviper
	[199833] = SetReagent(9, e.Fishing), -- Dragonhead Eel
	[200061] = SetReagent(9, e.Fishing), -- Prismatic Leaper
	[200074] = SetReagent(9, e.Fishing), -- Frosted Rimefin Tuna
})