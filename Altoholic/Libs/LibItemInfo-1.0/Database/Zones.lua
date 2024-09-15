--	*** LibItemInfo ***
-- Written by : Thaoky, EU-Marécages de Zangar
-- March 2021
-- This list was manually curated (source: mostly Wowhead + in-game).
-- Non-commercial use is permitted as long as credits are preserved, and that Blizzard's terms of services are respected.

--[[ Purpose of this file :

Items stored in this file are "zone items", or items that are only relevant to a given zone.
The goal is to provide a minimum of info to the user for all those items that only have a vague description.
If it's an item that can simply be clicked to learn (like a pet or a toy), it has nothing to do in this list.
If the item already has a clear description about a faction it is related to, it has nothing to do in this list.
However, if it is an item for which you cannot say from which expansion/zone it is.. then it should be here.
For some items that have only 1 location where they can be used in the zone, then try to add X-Y Coords with SetZoneItem()

Zones

https://wowpedia.fandom.com/wiki/UiMapID
C_Map.GetMapInfo()  https://wowpedia.fandom.com/wiki/API_C_Map.GetMapInfo
ID's : https://wowpedia.fandom.com/wiki/UiMapID
--]]

local lib = LibStub("LibItemInfo-1.0")

-- Note, pass the coordinates as integers (simply x10)
-- ex: 38.9 42.0 => 389, 420
local SetZoneItem = lib.SetZoneItem

local SHATTRATH_CITY = 111

local VALE_OF_ETERNAL_BLOSSOM = 390
local KRASARANG_WILDS = 418

local AZSUNA = 630
local DRAENOR_NAGRAND = 550
local SPIRES_OF_ARAK = 542
local LUNARFALL = 582		-- Alliance WoD Garrison
local FROSTWALL = 590		-- Horde WoD Garrison
local TANAAN_JUNGLE = 534

local ANTORAN_WASTES = 885

local MECHAGON_ISLAND = 1462

local BASTION = 1533
local MALDRAXXUS = 1536
local THE_MAW = 1960
local KORTHIA = 1961
local ZERETH_MORTIS = 1970
local OHNAHRAN_PLAINS = 2023
local AZURE_SPAN = 2024
local VALDRAKKEN = 2112
local WAKING_SHORES = 2127
local ZARALEK_CAVERN = 2175
local EMERALD_DREAM = 2200

-- 11.0 The War Within
local DORNOGAL = 2339

lib:RegisterItems({

	-- 1.0 Classic


	
	-- 2.0 BC
	[29735] = SetZoneItem(1, SHATTRATH_CITY, 486, 266), 		-- Holy Dust
	
	-- 3.0 WotLK
	
	-- 4.0 Cataclysm
	
	-- 5.0 Mists of Pandaria
	[79104] = SetZoneItem(4, VALE_OF_ETERNAL_BLOSSOM, 524, 472), 		-- Rusty Watering Can
	[87779] = SetZoneItem(4, VALE_OF_ETERNAL_BLOSSOM, 214, 169), 		-- Ancient Guo-Lai Cache Key
	[91877] = SetZoneItem(4, KRASARANG_WILDS, 896, 334), 		-- Domination Point Commission
	
	-- 6.0 Warlords of Draenor
	[117397] = SetZoneItem(5, LUNARFALL), 		-- Nat's Lucky Coin
	[122272] = SetZoneItem(5, LUNARFALL), 		-- Follower Ability Retraining Manual
	[122273] = SetZoneItem(5, LUNARFALL), 		-- Follower Trait Retraining Guide
	[122307] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: Barn
	[122490] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: Dwarven Bunker
	[122497] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: Garden Shipment
	[122487] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: Gladiator's Sanctum
	[122500] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: Gnomish Gearworks
	[122503] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: Mine Shipment
	[128373] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: Shipyard
	
	[122576] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: Alchemy Lab
	[122590] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: Enchanter's Study
	[122591] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: Engineering Works
	[122592] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: Gem Boutique
	[122593] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: Scribe's Quarters
	[122594] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: Tailoring Emporium
	[122595] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: The Forge
	[122596] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: The Tannery
	
	
	-- [122273] = SetZoneItem(5, LUNARFALL), 		-- scouting missives, to do   https://www.wowhead.com/npc=78564/sergeant-crowler#sells;0+1-2
	
	-- same for horde : https://www.wowhead.com/npc=79774/sergeant-grimjaw#sells;0+1-2
	-- SEE BELOW !!
	[122496] = SetZoneItem(5, FROSTWALL), 		-- Rush Order: Garden Shipment
	[122501] = SetZoneItem(5, FROSTWALL), 		-- Rush Order: Goblin Workshop
	[122502] = SetZoneItem(5, FROSTWALL), 		-- Rush Order: Mine Shipment
	[122491] = SetZoneItem(5, FROSTWALL), 		-- Rush Order: War Mill
	
	
	[118658] = SetZoneItem(5, DRAENOR_NAGRAND, 502, 412), 		-- Gagrog's Skull
	[118099] = SetZoneItem(5, DRAENOR_NAGRAND, 502, 412), 		-- Gorian Artifact Fragment
	
	[115463] = SetZoneItem(5, SPIRES_OF_ARAK),		-- Elixir of Shadow Sight
	
	[124099] = SetZoneItem(5, TANAAN_JUNGLE, 552, 748),		-- Blackfang Claw
	
	-- 7.0 Legion
	[131744] = SetZoneItem(6, AZSUNA, 533, 394), 		-- Key to Nar'thalas Academy
	[152999] = SetZoneItem(6, ANTORAN_WASTES, 666, 178), 		-- Imp Meat, summon Mother Rosula
	
	-- 8.0 Battle for Azeroth
	[169873] = SetZoneItem(7, MECHAGON_ISLAND, 206, 715), 		-- Mechanized Supply Key
	
	-- 9.0 Shadowlands
	[178149] = SetZoneItem(8, BASTION), -- Centurion Anima Core
	
	[175757] = SetZoneItem(8, MALDRAXXUS, 389, 420), -- Construct Supply Key
	[180277] = SetZoneItem(8, MALDRAXXUS, 379, 456), -- Battlefront Ration Key
	[183987] = SetZoneItem(8, MALDRAXXUS), 	-- Prisoner Cage Key
	
	[186727] = SetZoneItem(8, THE_MAW), 		-- Seal Breaker Key
	
	-- 9.1 Shadowlands / Korthia
	[186718] = SetZoneItem(8, KORTHIA), 		-- Teleporter Repair Kit
	
	-- 9.2 Shadowlands / Zereth Mortis
	[188957] = SetZoneItem(8, ZERETH_MORTIS), -- Genesis Mote
	[189863] = SetZoneItem(8, ZERETH_MORTIS), -- Spatial Opener
	[189704] = SetZoneItem(8, ZERETH_MORTIS, 600, 178), -- Dominance Key
	[190189] = SetZoneItem(8, ZERETH_MORTIS), -- Sandworn Relic
	[190197] = SetZoneItem(8, ZERETH_MORTIS), -- Sandworn Chest Key
	[190198] = SetZoneItem(8, ZERETH_MORTIS), -- Sandworn Chest Key Fragment
	[190739] = SetZoneItem(8, ZERETH_MORTIS), -- Provis Wax
	[190740] = SetZoneItem(8, ZERETH_MORTIS), -- Automa Integration

	[189157] = SetZoneItem(8, ZERETH_MORTIS), -- Glimmer of Animation
	[189158] = SetZoneItem(8, ZERETH_MORTIS), -- Glimmer of Cunning
	[189159] = SetZoneItem(8, ZERETH_MORTIS), -- Glimmer of Discovery
	[189160] = SetZoneItem(8, ZERETH_MORTIS), -- Glimmer of Focus
	[189161] = SetZoneItem(8, ZERETH_MORTIS), -- Glimmer of Malice
	[189162] = SetZoneItem(8, ZERETH_MORTIS), -- Glimmer of Metamorphosis
	[189163] = SetZoneItem(8, ZERETH_MORTIS), -- Glimmer of Motion
	[189164] = SetZoneItem(8, ZERETH_MORTIS), -- Glimmer of Multiplicity
	[189165] = SetZoneItem(8, ZERETH_MORTIS), -- Glimmer of Predation
	[189166] = SetZoneItem(8, ZERETH_MORTIS), -- Glimmer of Renewal
	[189167] = SetZoneItem(8, ZERETH_MORTIS), -- Glimmer of Satisfaction
	[189168] = SetZoneItem(8, ZERETH_MORTIS), -- Glimmer of Serenity
	[189169] = SetZoneItem(8, ZERETH_MORTIS), -- Glimmer of Survival
	[189170] = SetZoneItem(8, ZERETH_MORTIS), -- Glimmer of Vigilance
	
	[187634] = SetZoneItem(8, ZERETH_MORTIS), -- Ambystan Lattice
	[187636] = SetZoneItem(8, ZERETH_MORTIS), -- Aurelid Lattice
	[187633] = SetZoneItem(8, ZERETH_MORTIS), -- Bufonid Lattice
	[187635] = SetZoneItem(8, ZERETH_MORTIS), -- Cervid Lattice
	[189500] = SetZoneItem(8, ZERETH_MORTIS), -- Cervid Lattice (quest item)
	[189146] = SetZoneItem(8, ZERETH_MORTIS), -- Geomental Lattice
	[189145] = SetZoneItem(8, ZERETH_MORTIS), -- Helicid Lattice
	[189147] = SetZoneItem(8, ZERETH_MORTIS), -- Leporid Lattice
	[190388] = SetZoneItem(8, ZERETH_MORTIS), -- Lipine Lattice
	[189148] = SetZoneItem(8, ZERETH_MORTIS), -- Poultrid Lattice
	[189149] = SetZoneItem(8, ZERETH_MORTIS), -- Proto Avian Lattice
	[189150] = SetZoneItem(8, ZERETH_MORTIS), -- Raptora Lattice
	[189151] = SetZoneItem(8, ZERETH_MORTIS), -- Scarabid Lattice
	[189152] = SetZoneItem(8, ZERETH_MORTIS), -- Tarachnid Lattice
	[189153] = SetZoneItem(8, ZERETH_MORTIS), -- Unformed Lattice
	[189154] = SetZoneItem(8, ZERETH_MORTIS), -- Vespoid Lattice
	[189155] = SetZoneItem(8, ZERETH_MORTIS), -- Viperid Lattice
	[189156] = SetZoneItem(8, ZERETH_MORTIS), -- Vombata Lattice
	
	[187728] = SetZoneItem(8, ZERETH_MORTIS), -- Ephemera Strands
	
	
	-- 10.0 Dragonflight
	[192055] = SetZoneItem(9, WAKING_SHORES, 471, 825), -- Dragon Isles Artifact
	[191251] = SetZoneItem(9, WAKING_SHORES, 267, 626), -- Key Fragments
	[193201] = SetZoneItem(9, WAKING_SHORES, 267, 626), -- Key Framing
	[199906] = SetZoneItem(9, VALDRAKKEN, 260, 400), -- Titan Relic
	[200071] = SetZoneItem(9, AZURE_SPAN, 124, 493), -- Sacred Tuskarr Totem
	[200078] = SetZoneItem(9, AZURE_SPAN, 128, 491), -- Pickaxe Blade
	[200093] = SetZoneItem(9, OHNAHRAN_PLAINS, 640, 410), -- Centaur Hunting Trophy
	[199338] = SetZoneItem(9, OHNAHRAN_PLAINS, 822, 731), -- Copper Coin of the Isles
	[199339] = SetZoneItem(9, OHNAHRAN_PLAINS, 822, 731), -- Silver Coin of the Isles
	[199340] = SetZoneItem(9, OHNAHRAN_PLAINS, 822, 731), -- Gold Coin of the Isles
	[201159] = SetZoneItem(9, OHNAHRAN_PLAINS, 623, 423), -- Aloom's Token
	
	-- 10.1 Zaralek Cavern
	-- [] = SetZoneItem(9, ZARALEK_CAVERN), -- xx
	
	-- 10.2 Emerald Dream
	[208066] = SetZoneItem(9, EMERALD_DREAM), -- Small Dreamseed
	[208067] = SetZoneItem(9, EMERALD_DREAM), -- Plump Dreamseed
	[208047] = SetZoneItem(9, EMERALD_DREAM), -- Gigantic Dreamseed
	

	-- 11.0 The War Within
	[223951] = SetZoneItem(10, DORNOGAL, 570, 608), -- Earth-Encrusted Gem


})


-- If the player is playing horde, replace some id's by the horde equivalent location
if UnitFactionGroup("player") == "Horde" then
	lib:RegisterItems({
		[122307] = SetZoneItem(5, FROSTWALL), 		-- Rush Order: Barn
		[122487] = SetZoneItem(5, FROSTWALL), 		-- Rush Order: Gladiator's Sanctum
		[128373] = SetZoneItem(5, FROSTWALL), 		-- Rush Order: Shipyard
	})
end
