local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors
local icons = AddonFactory.Icons

local L = DataStore:GetLocale(addonName)
local MVC = LibStub("LibMVC-1.0")
local Columns = MVC:GetService("AltoholicUI.TabSummaryColumns")
local Formatter = MVC:GetService("AltoholicUI.Formatter")
local Characters = MVC:GetService("AltoholicUI.Characters")

local SKILL_CAP = 900

-- *** Utility functions ***
local professionIndices = DataStore:GetProfessionIndices()
local skillColors = { colors.recipeGrey, colors.red, colors.orange, colors.yellow, colors.green }

local function GetSkillRankColor(rank, skillCap)
	if Altoholic_SummaryTab_Options["UseColorForTradeSkills"] == false then
		return colors.white
	end

	rank = rank or 0
	skillCap = skillCap or SKILL_CAP

	-- Get the index in the colors table
	local index = floor(rank / (skillCap/4)) + 1
	
	-- players with a high skill level may trigger an out of bounds index, so cap it
	if index > #skillColors then
		index = #skillColors
	end
	
	return skillColors[index]
end

local function TradeskillHeader_OnEnter(frame, tooltip)
	tooltip:AddLine(" ")
	tooltip:AddLine(format("%s%s|r %s %s", colors.recipeGrey, L["COLOR_GREY"], L["up to"], (floor(SKILL_CAP*0.25)-1)),1,1,1)
	tooltip:AddLine(format("%s%s|r %s %s", colors.red, RED_GEM, L["up to"], (floor(SKILL_CAP*0.50)-1)),1,1,1)
	tooltip:AddLine(format("%s%s|r %s %s", colors.orange, L["COLOR_ORANGE"], L["up to"], (floor(SKILL_CAP*0.75)-1)),1,1,1)
	tooltip:AddLine(format("%s%s|r %s %s", colors.yellow, YELLOW_GEM, L["up to"], (SKILL_CAP-1)),1,1,1)
	tooltip:AddLine(format("%s%s|r %s %s %s", colors.green, L["COLOR_GREEN"], L["at"], SKILL_CAP, L["and above"]),1,1,1)
end

local function RidingSkillHeader_OnEnter(frame, tooltip)
	tooltip:AddLine(" ")
	
	DataStore:IterateRidingSkills(function(skill) 
		tooltip:AddDoubleLine(
			format("%s%s %s%d |r(%s %s%s|r)", 
				colors.white, LEVEL, 
				colors.green, skill.minLevel, 
				COSTS_LABEL,
				colors.gold, format(GOLD_AMOUNT_TEXTURE_STRING, BreakUpLargeNumbers(skill.cost), 13, 13)), 
			format("%s%s%%", colors.white, skill.speed))
	end)
end

local function Tradeskill_OnEnter(frame, professionIndex, showRecipeStats)
	local character = frame:GetParent().character
	if not DataStore:GetModuleLastUpdateByKey("DataStore_Crafts", character) then return end
	
	-- Prepare the tooltip
	local tt = AddonFactory_Tooltip
	
	tt:ClearLines()
	tt:SetOwner(frame, "ANCHOR_RIGHT")
	
	-- Get the profession, if it has been learned
	local profession = DataStore:GetProfessionByIndex(character, professionIndex)
	if not profession then 
		tt:AddLine(L["COLUMN_SKILLS_NOT_LEARNED"])
		tt:Show()
		return 
	end
	
	-- Get the ranks
	local curRank, maxRank = DataStore:GetProfessionRankByIndex(character, professionIndex)
	local skillName = profession.Name

	tt:AddLine(skillName,1,1,1)
	tt:AddLine(format("%s%s/%s", GetSkillRankColor(curRank), curRank, maxRank),1,1,1)
	
	-- Stop here for Archeology
	if professionIndex == professionIndices.Archeology then
		tt:Show()
		return
	end
	
	if showRecipeStats then	-- for primary skills + cooking & first aid
		-- if DataStore:GetProfessionSpellID(skillName) ~= 2366 and skillName ~= C_Spell.GetSpellName(8613) then		-- no display for herbalism & skinning
			tt:AddLine(" ")
			
			if not profession then
				tt:AddLine(L["No data"])
				tt:AddLine(L["COLUMN_SKILLS_NODATA"])
				tt:Show()
				return
			end

			local numCategories = DataStore:GetNumRecipeCategories(profession)
			
			if numCategories == 0 then
				tt:AddLine(format("%s: 0 %s", L["No data"], TRADESKILL_SERVICE_LEARN),1,1,1)
				tt:AddLine(" ")
				tt:AddLine(L["COLUMN_SKILLS_NODATA"])
				tt:Show()
				return
			else
				for i = 1, numCategories do
					local _, name, rank, maxRank = DataStore:GetRecipeCategoryInfo(profession, i)
					
					if name and rank and maxRank then
						-- display the rank in the right color
						if (maxRank == 0) or (rank < (maxRank * 0.5)) then		-- red if no maxrank, or below 50%
							color = colors.red
						elseif rank < maxRank then										-- yellow when below max
							color = colors.yellow
						else																	-- green otherwise	
							color = colors.green
						end
						
						tt:AddDoubleLine(name, format("%s%s|r / %s%s", color, rank, colors.green, maxRank))
					-- else
						-- tt:AddLine(name)
					end
				end
			
				local orange, yellow, green, grey = DataStore:GetNumRecipesByColor(profession)
				
				tt:AddLine(" ")
				tt:AddLine(format("%d %s",
					(orange + yellow + green + grey),
					TRADESKILL_SERVICE_LEARN),1,1,1)
				tt:AddLine(format("%s%d %s%s|r / %s%d %s%s|r / %s%d %s%s",
					colors.white, green, colors.recipeGreen, L["COLOR_GREEN"],
					colors.white, yellow, colors.yellow, L["COLOR_YELLOW"],
					colors.white, orange, colors.recipeOrange, L["COLOR_ORANGE"]))
			end
		-- end
	end

	-- local suggestion = addon:GetSuggestion(skillName, curRank)
	-- if suggestion then
		-- tt:AddLine(" ")
		-- tt:AddLine(format("%s: ", L["Suggestion"]),1,1,1)
		-- tt:AddLine(format("%s%s", colors.teal, suggestion),1,1,1)
	-- end
	
	-- parse profession cooldowns
	if profession then
		DataStore:ClearExpiredCooldowns(profession)
		local numCooldows = DataStore:GetNumActiveCooldowns(profession)
		
		if numCooldows == 0 then
			tt:AddLine(" ")
			tt:AddLine(L["All cooldowns are up"],1,1,1)
		else
			tt:AddLine(" ")
			for i = 1, numCooldows do
				local craftName, expiresIn = DataStore:GetCraftCooldownInfo(profession, i)
				tt:AddDoubleLine(craftName, Formatter.TimeString(expiresIn))
			end
		end
	end
	
	tt:Show()
end

local function Tradeskill_OnClick(frame, professionIndex)
	local character = frame:GetParent().character
	if not professionIndex or not DataStore:GetModuleLastUpdateByKey("DataStore_Crafts", character) then return end

	local profession = DataStore:GetProfessionByIndex(character, professionIndex)
	if not profession or DataStore:GetNumRecipeCategories(profession) == 0 then		-- if profession hasn't been scanned (or scan failed), exit
		return
	end
	
	local charName, realm, account = strsplit(".", character)
	local chat = ChatEdit_GetLastActiveWindow()
	
	if chat:IsShown() and IsShiftKeyDown() and realm == DataStore.ThisRealm then
		-- if shift-click, then display the profession link and exit
		local link = DataStore:GetProfessionLink(character, professionIndex)
		if link then
			chat:Insert(link)
		end
		return
	end

	-- Set the right tab
	AltoholicFrame:SwitchToTab("Characters")
	
	-- Set the right character
	local tab = AltoholicFrame.TabCharacters
	tab:SetCharacter(character)
	tab.CategoriesList:ClickCategory("key", character)
	
	-- Set the right panel
	local recipes = tab.Panels.Recipes
	recipes:SetCurrentProfession(skillName)
	recipes:ResetFilters()
	tab:ShowPanel("Recipes")
end


-- ** Skills **
Columns.RegisterColumn("Prof1", {
	-- Header
	headerWidth = 70,
	headerLabel = L["COLUMN_PROFESSION_1_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_PROFESSION_1_TITLE"],
	tooltipSubTitle = nil,
	headerOnEnter = TradeskillHeader_OnEnter,
	headerSort = DataStore.GetProfession1Rank,
	
	-- Content
	Width = 70,
	GetText = function(character)
			local rank = DataStore:GetProfession1Rank(character)
			local name = DataStore:GetProfession1Name(character)
			local spellID = DataStore:GetProfessionSpellID(name)
			local icon = spellID and Formatter.Texture18(C_Spell.GetSpellTexture(spellID)) .. " " or ""
			
			return format("%s%s%s", icon, GetSkillRankColor(rank), rank)
		end,
	OnEnter = function(frame) Tradeskill_OnEnter(frame, professionIndices.Profession1, true) end,
	OnClick = function(frame, button) Tradeskill_OnClick(frame, professionIndices.Profession1) end,
})

Columns.RegisterColumn("Prof2", {
	-- Header
	headerWidth = 70,
	headerLabel = L["COLUMN_PROFESSION_2_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_PROFESSION_2_TITLE"],
	tooltipSubTitle = nil,
	headerOnEnter = TradeskillHeader_OnEnter,
	headerSort = DataStore.GetProfession2Rank,
	
	-- Content
	Width = 70,
	GetText = function(character)
			local rank = DataStore:GetProfession2Rank(character)
			local name = DataStore:GetProfession2Name(character)
			local spellID = DataStore:GetProfessionSpellID(name)
			local icon = spellID and Formatter.Texture18(C_Spell.GetSpellTexture(spellID)) .. " " or ""
			
			return format("%s%s%s", icon, GetSkillRankColor(rank), rank)
		end,
	OnEnter = function(frame) Tradeskill_OnEnter(frame, professionIndices.Profession2, true) end,
	OnClick = function(frame, button) Tradeskill_OnClick(frame, professionIndices.Profession2) end,
})

Columns.RegisterColumn("ProfCooking", {
	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", Formatter.Texture18(C_Spell.GetSpellTexture(2550))),
	tooltipTitle = C_Spell.GetSpellName(2550),
	tooltipSubTitle = nil,
	headerOnEnter = TradeskillHeader_OnEnter,
	headerSort = DataStore.GetCookingRank,
	
	-- Content
	Width = 60,
	GetText = function(character)
			local rank = DataStore:GetCookingRank(character)
			return format("%s%s", GetSkillRankColor(rank), rank)
		end,
	OnEnter = function(frame) Tradeskill_OnEnter(frame, professionIndices.Cooking, true) end,
	OnClick = function(frame, button) Tradeskill_OnClick(frame, professionIndices.Cooking)	end,
})

Columns.RegisterColumn("ProfFishing", {
	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", Formatter.Texture18(C_Spell.GetSpellTexture(131474))),
	tooltipTitle = C_Spell.GetSpellName(131474),
	tooltipSubTitle = nil,
	headerOnEnter = TradeskillHeader_OnEnter,
	headerSort = DataStore.GetFishingRank,
	
	-- Content
	Width = 60,
	GetText = function(character)
			local rank = DataStore:GetFishingRank(character)
			return format("%s%s", GetSkillRankColor(rank), rank)
		end,
	OnEnter = function(frame) Tradeskill_OnEnter(frame, professionIndices.Fishing, true) end,
})

Columns.RegisterColumn("ProfArchaeology", {
	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", Formatter.Texture18(C_Spell.GetSpellTexture(78670))),
	tooltipTitle = C_Spell.GetSpellName(78670),
	tooltipSubTitle = nil,
	headerOnEnter = TradeskillHeader_OnEnter,
	headerSort = DataStore.GetArchaeologyRank,
	
	-- Content
	Width = 60,
	GetText = function(character)
			local rank = DataStore:GetArchaeologyRank(character)
			return format("%s%s", GetSkillRankColor(rank), rank)
		end,
	OnEnter = function(frame) Tradeskill_OnEnter(frame, professionIndices.Archeology) end,
})

Columns.RegisterColumn("Riding", {
	-- Header
	headerWidth = 80,
	headerLabel = format("    %s", Formatter.Texture18("Interface\\Icons\\spell_nature_swiftness")),
	tooltipTitle = L["Riding"],
	tooltipSubTitle = nil,
	headerOnEnter = RidingSkillHeader_OnEnter,
	headerSort = DataStore.GetRidingSkill,
	
	-- Content
	Width = 80,
	GetText = function(character) 
		local speed, _, _, equipmentID = DataStore:GetRidingSkill(character)
		local color = colors.white
		
		if speed == 0 then
			color = colors.grey
		elseif speed == 150 then
			color = colors.orange
		elseif speed == 280 then
			color = colors.yellow
		elseif speed == 310 then
			color = colors.green
		end
		
		local text = (addon:CanUpgradeRidingSkill(character, speed)) 
			and format("%s%d%% %s!", color, speed, colors.gold)
			or format("%s%d%%", color, speed)
		
		-- If the mount is equipped, display its icon, info will be in the tooltip
		if equipmentID then 
			local icon = select(5, GetItemInfoInstant(equipmentID))
			
			if icon then
				return format("%s %s", text, Formatter.Texture18(icon))
			end
		end
		
		return text	
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local speed, spellName, spellID, equipmentID = DataStore:GetRidingSkill(character)
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["Riding"])
			tt:AddLine(" ")

			if speed == 0 then 

			else
				tt:AddLine(spellName, 1, 1, 1)
				tt:AddLine(C_Spell.GetSpellDescription(spellID), nil, nil, nil, true)
			end
			
			-- Add the mount equipment
			if equipmentID then
				tt:AddLine(" ")
				local _, link, _, _, _, _, itemSubType, _, _, icon = GetItemInfo(equipmentID)
				
				if itemSubType then
					tt:AddLine(format("%s%s", colors.white, itemSubType))
				end
				
				if link and icon then
					tt:AddLine(format("%s %s", Formatter.Texture18(icon), link))
				end
			end

			-- Add a line if riding skill is upgradeable
			if addon:CanUpgradeRidingSkill(character, speed) then
				tt:AddLine(" ")
				
				local gender = DataStore:GetCharacterGender(character)
				if gender == 2 then
					tt:AddLine(L["COLUMN_RIDING_UPGRADEABLE_MALE"], 0, 1, 0)
				else
					tt:AddLine(L["COLUMN_RIDING_UPGRADEABLE_FEMALE"], 0, 1, 0)
				end
			end
			
			tt:Show()
		end,
})
