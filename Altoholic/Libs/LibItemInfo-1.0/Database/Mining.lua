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
	-- https://www.wowhead.com/items?filter=166:73:217;9:1:1;0:0:0
	
	-- 1.0 Classic
	[2770] = SetReagent(0, e.Mining), -- Copper Ore
	[2771] = SetReagent(0, e.Mining), -- Tin Ore
	[2772] = SetReagent(0, e.Mining), -- Iron Ore
	[2775] = SetReagent(0, e.Mining), -- Silver Ore
	[2776] = SetReagent(0, e.Mining), -- Gold Ore
	[2835] = SetReagent(0, e.Mining), -- Rough Stone
	[2836] = SetReagent(0, e.Mining), -- Coarse Stone
	[2838] = SetReagent(0, e.Mining), -- Heavy Stone

	[3857] = SetReagent(0, e.Mining), -- Coal
	[3858] = SetReagent(0, e.Mining), -- Mithril Ore
	[7911] = SetReagent(0, e.Mining), -- Truesilver Ore
	[7912] = SetReagent(0, e.Mining), -- Solid Stone
	[10620] = SetReagent(0, e.Mining), -- Thorium Ore
	[11370] = SetReagent(0, e.Mining), -- Dark Iron Ore
	[12365] = SetReagent(0, e.Mining), -- Dense Stone
	[22202] = SetReagent(0, e.Mining), -- Small Obsidian Shard	
	[22203] = SetReagent(0, e.Mining), -- Large Obsidian Shard
	[108298] = SetReagent(0, e.Mining), -- Thorium Ore Nugget
	[108297] = SetReagent(0, e.Mining), -- Iron Ore Nugget
	[108300] = SetReagent(0, e.Mining), -- Mithril Ore Nugget
	[108299] = SetReagent(0, e.Mining), -- Truesilver Ore Nugget
	[108296] = SetReagent(0, e.Mining), -- Gold Ore Nugget
	[108294] = SetReagent(0, e.Mining), -- Silver Ore Nugget
	
	[2840] = SetReagent(0, e.Mining, 1), -- Copper Bar
	[3576] = SetReagent(0, e.Mining, 50), -- Tin Bar
	[2841] = SetReagent(0, e.Mining, 50), -- Bronze Bar
	[2842] = SetReagent(0, e.Mining, 65), -- Silver Bar
	[3575] = SetReagent(0, e.Mining, 100), -- Iron Bar
	[3577] = SetReagent(0, e.Mining, 115), -- Gold Bar
	[3859] = SetReagent(0, e.Mining, 125), -- Steel Bar
	[3860] = SetReagent(0, e.Mining, 150), -- Mithril Bar
	[6037] = SetReagent(0, e.Mining, 165), -- Truesilver Bar
	[12359] = SetReagent(0, e.Mining, 200), -- Thorium Bar
	[11371] = SetReagent(0, e.Mining, 300), -- Dark Iron Bar
	[17771] = SetReagent(0, e.Mining, 300), -- Enchanted Elementium Bar
	
	-- 2.0 BC
	[23424] = SetReagent(1, e.Mining), -- Fel Iron Ore
	[23425] = SetReagent(1, e.Mining), -- Adamantite Ore
	[23426] = SetReagent(1, e.Mining), -- Khorium Ore
	[23427] = SetReagent(1, e.Mining), -- Eternium Ore	
	[108301] = SetReagent(1, e.Mining), -- Fel Iron Ore Nugget
	[108302] = SetReagent(1, e.Mining), -- Adamantite Ore Nugget
	[108304] = SetReagent(1, e.Mining), -- Khorium Ore Nugget
	
	[23445] = SetReagent(1, e.Mining, 1), -- Fel Iron Bar
	[23446] = SetReagent(1, e.Mining, 25), -- Adamantite Bar
	[23447] = SetReagent(1, e.Mining, 50), -- Eternium Bar
	[23448] = SetReagent(1, e.Mining, 50), -- Felsteel Bar
	[23573] = SetReagent(1, e.Mining, 75), -- Hardened Adamantite Bar
	[23449] = SetReagent(1, e.Mining, 75), -- Khorium Bar
	[35128] = SetReagent(1, e.Mining, 75), -- Hardened Khorium
	
	-- 3.0 WotLK
	[36909] = SetReagent(2, e.Mining), -- Cobalt Ore
	[36910] = SetReagent(2, e.Mining), -- Titanium Ore
	[36912] = SetReagent(2, e.Mining), -- Saronite Ore	
	[108391] = SetReagent(2, e.Mining), -- Titanium Ore Nugget
	[108305] = SetReagent(2, e.Mining), -- Cobalt Ore Nugget
	[108306] = SetReagent(2, e.Mining), -- Saronite Ore Nugget
	
	[36916] = SetReagent(2, e.Mining, 1), -- Cobalt Bar
	[36913] = SetReagent(2, e.Mining, 25), -- Saronite Bar
	[41163] = SetReagent(2, e.Mining, 75), -- Titanium Bar
	[37663] = SetReagent(2, e.Mining, 75), -- Titansteel Bar
	
	-- 4.0 Cataclysm
	[52183] = SetReagent(3, e.Mining), -- Pyrite Ore
	[52185] = SetReagent(3, e.Mining), -- Elementium Ore
	[53038] = SetReagent(3, e.Mining), -- Obsidium Ore
	[108307] = SetReagent(3, e.Mining), -- Obsidium Ore Nugget
	[108308] = SetReagent(3, e.Mining), -- Elementium Ore Nugget
	[108309] = SetReagent(3, e.Mining), -- Pyrite Ore Nugget
	
	[54849] = SetReagent(3, e.Mining, 1), -- Obsidium Bar
	[52186] = SetReagent(3, e.Mining, 25), -- Elementium Bar
	[53039] = SetReagent(3, e.Mining, 50), -- Hardened Elementium Bar
	[51950] = SetReagent(3, e.Mining, 75), -- Pyrite Bar
	
	-- 5.0 Mists of Pandaria
	[72092] = SetReagent(4, e.Mining), -- Ghost Iron Ore
	[72103] = SetReagent(4, e.Mining), -- White Trillium Ore
	[72093] = SetReagent(4, e.Mining), -- Kyparite
	[72094] = SetReagent(4, e.Mining), -- Black Trillium Ore
	[97512] = SetReagent(4, e.Mining), -- Ghost Iron Nugget
	[97546] = SetReagent(4, e.Mining), -- Kyparite Fragment
	
	[72096] = SetReagent(4, e.Mining, 1), -- Ghost Iron Bar
	[72095] = SetReagent(4, e.Mining, 75), -- Trillium Bar
	
	-- 6.0 Warlords of Draenor
	[109119] = SetReagent(5, e.Mining), -- True Iron Ore
	[109118] = SetReagent(5, e.Mining), -- Blackrock Ore
	[115508] = SetReagent(5, e.Mining), -- Draenic Stone
	[109991] = SetReagent(5, e.Mining), -- True Iron Nugget
	[109992] = SetReagent(5, e.Mining), -- Blackrock Fragment
	
	-- 7.0 Legion
	[124444] = SetReagent(6, e.Mining), -- Infernal Brimstone
	[123918] = SetReagent(6, e.Mining), -- Leystone Ore
	[123919] = SetReagent(6, e.Mining), -- Felslate
	[151564] = SetReagent(6, e.Mining), -- Empyrium
	
	-- 8.0 Battle for Azeroth
	[152512] = SetReagent(7, e.Mining), -- Monelite Ore
	[152513] = SetReagent(7, e.Mining), -- Platinum Ore
	[152579] = SetReagent(7, e.Mining), -- Storm Silver Ore
	[163609] = SetReagent(7, e.Mining), -- Luminous Monelite
	[163623] = SetReagent(7, e.Mining), -- Gleaming Storm Silver
	[163624] = SetReagent(7, e.Mining), -- Burnished Platinum
	[163625] = SetReagent(7, e.Mining), -- Rough Monelite
	[163626] = SetReagent(7, e.Mining), -- Coarse Storm Silver
	[163627] = SetReagent(7, e.Mining), -- Smooth Platinum
	[163628] = SetReagent(7, e.Mining), -- Hardened Monelite
	[163629] = SetReagent(7, e.Mining), -- Dense Storm Silver
	[163630] = SetReagent(7, e.Mining), -- Ductile Platinum
	[168185] = SetReagent(7, e.Mining), -- Osmenite Ore
	
	-- 9.0 Shadowlands
	[171828] = SetReagent(8, e.Mining), -- Laestrite Ore
	[171829] = SetReagent(8, e.Mining), -- Solenium Ore
	[171830] = SetReagent(8, e.Mining), -- Oxxein Ore
	[171831] = SetReagent(8, e.Mining), -- Phaedrum Ore
	[171832] = SetReagent(8, e.Mining), -- Sinvyr Ore
	[171833] = SetReagent(8, e.Mining), -- Elethium Ore
	[171840] = SetReagent(8, e.Mining), -- Porous Stone
	[171841] = SetReagent(8, e.Mining), -- Shaded Stone
	[177061] = SetReagent(8, e.Mining), -- Twilight Bark
	[187700] = SetReagent(8, e.Mining), -- Progenium Ore	
	
	-- 10.0 Dragonflight
	[188658] = SetReagent(9, e.Mining), -- Draconium Ore 1
	[189143] = SetReagent(9, e.Mining), -- Draconium Ore 2
	[190311] = SetReagent(9, e.Mining), -- Draconium Ore 3
	[190312] = SetReagent(9, e.Mining), -- Khaz'gorite Ore 1
	[190313] = SetReagent(9, e.Mining), -- Khaz'gorite Ore 2
	[190314] = SetReagent(9, e.Mining), -- Khaz'gorite Ore 3
	[190394] = SetReagent(9, e.Mining), -- Serevite Ore 3
	[190395] = SetReagent(9, e.Mining), -- Serevite Ore 1
	[190396] = SetReagent(9, e.Mining), -- Serevite Ore 2
	
	-- 11.0 The War Within
	[210930] = SetReagent(10, e.Mining), -- Bismuth 1
	[210931] = SetReagent(10, e.Mining), -- Bismuth 2
	[210932] = SetReagent(10, e.Mining), -- Bismuth 3
	[210933] = SetReagent(10, e.Mining), -- Aqirite 1
	[210934] = SetReagent(10, e.Mining), -- Aqirite 2
	[210935] = SetReagent(10, e.Mining), -- Aqirite 3
	[210936] = SetReagent(10, e.Mining), -- Ironclaw Ore 1
	[210937] = SetReagent(10, e.Mining), -- Ironclaw Ore 2
	[210938] = SetReagent(10, e.Mining), -- Ironclaw Ore 3
	[210939] = SetReagent(10, e.Mining), -- Null Stone
	[217707] = SetReagent(10, e.Mining), -- Imperfect Null Stone
	[226202] = SetReagent(10, e.Mining), -- Echoing Flux
	
})