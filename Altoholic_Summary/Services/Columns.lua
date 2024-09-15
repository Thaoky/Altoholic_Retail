local addon = Altoholic

addon:Service("AltoholicUI.TabSummaryColumns",  function() 
	local columns = {}

	return {
		RegisterColumn = function(name, data)
			if columns[name] then
				addon:Print(format("AltoholicUI.TabSummaryColumns:RegisterColumn() : Column %s already registered", name))
				return
			end
			
			columns[name] = data
		end,
		Get = function(name)
			return columns[name]
		end,
}end)

addon:Service("AltoholicUI.TabSummaryColumnProfiles",  function() 
	local profiles = {
		-- Account Summary
		[1] = { "Name", "Level", "RestXP", "Money", "Played", "AiL", "LastOnline" },
		-- Experience
		[2] = { "Name", "Level", "RestXP", "MaxRestXP", "SavedRestXP", "EarnedRestXP", "FullyRestedIn" },
		-- Levels
		-- [3] = { "Name", "Level", "AiL", "HonorLevel", "Renown" },
		[3] = { "Name", "Level", "AiL", "Renown", "DungeonScore" },
		-- Guild
		[4] = { "Name", "Level", "GuildName", "GuildRank", "GuildRep" },
		-- Location
		[5] = { "Name", "Level", "Hearthstone", "Zone", "SubZone" },
		-- Miscellaneous
		[6] = { "Name", "Level", "ClassAndSpec", "BankType", "AltGroup" },

		-- Bags
		[7] = { "Name", "Level", "BagSlots", "FreeBagSlots", "BankSlots", "FreeBankSlots" },
		-- Skills
		[8] = { "Name", "Level", "Prof1", "Prof2", "ProfCooking", "ProfFishing", "ProfArchaeology", "Riding" },
		-- Activity
		[9] = { "Name", "Level", "Mails", "LastMailCheck", "Auctions", "Bids", "AHLastVisit", "MissionTableLastVisit" },
		
		-- Currencies / Miscellaneous
		[10] = { "Name", "Level", "Cur_TimewarpedBadge", "Cur_Darkmoon", "Cur_Epicurean", "Cur_Ironpaw", "Cur_SpiritShard", "Cur_ChampionsSeal" },
		-- Currencies / Cataclysm
		[11] = { "Name", "Level", "Cur_Deathwing", "Cur_MoteDarkness", "Cur_MarkWorldTree", "Cur_IllustrJC" },
		-- Currencies / Mists of Pandaria
		[12] = { "Name", "Level", "Cur_Bloody", "Cur_ElderCharm", "Cur_LesserCharm", "Cur_MoguRune", "Cur_TimelessCoin", "Cur_WarforgedSeal" },
		-- Currencies / Warlords of Draenor
		[13] = { "Name", "Level", "Cur_Garrison", "Cur_Oil", "Cur_Apexis", "Cur_InevitableFate", "Cur_TemperedFate", "Cur_ArtifactFragment" },
		-- Currencies / Legion
		[14] = { "Name", "Level", "Cur_OrderHall", "Cur_WarSupplies", "Cur_Nethershard", "Cur_BrokenFate", "Cur_SightlessEye", "Cur_AncientMana", "Cur_VeiledArgunite" },
		-- Currencies / Battle for Azeroth
		[15] = { "Name", "Level", "Cur_WarResources", "Cur_WartornFate", "Cur_BfADubloons", "Cur_BfAWarSupplies", "Cur_BfARichAzerite" },
		-- Currencies / Shadowlands 9.0
		[16] = { "Name", "Level", "Cur_Stygia", "Cur_Anima", "Cur_RedeemedSoul", "Cur_Valor", "Cur_Conquest", "Cur_SoulAsh" },
		-- Currencies / Shadowlands 9.1
		[17] = { "Name", "Level", "Cur_CatalogedResearch", "Cur_TowerKnowledge", "Cur_StygianEmber", "Cur_SoulCinders" },
		
		-- Expansion Features / Draenor / Garrisons
		[18] = { "Name", "Level", "FollowersLV40", "FollowersEpic", "FollowersLV630", "FollowersLV660", "FollowersLV675", "FollowersItems" },
		
		-- Expansion Features / Legion / Artifact
		-- [19] = { "Name", "Level", "ArtifactRank", "ArtifactPower", "ArtifactKnowledge", "ArtifactNextResearch" },

		-- Expansion Features / Shadowlands / Covenant Sanctums
		[20] = { "Name", "Level", "CovenantName", "SoulbindName", "Renown", "Story90" },
		-- Expansion Features / Shadowlands / Sanctum Reservoir
		[21] = { "Name", "Level", "CovenantName", "TransportNetwork", "AnimaConductor", "CommandTable", "SanctumUnique" },

		-- Mythic Keystones
		[22] = { "Name", "Level", "KeyName", "KeyLevel", "WeeklyBestKeyName", "WeeklyBestKeyLevel", "WeeklyBestKeyTime" },
	
		-- Currencies / Shadowlands 9.2
		[23] = { "Name", "Level", "Cur_Cyphers", "Cur_CosmicFlux" },
		-- Expansion Features / Shadowlands / Campaign Progress
		[24] = { "Name", "Level", "Story90", "StoryTorghast", "Story91", "Story92" },
		-- Expansion Features / Shadowlands / Cypher Research
		[25] = { "Name", "Level", "CypherLvl", "Metrial", "Aealic", "Dealic", "Trebalim", "Cur_Cyphers" },
		
		-- Weekly Rewards
		[26] = { "Name", "Level", "RewardRaid", "RewardDungeons", "RewardWorld" },

		-- Currencies / Dragonflight 10.0
		[27] = { "Name", "Level", "Cur_DragonIslesSupplies", "Cur_ElementalOverflow", "Cur_StormSigil", "Cur_ConquestPoints", "Cur_Honor" },

		-- Currencies / Dragonflight 10.1
		[28] = { "Name", "Level", "Cur_Flightstones", "Cur_ParacausalFlakes", "Cur_RidersofAzerothBadge" },

		-- Currencies / Dragonflight 10.2
		[29] = { "Name", "Level", "Cur_EmeraldDewdrop","Cur_WhelplingsDreamingCrest", "Cur_DrakesDreamingCrest", "Cur_WyrmsDreamingCrest", "Cur_AspectsDreamingCrest", "Cur_DreamInfusion", "Cur_MysteriousFragment" },
		
		-- Weekly Best Runs per dungeon
		[30] = { "Name", "Level", "MPlus1", "MPlus2", "MPlus3", "MPlus4", "MPlus5", "MPlus6", "MPlus7", "MPlus8" },
		
		-- Expansion Features / Dragonflight / Campaign Progress
		[31] = { "Name", "Level", "Story100", "Story101", "Story1015", "Story102" },
		
		-- Currencies / War Within 11.0
		[32] = { "Name", "Level", "Cur_ResidualMemories", "Cur_ResonanceCrystals", "Cur_Kej", "Cur_Valorstones", "Cur_MereldarDerbyMark", "Cur_RestoredCofferKey" },
		
		-- Currencies / War Within 11.0 / Season 1
		[33] = { "Name", "Level", "Cur_WeatheredCrest", "Cur_CarvedCrest", "Cur_RunedCrest", "Cur_GildedCrest", "Cur_Undercoin" },

	}

	return {
		Get = function(index)
			return profiles[index]
		end,
}end)
