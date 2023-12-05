--	*** LibItemInfo ***
-- Written by : Thaoky, EU-Marécages de Zangar
-- March 2021
-- This list was manually curated (source: mostly Wowhead + in-game).
-- Non-commercial use is permitted as long as credits are preserved, and that Blizzard's terms of services are respected.

local lib = LibStub("LibItemInfo-1.0")

local e = lib.Enum.ReagentTypes
local bag = lib.Enum.BagTypes
local SetReagent = lib.SetReagent

-- Items that are related to multiple professions
lib:RegisterItems({

	-- 1.0 Classic
	[52843] = SetReagent(0, e.Archaeology), -- Dwarf Rune Stone
	[63127] = SetReagent(0, e.Archaeology), -- Highborne Scroll
	[63128] = SetReagent(0, e.Archaeology), -- Troll Tablet
	
	-- 2.0 BC
	[64392] = SetReagent(1, e.Archaeology), -- Orc Blood Text
	[64394] = SetReagent(1, e.Archaeology), -- Draenei Tome
	
	-- 3.0 WotLK
	[64395] = SetReagent(2, e.Archaeology), -- Vrykul Rune Stick
	[64396] = SetReagent(2, e.Archaeology), -- Nerubian Obelisk
	
	-- 4.0 Cataclysm
	[64397] = SetReagent(3, e.Archaeology), -- Tol'vir Hieroglyphic
	
	-- 5.0 Mists of Pandaria
	[79868] = SetReagent(4, e.Archaeology), -- Pandaren Pottery Shard
	[79869] = SetReagent(4, e.Archaeology), -- Mogu Statue Piece
	[95373] = SetReagent(4, e.Archaeology), -- Mantid Amber Sliver
	
	-- 6.0 Warlords of Draenor
	[108439] = SetReagent(5, e.Archaeology), -- Draenor Clan Orator Cane
	[109584] = SetReagent(5, e.Archaeology), -- Ogre Missive
	[109585] = SetReagent(5, e.Archaeology), -- Arakkoa Cipher
	
	-- 7.0 Legion
	[130903] = SetReagent(6, e.Archaeology), -- Ancient Suramar Scroll
	[130904] = SetReagent(6, e.Archaeology), -- Highmountain Ritual-Stone
	[130905] = SetReagent(6, e.Archaeology), -- Mark of the Deceiver
	
	-- 8.0 Battle for Azeroth
	[154989] = SetReagent(7, e.Archaeology), -- Zandalari Idol
	[154990] = SetReagent(7, e.Archaeology), -- Etched Drust Bone
	
	-- 9.0 Shadowlands
})
