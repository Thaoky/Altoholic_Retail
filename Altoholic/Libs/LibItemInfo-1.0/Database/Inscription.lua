--	*** LibItemInfo ***
-- Written by : Thaoky, EU-Marécages de Zangar
-- March 2021
-- This list was manually curated (source: mostly Wowhead + in-game).
-- Non-commercial use is permitted as long as credits are preserved, and that Blizzard's terms of services are respected.

local lib = LibStub("LibItemInfo-1.0")

local e = lib.Enum.ReagentTypes
local SetReagent = lib.SetReagent

lib:RegisterItems({
	-- https://www.wowhead.com/items?filter=166:143:217;9:1:1;0:0:0
	
	-- 1.0 Classic
	[39354] = SetReagent(0, e.Inscription), -- Light Parchment
	[39151] = SetReagent(0, e.Inscription), -- Alabaster Pigment
	[39334] = SetReagent(0, e.Inscription), -- Dusky Pigment
	[39338] = SetReagent(0, e.Inscription), -- Golden Pigment
	[39339] = SetReagent(0, e.Inscription), -- Emerald Pigment
	[39340] = SetReagent(0, e.Inscription), -- Violet Pigment
	[39341] = SetReagent(0, e.Inscription), -- Silvery Pigment
	[43103] = SetReagent(0, e.Inscription), -- Verdant Pigment
	[43104] = SetReagent(0, e.Inscription), -- Burnt Pigment
	[43105] = SetReagent(0, e.Inscription), -- Indigo Pigment
	[43106] = SetReagent(0, e.Inscription), -- Ruby Pigment
	[43107] = SetReagent(0, e.Inscription), -- Sapphire Pigment
	
	[39469] = SetReagent(0, e.Inscription, 1), -- Moonglow Ink
	[39774] = SetReagent(0, e.Inscription, 75), -- Midnight Ink
	[43115] = SetReagent(0, e.Inscription, 85), -- Hunter's Ink
	[43116] = SetReagent(0, e.Inscription, 100), -- Lion's Ink
	[43117] = SetReagent(0, e.Inscription, 125), -- Dawnstar Ink
	[43118] = SetReagent(0, e.Inscription, 150), -- Jadefire Ink
	[43119] = SetReagent(0, e.Inscription, 175), -- Royal Ink
	[43120] = SetReagent(0, e.Inscription, 200), -- Celestial Ink
	[43121] = SetReagent(0, e.Inscription, 225), -- Fiery Ink
	[43122] = SetReagent(0, e.Inscription, 250), -- Shimmering Ink
	[43123] = SetReagent(0, e.Inscription, 275), -- Ink of the Sky
	
	[19267] = SetReagent(0, e.Inscription, 275), -- Elementals Deck
	[19289] = SetReagent(0, e.Inscription, 275), -- Darkmoon Card: Maelstrom
	[19268] = SetReagent(0, e.Inscription, 275), -- A of Elementals
	[19269] = SetReagent(0, e.Inscription, 275), -- 2 of Elementals
	[19270] = SetReagent(0, e.Inscription, 275), -- 3 of Elementals
	[19271] = SetReagent(0, e.Inscription, 275), -- 4 of Elementals
	[19272] = SetReagent(0, e.Inscription, 275), -- 5 of Elementals
	[19273] = SetReagent(0, e.Inscription, 275), -- 6 of Elementals
	[19274] = SetReagent(0, e.Inscription, 275), -- 7 of Elementals
	[19275] = SetReagent(0, e.Inscription, 275), -- 8 of Elementals
	
	[19228] = SetReagent(0, e.Inscription, 275), -- Beasts Deck
	[19288] = SetReagent(0, e.Inscription, 275), -- Darkmoon Card: Blue Dragon
	[19227] = SetReagent(0, e.Inscription, 275), -- A of Beasts
	[19230] = SetReagent(0, e.Inscription, 275), -- 2 of Beasts
	[19231] = SetReagent(0, e.Inscription, 275), -- 3 of Beasts
	[19232] = SetReagent(0, e.Inscription, 275), -- 4 of Beasts
	[19233] = SetReagent(0, e.Inscription, 275), -- 5 of Beasts
	[19234] = SetReagent(0, e.Inscription, 275), -- 6 of Beasts
	[19235] = SetReagent(0, e.Inscription, 275), -- 7 of Beasts
	[19236] = SetReagent(0, e.Inscription, 275), -- 8 of Beasts
	
	[19277] = SetReagent(0, e.Inscription, 275), -- Portals Deck
	[19290] = SetReagent(0, e.Inscription, 275), -- Darkmoon Card: Twisting Nether
	[19276] = SetReagent(0, e.Inscription, 275), -- A of Portals
	[19278] = SetReagent(0, e.Inscription, 275), -- 2 of Portals
	[19279] = SetReagent(0, e.Inscription, 275), -- 3 of Portals
	[19280] = SetReagent(0, e.Inscription, 275), -- 4 of Portals
	[19281] = SetReagent(0, e.Inscription, 275), -- 5 of Portals
	[19282] = SetReagent(0, e.Inscription, 275), -- 6 of Portals
	[19283] = SetReagent(0, e.Inscription, 275), -- 7 of Portals
	[19284] = SetReagent(0, e.Inscription, 275), -- 8 of Portals
	
	[19257] = SetReagent(0, e.Inscription, 275), -- Warlords Deck
	[19287] = SetReagent(0, e.Inscription, 275), -- Darkmoon Card: Heroism
	[19258] = SetReagent(0, e.Inscription, 275), -- A of Warlords
	[19259] = SetReagent(0, e.Inscription, 275), -- 2 of Warlords
	[19260] = SetReagent(0, e.Inscription, 275), -- 3 of Warlords
	[19261] = SetReagent(0, e.Inscription, 275), -- 4 of Warlords
	[19262] = SetReagent(0, e.Inscription, 275), -- 5 of Warlords
	[19263] = SetReagent(0, e.Inscription, 275), -- 6 of Warlords
	[19264] = SetReagent(0, e.Inscription, 275), -- 7 of Warlords
	[19265] = SetReagent(0, e.Inscription, 275), -- 8 of Warlords
	
	-- 2.0 BC
	[39342] = SetReagent(1, e.Inscription), -- Nether Pigment
	[43108] = SetReagent(1, e.Inscription), -- Ebon Pigment
	[43124] = SetReagent(1, e.Inscription, 1), -- Ethereal Ink
	[43125] = SetReagent(1, e.Inscription, 25), -- Darkflame Ink
	
	[31890] = SetReagent(1, e.Inscription, 25), -- Blessings Deck
	[31856] = SetReagent(1, e.Inscription, 25), -- Darkmoon Card: Crusade
	[31882] = SetReagent(1, e.Inscription, 25), -- A of Blessings
	[31889] = SetReagent(1, e.Inscription, 25), -- 2 of Blessings
	[31888] = SetReagent(1, e.Inscription, 25), -- 3 of Blessings
	[31885] = SetReagent(1, e.Inscription, 25), -- 4 of Blessings
	[31884] = SetReagent(1, e.Inscription, 25), -- 5 of Blessings
	[31887] = SetReagent(1, e.Inscription, 25), -- 6 of Blessings
	[31886] = SetReagent(1, e.Inscription, 25), -- 7 of Blessings
	[31883] = SetReagent(1, e.Inscription, 25), -- 8 of Blessings
	
	[31907] = SetReagent(1, e.Inscription, 25), -- Furies Deck
	[31858] = SetReagent(1, e.Inscription, 25), -- Darkmoon Card: Vengeance
	[31901] = SetReagent(1, e.Inscription, 25), -- A of Furies
	[31909] = SetReagent(1, e.Inscription, 25), -- 2 of Furies
	[31908] = SetReagent(1, e.Inscription, 25), -- 3 of Furies
	[31904] = SetReagent(1, e.Inscription, 25), -- 4 of Furies
	[31903] = SetReagent(1, e.Inscription, 25), -- 5 of Furies
	[31906] = SetReagent(1, e.Inscription, 25), -- 6 of Furies
	[31905] = SetReagent(1, e.Inscription, 25), -- 7 of Furies
	[31902] = SetReagent(1, e.Inscription, 25), -- 8 of Furies
	
	[31914] = SetReagent(1, e.Inscription, 25), -- Lunacy Deck
	[31859] = SetReagent(1, e.Inscription, 25), -- Darkmoon Card: Madness
	[31910] = SetReagent(1, e.Inscription, 25), -- A of Lunacy
	[31918] = SetReagent(1, e.Inscription, 25), -- 2 of Lunacy
	[31917] = SetReagent(1, e.Inscription, 25), -- 3 of Lunacy
	[31913] = SetReagent(1, e.Inscription, 25), -- 4 of Lunacy
	[31912] = SetReagent(1, e.Inscription, 25), -- 5 of Lunacy
	[31916] = SetReagent(1, e.Inscription, 25), -- 6 of Lunacy
	[31915] = SetReagent(1, e.Inscription, 25), -- 7 of Lunacy
	[31911] = SetReagent(1, e.Inscription, 25), -- 8 of Lunacy
	
	[31891] = SetReagent(1, e.Inscription, 25), -- Storms Deck
	[31857] = SetReagent(1, e.Inscription, 25), -- Darkmoon Card: Wrath
	[31892] = SetReagent(1, e.Inscription, 25), -- A of Storms
	[31900] = SetReagent(1, e.Inscription, 25), -- 2 of Storms
	[31899] = SetReagent(1, e.Inscription, 25), -- 3 of Storms
	[31895] = SetReagent(1, e.Inscription, 25), -- 4 of Storms
	[31894] = SetReagent(1, e.Inscription, 25), -- 5 of Storms
	[31898] = SetReagent(1, e.Inscription, 25), -- 6 of Storms
	[31896] = SetReagent(1, e.Inscription, 25), -- 7 of Storms
	[31893] = SetReagent(1, e.Inscription, 25), -- 8 of Storms
	
	-- 3.0 WotLK
	[39343] = SetReagent(2, e.Inscription), -- Azure Pigment
	[43109] = SetReagent(2, e.Inscription), -- Icy Pigment
	[43126] = SetReagent(2, e.Inscription, 1), -- Ink of the Sea
	[43127] = SetReagent(2, e.Inscription, 1), -- Snowfall Ink

	[37140] = SetReagent(2, e.Inscription), -- A of Rogues
	[37143] = SetReagent(2, e.Inscription), -- 2 of Rogues
	[37156] = SetReagent(2, e.Inscription), -- 3 of Rogues
	
	[37145] = SetReagent(2, e.Inscription), -- A of Swords
	[37147] = SetReagent(2, e.Inscription), -- 2 of Swords
	[37159] = SetReagent(2, e.Inscription), -- 3 of Swords
	[37160] = SetReagent(2, e.Inscription), -- 3 of Swords
	
	[44165] = SetReagent(2, e.Inscription), -- A of Mages
	[44144] = SetReagent(2, e.Inscription), -- 2 of Mages
	[44145] = SetReagent(2, e.Inscription), -- 3 of Mages
	[44146] = SetReagent(2, e.Inscription), -- 4 of Mages
	[44147] = SetReagent(2, e.Inscription), -- 5 of Mages

	[44143] = SetReagent(2, e.Inscription), -- A of Demons
	[44154] = SetReagent(2, e.Inscription), -- 2 of Demons
	[44155] = SetReagent(2, e.Inscription), -- 3 of Demons
	[44156] = SetReagent(2, e.Inscription), -- 4 of Demons
	[44157] = SetReagent(2, e.Inscription), -- 5 of Demons

	[44276] = SetReagent(2, e.Inscription, 25), -- Chaos Deck
	[42989] = SetReagent(2, e.Inscription, 25), -- Darkmoon Card: Berserker
	[44277] = SetReagent(2, e.Inscription, 25), -- A of Chaos
	[44278] = SetReagent(2, e.Inscription, 25), -- 2 of Chaos
	[44279] = SetReagent(2, e.Inscription, 25), -- 3 of Chaos
	[44280] = SetReagent(2, e.Inscription, 25), -- 4 of Chaos
	[44281] = SetReagent(2, e.Inscription, 25), -- 5 of Chaos
	[44282] = SetReagent(2, e.Inscription, 25), -- 6 of Chaos
	[44284] = SetReagent(2, e.Inscription, 25), -- 7 of Chaos
	[44285] = SetReagent(2, e.Inscription, 25), -- 8 of Chaos

	[44294] = SetReagent(2, e.Inscription, 25), -- Undeath Deck
	[42990] = SetReagent(2, e.Inscription, 25), -- Darkmoon Card: Death
	[44286] = SetReagent(2, e.Inscription, 25), -- A of Undeath
	[44287] = SetReagent(2, e.Inscription, 25), -- 2 of Undeath
	[44288] = SetReagent(2, e.Inscription, 25), -- 3 of Undeath
	[44289] = SetReagent(2, e.Inscription, 25), -- 4 of Undeath
	[44290] = SetReagent(2, e.Inscription, 25), -- 5 of Undeath
	[44291] = SetReagent(2, e.Inscription, 25), -- 6 of Undeath
	[44292] = SetReagent(2, e.Inscription, 25), -- 7 of Undeath
	[44293] = SetReagent(2, e.Inscription, 25), -- 8 of Undeath

	[44326] = SetReagent(2, e.Inscription, 25), -- Nobles Deck
	[42987] = SetReagent(2, e.Inscription, 25), -- Darkmoon Card: Greatness
	[44253] = SetReagent(2, e.Inscription, 25), -- Darkmoon Card: Greatness
	[44254] = SetReagent(2, e.Inscription, 25), -- Darkmoon Card: Greatness
	[44255] = SetReagent(2, e.Inscription, 25), -- Darkmoon Card: Greatness
	[44268] = SetReagent(2, e.Inscription, 25), -- A of Nobles
	[44269] = SetReagent(2, e.Inscription, 25), -- 2 of Nobles
	[44270] = SetReagent(2, e.Inscription, 25), -- 3 of Nobles
	[44271] = SetReagent(2, e.Inscription, 25), -- 4 of Nobles
	[44272] = SetReagent(2, e.Inscription, 25), -- 5 of Nobles
	[44273] = SetReagent(2, e.Inscription, 25), -- 6 of Nobles
	[44274] = SetReagent(2, e.Inscription, 25), -- 7 of Nobles
	[44275] = SetReagent(2, e.Inscription, 25), -- 8 of Nobles
	
	[44259] = SetReagent(2, e.Inscription, 25), -- Prisms Deck
	[42988] = SetReagent(2, e.Inscription, 25), -- Darkmoon Card: Illusion
	[44260] = SetReagent(2, e.Inscription, 25), -- A of Prisms
	[44261] = SetReagent(2, e.Inscription, 25), -- 2 of Prisms
	[44262] = SetReagent(2, e.Inscription, 25), -- 3 of Prisms
	[44263] = SetReagent(2, e.Inscription, 25), -- 4 of Prisms
	[44264] = SetReagent(2, e.Inscription, 25), -- 5 of Prisms
	[44265] = SetReagent(2, e.Inscription, 25), -- 6 of Prisms
	[44266] = SetReagent(2, e.Inscription, 25), -- 7 of Prisms
	[44267] = SetReagent(2, e.Inscription, 25), -- 8 of Prisms
	
	-- 4.0 Cataclysm
	[62323] = SetReagent(3, e.Inscription), -- Deathwing Scale Fragment
	[67319] = SetReagent(3, e.Inscription), -- Preserved Ogre Eye
	[68047] = SetReagent(3, e.Inscription), -- Scavenged Dragon Horn
	[67335] = SetReagent(3, e.Inscription), -- Silver Charm Bracelet
	[61979] = SetReagent(3, e.Inscription), -- Ashen Pigment
	[61980] = SetReagent(3, e.Inscription), -- Burning Embers	
	[61978] = SetReagent(3, e.Inscription, 1), -- Blackfallow Ink
	[61981] = SetReagent(3, e.Inscription, 25), -- Inferno Ink
	
	[62044] = SetReagent(3, e.Inscription, 75), -- Tsunami Deck
	[62050] = SetReagent(3, e.Inscription, 75), -- Darkmoon Card: Tsunami
	[62012] = SetReagent(3, e.Inscription, 75), -- A of Waves
	[62013] = SetReagent(3, e.Inscription, 75), -- 2 of Waves
	[62014] = SetReagent(3, e.Inscription, 75), -- 3 of Waves
	[62015] = SetReagent(3, e.Inscription, 75), -- 4 of Waves
	[62016] = SetReagent(3, e.Inscription, 75), -- 5 of Waves
	[62017] = SetReagent(3, e.Inscription, 75), -- 6 of Waves
	[62018] = SetReagent(3, e.Inscription, 75), -- 7 of Waves
	[62019] = SetReagent(3, e.Inscription, 75), -- 8 of Waves
	
	[62045] = SetReagent(3, e.Inscription, 75), -- Hurricane Deck
	[62049] = SetReagent(3, e.Inscription, 75), -- Darkmoon Card: Hurricane
	[62051] = SetReagent(3, e.Inscription, 75), -- Darkmoon Card: Hurricane
	[62004] = SetReagent(3, e.Inscription, 75), -- A of the Winds
	[62005] = SetReagent(3, e.Inscription, 75), -- 2 of the Winds
	[62006] = SetReagent(3, e.Inscription, 75), -- 3 of the Winds
	[62007] = SetReagent(3, e.Inscription, 75), -- 4 of the Winds
	[62008] = SetReagent(3, e.Inscription, 75), -- 5 of the Winds
	[62009] = SetReagent(3, e.Inscription, 75), -- 6 of the Winds
	[62010] = SetReagent(3, e.Inscription, 75), -- 7 of the Winds
	[62011] = SetReagent(3, e.Inscription, 75), -- 8 of the Winds	
	
	[62046] = SetReagent(3, e.Inscription, 75), -- Earthquake Deck
	[62048] = SetReagent(3, e.Inscription, 75), -- Darkmoon Card: Earthquake
	[61996] = SetReagent(3, e.Inscription, 75), -- A of Stones
	[61997] = SetReagent(3, e.Inscription, 75), -- 2 of Stones
	[61998] = SetReagent(3, e.Inscription, 75), -- 3 of Stones
	[61999] = SetReagent(3, e.Inscription, 75), -- 4 of Stones
	[62000] = SetReagent(3, e.Inscription, 75), -- 5 of Stones
	[62001] = SetReagent(3, e.Inscription, 75), -- 6 of Stones
	[62002] = SetReagent(3, e.Inscription, 75), -- 7 of Stones
	[62003] = SetReagent(3, e.Inscription, 75), -- 8 of Stones
	
	[62021] = SetReagent(3, e.Inscription, 75), -- Volcanic Deck
	[62047] = SetReagent(3, e.Inscription, 75), -- Darkmoon Card: Volcano
	[61988] = SetReagent(3, e.Inscription, 75), -- A of Embers
	[61989] = SetReagent(3, e.Inscription, 75), -- 2 of Embers
	[61990] = SetReagent(3, e.Inscription, 75), -- 3 of Embers
	[61991] = SetReagent(3, e.Inscription, 75), -- 4 of Embers
	[61992] = SetReagent(3, e.Inscription, 75), -- 5 of Embers
	[61993] = SetReagent(3, e.Inscription, 75), -- 6 of Embers
	[61994] = SetReagent(3, e.Inscription, 75), -- 7 of Embers
	[61995] = SetReagent(3, e.Inscription, 75), -- 8 of Embers	
	
	-- 5.0 Mists of Pandaria
	[79251] = SetReagent(4, e.Inscription), -- Shadow Pigment
	[79253] = SetReagent(4, e.Inscription), -- Misty Pigment
	[79254] = SetReagent(4, e.Inscription, 1), -- Ink of Dreams
	[79255] = SetReagent(4, e.Inscription, 1), -- Starlight Ink
	
	[79323] = SetReagent(4, e.Inscription, 75), -- Tiger Deck
	[79327] = SetReagent(4, e.Inscription, 75), -- Relic of Xuen
	[79328] = SetReagent(4, e.Inscription, 75), -- Relic of Xuen
	[79283] = SetReagent(4, e.Inscription, 75), -- A of Tigers
	[79284] = SetReagent(4, e.Inscription, 75), -- 2 of Tigers
	[79285] = SetReagent(4, e.Inscription, 75), -- 3 of Tigers
	[79286] = SetReagent(4, e.Inscription, 75), -- 4 of Tigers
	[79287] = SetReagent(4, e.Inscription, 75), -- 5 of Tigers
	[79288] = SetReagent(4, e.Inscription, 75), -- 6 of Tigers
	[79289] = SetReagent(4, e.Inscription, 75), -- 7 of Tigers
	[79290] = SetReagent(4, e.Inscription, 75), -- 8 of Tigers
	
	[79324] = SetReagent(4, e.Inscription, 75), -- Ox Deck
	[79329] = SetReagent(4, e.Inscription, 75), -- Relic of Niuzao
	[79291] = SetReagent(4, e.Inscription, 75), -- A of Oxen
	[79292] = SetReagent(4, e.Inscription, 75), -- 2 of Oxen
	[79293] = SetReagent(4, e.Inscription, 75), -- 3 of Oxen
	[79294] = SetReagent(4, e.Inscription, 75), -- 4 of Oxen
	[79295] = SetReagent(4, e.Inscription, 75), -- 5 of Oxen
	[79296] = SetReagent(4, e.Inscription, 75), -- 6 of Oxen
	[79297] = SetReagent(4, e.Inscription, 75), -- 7 of Oxen
	[79298] = SetReagent(4, e.Inscription, 75), -- 8 of Oxen
	
	[79325] = SetReagent(4, e.Inscription, 75), -- Crane Deck
	[79330] = SetReagent(4, e.Inscription, 75), -- Relic of Chi-Ji
	[79299] = SetReagent(4, e.Inscription, 75), -- A of Cranes
	[79300] = SetReagent(4, e.Inscription, 75), -- 2 of Cranes
	[79301] = SetReagent(4, e.Inscription, 75), -- 3 of Cranes
	[79302] = SetReagent(4, e.Inscription, 75), -- 4 of Cranes
	[79303] = SetReagent(4, e.Inscription, 75), -- 5 of Cranes
	[79304] = SetReagent(4, e.Inscription, 75), -- 6 of Cranes
	[79305] = SetReagent(4, e.Inscription, 75), -- 7 of Cranes
	[79306] = SetReagent(4, e.Inscription, 75), -- 8 of Cranes
	
	[79326] = SetReagent(4, e.Inscription, 75), -- Serpent Deck
	[79331] = SetReagent(4, e.Inscription, 75), -- Relic of Yu'lon
	[79307] = SetReagent(4, e.Inscription, 75), -- A of Serpents
	[79308] = SetReagent(4, e.Inscription, 75), -- 2 of Serpents
	[79309] = SetReagent(4, e.Inscription, 75), -- 3 of Serpents
	[79310] = SetReagent(4, e.Inscription, 75), -- 4 of Serpents
	[79311] = SetReagent(4, e.Inscription, 75), -- 5 of Serpents
	[79312] = SetReagent(4, e.Inscription, 75), -- 6 of Serpents
	[79313] = SetReagent(4, e.Inscription, 75), -- 7 of Serpents
	[79314] = SetReagent(4, e.Inscription, 75), -- 8 of Serpents
	
	-- 6.0 Warlords of Draenor
	[114931] = SetReagent(5, e.Inscription), -- Cerulean Pigment
	[113111] = SetReagent(5, e.Inscription, 1), -- Warbinder's Ink
	[166432] = SetReagent(5, e.Inscription, 100), -- Volatile Crystal
	
	[112303] = SetReagent(5, e.Inscription, 100), -- Iron Deck
	[112319] = SetReagent(5, e.Inscription, 100), -- Knight's Badge
	[112278] = SetReagent(5, e.Inscription, 100), -- A of Iron
	[112277] = SetReagent(5, e.Inscription, 100), -- 2 of Iron
	[112276] = SetReagent(5, e.Inscription, 100), -- 3 of Iron
	[112274] = SetReagent(5, e.Inscription, 100), -- 4 of Iron
	[112275] = SetReagent(5, e.Inscription, 100), -- 5 of Iron
	[112273] = SetReagent(5, e.Inscription, 100), -- 6 of Iron
	[112272] = SetReagent(5, e.Inscription, 100), -- 7 of Iron
	[112271] = SetReagent(5, e.Inscription, 100), -- 8 of Iron
	
	[112304] = SetReagent(5, e.Inscription, 100), -- Moon Deck
	[112320] = SetReagent(5, e.Inscription, 100), -- Sandman's Pouch
	[112302] = SetReagent(5, e.Inscription, 100), -- A of Moon
	[112301] = SetReagent(5, e.Inscription, 100), -- 2 of Moon
	[112300] = SetReagent(5, e.Inscription, 100), -- 3 of Moon
	[112299] = SetReagent(5, e.Inscription, 100), -- 4 of Moon
	[112298] = SetReagent(5, e.Inscription, 100), -- 5 of Moon
	[112297] = SetReagent(5, e.Inscription, 100), -- 6 of Moon
	[112296] = SetReagent(5, e.Inscription, 100), -- 7 of Moon
	[112295] = SetReagent(5, e.Inscription, 100), -- 8 of Moon
	
	[112305] = SetReagent(5, e.Inscription, 100), -- Visions Deck
	[112317] = SetReagent(5, e.Inscription, 100), -- Winged Hourglass
	[112286] = SetReagent(5, e.Inscription, 100), -- A of Visions
	[112285] = SetReagent(5, e.Inscription, 100), -- 2 of Visions
	[112284] = SetReagent(5, e.Inscription, 100), -- 3 of Visions
	[112283] = SetReagent(5, e.Inscription, 100), -- 4 of Visions
	[112282] = SetReagent(5, e.Inscription, 100), -- 5 of Visions
	[112281] = SetReagent(5, e.Inscription, 100), -- 6 of Visions
	[112280] = SetReagent(5, e.Inscription, 100), -- 7 of Visions
	[112279] = SetReagent(5, e.Inscription, 100), -- 8 of Visions
	
	[112306] = SetReagent(5, e.Inscription, 100), -- War Deck
	[112318] = SetReagent(5, e.Inscription, 100), -- Skull of War
	[112294] = SetReagent(5, e.Inscription, 100), -- A of War
	[112293] = SetReagent(5, e.Inscription, 100), -- 2 of War
	[112292] = SetReagent(5, e.Inscription, 100), -- 3 of War
	[112291] = SetReagent(5, e.Inscription, 100), -- 4 of War
	[112290] = SetReagent(5, e.Inscription, 100), -- 5 of War
	[112289] = SetReagent(5, e.Inscription, 100), -- 6 of War
	[112288] = SetReagent(5, e.Inscription, 100), -- 7 of War
	[112287] = SetReagent(5, e.Inscription, 100), -- 8 of War
	
	-- 7.0 Legion
	[129032] = SetReagent(6, e.Inscription), -- Roseate Pigment
	[129034] = SetReagent(6, e.Inscription), -- Sallow Pigment
	
	[128705] = SetReagent(6, e.Inscription, 85), -- Dominion Deck
	[128736] = SetReagent(6, e.Inscription, 85), -- A of Dominion
	[128735] = SetReagent(6, e.Inscription, 85), -- 2 of Dominion
	[128734] = SetReagent(6, e.Inscription, 85), -- 3 of Dominion
	[128733] = SetReagent(6, e.Inscription, 85), -- 4 of Dominion
	[128732] = SetReagent(6, e.Inscription, 85), -- 5 of Dominion
	[128731] = SetReagent(6, e.Inscription, 85), -- 6 of Dominion
	[128730] = SetReagent(6, e.Inscription, 85), -- 7 of Dominion
	[128729] = SetReagent(6, e.Inscription, 85), -- 8 of Dominion

	[128709] = SetReagent(6, e.Inscription, 85), -- Hellfire Deck
	[128744] = SetReagent(6, e.Inscription, 85), -- A of Hellfire
	[128743] = SetReagent(6, e.Inscription, 85), -- 2 of Hellfire
	[128742] = SetReagent(6, e.Inscription, 85), -- 3 of Hellfire
	[128741] = SetReagent(6, e.Inscription, 85), -- 4 of Hellfire
	[128740] = SetReagent(6, e.Inscription, 85), -- 5 of Hellfire
	[128739] = SetReagent(6, e.Inscription, 85), -- 6 of Hellfire
	[128738] = SetReagent(6, e.Inscription, 85), -- 7 of Hellfire
	[128737] = SetReagent(6, e.Inscription, 85), -- 8 of Hellfire	

	[128710] = SetReagent(6, e.Inscription, 85), -- Promises Deck
	[128728] = SetReagent(6, e.Inscription, 85), -- A of Promises
	[128727] = SetReagent(6, e.Inscription, 85), -- 2 of Promises
	[128726] = SetReagent(6, e.Inscription, 85), -- 3 of Promises
	[128725] = SetReagent(6, e.Inscription, 85), -- 4 of Promises
	[128724] = SetReagent(6, e.Inscription, 85), -- 5 of Promises
	[128723] = SetReagent(6, e.Inscription, 85), -- 6 of Promises
	[128722] = SetReagent(6, e.Inscription, 85), -- 7 of Promises
	[128721] = SetReagent(6, e.Inscription, 85), -- 8 of Promises	

	[128711] = SetReagent(6, e.Inscription, 85), -- Immortality Deck
	[128720] = SetReagent(6, e.Inscription, 85), -- A of Immortality
	[128719] = SetReagent(6, e.Inscription, 85), -- 2 of Immortality
	[128718] = SetReagent(6, e.Inscription, 85), -- 3 of Immortality
	[128716] = SetReagent(6, e.Inscription, 85), -- 4 of Immortality
	[128717] = SetReagent(6, e.Inscription, 85), -- 5 of Immortality
	[128715] = SetReagent(6, e.Inscription, 85), -- 6 of Immortality
	[128714] = SetReagent(6, e.Inscription, 85), -- 7 of Immortality
	[128713] = SetReagent(6, e.Inscription, 85), -- 8 of Immortality	
	
	-- 8.0 Battle for Azeroth
	[153635] = SetReagent(7, e.Inscription), -- Ultramarine Pigment
	[153636] = SetReagent(7, e.Inscription), -- Crimson Pigment
	[153669] = SetReagent(7, e.Inscription), -- Viridescent Pigment
	[158186] = SetReagent(7, e.Inscription), -- Distilled Water
	[158187] = SetReagent(7, e.Inscription), -- Ultramarine Ink
	[158188] = SetReagent(7, e.Inscription), -- Crimson Ink
	[158189] = SetReagent(7, e.Inscription), -- Viridescent Ink
	[168662] = SetReagent(7, e.Inscription), -- Maroon Pigment
	[168663] = SetReagent(7, e.Inscription), -- Maroon Ink

	[159125] = SetReagent(7, e.Inscription, 85), -- Fathoms Deck
	[153605] = SetReagent(7, e.Inscription, 85), -- A of Fathoms
	[153621] = SetReagent(7, e.Inscription, 85), -- 2 of Fathoms
	[153622] = SetReagent(7, e.Inscription, 85), -- 3 of Fathoms
	[153623] = SetReagent(7, e.Inscription, 85), -- 4 of Fathoms
	[153624] = SetReagent(7, e.Inscription, 85), -- 5 of Fathoms
	[153625] = SetReagent(7, e.Inscription, 85), -- 6 of Fathoms
	[153626] = SetReagent(7, e.Inscription, 85), -- 7 of Fathoms
	[153627] = SetReagent(7, e.Inscription, 85), -- 8 of Fathoms	

	[159126] = SetReagent(7, e.Inscription, 85), -- Squalls Deck
	[153604] = SetReagent(7, e.Inscription, 85), -- A of Squalls
	[153614] = SetReagent(7, e.Inscription, 85), -- 2 of Squalls
	[153615] = SetReagent(7, e.Inscription, 85), -- 3 of Squalls
	[153616] = SetReagent(7, e.Inscription, 85), -- 4 of Squalls
	[153617] = SetReagent(7, e.Inscription, 85), -- 5 of Squalls
	[153618] = SetReagent(7, e.Inscription, 85), -- 6 of Squalls
	[153619] = SetReagent(7, e.Inscription, 85), -- 7 of Squalls
	[153620] = SetReagent(7, e.Inscription, 85), -- 8 of Squalls

	[159127] = SetReagent(7, e.Inscription, 85), -- Tides Deck
	[153603] = SetReagent(7, e.Inscription, 85), -- A of Tides
	[153607] = SetReagent(7, e.Inscription, 85), -- 2 of Tides
	[153608] = SetReagent(7, e.Inscription, 85), -- 3 of Tides
	[153609] = SetReagent(7, e.Inscription, 85), -- 4 of Tides
	[153610] = SetReagent(7, e.Inscription, 85), -- 5 of Tides
	[153611] = SetReagent(7, e.Inscription, 85), -- 6 of Tides
	[153612] = SetReagent(7, e.Inscription, 85), -- 7 of Tides
	[153613] = SetReagent(7, e.Inscription, 85), -- 8 of Tides
	
	[159128] = SetReagent(7, e.Inscription, 85), -- Blockades Deck
	[153606] = SetReagent(7, e.Inscription, 85), -- A of Blockades
	[153628] = SetReagent(7, e.Inscription, 85), -- 2 of Blockades
	[153629] = SetReagent(7, e.Inscription, 85), -- 3 of Blockades
	[153630] = SetReagent(7, e.Inscription, 85), -- 4 of Blockades
	[153631] = SetReagent(7, e.Inscription, 85), -- 5 of Blockades
	[153632] = SetReagent(7, e.Inscription, 85), -- 6 of Blockades
	[153633] = SetReagent(7, e.Inscription, 85), -- 7 of Blockades
	[153634] = SetReagent(7, e.Inscription, 85), -- 8 of Blockades	
	
	-- 9.0 Shadowlands
	[175886] = SetReagent(8, e.Inscription), -- Dark Parchment
	[173056] = SetReagent(8, e.Inscription), -- Umbral Pigment
	[173057] = SetReagent(8, e.Inscription), -- Luminous Pigment
	[173058] = SetReagent(8, e.Inscription), -- Umbral Ink
	[173059] = SetReagent(8, e.Inscription), -- Luminous Ink
	[175788] = SetReagent(8, e.Inscription), -- Tranquil Pigment
	[175970] = SetReagent(8, e.Inscription, 35), -- Tranquil Ink
	
	[173096] = SetReagent(8, e.Inscription, 80), -- Darkmoon Deck: Indomitable
	[173097] = SetReagent(8, e.Inscription, 80), -- A of the Indomitable 
	[173098] = SetReagent(8, e.Inscription, 80), -- 2 of the Indomitable 
	[173099] = SetReagent(8, e.Inscription, 80), -- 3 of the Indomitable 
	[173100] = SetReagent(8, e.Inscription, 80), -- 4 of the Indomitable 
	[173101] = SetReagent(8, e.Inscription, 80), -- 5 of the Indomitable 
	[173102] = SetReagent(8, e.Inscription, 80), -- 6 of the Indomitable 
	[173103] = SetReagent(8, e.Inscription, 80), -- 7 of the Indomitable 
	[173104] = SetReagent(8, e.Inscription, 80), -- 8 of the Indomitable 
	
	[173069] = SetReagent(8, e.Inscription, 80), -- Darkmoon Deck: Putrescence
	[173070] = SetReagent(8, e.Inscription, 80), -- A of Putrescence 
	[173071] = SetReagent(8, e.Inscription, 80), -- 2 of Putrescence 
	[173072] = SetReagent(8, e.Inscription, 80), -- 3 of Putrescence 
	[173073] = SetReagent(8, e.Inscription, 80), -- 4 of Putrescence 
	[173074] = SetReagent(8, e.Inscription, 80), -- 5 of Putrescence 
	[173075] = SetReagent(8, e.Inscription, 80), -- 6 of Putrescence 
	[173076] = SetReagent(8, e.Inscription, 80), -- 7 of Putrescence 
	[173077] = SetReagent(8, e.Inscription, 80), -- 8 of Putrescence 
	
	[173087] = SetReagent(8, e.Inscription, 80), -- Darkmoon Deck: Voracity
	[173088] = SetReagent(8, e.Inscription, 80), -- A of Voracity 
	[173089] = SetReagent(8, e.Inscription, 80), -- 2 of Voracity 
	[173090] = SetReagent(8, e.Inscription, 80), -- 3 of Voracity 
	[173091] = SetReagent(8, e.Inscription, 80), -- 4 of Voracity 
	[173092] = SetReagent(8, e.Inscription, 80), -- 5 of Voracity 
	[173093] = SetReagent(8, e.Inscription, 80), -- 6 of Voracity 
	[173094] = SetReagent(8, e.Inscription, 80), -- 7 of Voracity 
	[173095] = SetReagent(8, e.Inscription, 80), -- 8 of Voracity 
	
	[173078] = SetReagent(8, e.Inscription, 80), -- Darkmoon Deck: Repose
	[173079] = SetReagent(8, e.Inscription, 80), -- A of Repose
	[173080] = SetReagent(8, e.Inscription, 80), -- 2 of Repose
	[173081] = SetReagent(8, e.Inscription, 80), -- 3 of Repose
	[173082] = SetReagent(8, e.Inscription, 80), -- 4 of Repose
	[173083] = SetReagent(8, e.Inscription, 80), -- 5 of Repose
	[173084] = SetReagent(8, e.Inscription, 80), -- 6 of Repose
	[173085] = SetReagent(8, e.Inscription, 80), -- 7 of Repose
	[173086] = SetReagent(8, e.Inscription, 80), -- 8 of Repose
	
	[173160] = SetReagent(8, e.Inscription, 85), -- Missive of Haste
	[173161] = SetReagent(8, e.Inscription, 85), -- Missive of Critical Strike
	[173162] = SetReagent(8, e.Inscription, 85), -- Missive of Mastery
	[173163] = SetReagent(8, e.Inscription, 85), -- Missive of Versatility
	
	-- 10.0 Dragonflight
	[192894] = SetReagent(9, e.Inscription), -- Blotting Sand 1
	[192895] = SetReagent(9, e.Inscription), -- Blotting Sand 2
	[192896] = SetReagent(9, e.Inscription), -- Blotting Sand 3
	[192897] = SetReagent(9, e.Inscription), -- Pounce 1
	[192898] = SetReagent(9, e.Inscription), -- Pounce 2
	[192899] = SetReagent(9, e.Inscription), -- Pounce 3
	
	[194751] = SetReagent(9, e.Inscription), -- Blazing Ink 1
	[194752] = SetReagent(9, e.Inscription), -- Blazing Ink 2
	[194846] = SetReagent(9, e.Inscription), -- Blazing Ink 3
	[194760] = SetReagent(9, e.Inscription), -- Burnished Ink 1
	[194761] = SetReagent(9, e.Inscription), -- Burnished Ink 2
	[194855] = SetReagent(9, e.Inscription), -- Burnished Ink 3
	[194754] = SetReagent(9, e.Inscription), -- Cosmic Ink 1
	[194755] = SetReagent(9, e.Inscription), -- Cosmic Ink 2
	[194756] = SetReagent(9, e.Inscription), -- Cosmic Ink 3
	[194850] = SetReagent(9, e.Inscription), -- Flourishing Ink 1
	[194758] = SetReagent(9, e.Inscription), -- Flourishing Ink 2
	[194852] = SetReagent(9, e.Inscription), -- Flourishing Ink 3
	[194856] = SetReagent(9, e.Inscription), -- Serene Ink 1
	[194857] = SetReagent(9, e.Inscription), -- Serene Ink 2
	[194858] = SetReagent(9, e.Inscription), -- Serene Ink 3
	[194859] = SetReagent(9, e.Inscription), -- Chilled Rune 1
	[194767] = SetReagent(9, e.Inscription), -- Chilled Rune 2
	[194768] = SetReagent(9, e.Inscription), -- Chilled Rune 3
	[194862] = SetReagent(9, e.Inscription), -- Runed Writhebark 1
	[194863] = SetReagent(9, e.Inscription), -- Runed Writhebark 2
	[194864] = SetReagent(9, e.Inscription), -- Runed Writhebark 3
	[194784] = SetReagent(9, e.Inscription), -- Glittering Parchment
	[198487] = SetReagent(9, e.Inscription), -- Iridescent Water

	[198412] = SetReagent(9, e.Inscription), -- Serene Pigment 1
	[198413] = SetReagent(9, e.Inscription), -- Serene Pigment 2
	[198414] = SetReagent(9, e.Inscription), -- Serene Pigment 3
	[198415] = SetReagent(9, e.Inscription), -- Flourishing Pigment 1
	[198416] = SetReagent(9, e.Inscription), -- Flourishing Pigment 2
	[198417] = SetReagent(9, e.Inscription), -- Flourishing Pigment 3
	[198418] = SetReagent(9, e.Inscription), -- Blazing Pigment 1
	[198419] = SetReagent(9, e.Inscription), -- Blazing Pigment 2
	[198420] = SetReagent(9, e.Inscription), -- Blazing Pigment 3
	[198421] = SetReagent(9, e.Inscription), -- Shimmering Pigment 1
	[198422] = SetReagent(9, e.Inscription), -- Shimmering Pigment 2
	[198423] = SetReagent(9, e.Inscription), -- Shimmering Pigment 3
	
	[194785] = SetReagent(9, e.Inscription), -- A of Fire
	[194786] = SetReagent(9, e.Inscription), -- 2 of Fire
	[194787] = SetReagent(9, e.Inscription), -- 3 of Fire
	[194788] = SetReagent(9, e.Inscription), -- 4 of Fire
	[194789] = SetReagent(9, e.Inscription), -- 5 of Fire
	[194790] = SetReagent(9, e.Inscription), -- 6 of Fire
	[194799] = SetReagent(9, e.Inscription), -- 7 of Fire
	[194792] = SetReagent(9, e.Inscription), -- 8 of Fire
	
	[194793] = SetReagent(9, e.Inscription), -- A of Frost
	[194794] = SetReagent(9, e.Inscription), -- 2 of Frost
	[194795] = SetReagent(9, e.Inscription), -- 3 of Frost
	[194796] = SetReagent(9, e.Inscription), -- 4 of Frost
	[194797] = SetReagent(9, e.Inscription), -- 5 of Frost
	[194798] = SetReagent(9, e.Inscription), -- 6 of Frost
	[194791] = SetReagent(9, e.Inscription), -- 7 of Frost
	[194800] = SetReagent(9, e.Inscription), -- 8 of Frost
	
	[194801] = SetReagent(9, e.Inscription), -- A of Air
	[194802] = SetReagent(9, e.Inscription), -- 2 of Air
	[194803] = SetReagent(9, e.Inscription), -- 3 of Air
	[194804] = SetReagent(9, e.Inscription), -- 4 of Air
	[194805] = SetReagent(9, e.Inscription), -- 5 of Air
	[194806] = SetReagent(9, e.Inscription), -- 6 of Air
	[194807] = SetReagent(9, e.Inscription), -- 7 of Air
	[194808] = SetReagent(9, e.Inscription), -- 8 of Air
	
	[194809] = SetReagent(9, e.Inscription), -- A of Earth
	[194810] = SetReagent(9, e.Inscription), -- 2 of Earth
	[194811] = SetReagent(9, e.Inscription), -- 3 of Earth
	[194812] = SetReagent(9, e.Inscription), -- 4 of Earth
	[194813] = SetReagent(9, e.Inscription), -- 5 of Earth
	[194814] = SetReagent(9, e.Inscription), -- 6 of Earth
	[194815] = SetReagent(9, e.Inscription), -- 7 of Earth
	[194816] = SetReagent(9, e.Inscription), -- 8 of Earth	
})