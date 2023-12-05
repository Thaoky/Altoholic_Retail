local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local MVC = LibStub("LibMVC-1.0")
local Columns = MVC:GetService("AltoholicUI.TabSummaryColumns")
local Formatter = MVC:GetService("AltoholicUI.Formatter")

-- *** Utility functions ***

-- ** Keystones **
Columns.RegisterColumn("KeyName", {
	-- Header
	headerWidth = 180,
	headerLabel = format("%s  %s", Formatter.Texture18("Interface\\Icons\\inv_relics_hourglass"), L["COLUMN_KEYNAME_TITLE_SHORT"]),
	tooltipTitle = L["COLUMN_KEYNAME_TITLE"],
	tooltipSubTitle = L["COLUMN_KEYNAME_SUBTITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("KeyName") end,
	headerSort = DataStore.GetKeystoneName,
	
	-- Content
	Width = 180,
	JustifyH = "CENTER",
	GetText = function(character) 
		return Formatter.GreyIfEmpty(DataStore:GetKeystoneName(character))
	end,
})

Columns.RegisterColumn("KeyLevel", {
	-- Header
	headerWidth = 60,
	headerLabel = L["COLUMN_LEVEL_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_KEYLEVEL_TITLE"],
	tooltipSubTitle = L["COLUMN_KEYLEVEL_SUBTITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("KeyLevel") end,
	headerSort = DataStore.GetKeystoneLevel,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = DataStore:GetKeystoneLevel(character) or 0
		local color = (level == 0) and colors.grey or colors.yellow
	
		return format("%s%d", color, level)	
	end,
})

Columns.RegisterColumn("DungeonScore", {
	-- Header
	headerWidth = 120,
	headerLabel = DUNGEON_SCORE,
	tooltipTitle = DUNGEON_SCORE,
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("DungeonScore") end,
	headerSort = DataStore.GetDungeonScore,
	
	-- Content
	Width = 120,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = DataStore:GetDungeonScore(character) or 0
		local color = (level == 0) and colors.grey or colors.yellow
	
		return format("%s%d", color, level)	
	end,
})

Columns.RegisterColumn("WeeklyBestKeyName", {
	-- Header
	headerWidth = 110,
	headerLabel = format("%s  %s", Formatter.Texture18("Interface\\Icons\\achievement_challengemode_gold"), CHALLENGE_MODE_WEEKLY_BEST),
	tooltipTitle = L["COLUMN_WEEKLYBEST_KEYNAME_TITLE"],
	tooltipSubTitle = L["COLUMN_WEEKLYBEST_KEYNAME_SUBTITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("WeeklyBestKeyName") end,
	headerSort = DataStore.GetWeeklyBestKeystoneName,
	
	-- Content
	Width = 110,
	JustifyH = "CENTER",
	GetText = function(character) 
		return Formatter.GreyIfEmpty(DataStore:GetWeeklyBestKeystoneName(character))
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Stats", character) then
				return
			end
			
			local level = DataStore:GetWeeklyBestKeystoneLevel(character) or 0
			if level == 0 then return end
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), CHALLENGE_MODE_WEEKLY_BEST)
			tt:AddLine(" ")
			
			-- Get this character's dungeons
			local dungeons = DataStore:GetDungeonStats(character)
			
			for mapID, info in pairs(dungeons) do
				-- Add season best lines
				if info.weeklyBestLevel then
					local name, _, _, texture = C_ChallengeMode.GetMapUIInfo(mapID)
				
					tt:AddDoubleLine(
						format("%s %s %s+%d", Formatter.Texture18(texture), name, colors.green, info.weeklyBestLevel), 
						Formatter.Duration(info.weeklyBestTimeInSeconds)
					)
				end
			end			

			tt:Show()
		end,	
})

Columns.RegisterColumn("WeeklyBestKeyLevel", {
	-- Header
	headerWidth = 60,
	headerLabel = L["COLUMN_LEVEL_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_WEEKLYBEST_KEYLEVEL_TITLE"],
	tooltipSubTitle = L["COLUMN_WEEKLYBEST_KEYLEVEL_SUBTITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("WeeklyBestKeyLevel") end,
	headerSort = DataStore.GetWeeklyBestKeystoneLevel,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = DataStore:GetWeeklyBestKeystoneLevel(character) or 0
		local color = (level == 0) and colors.grey or colors.yellow
	
		return format("%s%d", color, level)	
	end,
})

Columns.RegisterColumn("WeeklyBestKeyTime", {
	-- Header
	headerWidth = 90,
	headerLabel = format("%s  %s", Formatter.Texture18("Interface\\Icons\\spell_holy_borrowedtime"), BEST),
	tooltipTitle = L["COLUMN_WEEKLYBEST_KEYTIME_TITLE"],
	tooltipSubTitle = L["COLUMN_WEEKLYBEST_KEYTIME_SUBTITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("WeeklyBestKeyTime") end,
	headerSort = DataStore.GetWeeklyBestKeystoneTime,

	-- Content
	Width = 90,
	JustifyH = "CENTER",
	GetText = function(character) 
		local seconds = DataStore:GetWeeklyBestKeystoneTime(character) or 0
		return Formatter.Duration(seconds)
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Stats", character) then
				return
			end
			
			local level = DataStore:GetWeeklyBestKeystoneLevel(character) or 0
			if level == 0 then return end
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), MYTHIC_PLUS_SEASON_BEST)
			tt:AddLine(" ")

			-- Get this character's dungeons
			local dungeons = DataStore:GetDungeonStats(character)
			
			for mapID, info in pairs(dungeons) do
				-- Add season best lines
				if info.seasonBestLevel then
					local name, _, _, texture = C_ChallengeMode.GetMapUIInfo(mapID)
				
					tt:AddDoubleLine(
						format("%s %s %s+%d", Formatter.Texture18(texture), name, colors.green, info.seasonBestLevel), 
						Formatter.Duration(info.seasonBestTimeInSeconds)
					)
				end
			end

			-- second pass for overtime
			local isHeaderShownYet = false
			
			for mapID, info in pairs(dungeons) do
				-- Add season best lines
				if info.seasonBestOvertimeLevel then
					local name, _, _, texture = C_ChallengeMode.GetMapUIInfo(mapID)
				
					if not isHeaderShownYet then
						tt:AddLine(" ")
						tt:AddLine(MYTHIC_PLUS_OVERTIME_SEASON_BEST, 1, 1, 1)
						tt:AddLine(" ")
						
						isHeaderShownYet = true
					end
				
					tt:AddDoubleLine(
						format("%s %s %s+%d", Formatter.Texture18(texture), name, colors.green, info.seasonBestOvertimeLevel), 
						Formatter.Duration(info.seasonBestOvertimeTimeInSeconds)
					)
				end
			end

			tt:Show()
		end,
})


-- ** Weekly Rewards **

-- Source : https://www.wowhead.com/guide/mythic-plus-dungeons/dragonflight-season-1/rewards
local greatVaultItemLevels = {
	0, 382, 385, 385, 389,
	389, 392, 395, 395, 398,
	402, 405, 408, 408, 411,
	415, 415, 418, 418, 421
}

Columns.RegisterColumn("RewardMythic", {
	-- Header
	headerWidth = 120,
	headerLabel = CHALLENGES,
	tooltipTitle = CHALLENGES,
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("RewardMythic") end,
	headerSort = DataStore.GetWeeklyMythicPlusReward,
	
	-- Content
	Width = 120,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = DataStore:GetWeeklyMythicPlusReward(character) or 0
		local color = (level == 0) and colors.grey or colors.white
		
		if level > 8 then level = 8 end
		
		return format("%s%s%s/%s%s", color, level, colors.white, colors.yellow, 8)
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Stats", character) then
				return
			end
			
			-- Get the top 10 runs this week
			local top10runs = DataStore:GetWeeklyTop10Runs(character)
			if not top10runs or #top10runs == 0 then return end
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), format(WEEKLY_REWARDS_MYTHIC_TOP_RUNS, 10))
			tt:AddLine(" ")
			
			-- Add the top 10 runs
			for _, run in pairs(top10runs) do
				local mapName = C_ChallengeMode.GetMapUIInfo(run.mapID)
				local rewardLevel = (run.level <= 20) and run.level or 20
				
				tt:AddDoubleLine(
					format("%s+%d|r %s%s", colors.green, run.level, colors.white, mapName), 
					format("%s%d", colors.epic, greatVaultItemLevels[rewardLevel])
				)
			end
			
			-- Add the break down by dungeon
			tt:AddLine(" ")
			tt:AddLine(DUNGEONS)
			
			local dungeons = DataStore:GetDungeonStats(character)
			local runLevels = {}
			
			for mapID, dungeonInfo in pairs(dungeons) do
				local mapName = C_ChallengeMode.GetMapUIInfo(mapID)
			
				wipe(runLevels)
				
				local runHistory = DataStore:GetWeeklyRunHistory(character, mapID)
				
				if runHistory then
					for _, run in pairs(runHistory) do
						local color = run.completed and colors.green or colors.red
						
						-- build a table of levels, by color, for simple concat later on
						table.insert(runLevels, format("%s%d|r", color, run.level))
					end
					
					tt:AddDoubleLine(
						format("%s%s", colors.white, mapName),		-- map name
						table.concat(runLevels, "-")					-- list of levels for this map, descending
					)
				end
			end

			tt:AddLine(" ")
			tt:AddLine(format("%s%s", colors.green, CRITERIA_COMPLETED))
			tt:AddLine(format("%s%s", colors.red, CRITERIA_NOT_COMPLETED))

			tt:Show()
		end,	
})

Columns.RegisterColumn("RewardRaid", {
	-- Header
	headerWidth = 80,
	headerLabel = RAIDS,
	tooltipTitle = RAIDS,
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("RewardRaid") end,
	headerSort = DataStore.GetWeeklyRaidReward,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = DataStore:GetWeeklyRaidReward(character) or 0
		local color = (level == 0) and colors.grey or colors.white
		
		if level > 8 then level = 8 end
		
		return format("%s%s%s/%s%s", color, level, colors.white, colors.yellow, 8)
	end,
})

Columns.RegisterColumn("RewardPvP", {
	-- Header
	headerWidth = 120,
	headerLabel = PLAYER_V_PLAYER,
	tooltipTitle = PLAYER_V_PLAYER,
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("RewardPvP") end,
	headerSort = DataStore.GetWeeklyRankedPvPReward,
	
	-- Content
	Width = 120,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = DataStore:GetWeeklyRankedPvPReward(character) or 0
		local color = (level == 0) and colors.grey or colors.white
		
		if level > 5500 then level = 5500 end
		
		return format("%s%s%s/%s%s", color, level, colors.white, colors.yellow, 5500)
	end,
})

-- This creates maps = { [1] = 123, [2] = 234, ... } for the 8 maps of the season
local maps = C_ChallengeMode.GetMapTable()

local function GetMapName(index)
	local mapID = maps[index]
	
	return select(1, C_ChallengeMode.GetMapUIInfo(mapID))
end

local function GetMapTexture(index)
	local mapID = maps[index]
	
	return select(4, C_ChallengeMode.GetMapUIInfo(mapID))
end

local function GetWeeklyBestByDungeon(character, mapID)
	return DataStore:GetWeeklyBestByDungeon(character, mapID) or 0
end

for mapIndex = 1, 8 do

	Columns.RegisterColumn("MPlus" .. mapIndex, {
		-- Header
		headerWidth = 60,
		headerLabel = format("     %s", Formatter.Texture18(GetMapTexture(mapIndex))),
		tooltipTitle = GetMapName(mapIndex),
		tooltipSubTitle = L["COLUMN_WEEKLYBEST_DUNGEON_SUBTITLE"],
		
		headerOnClick = function() AltoholicFrame.TabSummary:SortBy("MPlus" .. mapIndex) end,
		headerSort = function(self, character) 
			return GetWeeklyBestByDungeon(character, maps[mapIndex])
		end,
		
		-- Content
		Width = 60,
		JustifyH = "CENTER",
		GetText = function(character) 
			local level = GetWeeklyBestByDungeon(character, maps[mapIndex])
			local color = (level == 0) and colors.grey or colors.green
			
			return format("%s%s", color, level)
		end,
	})

end