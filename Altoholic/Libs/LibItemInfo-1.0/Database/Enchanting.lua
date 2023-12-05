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
	[10938] = SetReagent(0, e.Enchanting), -- Lesser Magic Essence
	[10939] = SetReagent(0, e.Enchanting), -- Greater Magic Essence
	[10940] = SetReagent(0, e.Enchanting), -- Strange Dust
	[14343] = SetReagent(0, e.Enchanting), -- Small Brilliant Shard	
	[14344] = SetReagent(0, e.Enchanting), -- Large Brilliant Shard
	[16202] = SetReagent(0, e.Enchanting), -- Lesser Eternal Essence
	[16203] = SetReagent(0, e.Enchanting), -- Greater Eternal Essence
	[16204] = SetReagent(0, e.Enchanting), -- Light Illusion Dust
	[156930] = SetReagent(0, e.Enchanting), -- Rich Illusion Dust
	[12810] = SetReagent(0, e.Enchanting, 250, bag.LeatherworkingBag), -- Enchanted Leather
	[138787] = SetReagent(0, e.Enchanting, 275), -- Tome of Illusions: Azeroth
	
	-- 2.0 BC
	[22445] = SetReagent(1, e.Enchanting), -- Arcane Dust
	[22446] = SetReagent(1, e.Enchanting), -- Greater Planar Essence
	[22447] = SetReagent(1, e.Enchanting), -- Lesser Planar Essence	
	[22448] = SetReagent(1, e.Enchanting), -- Small Prismatic Shard
	[22449] = SetReagent(1, e.Enchanting), -- Large Prismatic Shard
	[22450] = SetReagent(1, e.Enchanting), -- Void Crystal
	[138789] = SetReagent(1, e.Enchanting, 50), -- Tome of Illusions: Outland

	-- 3.0 WotLK
	[34052] = SetReagent(2, e.Enchanting), -- Dream Shard
	[34053] = SetReagent(2, e.Enchanting), -- Small Dream Shard
	[34054] = SetReagent(2, e.Enchanting), -- Infinite Dust
	[34055] = SetReagent(2, e.Enchanting), -- Greater Cosmic Essence
	[34056] = SetReagent(2, e.Enchanting), -- Lesser Cosmic Essence	
	[34057] = SetReagent(2, e.Enchanting), -- Abyss Crystal
	[138790] = SetReagent(2, e.Enchanting, 50), -- Tome of Illusions: Northrend
	
	-- 4.0 Cataclysm
	[52555] = SetReagent(3, e.Enchanting), -- Hypnotic Dust
	[52718] = SetReagent(3, e.Enchanting), -- Lesser Celestial Essence
	[52719] = SetReagent(3, e.Enchanting), -- Greater Celestial Essence
	[52720] = SetReagent(3, e.Enchanting), -- Small Heavenly Shard
	[52721] = SetReagent(3, e.Enchanting), -- Heavenly Shard
	[52722] = SetReagent(3, e.Enchanting), -- Maelstrom Crystal
	[138791] = SetReagent(3, e.Enchanting, 50), -- Tome of Illusions: Cataclysm
	[138792] = SetReagent(3, e.Enchanting), -- Tome of Illusions: Elemental Lords
	
	-- 5.0 Mists of Pandaria
	[74247] = SetReagent(4, e.Enchanting), -- Ethereal Shard
	[74248] = SetReagent(4, e.Enchanting), -- Sha Crystal
	[74249] = SetReagent(4, e.Enchanting), -- Spirit Dust
	[74250] = SetReagent(4, e.Enchanting), -- Mysterious Essence
	[74252] = SetReagent(4, e.Enchanting), -- Small Ethereal Shard
	[80433] = SetReagent(4, e.Enchanting), -- Blood Spirit
	[94289] = SetReagent(4, e.Enchanting), -- Haunting Spirit
	[102218] = SetReagent(4, e.Enchanting), -- Spirit of War
	[105718] = SetReagent(4, e.Enchanting), -- Sha Crystal Fragment
	[138793] = SetReagent(4, e.Enchanting, 50), -- Tome of Illusions: Pandaria
	[138794] = SetReagent(4, e.Enchanting), -- Tome of Illusions: Secrets of the Shado-Pan
	
	-- 6.0 Warlords of Draenor
	[109693] = SetReagent(5, e.Enchanting), -- Draenic Dust
	[111245] = SetReagent(5, e.Enchanting), -- Luminous Shard
	[113588] = SetReagent(5, e.Enchanting), -- Temporal Crystal
	[115502] = SetReagent(5, e.Enchanting), -- Small Luminous Shard	
	[115504] = SetReagent(5, e.Enchanting), -- Fractured Temporal Crystal
	[119293] = SetReagent(5, e.Enchanting), -- Secrets of Draenor Enchanting
	[138795] = SetReagent(5, e.Enchanting), -- Tome of Illusions: Draenor
	
	-- 7.0 Legion
	[124440] = SetReagent(6, e.Enchanting), -- Arkhana
	[124441] = SetReagent(6, e.Enchanting), -- Leylight Shard
	[124442] = SetReagent(6, e.Enchanting), -- Chaos Crystal
	
	-- 8.0 Battle for Azeroth
	[152875] = SetReagent(7, e.Enchanting), -- Gloom Dust
	[152876] = SetReagent(7, e.Enchanting), -- Umbra Shard	
	[152877] = SetReagent(7, e.Enchanting), -- Veiled Crystal
	
	-- 9.0 Shadowlands
	[172230] = SetReagent(8, e.Enchanting), -- Soul Dust
	[172231] = SetReagent(8, e.Enchanting), -- Sacred Shard
	[172232] = SetReagent(8, e.Enchanting), -- Eternal Crystal
	[172438] = SetReagent(8, e.Enchanting, 0, bag.LeatherworkingBag), -- Enchanted Heavy Callous Hide
	[183951] = SetReagent(8, e.Enchanting), -- Immortal Shard
	
	-- 10.0 Dragonflight
	[194123] = SetReagent(9, e.Enchanting), -- Chromatic Dust
	[194124] = SetReagent(9, e.Enchanting), -- Vibrant Shard
	[200113] = SetReagent(9, e.Enchanting), -- Resonant Crystal
	[201584] = SetReagent(9, e.Enchanting), -- Serevite Rod
})