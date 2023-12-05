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
	[11382] = SetReagent(0, e.Blacksmithing, 0, bag.GemBag), -- Blood of the Mountain
	[17203] = SetReagent(0, e.Blacksmithing, 0, bag.MiningBag), -- Sulfuron Ingot
	[18562] = SetReagent(0, e.Blacksmithing, 0, bag.MiningBag), -- Elementium Ingot
	[18567] = SetReagent(0, e.Blacksmithing, 0, bag.MiningBag), -- Elemental Flux
	
	[3470] = SetReagent(0, e.Blacksmithing, 45, bag.MiningBag), -- Rough Grinding Stone
	[3478] = SetReagent(0, e.Blacksmithing, 75, bag.MiningBag), -- Coarse Grinding Stone
	[3486] = SetReagent(0, e.Blacksmithing, 125, bag.MiningBag), -- Heavy Grinding Stone
	[7071] = SetReagent(0, e.Blacksmithing, 150, bag.EngineeringBag), -- Iron Buckle
	[7966] = SetReagent(0, e.Blacksmithing, 200, bag.MiningBag), -- Solid Grinding Stone	
	[9060] = SetReagent(0, e.Blacksmithing, 225, bag.EngineeringBag), -- Inlaid Mithril Cylinder
	[12644] = SetReagent(0, e.Blacksmithing, 255, bag.MiningBag), -- Dense Grinding Stone	

	-- 2.0 BC


	-- 3.0 WotLK
	
	
	-- 4.0 Cataclysm
	[65365] = SetReagent(3, e.Blacksmithing, 1, bag.MiningBag), -- Folded Obsidium
	
	-- 5.0 Mists of Pandaria

	
	-- 6.0 Warlords of Draenor
	-- Note : as of 6.0, bars are part of blacksmithing

	
	-- 7.0 Legion
	[124461] = SetReagent(6, e.Blacksmithing, 60, bag.MiningBag), -- Demonsteel Bar

	
	-- 8.0 Battle for Azeroth
	[160298] = SetReagent(7, e.Blacksmithing, 0, bag.EngineeringBag), -- Durable Flux
	
	-- 9.0 Shadowlands
	[180733] = SetReagent(8, e.Blacksmithing, 0, bag.MiningBag), -- Luminous Flux
	[171428] = SetReagent(8, e.Blacksmithing, 57, bag.MiningBag), -- Shadowghast Ingot
	
	-- 10.0 Dragonflight
	[191511] = SetReagent(9, e.Blacksmithing), -- Stable Fluidic Draconium 1
	[191512] = SetReagent(9, e.Blacksmithing), -- Stable Fluidic Draconium 2
	[191513] = SetReagent(9, e.Blacksmithing), -- Stable Fluidic Draconium 3
})