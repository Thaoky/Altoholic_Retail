local addonName = "Altoholic"
local addon = _G[addonName]

-- *** Difficulties ***
-- source: https://wowpedia.fandom.com/wiki/DifficultyID

local DUNGEON_HEROIC = GetDifficultyInfo(2)
local RAID_10P = GetDifficultyInfo(3)
local RAID_25P = GetDifficultyInfo(4)
local RAID_40P = GetDifficultyInfo(9)
local RAID_10PH = GetDifficultyInfo(5)
local RAID_25PH = GetDifficultyInfo(6)
local RAID_LFR = GetDifficultyInfo(7)
local RAID_FLEX = GetDifficultyInfo(14)
local RAID_HEROIC = GetDifficultyInfo(15)
local RAID_MYTHIC = GetDifficultyInfo(16)
local SCENARIO_HEROIC = GetDifficultyInfo(11)

local dungeons = {
	{	-- [1]
		name = EXPANSION_NAME0,	-- "Classic"
		{	-- [1] 10 player raids
			name = format("%s - %s", RAIDS, RAID_10P),
			{ id = 160, achID = 689 },	-- Ahn'Qiraj Ruins
		},
		{	-- [2] 40 player raids
			name = format("%s - %s", RAIDS, RAID_40P),
			{ id = 48, achID = 686 },	-- Molten Core
			{ id = 50, achID = 685 },	-- Blackwing Lair
			{ id = 161, achID = 687 },	-- Ahn'Qiraj Temple
		},
	},
	{	-- [2]
		name = EXPANSION_NAME1,	-- "The Burning Crusade"
		{	-- [1] heroic dungeons
			name = format("%s - %s", DUNGEONS, DUNGEON_HEROIC),
			{ id = 178, achID = 672 },	-- Auchenai Crypts
			{ id = 179, achID = 671 },	-- Mana-Tombs
			{ id = 180, achID = 674 },	-- Sethekk Halls
			{ id = 181, achID = 675 },	-- Shadow Labyrinth
			{ id = 182, achID = 676 },	-- Opening of the Dark Portal
			{ id = 183, achID = 673 },	-- The Escape From Durnholde
			{ id = 184, achID = 669 },	-- Slave Pens
			{ id = 185, achID = 677 },	-- The Steamvault
			{ id = 186, achID = 670 },	-- Underbog
			{ id = 187, achID = 668 },	-- Blood Furnace
			{ id = 188, achID = 667 },	-- Hellfire Ramparts
			{ id = 189, achID = 678 },	-- Shattered Halls
			{ id = 190, achID = 681 },	-- The Arcatraz
			{ id = 191, achID = 680 },	-- The Botanica
			{ id = 192, achID = 679 },	-- The Mechanar
			{ id = 201, achID = 682 },	-- Magisters' Terrace
		},
		{	-- [2] 10 player raids
			name = format("%s - %s", RAIDS, RAID_10P),
			{ id = 175, achID = 690 },	-- Karazhan
		},
		{	-- [3] 25 player raids
			name = format("%s - %s", RAIDS, RAID_25P),
			{ id = 176, achID = 693 },	-- Magtheridon's Lair
			{ id = 177, achID = 692 },	-- Gruul's Lair
			{ id = 193, achID = 696 },	-- Tempest Keep
			{ id = 194, achID = 694 },	-- Serpentshrine Cavern
			{ id = 195, achID = 695 },	-- Hyjal Past
			{ id = 196, achID = 697 },	-- Black Temple
			{ id = 199, achID = 698 },	-- The Sunwell
		},
	},
	{	-- [3]
		name = EXPANSION_NAME2,	-- "Wrath of the Lich King"
		{	-- [1] heroic dungeons
			name = format("%s - %s", DUNGEONS, DUNGEON_HEROIC),
			{ id = 205, achID = 499 },	--	Utgarde Pinnacle
			{ id = 210, achID = 500 },	--	The Culling of Stratholme
			{ id = 211, achID = 498 },	--	The Oculus
			{ id = 212, achID = 497 },	--	Halls of Lightning
			{ id = 213, achID = 496 },	--	Halls of Stone
			{ id = 215, achID = 493 },	--	Drak'Tharon Keep
			{ id = 217, achID = 495 },	--	Gundrak
			{ id = 219, achID = 492 },	--	Ahn'kahet: The Old Kingdom
			{ id = 221, achID = 494 },	--	Violet Hold
			{ id = 226, achID = 490 },	--	The Nexus
			{ id = 241, achID = 491 },	--	Azjol-Nerub
			{ id = 242, achID = 489 },	--	Utgarde Keep
			{ id = 249, achID = 4298 },	--	Trial of the Champion
			{ id = 252, achID = 4519 },	--	The Forge of Souls
			{ id = 254, achID = 4520 },	--	Pit of Saron
			{ id = 256, achID = 4521 },	--	Halls of Reflection
		},
		{	-- [2] 10 player raids
			name = format("%s - %s", RAIDS, RAID_10P),
			{ id = 46 , achID = 4396 },	--	Onyxia's Lair
			{ id = 159, achID = 576 },	--	Naxxramas
			{ id = 223, achID = 622 },	--	The Eye of Eternity
			{ id = 224, achID = 1876 },	--	The Obsidian Sanctum
			{ id = 239, achID = 4016 },	--	Vault of Archavon
			{ id = 243, achID = 2894 },	--	Ulduar
			{ id = 246, achID = 3917 },	--	Trial of the Crusader
			{ id = 279, achID = 4530 },	--	Icecrown Citadel
			{ id = 293, achID = 4817 },	--	Ruby Sanctum
		},
		{	-- [3] 25 player raids
			name = format("%s - %s", RAIDS, RAID_25P),
			{ id = 227, achID = 577 },	--	Naxxramas
			{ id = 237, achID = 623 },	--	The Eye of Eternity
			{ id = 238, achID = 625 },	--	The Obsidian Sanctum
			{ id = 240, achID = 4017 },	--	Vault of Archavon
			{ id = 244, achID = 2895 },	--	Ulduar
			{ id = 248, achID = 3916 },	--	Trial of the Crusader
			{ id = 257, achID = 4397 },	--	Onyxia's Lair
			{ id = 280, achID = 4597 },	--	Icecrown Citadel
			{ id = 294, achID = 4815 },	--	Ruby Sanctum
		},		
		{	-- [4] 10 player heroic raids
			name = format("%s - %s", RAIDS, RAID_10PH),
			{ id = 247, achID = 3918 },	--	Trial of the Grand Crusader
		},
		{	-- [5] 25 player heroic raids
			name = format("%s - %s", RAIDS, RAID_25PH),
			{ id = 250, achID = 3812 },	--	Trial of the Grand Crusader
		},
	},
	{	-- [4]
		name = EXPANSION_NAME3,	-- "Cataclysm"
		{	-- [1] heroic dungeons
			name = format("%s - %s", DUNGEONS, DUNGEON_HEROIC),
			{ id = 319, achID = 5064 },	--	The Vortex Pinnacle
			{ id = 320, achID = 5063 },	--	The Stonecore
			{ id = 321, achID = 5065 },	--	Halls of Origination
			{ id = 322, achID = 5062 },	--	Grim Batol
			{ id = 323, achID = 5060 },	--	Blackrock Caverns
			{ id = 324, achID = 5061 },	--	Throne of the Tides
			{ id = 325, achID = 5066 },	--	Lost City of the Tol'vir
			{ id = 326, achID = 5083 },	--	Deadmines
			{ id = 327, achID = 5093 },	--	Shadowfang Keep
			{ id = 334, achID = 5768 },	--	Zul'Gurub
			{ id = 340, achID = 5769 },	--	Zul'Aman
			{ id = 435, achID = 6117 },	--	End Time
			{ id = 437, achID = 6118 },	--	Well of Eternity
			{ id = 439, achID = 6119 },	--	Hour of Twilight
		},
		{	-- [2] LFR Raids
			name = format("%s - %s", RAIDS, RAID_LFR),
			{ id = 416, achID = 6107, bosses = 4 },	--	The Siege of Wyrmrest Temple
			{ id = 417, achID = 6107, bosses = 4 },	--	Fall of Deathwing
		},
		{	-- [3] 10 player raids
			name = format("%s - %s", RAIDS, RAID_10P),
			{ id = 313, achID = 4842 },	--	Blackwing Descent
			{ id = 315, achID = 4850 },	--	The Bastion of Twilight
			{ id = 317, achID = 4851 },	--	Throne of the Four Winds
			{ id = 328, achID = 5425 },	--	Baradin Hold
			{ id = 361, achID = 5802 },	--	Firelands
			{ id = 447, achID = 6177 },	--	Dragon Soul
		},
		{	-- [4] 25 player raids
			name = format("%s - %s", RAIDS, RAID_25P),
			{ id = 314, achID = 4842 },	--	Blackwing Descent
			{ id = 316, achID = 4850 },	--	The Bastion of Twilight
			{ id = 318, achID = 4851 },	--	Throne of the Four Winds
			{ id = 329, achID = 5425 },	--	Baradin Hold
			{ id = 362, achID = 5802 },	--	Firelands
			{ id = 448, achID = 6177 },	--	Dragon Soul
		},		
	},
	{	-- [5]
		name = EXPANSION_NAME4,	-- "Mists of Pandaria"
		{	-- [1] heroic dungeons
			name = format("%s - %s", DUNGEONS, DUNGEON_HEROIC),
			{ id = 468, achID = 6758 },	--	Temple of the Jade Serpent
			{ id = 469, achID = 6456 },	--	Stormstout Brewery
			{ id = 470, achID = 6470 },	--	Shado-Pan Monastery
			{ id = 471, achID = 6759 },	--	Gate of the Setting Sun
			{ id = 472, achID = 6762 },	--	Scholomance
			{ id = 473, achID = 6760 },	--	Scarlet Halls
			{ id = 474, achID = 6761 },	--	Scarlet Monastery
			{ id = 519, achID = 6756 },	--	Mogu'shan Palace
			{ id = 554, achID = 6763 },	--	Siege of Niuzao Temple
		},
		{	-- [2] LFR Raids
			name = format("%s - %s", RAIDS, RAID_LFR),
			{ id = 526, achID = 6689, bosses = 4 },	--	Terrace of Endless Spring
			{ id = 527, achID = 6458, bosses = 3 },	--	Guardians of Mogu'shan
			{ id = 528, achID = 6844, bosses = 3 },	--	The Vault of Mysteries
			{ id = 529, achID = 6718, bosses = 3 },	--	The Dread Approach
			{ id = 530, achID = 6845, bosses = 3 },	--	Nightmare of Shek'zeer
			{ id = 610, achID = 8069, bosses = 3 },	--	Last Stand of the Zandalari
			{ id = 611, achID = 8070, bosses = 3 },	--	Forgotten Depths
			{ id = 612, achID = 8071, bosses = 3 },	--	Halls of Flesh-Shaping
			{ id = 613, achID = 8072, bosses = 3 },	--	Pinnacle of Storms
			{ id = 716, achID = 8458, bosses = 4 },	--	Vale of Eternal Sorrows
			{ id = 717, achID = 8459, bosses = 4 },	--	Gates of Retribution
			{ id = 724, achID = 8461, bosses = 3 },	--	The Underhold
			{ id = 725, achID = 8462, bosses = 3 },	--	Downfall
		},
		{	-- [3] heroic scenarios
			name = format("%s - %s", SCENARIOS, SCENARIO_HEROIC),
			{ id = 588, achID = 8364 },	--	Battle on the High Seas
			{ id = 624, achID = 8318 },	--	Dark Heart of Pandaria
			{ id = 625, achID = 8327 },	--	The Secrets of Ragefire
			{ id = 637, achID = 8312 },	--	Blood in the Snow
			{ id = 639, achID = 8310 },	--	A Brewing Storm
			-- { id = 645, achID =  },	--	Greenstone Village
			{ id = 648, achID = 8311 },	--	Crypt of Forgotten Kings
			-- { id = 652, achID =  },	--	Battle on the High Seas
			-- { id = 749, achID =  },	--	Noodle Time
		},
		{	-- [4] 10 player raids
			name = format("%s - %s", RAIDS, RAID_10P),
			{ id = 531, achID = 6844 },	--	Mogu'shan Vaults
			{ id = 533, achID = 6845 },	--	Heart of Fear
			{ id = 535, achID = 6689, bosses = 4 },	--	Terrace of Endless Spring
			{ id = 633, achID = 8072 },	--	Throne of Thunder
			{ id = 714, achID = 8462 },	--	Siege of Orgrimmar
		},
		{	-- [5] 25 player raids
			name = format("%s - %s", RAIDS, RAID_25P),
			{ id = 532, achID = 6844 },	--	Mogu'shan Vaults
			{ id = 534, achID = 6845 },	--	Heart of Fear
			{ id = 536, achID = 6689 },	--	Terrace of Endless Spring
			{ id = 634, achID = 8072 },	--	Throne of Thunder
			{ id = 715, achID = 8462 },	--	Siege of Orgrimmar
			{ id = 767, achID = 8533 },	--	Ordos
			{ id = 768, achID = 8535 },	--	Celestials
		},
	},
	{	-- [6]
		name = EXPANSION_NAME5,	-- "Warlords of Draenor"
		{	-- [1] LFR Raids
			name = format("%s - %s", RAIDS, RAID_LFR),
			{ id = 849, achID = 8986, bosses = 3 },	--	Highmaul 1 : Walled City
			{ id = 850, achID = 8987, bosses = 3 },	--	Highmaul 2 : Arcane Sanctum
			{ id = 851, achID = 8988, bosses = 1 },	--	Highmaul 3 : Imperator's Rise
			{ id = 847, achID = 8989, bosses = 3 },	--	Blackrock Foundry 1 : Slagworks
			{ id = 846, achID = 8990, bosses = 3 },	--	Blackrock Foundry 2 : The Black Forge
			{ id = 848, achID = 8991, bosses = 3 },	--	Blackrock Foundry 3 : Iron Assembly
			{ id = 823, achID = 8992, bosses = 1 },	--	Blackrock Foundry 4 : Blackhand's Crucible
			{ id = 982, achID = 10023, bosses = 3 }, --  Hellfire Citadel 1 : Hellbreach
			{ id = 983, achID = 10024, bosses = 3 }, --  Hellfire Citadel 2 : Halls of Blood
			{ id = 984, achID = 10025, bosses = 3 }, --  Hellfire Citadel 3 : Bastion of Shadows
			{ id = 985, achID = 10026, bosses = 3 }, --  Hellfire Citadel 4 : Destructor's Rise
			{ id = 986, achID = 10027, bosses = 1 }, --  Hellfire Citadel 5 : The Black Gate
		},
	},
	{	-- [7]
		name = EXPANSION_NAME6,	-- "Legion"
		{	-- [1] LFR Raids
			name = format("%s - %s", RAIDS, RAID_LFR),
			{ id = 1925, achID = 10829, bosses = 3 },	--	Nighthold 1 : Arcing Aqueducts
			{ id = 1924, achID = 10837, bosses = 3 },	--	Nighthold 2 : Royal Athenaeum
			{ id = 1923, achID = 10838, bosses = 3 },	--	Nighthold 3 : Nightspire
			{ id = 1922, achID = 10839, bosses = 1 },	--	Nighthold 4 : Betrayer's Rise
			{ id = 1920, achID = 11787, bosses = 3 },	--	Tomb of Sargeras 1 : The Gates of Hell
			{ id = 1919, achID = 11788, bosses = 3 },	--	Tomb of Sargeras 2 : Wailing Halls
			{ id = 1918, achID = 11789, bosses = 2 },	--	Tomb of Sargeras 3 : Chamber of the Avatar
			{ id = 1917, achID = 11790, bosses = 1 },	--	Tomb of Sargeras 4 : Deceiver's Fall
			{ id = 1916, achID = 11988, bosses = 3 },	--	Antorus, the Burning Throne 1 : Light's Breach
			{ id = 1914, achID = 11990, bosses = 3 },	--	Antorus, the Burning Throne 2 : Hope's End
			{ id = 1915, achID = 11989, bosses = 3 },	--	Antorus, the Burning Throne 3 : Forbidden Descent
			{ id = 1913, achID = 11991, bosses = 2 },	--	Antorus, the Burning Throne 4 : Seat of the Pantheon
		},
	},
	{	-- [8]
		name = EXPANSION_NAME7,	-- "Battle for Azeroth"
		{	-- [1] LFR Raids
			name = format("%s - %s", RAIDS, RAID_LFR),
			{ id = 1731, achID = 12521, bosses = 3 },	--	Uldir 1 : Halls of Containment
			{ id = 1732, achID = 12522, bosses = 3 },	--	Uldir 2 : Crimson Descent
			{ id = 1733, achID = 12523, bosses = 2 },	--	Uldir 3 : Heart of Corruption
			{ id = 1945, achID = 13286, bosses = 3 },	--	Battle of Dazar'alor 1 : Siege of Dazar'alor (A)
			{ id = 1946, achID = 13287, bosses = 3 },	--	Battle of Dazar'alor 2 : Empire's Fall (A)
			{ id = 1947, achID = 13288, bosses = 3 },	--	Battle of Dazar'alor 3 : Might of the Alliance (A)
			{ id = 1948, achID = 13289, bosses = 3 },	--	Battle of Dazar'alor 1 : Defense of Dazar'alor (H)
			{ id = 1949, achID = 13290, bosses = 3 },	--	Battle of Dazar'alor 2 : Death's Bargain (H)
			{ id = 1950, achID = 13291, bosses = 3 },	--	Battle of Dazar'alor 3 : Victory or Death (H)
			
			{ id = 1951, achID = 13414, bosses = 2 },	--	Crucible of Storms
			{ id = 2009, achID = 13718, bosses = 3 },	--	The Eternal Palace 1 : The Grand Reception
			{ id = 2010, achID = 13719, bosses = 3 },	--	The Eternal Palace 2 : Depths of the Devoted
			{ id = 2011, achID = 13725, bosses = 2 },	--	The Eternal Palace 3 : The Circle of Stars
			{ id = 2036, achID = 14193, bosses = 3 },	--	Ny'alotha, the Waking City 1 : Vision of Destiny
			{ id = 2037, achID = 14194, bosses = 4 },	--	Ny'alotha, the Waking City 2 : Halls of Devotion
			{ id = 2038, achID = 14195, bosses = 3 },	--	Ny'alotha, the Waking City 3 : Gift of Flesh
			{ id = 2039, achID = 14196, bosses = 2 },	--	Ny'alotha, the Waking City 4 : The Waking Dream
		},
	},
	{	-- [9]
		name = EXPANSION_NAME8,	-- "Shadowlands"
		{	-- [1] LFR Raids
			name = format("%s - %s", RAIDS, RAID_LFR),
			{ id = 2090, achID = 14715, bosses = 3 },	--	Castle Nathria 1 : The Leeching Vaults
			{ id = 2091, achID = 14715, bosses = 3 },	--	Castle Nathria 2 : Reliquary of Opulence
			{ id = 2092, achID = 14715, bosses = 3 },	--	Castle Nathria 3 : Blood from Stone
			{ id = 2096, achID = 14715, bosses = 1 },	--	Castle Nathria 4 : An Audience with Arrogance
			{ id = 2221, achID = 15122, bosses = 3 },	--	Sanctum of Domination 1 : The Jailer's Vanguard
			{ id = 2222, achID = 15123, bosses = 3 },	--	Sanctum of Domination 2 : The Dark Bastille
			{ id = 2223, achID = 15124, bosses = 3 },	--	Sanctum of Domination 3 : Shackles of Fate
			{ id = 2224, achID = 15125, bosses = 1 },	--	Sanctum of Domination 4 : The Reckoning
		},
	},
	{ -- [10]
		name = EXPANSION_NAME9, -- "Dragonflight"
		{ -- [1] LFR Raids
			name = format("%s - %s", RAIDS, RAID_LFR),
			{ id = 2370, achID = 16343, bosses = 3 }, --	Vault of the Incarnates 1 : The Primal Bulwark
			{ id = 2371, achID = 16343, bosses = 3 }, --	Vault of the Incarnates 2 : Caverns of Infusion
			{ id = 2372, achID = 16343, bosses = 2 }, --	Vault of the Incarnates 3 : Fury of the Storm
		},
	},
}

addon:Service("AltoholicUI.DungeonsLists",  function() 

	return {
		GetNumExpansions = function()
			return #dungeons
		end,
		GetExpansionName = function(xPackIndex)
			if dungeons[xPackIndex] then 
				return dungeons[xPackIndex].name
			end
		end,
		
		GetNumDifficulties = function(xPackIndex)
			return (dungeons[xPackIndex]) and #dungeons[xPackIndex] or 0
		end,
		GetDifficultyName = function(xPackIndex, difficultyIndex)
			if dungeons[xPackIndex] and dungeons[xPackIndex][difficultyIndex] then
				return dungeons[xPackIndex][difficultyIndex].name
			end
		end,
	
		GetRaids = function(xPackIndex, difficultyIndex)
			if dungeons[xPackIndex] and dungeons[xPackIndex][difficultyIndex] then
				return dungeons[xPackIndex][difficultyIndex]
			end			
		end,
	
}end)