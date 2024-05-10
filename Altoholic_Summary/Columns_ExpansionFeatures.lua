local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = DataStore:GetLocale(addonName)
local MVC = LibStub("LibMVC-1.0")
local Columns = MVC:GetService("AltoholicUI.TabSummaryColumns")
local Formatter = MVC:GetService("AltoholicUI.Formatter")

local CRITERIA_COMPLETE_ICON = "\124TInterface\\AchievementFrame\\UI-Achievement-Criteria-Check:14\124t"

-- *** Utility functions ***
local function GetRarityLevel(self, character)
	local numEpic = DataStore:GetNumEpicFollowers(character) or 0
	local numRare = DataStore:GetNumRareFollowers(character) or 0
	
	return numEpic + (numRare / 100)
end

local function GetFollowersLevel615To630(self, character)
	local num615 = DataStore:GetNumFollowersAtiLevel615(character) or 0
	local num630 = DataStore:GetNumFollowersAtiLevel630(character) or 0
	
	return num630 + (num615 / 100)
end

local function GetFollowersLevel645To660(self, character)
	local num645 = DataStore:GetNumFollowersAtiLevel645(character) or 0
	local num660 = DataStore:GetNumFollowersAtiLevel660(character) or 0
	
	return num660 + (num645 / 100)
end

local function GetFollowersItemLevel(self, character)
	local avgWeapon = DataStore:GetAvgWeaponiLevel(character) or 0
	local avgArmor = DataStore:GetAvgArmoriLevel(character) or 0
	
	avgWeapon = math.floor(avgWeapon*10)	-- 615.17 becomes 6151
	avgArmor = math.floor(avgArmor*10)
	
	return avgWeapon + (avgArmor / 10000)
end

local function GetColorFromAIL(level)
	if (level < 600) then return colors.grey end
	if (level <= 615) then return colors.green end
	if (level <= 630) then return colors.rare end
	return colors.epic
end

local function GetRenownLevel(self, character)
	return select(3, DataStore:GetCovenantInfo(character)) or 0
end

local function Storyline_GetText(character, storyline)
	local numCompleted = DataStore:GetStorylineProgress(character, storyline)
	local numQuests = DataStore:GetStorylineLength(storyline)
	
	return Formatter.Progress(numCompleted, numQuests)
end

local function Storyline_OnEnter(frame, campaignID, storyline)
	local character = frame:GetParent().character
	if not character then return end
	
	local numCompleted = DataStore:GetStorylineProgress(character, storyline)
	local numQuests = DataStore:GetStorylineLength(storyline)
	
	local tt = AddonFactory_Tooltip
	tt:ClearLines()
	tt:SetOwner(frame, "ANCHOR_RIGHT")
	tt:AddDoubleLine(
		DataStore:GetColoredCharacterName(character), 
		campaignID and C_CampaignInfo.GetCampaignInfo(campaignID).name or ""
	)
	tt:AddLine(" ")
	tt:AddLine(format(CAMPAIGN_PROGRESS_CHAPTERS_TOOLTIP, numCompleted, numQuests))
	
	for _, info in pairs(DataStore:GetCampaignChaptersInfo(character, campaignID, storyline)) do
		local color
		local icon = " - "
		
		if info.completed == nil then
			color = colors.grey				-- grey for not started
		elseif info.completed == false then
			color = colors.white				-- white for ongoing
		elseif info.completed == true then
			color = colors.green				-- green for completed
			icon = CRITERIA_COMPLETE_ICON
		end
		
		tt:AddLine(format("%s%s%s", icon, color, info.name))
	end
	tt:Show()
end


-- ** Garrison Followers **
Columns.RegisterColumn("FollowersLV40", {
	-- Header
	headerWidth = 70,
	headerLabel = L["COLUMN_FOLLOWERS_LV40_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_FOLLOWERS_LV40_TITLE"],
	tooltipSubTitle = L["COLUMN_FOLLOWERS_LV40_SUBTITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("FollowersLV40") end,
	headerSort = DataStore.GetNumFollowersAtLevel40,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount = DataStore:GetNumFollowers(character) or 0
			local color = (amount == 0) and colors.grey or colors.white
			local amountLv40 = DataStore:GetNumFollowersAtLevel40(character) or 0
			
			return format("%s%s/%s", color, amountLv40, amount)
		end,
})

Columns.RegisterColumn("FollowersEpic", {
	-- Header
	headerWidth = 55,
	headerLabel = L["COLUMN_FOLLOWERS_RARITY_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_FOLLOWERS_RARITY_TITLE"],
	tooltipSubTitle = L["COLUMN_FOLLOWERS_RARITY_SUBTITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("FollowersEpic") end,
	headerSort = GetRarityLevel,
	
	-- Content
	Width = 55,
	JustifyH = "CENTER",
	GetText = function(character)
			local numRare = DataStore:GetNumRareFollowers(character) or 0
			local colorRare = (numRare == 0) and colors.grey or colors.rare
			
			local numEpic = DataStore:GetNumEpicFollowers(character) or 0
			local colorEpic = (numEpic == 0) and colors.grey or colors.epic
			
			return format("%s%s%s/%s%s", colorRare, numRare, colors.white, colorEpic, numEpic)
		end,
})

Columns.RegisterColumn("FollowersLV630", {
	-- Header
	headerWidth = 70,
	headerLabel = "615/630",
	tooltipTitle = format(L["COLUMN_FOLLOWERS_ILEVEL_TITLE"], "615/630"),
	tooltipSubTitle = format(L["COLUMN_FOLLOWERS_ILEVEL_SUBTITLE"], "615 vs 630"),
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("FollowersLV630") end,
	headerSort = GetFollowersLevel615To630,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			local num615 = DataStore:GetNumFollowersAtiLevel615(character) or 0
			local color615 = (num615 == 0) and colors.grey or colors.green
			local num630 = DataStore:GetNumFollowersAtiLevel630(character) or 0
			local color630 = (num630 == 0) and colors.grey or colors.rare
			
			return format("%s%s%s/%s%s", color615, num615, colors.white, color630, num630)
		end,
})

Columns.RegisterColumn("FollowersLV660", {
	-- Header
	headerWidth = 70,
	headerLabel = "645/660",
	tooltipTitle = format(L["COLUMN_FOLLOWERS_ILEVEL_TITLE"], "645/660"),
	tooltipSubTitle = format(L["COLUMN_FOLLOWERS_ILEVEL_SUBTITLE"], "645 vs 660"),
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("FollowersLV660") end,
	headerSort = GetFollowersLevel645To660,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			local num645 = DataStore:GetNumFollowersAtiLevel645(character) or 0
			local color645 = (num645 == 0) and colors.grey or colors.epic
			local num660 = DataStore:GetNumFollowersAtiLevel660(character) or 0
			local color660 = (num660 == 0) and colors.grey or colors.epic
			
			return format("%s%s%s/%s%s", color645, num645, colors.white, color660, num660)
		end,
})

Columns.RegisterColumn("FollowersLV675", {
	-- Header
	headerWidth = 50,
	headerLabel = "675",
	tooltipTitle = format(L["COLUMN_FOLLOWERS_ILEVEL_TITLE"], "675"),
	tooltipSubTitle = format(L["COLUMN_FOLLOWERS_ILEVEL_SUBTITLE"], "675"),
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("FollowersLV675") end,
	headerSort = DataStore.GetNumFollowersAtiLevel675,
	
	-- Content
	Width = 50,
	JustifyH = "CENTER",
	GetText = function(character)
			local amount = DataStore:GetNumFollowersAtiLevel675(character) or 0
			local color = (amount == 0) and colors.grey or colors.epic
			
			return format("%s%s", color, amount)
		end,
})

Columns.RegisterColumn("FollowersItems", {
	-- Header
	headerWidth = 75,
	headerLabel = L["COLUMN_FOLLOWERS_AIL_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_FOLLOWERS_AIL_TITLE"],
	tooltipSubTitle = L["COLUMN_FOLLOWERS_AIL_SUBTITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("FollowersItems") end,
	headerSort = GetFollowersItemLevel,
	
	-- Content
	Width = 75,
	JustifyH = "CENTER",
	GetText = function(character)
			local avgWeapon = DataStore:GetAvgWeaponiLevel(character) or 0
			local colorW = GetColorFromAIL(avgWeapon)
			
			local avgArmor = DataStore:GetAvgArmoriLevel(character) or 0
			local colorA = GetColorFromAIL(avgArmor)
			
			return format("%s%.1f%s/%s%.1f", colorW, avgWeapon, colors.white, colorA, avgArmor)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Garrisons", character) then
				return
			end
			
			local avgWeapon = DataStore:GetAvgWeaponiLevel(character) or 0
			local colorW = GetColorFromAIL(avgWeapon)
			local avgArmor = DataStore:GetAvgArmoriLevel(character) or 0
			local colorA = GetColorFromAIL(avgArmor)
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddLine(DataStore:GetColoredCharacterName(character),1,1,1)
			tt:AddLine(" ")
			tt:AddLine(format("%s: %s%.1f", WEAPON, colorW, avgWeapon),1,1,1)
			tt:AddLine(format("%s: %s%.1f", ARMOR, colorA, avgArmor),1,1,1)
			tt:Show()
		end,
})

-- ** Legion Artifact **
-- Refer to 7.3 sources, no longer in-game at all.

-- ** Covenant Sanctums **
local playStyles = {
	["main"] = L["Overall"],
	["raid"] = CALENDAR_TYPE_RAID,
	["mythic"] = MYTHIC_DUNGEONS,
	["torghast"] = L["Torghast"],
	["single"] = L["Single target build"],
	["aoe"] = L["AOE build"],
}

Columns.RegisterColumn("CovenantName", {
	-- Header
	headerWidth = 80,
	headerLabel = L["COLUMN_COVENANT_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_COVENANT_TITLE"],
	tooltipSubTitle = L["COLUMN_COVENANT_SUBTITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("CovenantName") end,
	headerSort = DataStore.GetCovenantName,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character) 
		return Formatter.GreyIfEmpty(DataStore:GetCovenantName(character))
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			-- Get the class ID, may be unknown if the character has not been logged in yet.
			local _, englishClass, classID = DataStore:GetCharacterClass(character)
			if not classID then return end
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["Recommended Covenant"])
			
			for i = 1, GetNumSpecializationsForClassID(classID) do
				local _, specName, _, iconID = GetSpecializationInfoForClassID(classID, i)
				-- local icon = addon:GetSpellIcon(iconID)
				
				tt:AddLine(" ")
				tt:AddLine(format("%s%s", colors.gold, specName))
				-- tt:AddDoubleLine(format("%s%s", colors.white, specName), format(TEXTURE_FONT, icon, 18, 18))
				
				local info = DataStore:GetRecommendedCovenant(englishClass, i)
				
				for context, bestCovenantID in pairs(info) do
					local text = (playStyles[context]) and playStyles[context]

					if context == "choice1" then
						-- Maybe we have 2 equally viable choices
						tt:AddLine(format("%s%s : %s%s, %s", colors.white, L["Equally viable"], colors.cyan,
							DataStore:GetCovenantNameByID(info.choice1), 
							DataStore:GetCovenantNameByID(info.choice2)))
					elseif text then
						tt:AddLine(format("%s%s : %s%s", colors.white, text, colors.cyan, DataStore:GetCovenantNameByID(bestCovenantID)))
					end
					
				end
			end
			
			tt:Show()
		end,
	OnClick = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local covenantID = DataStore:GetCovenantInfo(character)
			if not covenantID or covenantID == 0 then return end

			addon:ShowCharacterPanel(character, "Soulbinds")
		end,
})

Columns.RegisterColumn("SoulbindName", {
	-- Header
	headerWidth = 120,
	headerLabel = L["COLUMN_SOULBIND_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_SOULBIND_TITLE"],
	tooltipSubTitle = L["COLUMN_SOULBIND_SUBTITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("SoulbindName") end,
	headerSort = DataStore.GetActiveSoulbindName,
	
	-- Content
	Width = 120,
	JustifyH = "CENTER",
	GetText = function(character) 
		return Formatter.GreyIfEmpty(DataStore:GetActiveSoulbindName(character))
	end,
	OnEnter = function(frame)
		local character = frame:GetParent().character
		if not character then return end
		
		-- Get the 4 levels, if their sum is higher than 0, it means we have some data and the
		-- Sanctum Reservoir has been visited
		local name = DataStore:GetActiveSoulbindName(character)
		
		if name and name ~= "" then return end
		
		-- If not, display a message
		local tt = AddonFactory_Tooltip
		tt:ClearLines()
		tt:SetOwner(frame, "ANCHOR_RIGHT")
		tt:AddLine(L["COLUMN_SOULBIND_NODATA"])
		tt:Show()
	end,
	
	OnClick = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local covenantID = DataStore:GetCovenantInfo(character)
			if not covenantID or covenantID == 0 then return end

			addon:ShowCharacterPanel(character, "Soulbinds")
		end,
})

Columns.RegisterColumn("Renown", {
	-- Header
	headerWidth = 90,
	headerLabel = format("%s  %s", Formatter.Texture18("Interface\\Icons\\inv_misc_covenant_renown"), COVENANT_SANCTUM_TAB_RENOWN),
	tooltipTitle = L["COLUMN_RENOWN_TITLE"],
	tooltipSubTitle = L["COLUMN_RENOWN_SUBTITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("Renown") end,
	headerSort = GetRenownLevel,
	
	-- Content
	Width = 90,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = select(3, DataStore:GetCovenantInfo(character))
		local color = (level == 80) and colors.gold or colors.white
	
		return format("%s%s", color, level)
	end,
	OnClick = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local covenantID = DataStore:GetCovenantInfo(character)
			if not covenantID or covenantID == 0 then return end

			addon:ShowCharacterPanel(character, "Renown")
		end,
})

Columns.RegisterColumn("Story90", {
	-- Header
	headerWidth = 70,
	headerLabel = format("%s %s9.0", L["COLUMN_CAMPAIGNPROGRESS_TITLE_SHORT"], colors.green),
	tooltipTitle = L["COLUMN_CAMPAIGNPROGRESS_TITLE"],
	tooltipSubTitle = L["COLUMN_CAMPAIGNPROGRESS_SUBTITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("Story90") end,
	headerSort = DataStore.GetCovenantCampaignProgress,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character) 
		local numCompleted = DataStore:GetCovenantCampaignProgress(character)
		local numQuests = DataStore:GetCovenantCampaignLength(character)
		
		return Formatter.Progress(numCompleted, numQuests)
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local numCompleted = DataStore:GetCovenantCampaignProgress(character)
			local numQuests = DataStore:GetCovenantCampaignLength(character)
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), DataStore:GetCovenantName(character))
			tt:AddLine(" ")
			tt:AddLine(format(CAMPAIGN_PROGRESS_CHAPTERS_TOOLTIP, numCompleted, numQuests))
			
			for _, info in pairs(DataStore:GetCovenantCampaignChaptersInfo(character)) do
				local color
				local icon = " - "
				
				if info.completed == nil then
					color = colors.grey				-- grey for not started
				elseif info.completed == false then
					color = colors.white				-- white for ongoing
				elseif info.completed == true then
					color = colors.green				-- green for completed
					icon = CRITERIA_COMPLETE_ICON
				end
				
				tt:AddLine(format("%s%s%s", icon, color, info.name))
			end
			tt:Show()
		end,
})

Columns.RegisterColumn("StoryTorghast", {
	-- Header
	headerWidth = 70,
	headerLabel = L["Torghast"],
	tooltipTitle = L["COLUMN_CAMPAIGNPROGRESS_TITLE"],
	tooltipSubTitle = L["Torghast"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("StoryTorghast") end,
	headerSort = function(self, character) return DataStore:GetStorylineProgress(character, "Torghast") end,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character) return Storyline_GetText(character, "Torghast") end,
	OnEnter = function(frame) Storyline_OnEnter(frame, nil, "Torghast") end,
})

Columns.RegisterColumn("Story91", {
	-- Header
	headerWidth = 70,
	headerLabel = format("%s %s9.1", L["COLUMN_CAMPAIGNPROGRESS_TITLE_SHORT"], colors.green),
	tooltipTitle = L["COLUMN_CAMPAIGNPROGRESS_TITLE"],
	tooltipSubTitle = C_CampaignInfo.GetCampaignInfo(138).name,
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("Story91") end,
	headerSort = function(self, character) return DataStore:GetStorylineProgress(character, "9.1") end,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character) return Storyline_GetText(character, "9.1") end,
	OnEnter = function(frame) Storyline_OnEnter(frame, 138, "9.1") end,
})

Columns.RegisterColumn("Story92", {
	-- Header
	headerWidth = 70,
	headerLabel = format("%s %s9.2", L["COLUMN_CAMPAIGNPROGRESS_TITLE_SHORT"], colors.green),
	tooltipTitle = L["COLUMN_CAMPAIGNPROGRESS_TITLE"],
	tooltipSubTitle = C_CampaignInfo.GetCampaignInfo(158).name,
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("Story92") end,
	headerSort = function(self, character) return DataStore:GetStorylineProgress(character, "9.2") end,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character) return Storyline_GetText(character, "9.2") end,
	OnEnter = function(frame) Storyline_OnEnter(frame, 158, "9.2") end,
})

Columns.RegisterColumn("Story100", {
	-- Header
	headerWidth = 80,
	headerLabel = format("%s %s10.0", L["COLUMN_CAMPAIGNPROGRESS_TITLE_SHORT"], colors.green),
	tooltipTitle = L["COLUMN_CAMPAIGNPROGRESS_TITLE"],
	tooltipSubTitle = C_CampaignInfo.GetCampaignInfo(190).name,
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("Story100") end,
	headerSort = function(self, character) return DataStore:GetStorylineProgress(character, "10.0") end,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character) return Storyline_GetText(character, "10.0") end,
	OnEnter = function(frame) Storyline_OnEnter(frame, nil, "10.0") end,
})

Columns.RegisterColumn("Story101", {
	-- Header
	headerWidth = 80,
	headerLabel = format("%s %s10.1", L["COLUMN_CAMPAIGNPROGRESS_TITLE_SHORT"], colors.green),
	tooltipTitle = L["COLUMN_CAMPAIGNPROGRESS_TITLE"],
	tooltipSubTitle = C_CampaignInfo.GetCampaignInfo(203).name,
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("Story101") end,
	headerSort = function(self, character) return DataStore:GetStorylineProgress(character, "10.1") end,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character) return Storyline_GetText(character, "10.1") end,
	OnEnter = function(frame) Storyline_OnEnter(frame, 203, "10.1") end,
})

Columns.RegisterColumn("Story1015", {
	-- Header
	headerWidth = 80,
	headerLabel = format("%s %s10.1.5", L["COLUMN_CAMPAIGNPROGRESS_TITLE_SHORT"], colors.green),
	tooltipTitle = L["COLUMN_CAMPAIGNPROGRESS_TITLE"],
	tooltipSubTitle = "Dawn of the Infinites",
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("Story1015") end,
	headerSort = function(self, character) return DataStore:GetStorylineProgress(character, "10.1.5") end,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character) return Storyline_GetText(character, "10.1.5") end,
	OnEnter = function(frame) Storyline_OnEnter(frame, nil, "10.1.5") end,
})

Columns.RegisterColumn("Story102", {
	-- Header
	headerWidth = 80,
	headerLabel = format("%s %s10.2", L["COLUMN_CAMPAIGNPROGRESS_TITLE_SHORT"], colors.green),
	tooltipTitle = L["COLUMN_CAMPAIGNPROGRESS_TITLE"],
	tooltipSubTitle = C_CampaignInfo.GetCampaignInfo(231).name,
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("Story102") end,
	headerSort = function(self, character) return DataStore:GetStorylineProgress(character, "10.2") end,
	
	-- Content
	Width = 80,
	JustifyH = "CENTER",
	GetText = function(character) return Storyline_GetText(character, "10.2") end,
	OnEnter = function(frame) Storyline_OnEnter(frame, 231, "10.2") end,
})


-- ** Sanctum Reservoir **
local function GetTransportNetworkLevel(self, character)
	return DataStore:GetReservoirTalentTreeInfo(character, Enum.GarrTalentFeatureType.TravelPortals)
end

local function GetAnimaConductorLevel(self, character)
	return DataStore:GetReservoirTalentTreeInfo(character, Enum.GarrTalentFeatureType.AnimaDiversion)
end

local function GetCommandTableLevel(self, character)
	return DataStore:GetReservoirTalentTreeInfo(character, Enum.GarrTalentFeatureType.Adventures)
end

local function GetSanctumUniqueLevel(self, character)
	return DataStore:GetReservoirTalentTreeInfo(character, Enum.GarrTalentFeatureType.SanctumUnique)
end

local function GetLevelColor(level, maxLevel)
	if level == 0 then return colors.grey end
	return (level == maxLevel) and colors.gold or colors.white
end

local function Reservoir_OnEnter(frame)
	local character = frame:GetParent().character
	if not character then return end
	
	-- Get the 4 levels, if their sum is higher than 0, it means we have some data and the
	-- Sanctum Reservoir has been visited
	if (GetTransportNetworkLevel(nil, character) + 
		GetAnimaConductorLevel(nil, character) + 
		GetCommandTableLevel(nil, character) + 
		GetSanctumUniqueLevel(nil, character)) ~= 0 then return end
	
	-- If not, display a message
	local tt = AddonFactory_Tooltip
	tt:ClearLines()
	tt:SetOwner(frame, "ANCHOR_RIGHT")
	tt:AddLine(L["COLUMN_SANCTUM_NODATA"])
	tt:Show()
end

local function Reservoir_OnClick(frame)
	local character = frame:GetParent().character
	if not character then return end
	
	local covenantID = DataStore:GetCovenantInfo(character)
	if not covenantID or covenantID == 0 then return end

	addon:ShowCharacterPanel(character, "Reservoir")
end


Columns.RegisterColumn("TransportNetwork", {
	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\sanctum_features_transportationnetwork")),
	tooltipTitle = L["COLUMN_TRANSPORT_NETWORK_TITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("TransportNetwork") end,
	headerSort = GetTransportNetworkLevel,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = GetTransportNetworkLevel(nil, character)
		local color = GetLevelColor(level, 3)
	
		return format("%s%s", color, level)
	end,
	OnEnter = Reservoir_OnEnter,
	OnClick = Reservoir_OnClick,
})

Columns.RegisterColumn("AnimaConductor", {
	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\sanctum_features_animadiversion")),
	tooltipTitle = L["COLUMN_ANIMA_TITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("AnimaConductor") end,
	headerSort = GetAnimaConductorLevel,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = GetAnimaConductorLevel(nil, character)
		local color = GetLevelColor(level, 3)
	
		return format("%s%s", color, level)
	end,
	OnEnter = Reservoir_OnEnter,
	OnClick = Reservoir_OnClick,
})

Columns.RegisterColumn("CommandTable", {
	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\sanctum_features_missiontable")),
	tooltipTitle = L["COLUMN_COMMAND_TABLE_TITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("CommandTable") end,
	headerSort = GetCommandTableLevel,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = GetCommandTableLevel(nil, character)
		local color = GetLevelColor(level, 3)
	
		return format("%s%s", color, level)
	end,
	OnEnter = Reservoir_OnEnter,
	OnClick = Reservoir_OnClick,
})

Columns.RegisterColumn("SanctumUnique", {
	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\spell_animaardenweald_buff")),
	tooltipTitle = L["COLUMN_SANCTUM_UNIQUE_TITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("SanctumUnique") end,
	headerSort = GetSanctumUniqueLevel,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character) 
		local level = GetSanctumUniqueLevel(nil, character)
		local color = GetLevelColor(level, 5)
	
		return format("%s%s", color, level)
	end,
	OnEnter = Reservoir_OnEnter,
	OnClick = Reservoir_OnClick,
})


-- ** Cypher Research **
local function Cypher_OnEnter(frame)
	local character = frame:GetParent().character
	if not character then return end
	
	-- Get the 4 levels, if their sum is higher than 0, it means we have some data and the
	-- research console has been visited
	if (DataStore:GetCypherMetrialLevel(character) + 
		DataStore:GetCypherAealicLevel(character) + 
		DataStore:GetCypherDealicLevel(character) + 
		DataStore:GetCypherTrebalimLevel(character)) ~= 0 then return end
	
	-- If not, display a message
	local tt = AddonFactory_Tooltip
	tt:ClearLines()
	tt:SetOwner(frame, "ANCHOR_RIGHT")
	tt:AddLine(L["COLUMN_CYPHER_NODATA"])
	tt:Show()
end

Columns.RegisterColumn("CypherLvl", {
	-- Header
	headerWidth = 70,
	headerLabel = CYPHER,
	tooltipTitle = CYPHER_EQUIPMENT_LEVEL ,
	-- tooltipSubTitle = ,
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("CypherLvl") end,
	headerSort = DataStore.GetCypherLevel,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character) 
		return Formatter.Progress(DataStore:GetCypherLevel(character))
	end,
	OnEnter = Cypher_OnEnter,
})

Columns.RegisterColumn("Metrial", {
	-- Header
	headerWidth = 70,
	headerLabel = METRIAL,
	tooltipTitle = METRIAL ,
	-- tooltipSubTitle = ,
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("Metrial") end,
	headerSort = DataStore.GetCypherMetrialLevel,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
		return Formatter.Progress(DataStore:GetCypherMetrialLevel(character), 8)
	end,
	OnEnter = Cypher_OnEnter,
})

Columns.RegisterColumn("Aealic", {
	-- Header
	headerWidth = 70,
	headerLabel = AEALIC,
	tooltipTitle = AEALIC ,
	-- tooltipSubTitle = ,
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("Aealic") end,
	headerSort = DataStore.GetCypherAealicLevel,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
		return Formatter.Progress(DataStore:GetCypherAealicLevel(character), 12)
	end,
	OnEnter = Cypher_OnEnter,
})

Columns.RegisterColumn("Dealic", {
	-- Header
	headerWidth = 70,
	headerLabel = DEALIC,
	tooltipTitle = DEALIC ,
	-- tooltipSubTitle = ,
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("Dealic") end,
	headerSort = DataStore.GetCypherDealicLevel,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
		return Formatter.Progress(DataStore:GetCypherDealicLevel(character), 12)
	end,
	OnEnter = Cypher_OnEnter,
})

Columns.RegisterColumn("Trebalim", {
	-- Header
	headerWidth = 70,
	headerLabel = TREBALIM,
	tooltipTitle = TREBALIM ,
	-- tooltipSubTitle = ,
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("Trebalim") end,
	headerSort = DataStore.GetCypherTrebalimLevel,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
		return Formatter.Progress(DataStore:GetCypherTrebalimLevel(character), 11)
	end,
	OnEnter = Cypher_OnEnter,
})
