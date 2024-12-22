local addonName = "Altoholic"
local addon = _G[addonName]

-- Mage set id's are used as reference for tier data
local transmogSets = {
	-- each entry will be enriched with extra data
	-- ["WARRIOR"] = set id (for all classes), description, label, requiredFaction

	{	-- [1] Classic
		{ setID = 910, tier = 1 },				-- Molten Core
		{ setID = 909, tier = 2 },				-- Blackwing Lair
		{ setID = 908, tier = 2.5 },			-- Temple of Ahn'Qiraj 
		{ setID = 907, tier = 3 },				-- Naxxramas
		{ setID = 855 },							-- Darkmoon Faire
	},
	{	-- [2] The Burning Crusade
		{ setID = 898, tier = 4 },				-- Gruul's Lair
		{ setID = 905, tier = 5 },				-- Serpentshrine Cavern
		{ setID = 904, tier = 6 },				-- Black Temple
		{ setID = 903, tier = 6.5 },			-- Sunwell Plateau
		{ setID = 975, tier = 1, isPVP = true },		-- Season 1
		{ setID = 967, tier = 2, isPVP = true },		-- Season 2
		{ setID = 959, tier = 3, isPVP = true },		-- Season 3
		{ setID = 951, tier = 4, isPVP = true },		-- Season 4
	},
	{	-- [3] Wrath of the Lich King
		{ setID = 726, tier = 7 },				-- Naxxramas
		{ setID = 727, tier = 7 },				-- Naxxramas
		{ setID = 724, tier = 8 },				-- Ulduar
		{ setID = 725, tier = 8 },				-- Ulduar
		{ setID = 722, tier = 9 },				-- Trial of the Crusader
		{ setID = 723, tier = 9 },				-- Trial of the Crusader
		{ setID = 719, tier = 10 },			-- Icecrown Citadel
		{ setID = 720, tier = 10 },			-- Icecrown Citadel
		{ setID = 721, tier = 10 },			-- Icecrown Citadel
		{ setID = 811, tier = 5, isPVP = true },		-- Season 5
		{ setID = 802, tier = 5, isPVP = true },		-- Season 5
		{ setID = 793, tier = 5, isPVP = true },		-- Season 5
		{ setID = 784, tier = 6, isPVP = true },		-- Season 6
		{ setID = 775, tier = 7, isPVP = true },		-- Season 7
		{ setID = 766, tier = 8, isPVP = true },		-- Season 8
	},
	{	-- [4] Cataclysm
		{ setID = 717, tier = 11 },			-- The Bastion of Twilight
		{ setID = 718, tier = 11 },			-- The Bastion of Twilight
		{ setID = 715, tier = 12 },			-- Firelands
		{ setID = 716, tier = 12 },			-- Firelands
		{ setID = 713, tier = 13 },			-- Dragon Soul
		{ setID = 712, tier = 13 },			-- Dragon Soul
		{ setID = 714, tier = 13 },			-- Dragon Soul
		{ setID = 1198, tier = 9, isPVP = true },		-- Season 9
		{ setID = 753, tier = 9, isPVP = true },		-- Season 9
		{ setID = 754, tier = 9, isPVP = true },		-- Season 9
		{ setID = 618, tier = 10, isPVP = true },		-- Season 10
		{ setID = 619, tier = 10, isPVP = true },		-- Season 10
		{ setID = 598, tier = 11, isPVP = true },		-- Season 11
		{ setID = 599, tier = 11, isPVP = true },		-- Season 11
	},
	{	-- [5] Mists of Pandaria
		{ setID = 531, tier = 14 },			-- Heart of Fear
		{ setID = 529, tier = 14 },			-- Heart of Fear
		{ setID = 530, tier = 14 },			-- Heart of Fear
		{ setID = 528, tier = 15 },			-- Throne of Thunder
		{ setID = 526, tier = 15 },			-- Throne of Thunder
		{ setID = 527, tier = 15 },			-- Throne of Thunder
		{ setID = 525, tier = 16 },			-- Siege of Orgrimmar
		{ setID = 523, tier = 16 },			-- Siege of Orgrimmar
		{ setID = 524, tier = 16 },			-- Siege of Orgrimmar
		{ setID = 197, tier = 12, isPVP = true },		-- Season 12
		{ setID = 276, tier = 12, isPVP = true },		-- Season 12
		{ setID = 1057, tier = 12, isPVP = true },	-- Season 12
		{ setID = 275, tier = 13, isPVP = true },		-- Season 13 A
		{ setID = 264, tier = 13, isPVP = true },		-- Season 13 H
		{ setID = 1016, tier = 13, isPVP = true },	-- Season 13 A
		{ setID = 1017, tier = 13, isPVP = true },	-- Season 13 H
		{ setID = 219, tier = 14, isPVP = true },		-- Season 14 A
		{ setID = 209, tier = 14, isPVP = true },		-- Season 14 H
		{ setID = 1036, tier = 14, isPVP = true },	-- Season 14 A
		{ setID = 1037, tier = 14, isPVP = true },	-- Season 14 H
		{ setID = 242, tier = 15, isPVP = true },		-- Season 15 A
		{ setID = 253, tier = 15, isPVP = true },		-- Season 15 H
		{ setID = 1079, tier = 15, isPVP = true },	-- Season 15 A
		{ setID = 1080, tier = 15, isPVP = true },	-- Season 15 H
	},
	{	-- [6] Warlords of Draenor
		{ setID = 520, tier = 17 },			-- Blackrock Foundry
		{ setID = 521, tier = 17 },			-- Blackrock Foundry
		{ setID = 522, tier = 17 },			-- Blackrock Foundry
		{ setID = 581, tier = 18 },			-- Hellfire Citadel LFR (multi-class)
		{ setID = 517, tier = 18 },			-- Hellfire Citadel
		{ setID = 519, tier = 18 },			-- Hellfire Citadel
		{ setID = 518, tier = 18 },			-- Hellfire Citadel
		{ setID = 78, tier = 16, isPVP = true },		-- Warlords Season 1 A
		{ setID = 77, tier = 16, isPVP = true },		-- Warlords Season 1 H
		{ setID = 144, tier = 16, isPVP = true },		-- Warlords Season 1 A
		{ setID = 143, tier = 16, isPVP = true },		-- Warlords Season 1 H
		{ setID = 1144, tier = 16, isPVP = true },	-- Warlords Season 1 A
		{ setID = 1145, tier = 16, isPVP = true },	-- Warlords Season 1 H
		{ setID = 29, tier = 17, isPVP = true },		-- Warlords Season 2 A
		{ setID = 30, tier = 17, isPVP = true },		-- Warlords Season 2 H
		{ setID = 100, tier = 17, isPVP = true },		-- Warlords Season 2 A
		{ setID = 99, tier = 17, isPVP = true },		-- Warlords Season 2 H
		{ setID = 1179, tier = 17, isPVP = true },	-- Warlords Season 2 A
		{ setID = 1180, tier = 17, isPVP = true },	-- Warlords Season 2 H
		{ setID = 53, tier = 18, isPVP = true },		-- Warlords Season 3 A
		{ setID = 54, tier = 18, isPVP = true },		-- Warlords Season 3 H
		{ setID = 122, tier = 18, isPVP = true },		-- Warlords Season 3 A
		{ setID = 121, tier = 18, isPVP = true },		-- Warlords Season 3 H
		{ setID = 1210, tier = 18, isPVP = true },	-- Warlords Season 3 A
		{ setID = 1211, tier = 18, isPVP = true },	-- Warlords Season 3 H
	},
	{	-- [7] Legion
		{ setID = 160 },							-- Legion Invasions
		{ setID = 516 },							-- Legion Order Hall
		{ setID = 989, tier = 19 },			-- The Nighthold
		{ setID = 986, tier = 19 },			-- The Nighthold
		{ setID = 987, tier = 19 },			-- The Nighthold
		{ setID = 988, tier = 19 },			-- The Nighthold
		{ setID = 174, tier = "/" },			-- Trial of Valor
		{ setID = 172, tier = "/" },			-- Trial of Valor
		{ setID = 171, tier = "/" },			-- Trial of Valor
		{ setID = 173, tier = "/" },			-- Trial of Valor
		{ setID = 1323, tier = 20 },			-- Tomb of Sargeras
		{ setID = 1321, tier = 20 },			-- Tomb of Sargeras
		{ setID = 1324, tier = 20 },			-- Tomb of Sargeras
		{ setID = 1322, tier = 20 },			-- Tomb of Sargeras
		{ setID = 1491, tier = 21 },			-- Antorus
		{ setID = 1488, tier = 21 },			-- Antorus
		{ setID = 1489, tier = 21 },			-- Antorus
		{ setID = 1490, tier = 21 },			-- Antorus
		
		{ setID = 1450, tier = "/"},            -- Trial of Style
		{ setID = 1457, tier = "/"},            -- Time's Keeper (Chromie scenario)
		{ setID = 1471, tier = 21},             -- Seat of the Triumvirate
		
		{ setID = 1137, tier = "19+20", isPVP = true,
			["DEATHKNIGHT"] = 1163,				-- Manual fix, this set has no proper label in the table returned by the game
		},		-- Legion Season 1 and 2 A
		{ setID = 1159, tier = "19+20", isPVP = true },		-- Legion Season 1 and 2 H
		{ setID = 1094, tier = "19+20", isPVP = true },		-- Legion Season 1 and 2 A
		{ setID = 1093, tier = "19+20", isPVP = true },		-- Legion Season 1 and 2 H
		{ setID = 1096, tier = "19+20", isPVP = true },		-- Legion Season 1 and 2 A
		{ setID = 1095, tier = "19+20", isPVP = true },		-- Legion Season 1 and 2 H
		{ setID = 1284, tier = "21+22", isPVP = true },		-- Legion Season 3 and 4 A
		{ setID = 1283, tier = "21+22", isPVP = true },		-- Legion Season 3 and 4 H
		{ setID = 1249, tier = "21+22", isPVP = true },		-- Legion Season 3 and 4 A
		{ setID = 1250, tier = "21+22", isPVP = true },		-- Legion Season 3 and 4 H
		{ setID = 1251, tier = "21+22", isPVP = true },		-- Legion Season 3 and 4 A
		{ setID = 1252, tier = "21+22", isPVP = true },		-- Legion Season 3 and 4 H
		{ setID = 1364, tier = "23-25", isPVP = true },		-- Legion Season 5, 6 and 7 A
		{ setID = 1365, tier = "23-25", isPVP = true },		-- Legion Season 5, 6 and 7 H
		{ setID = 1384, tier = "23-25", isPVP = true },		-- Legion Season 5, 6 and 7 A
		{ setID = 1385, tier = "23-25", isPVP = true },		-- Legion Season 5, 6 and 7 H
	},
    
	{  -- [8] Battle for Azeroth
		{ setID = 1641, tier = 22 },                         -- Uldir
		{ setID = 1638, tier = 22 },                         -- Uldir
		{ setID = 1639, tier = 22 },                         -- Uldir
		{ setID = 1640, tier = 22 },                         -- Uldir

		{ setID = 1807, tier = 23 },                         -- Battle of Dazar'alor
		{ setID = 1806, tier = 23 },                         -- Battle of Dazar'alor
		{ setID = 1808, tier = 23 },                         -- Battle of Dazar'alor
		{ setID = 1809, tier = 23 },                         -- Battle of Dazar'alor

		{ setID = 1845, tier = 24 },                         -- Eternal Palace
		{ setID = 1833, tier = 24 },                         -- Eternal Palace
		{ setID = 1837, tier = 24 },                         -- Eternal Palace
		{ setID = 1841, tier = 24 },                         -- Eternal Palace

		{ setID = 1995, tier = 25 },                         -- Nya'lotha
		{ setID = 1994, tier = 25 },                         -- Nya'lotha
		{ setID = 1996, tier = 25 },                         -- Nya'lotha
		{ setID = 1997, tier = 25 },                         -- Nya'lotha


		{ setID = 1656, tier = "22", isPVP = true },             -- BfA Season 1 Warfront A
		{ setID = 1655, tier = "22", isPVP = true },             -- BfA Season 1 Aspirant A
		{ setID = 1654, tier = "22", isPVP = true },             -- BfA Season 1 Gladiator A
		{ setID = 1738, tier = "22", isPVP = true },             -- BfA Season 1 Elite A
		{ setID = 1668, tier = "22", isPVP = true },             -- BfA Season 1 Warfront H
		{ setID = 1666, tier = "22", isPVP = true },             -- BfA Season 1 Aspirant H
		{ setID = 1667, tier = "22", isPVP = true },             -- BfA Season 1 Gladiator H
		{ setID = 1734, tier = "22", isPVP = true },             -- BfA Season 1 Elite H

		{ setID = 1796, tier = "23", isPVP = true },             -- BfA Season 2 Warfront A
		{ setID = 1797, tier = "23", isPVP = true },             -- BfA Season 2 Aspirant A
		{ setID = 1802, tier = "23", isPVP = true },             -- BfA Season 2 Gladiator A
		{ setID = 1801, tier = "23", isPVP = true },             -- BfA Season 2 Elite A
		{ setID = 1766, tier = "23", isPVP = true },             -- BfA Season 2 Warfront H
		{ setID = 1767, tier = "23", isPVP = true },             -- BfA Season 2 Aspirant H
		{ setID = 1772, tier = "23", isPVP = true },             -- BfA Season 2 Gladiator H
		{ setID = 1771, tier = "23", isPVP = true },             -- BfA Season 2 Elite H

		{ setID = 1851, tier = "24", isPVP = true },             -- BfA Season 3 Aspirant A
		{ setID = 1846, tier = "24", isPVP = true },             -- BfA Season 3 Gladiator A
		{ setID = 1847, tier = "24", isPVP = true },             -- BfA Season 3 Elite A
		{ setID = 1892, tier = "24", isPVP = true },             -- BfA Season 3 Aspirant H
		{ setID = 1897, tier = "24", isPVP = true },             -- BfA Season 3 Gladiator H
		{ setID = 1896, tier = "24", isPVP = true },             -- BfA Season 3 Elite H

		{ setID = 1969, tier = "25", isPVP = true },             -- BfA Season 4 Gladiator
		{ setID = 1968, tier = "25", isPVP = true },             -- BfA Season 4 Elite A
		{ setID = 1975, tier = "25", isPVP = true },             -- BfA Season 4 Elite H

		--[[
		-- Heritage sets:
		{ setID = 1522, tier = "/" },       -- Allied Race: Highmountain
		{ setID = 1523, tier = "/" },       -- Allied Race: Nightbourne
		{ setID = 1524, tier = "/" },       -- Void Elf
		{ setID = 1525, tier = "/" },       -- Lightforged
		{ setID = 1679, tier = "/" },       -- Dark Iron
		{ setID = 1680, tier = "/" },       -- Mag'har?
		{ setID = 1681, tier = "/" },       -- Mag'har?
		{ setID = 1682, tier = "/" },       -- Mag'har?
		{ setID = 1741, tier = "/" },       -- Kul'tiran
		{ setID = 1742, tier = "/" },       -- Zandalari
		{ setID = 1789, tier = "/" },       -- Night Elf?
		{ setID = 1803, tier = "/" },       -- Dwarf
		{ setID = 1804, tier = "/" },       -- Blood Elf
		{ setID = 1828, tier = "/" },       -- Gnomes
		{ setID = 1829, tier = "/" },       -- Tauren
		{ setID = 1976, tier = "/" },       -- Worgen
		{ setID = 1977, tier = "/" },       -- Goblin
		{ setID = 1980, tier = "/" },       -- Mechagnome
		{ setID = 1981, tier = "/" },       -- Vulpera
		--]]

		-- Misc:
		--{ setID = 1823},        -- Brawler's Guild H
		--{ setID = 1822},        -- Brawler's Guild A
		{ setID = 1827},                      -- Trial of Style
		--{ setID = 1902},                      -- RAF
		--{ setID = 1903},                      -- Blizzcon
		--{ setID = 1913},                      -- Eternal Traveler

		-- Looks like sets that don't have alternatives don't work. Trial of Style has a cloth/leather/etc alternative, but Eternal Traveler is just one set for every class.
	},
	{  -- [9] Shadowlands
		{ setID = 2015, tier = 26 },        -- 9.0 Covenant - Bastion - Cloth - Gold
		{ setID = 2016, tier = 26 },        -- 9.0 Covenant - Bastion - Cloth - White
		{ setID = 2017, tier = 26 },        -- 9.0 Covenant - Bastion - Cloth - Bronze
		{ setID = 2018, tier = 26 },        -- 9.0 Covenant - Bastion - Cloth - Black
		{ setID = 2031, tier = 26 },        -- Rationale of Maldraxxus
		{ setID = 2032, tier = 26 },        -- Rationale of Maldraxxus
		{ setID = 2033, tier = 26 },        -- Rationale of Maldraxxus
		{ setID = 2034, tier = 26 },        -- Rationale of Maldraxxus
		{ setID = 2047, tier = 26 },        -- Faewoven Regalia
		{ setID = 2048, tier = 26 },        -- Night Courtier's Regalia
		{ setID = 2049, tier = 26 },        -- Conservator's Regalia
		{ setID = 2050, tier = 26 },        -- Regalia of the Winter Queen
		{ setID = 2063, tier = 26 },        -- Soulbreaker's Crimson Vestments
		{ setID = 2064, tier = 26 },        -- Soulbreaker's Burnished Vestments
		{ setID = 2065, tier = 26 },        -- Soulbreaker's Court Vestments
		{ setID = 2066, tier = 26 },        -- Soulbreaker's Ebony Vestments
		--{ setID = 2086, tier = 26 },        -- Night Fae Renown Cloth
		--{ setID = 2087, tier = 26 },        -- Night Fae Renown Cloth
	},
}

addon:Service("AltoholicUI.TransmogSetsLists",  function() 

	local pvpSortedDescriptions = {}
	
	return {
		Initialize = function()
			local function SetMatchesRefenceSet(set, referenceSet)
				-- we will be trying to find sets that have the same properties as the reference set
				-- ex:	
				--		["description"] = "Combatant",
				-- 	["label"] = "Warlords Season 2",
				-- 	["expansionID"] = 5,
				-- 	["requiredFaction"] = "Alliance",
				-- Note : Do not use ["uiOrder"], it may differ for sets of the same tier (blizzard bug I guess)

				-- if any basic property does not match, exit
				if set.description ~= referenceSet.description or
					set.label ~= referenceSet.label or
					set.expansionID ~= referenceSet.expansionID  then
					return false
				end

				-- if a required faction is defined, and it does not match, exit
				if set.requiredFaction and referenceSet.requiredFaction and
					set.requiredFaction ~= referenceSet.requiredFaction then
					return false
				end

				-- everything matches, we found a matching set
				return true
			end
			
			local classMasks = {
				[1] = "WARRIOR",
				[2] = "PALADIN",
				[4] = "HUNTER",
				[8] = "ROGUE",
				[16] = "PRIEST",
				[32] = "DEATHKNIGHT",
				[64] = "SHAMAN",
				[128] = "MAGE",
				[256] = "WARLOCK",
				[512] = "MONK",
				[1024] = "DRUID",
				[2048] = "DEMONHUNTER"
			}	
		
			local bAnd = bit.band
		
			local sets = C_TransmogSets.GetAllSets()
			local setIndexes = {}

			-- determine indexes for sets: [set id 13] = position 1
			for index, set in ipairs(sets) do
				setIndexes[set.setID] = index
			end

			local pvpDescriptions = {}
			
			-- browse tracked sets
			for xpackIndex, xpack in ipairs(transmogSets) do
				for setInfoIndex, setInfo in ipairs(xpack) do
					local setID = setInfo.setID
					local refSet = sets[setIndexes[setID]]	-- reference set : mage

					local matchCount = 0
					
					-- browse all sets
					for _, set in ipairs(sets) do
						-- attempt to match current set with the reference (ie: part of the same tier ?)
						if SetMatchesRefenceSet(set, refSet) then
							-- some sets are for multiple classes ..
							for classMask, class in pairs(classMasks) do
								-- check if the bit for that class is set ..
								if bAnd(set.classMask, classMask) ~= 0 then
									setInfo[class] = set.setID		-- .. if yes, apply the set id
								end
							end

							setInfo.label = set.label
							setInfo.description = set.description
							setInfo.requiredFaction = set.requiredFaction
						
							-- keep track of pvp descriptions
							if set.description and setInfo.isPVP then
								pvpDescriptions[set.description] = true
							end
						
							-- save some cpu cycles, when 12 sets are found matching the reference, break the loop
							matchCount = matchCount + 1
							if matchCount == 12 then break end
						end
					end
				end
			end
			
			for desc, _ in pairs(pvpDescriptions) do
				table.insert(pvpSortedDescriptions, desc)
			end
			table.sort(pvpSortedDescriptions)
		end,
	
		Get = function()
			return transmogSets
		end,
		
		GetPvPDescriptions = function()
			return pvpSortedDescriptions
		end,
}end)