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
	[5498] = SetReagent(0, e.Multi, 0, bag.GemBag), -- Small Lustrous Pearl
	[5500] = SetReagent(0, e.Multi, 0, bag.GemBag), -- Iridescent Pearl
	[7067] = SetReagent(0, e.Elemental), -- Elemental Earth
	[7068] = SetReagent(0, e.Elemental), -- Elemental Fire
	[7069] = SetReagent(0, e.Elemental), -- Elemental Air
	[7070] = SetReagent(0, e.Elemental), -- Elemental Water
	[7075] = SetReagent(0, e.Elemental), -- Core of Earth
	[7077] = SetReagent(0, e.Elemental), -- Heart of Fire
	[7079] = SetReagent(0, e.Elemental), -- Globe of Water
	[7081] = SetReagent(0, e.Elemental), -- Breath of Wind
	[7971] = SetReagent(0, e.Multi), -- Black Pearl
	[7972] = SetReagent(0, e.Elemental), -- Ichor of Undeath
	[10286] = SetReagent(0, e.Elemental, 0, bag.HerbBag), -- Heart of the wild
	[11291] = SetReagent(0, e.Multi), -- Star Wood
	[12809] = SetReagent(0, e.Multi, 0), -- Guardian Stone
	[13926] = SetReagent(0, e.Multi, 0, bag.GemBag), -- Golden Pearl
	
	-- 2.0 BC
	[23572] = SetReagent(1, e.Elemental), -- Primal Nether
	[24478] = SetReagent(1, e.Multi, 0, bag.GemBag), -- Jaggal Pearl
	[30183] = SetReagent(1, e.Elemental, 0, bag.LeatherworkingBag), -- Nether Vortex
	[32428] = SetReagent(1, e.Multi, 0, bag.LeatherworkingBag), -- Heart of Darkness
	
	-- 3.0 WotLK
	[36784] = SetReagent(2, e.Multi, 0, bag.GemBag), -- Siren's Tear
	[43102] = SetReagent(2, e.Multi), -- Frozen Orb
	[49908] = SetReagent(2, e.Multi, 0, bag.LeatherworkingBag), -- Primordial Saronite
	
	-- 4.0 Cataclysm
	[52325] = SetReagent(3, e.Elemental), -- Volatile Fire
	[52326] = SetReagent(3, e.Elemental), -- Volatile Water
	[52327] = SetReagent(3, e.Elemental), -- Volatile Earth
	[52328] = SetReagent(3, e.Elemental), -- Volatile Air
	[52329] = SetReagent(3, e.Elemental), -- Volatile Life
	
	-- 5.0 Mists of Pandaria
	[89112] = SetReagent(4, e.Elemental), -- Mote of Harmony
	[76061] = SetReagent(4, e.Elemental), -- Spirit of Harmony
	
	-- 6.0 Warlords of Draenor
	[120945] = SetReagent(4, e.Multi), -- Primal Spirit
	[127759] = SetReagent(4, e.Multi), -- Felblight
	
	-- 7.0 Legion
	[124438] = SetReagent(6, e.Multi), -- Unbroken Claw
	[124439] = SetReagent(6, e.Multi), -- Unbroken Tooth
	
	-- 8.0 Battle for Azeroth
	[152668] = SetReagent(7, e.Multi), -- Expulsom
	[162460] = SetReagent(7, e.Multi), -- Hydrocore
	[162461] = SetReagent(7, e.Multi), -- Sanguicel
	[165703] = SetReagent(7, e.Multi), -- Breath of Bwonsamdi
	[165948] = SetReagent(7, e.Multi), -- Tidalcore
		
	-- 9.0 Shadowlands
	[178787] = SetReagent(8, e.Elemental), -- Orboreal Shard
	[180055] = SetReagent(8, e.Multi), -- Relic of the Past I
	[178757] = SetReagent(8, e.Multi), -- Relic of the Past II
	[178788] = SetReagent(8, e.Multi), -- Relic of the Past III
	[178759] = SetReagent(8, e.Multi), -- Relic of the Past IV
	[178760] = SetReagent(8, e.Multi), -- Relic of the Past V
	[186017] = SetReagent(8, e.Elemental), -- Korthite Crystal
	[187707] = SetReagent(8, e.Elemental), -- Progenitor Essentia
	[187742] = SetReagent(8, e.Multi), -- Crafter's Mark of the First Ones
	[187784] = SetReagent(8, e.Multi), -- Vestige of the Eternal
	
	[187823] = SetReagent(8, e.Multi), -- Magically Regulated Automa Core
	[187825] = SetReagent(8, e.Multi), -- Cosmic Protoweave
	[187829] = SetReagent(8, e.Multi), -- Aealic Harmonizing Stone
	[187831] = SetReagent(8, e.Multi), -- Pure-Air Sail Extensions
	[187836] = SetReagent(8, e.Multi), -- Erratic Genesis Matrix
	[187849] = SetReagent(8, e.Multi), -- Devourer Essence Stone
	[187850] = SetReagent(8, e.Multi), -- Sustaining Armor Polish
	
	-- 10.0 Dragonflight
	[190315] = SetReagent(9, e.Elemental), -- Rousing Earth
	[190316] = SetReagent(9, e.Elemental), -- Awakened Earth
	[190320] = SetReagent(9, e.Elemental), -- Rousing Fire
	[190321] = SetReagent(9, e.Elemental), -- Awakened Fire
	[190322] = SetReagent(9, e.Elemental), -- Rousing Order
	[190324] = SetReagent(9, e.Elemental), -- Awakened Order
	[190326] = SetReagent(9, e.Elemental), -- Rousing Air
	[190327] = SetReagent(9, e.Elemental), -- Awakened Air
	[190328] = SetReagent(9, e.Elemental), -- Rousing Frost
	[190329] = SetReagent(9, e.Elemental), -- Awakened Frost
	[190330] = SetReagent(9, e.Elemental), -- Rousing Decay
	[190331] = SetReagent(9, e.Elemental), -- Awakened Decay
	[190450] = SetReagent(9, e.Elemental), -- Awakened Ire
	[190451] = SetReagent(9, e.Elemental), -- Rousing Ire
	[190456] = SetReagent(9, e.Multi), -- Artisan's Mettle

	[192887] = SetReagent(9, e.Elemental), -- Elemental Harmony 1
	[193378] = SetReagent(9, e.Elemental), -- Elemental Harmony 2
	[193379] = SetReagent(9, e.Elemental), -- Elemental Harmony 3
	[191514] = SetReagent(9, e.Multi), -- Brood Salt 1
	[191515] = SetReagent(9, e.Multi), -- Brood Salt 2
	[191516] = SetReagent(9, e.Multi), -- Brood Salt 3
	[191517] = SetReagent(9, e.Multi), -- Writhefire Oil 1
	[191518] = SetReagent(9, e.Multi), -- Writhefire Oil 2
	[191519] = SetReagent(9, e.Multi), -- Writhefire Oil 3
	
	[191529] = SetReagent(9, e.Multi), -- Illustrious Insight
	[198048] = SetReagent(9, e.Multi), -- Titan Training Matrix 1
	[198056] = SetReagent(9, e.Multi), -- Titan Training Matrix 2
	[198058] = SetReagent(9, e.Multi), -- Titan Training Matrix 3
	[198059] = SetReagent(9, e.Multi), -- Titan Training Matrix 4
	[204673] = SetReagent(9, e.Multi), -- Titan Training Matrix 5
	
	[201399] = SetReagent(9, e.Multi), -- Primal Bear Spine
	[201400] = SetReagent(9, e.Multi), -- Aquatic Maw
	[201401] = SetReagent(9, e.Multi), -- Iridescent Plume
	[201402] = SetReagent(9, e.Multi), -- Large Sturdy Femur
	[201403] = SetReagent(9, e.Multi), -- Mastodon Tusk
	[201404] = SetReagent(9, e.Multi), -- Tallstrider Sinew
	
})
