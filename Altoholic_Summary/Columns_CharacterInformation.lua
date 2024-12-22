local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors
local icons = AddonFactory.Icons

local L = AddonFactory:GetLocale(addonName)
local MVC = LibStub("LibMVC-1.0")
local Columns = MVC:GetService("AltoholicUI.TabSummaryColumns")
local Formatter = MVC:GetService("AltoholicUI.Formatter")
local Characters = MVC:GetService("AltoholicUI.Characters")
local AccountSharing = MVC:GetService("AltoholicUI.AccountSharing")

local MAX_PLAYER_LEVEL = 80
local MAX_LOGOUT_TIMESTAMP = 5000000000

-- *** Utility functions ***
local function GetRestedXP(character)
	local rate, savedXP, savedRate, rateEarnedResting, xpEarnedResting, maxXP, isFullyRested, timeUntilFullyRested = DataStore:GetRestXPRate(character)

	-- display in 100% or 150% mode ?
	local coeff = 1
	if Altoholic_SummaryTab_Options["ShowRestXP150pc"] then
		coeff = 1.5
	end
	
	-- coefficient remains the same for pandaren, only the max should be increased
	local maxCoeff = coeff
	if DataStore:GetCharacterRace(character) == "Pandaren" then 
		maxCoeff = maxCoeff * 2 -- show as "200%" or "300%" for pandaren, who can accumulate 3 levels instead of 1.5
	end
	
	rate = rate * maxCoeff
	
	-- second return value = the actual percentage of rest xp, as a numeric value (1 to 100, not 150)
	local color = colors.green
	if rate >= (100 * maxCoeff) then 
		rate = 100 * maxCoeff
	else
		if rate < (30 * coeff) then
			color = colors.red
		elseif rate < (60 * coeff) then
			color = colors.yellow
		end
	end

	return format("%s%2.0f%%", color, rate), rate, savedXP, savedRate * maxCoeff, rateEarnedResting * maxCoeff, xpEarnedResting, maxXP, isFullyRested, timeUntilFullyRested
end

-- ** Right-Click Menu **
local function ViewAltInfo(self, characterLine)
	self:GetParent():Close()
	
	local character = Characters.GetKey(characterLine)
	
	AltoholicFrame:SwitchToTab("Characters")
	
	local tab = AltoholicFrame.TabCharacters
	tab:SetCharacter(character)
	tab.CategoriesList:ClickCategory("key", character)
	tab:ShowPanel(self.value)	
end

local function DeleteAlt(self, characterLine)
	local name, _, _, key = Characters.GetInfo(characterLine)
	
	if key == DataStore.ThisCharKey then
		addon:Print(L["Cannot delete current character"])
		return
	end
	
	AltoMessageBox:Ask(format("%s%s?\n|r%s", colors.white, L["Delete this Alt"], name), function()
		local name, realm, account = Characters.GetInfo(characterLine)
		
		DataStore:DeleteCharacter(name, realm, account)
		
		-- rebuild the main character table, and all the menus
		Characters.InvalidateView()
		AltoholicFrame.TabSummary:Update()
			
		addon:Print(format( L["Character %s successfully deleted"], name))
	end)
end

local function UpdateRealm(self, characterLine)
	local _, realm, account = Characters.GetInfo(characterLine)
	
	AltoAccountSharing_AccNameEditBox:SetText(account)
	AltoAccountSharing_UseTarget:SetChecked(nil)
	AltoAccountSharing_UseName:SetChecked(1)
	
	local _, updatedWith = AccountSharing.GetLastAccountSharingInfo(realm, account)
	AltoAccountSharing_AccTargetEditBox:SetText(updatedWith)
	
	addon.Tabs.Summary:AccountSharingButton_OnClick()
end

local function DeleteRealm(self, characterLine)
	local _, realm, account = Characters.GetInfo(characterLine)
		
	if (account == DataStore.ThisAccount) and	(realm == DataStore.ThisRealm) then
		addon:Print(L["Cannot delete current realm"])
		return
	end

	AltoMessageBox:Ask(format("%s%s?\n|r%s", colors.white, L["Delete this Realm"], realm), function() 
		local _, realm, account = Characters.GetInfo(characterLine)
		DataStore:DeleteRealm(realm, account)
		
		-- rebuild the main character table, and all the menus
		Characters.InvalidateView()
		AltoholicFrame.TabSummary:Update()
			
		addon:Print(format( L["Realm %s successfully deleted"], realm))
	end)
end

local function MarkAltAsBank(self, characterLine)
	local bankType = self.value
	local character = Characters.GetKey(characterLine)
	
	DataStore:ToggleBankType(character, bankType)
	
	-- rebuild the main character table, and all the menus
	Characters.InvalidateView()
	AltoholicFrame.TabSummary:Update()
end

local function AddToAltGroup(self, characterLine)
	local group = self.value
	local character = Characters.GetKey(characterLine)
	
	DataStore.AltGroups:AddCharacter(group, character)
end

local function RemoveFromAltGroup(self, characterLine)
	local group = self.value
	local character = Characters.GetKey(characterLine)
	
	DataStore.AltGroups:RemoveCharacter(group, character)
	
	-- rebuild the main character table, and all the menus
	Characters.InvalidateView()
	AltoholicFrame.TabSummary:Update()
end


local clickedLine

local function NameRightClickMenu_Initialize(frame, level)
	if not clickedLine then return end
	
	if level == 1 then
		-- Realm line
		if Characters.IsRealmLine(clickedLine) then
			local _, realm, account = Characters.GetInfo(clickedLine)
			local _, updatedWith = AccountSharing.GetLastAccountSharingInfo(realm, account)
			
			if updatedWith then
				frame:AddButtonWithArgs(format(L["Update from %s%s"], colors.green, updatedWith), nil, UpdateRealm, clickedLine)
			end
			frame:AddButtonWithArgs(L["Delete this Realm"], nil, DeleteRealm, clickedLine)
			return
		end
		
		-- Character line
		frame:AddTitle(DataStore:GetColoredCharacterName(Characters.Get(clickedLine).key))
		frame:AddTitle()
		
		frame:AddCategoryButton(L["View"], 1, level)
		frame:AddCategoryButton(L["Mark as profession bank"], 2, level)
		frame:AddCategoryButton(L["Mark as expansion bank"], 3, level)
		frame:AddCategoryButton(L["Add to group"], 4, level)
		frame:AddCategoryButton(L["Remove from group"], 5, level)
		frame:AddTitle()
		frame:AddButtonWithArgs(L["Delete this Alt"], nil, DeleteAlt, clickedLine)
		frame:AddCloseMenu()
	
	elseif level == 2 then
		local subMenu = frame:GetCurrentOpenMenuValue()
	
		if subMenu == 1 then					-- View 
			frame:AddButtonWithArgs(L["COLUMN_BAGS_TITLE_SHORT"], "Containers", ViewAltInfo, clickedLine, nil, nil, level)
			frame:AddButtonWithArgs(TALENTS , "Talents", ViewAltInfo, clickedLine, nil, nil, level)
			frame:AddButtonWithArgs(MINIMAP_TRACKING_MAILBOX , 2, ViewAltInfo, clickedLine, nil, nil, level)
			frame:AddButtonWithArgs(QUEST_LOG, "QuestLog", ViewAltInfo, clickedLine, nil, nil, level)
			frame:AddButtonWithArgs(AUCTIONS, 4, ViewAltInfo, clickedLine, nil, nil, level)
			frame:AddButtonWithArgs(BIDS, 5, ViewAltInfo, clickedLine, nil, nil, level)
			frame:AddButtonWithArgs(COMPANIONS, 6, ViewAltInfo, clickedLine, nil, nil, level)
			
		elseif subMenu == 2 then			-- Mark as profession bank
			local bank = DataStore.Enum.BankTypes
			local labels = DataStore.Enum.BankTypesLabels
			local _, _, _, character = Characters.GetInfo(clickedLine)
			
			frame:AddButtonWithArgs(labels.Cooking, bank.Cooking, MarkAltAsBank, clickedLine, nil, DataStore:IsBankType(character, bank.Cooking), level)
			frame:AddButtonWithArgs(labels.Fishing, bank.Fishing, MarkAltAsBank, clickedLine, nil, DataStore:IsBankType(character, bank.Fishing), level)
			frame:AddTitle(nil, nil, level)
			frame:AddButtonWithArgs(labels.Herb, bank.Herb, MarkAltAsBank, clickedLine, nil, DataStore:IsBankType(character, bank.Herb), level)
			frame:AddButtonWithArgs(labels.Cloth, bank.Cloth, MarkAltAsBank, clickedLine, nil, DataStore:IsBankType(character, bank.Cloth), level)
			frame:AddButtonWithArgs(labels.Leather, bank.Leather, MarkAltAsBank, clickedLine, nil, DataStore:IsBankType(character, bank.Leather), level)
			frame:AddButtonWithArgs(labels.Metal, bank.Metal, MarkAltAsBank, clickedLine, nil, DataStore:IsBankType(character, bank.Metal), level)
			frame:AddTitle(nil, nil, level)
			frame:AddButtonWithArgs(labels.Elemental, bank.Elemental, MarkAltAsBank, clickedLine, nil, DataStore:IsBankType(character, bank.Elemental), level)
			frame:AddButtonWithArgs(labels.Enchanting, bank.Enchanting, MarkAltAsBank, clickedLine, nil, DataStore:IsBankType(character, bank.Enchanting), level)
			frame:AddButtonWithArgs(labels.Engineering, bank.Engineering, MarkAltAsBank, clickedLine, nil, DataStore:IsBankType(character, bank.Engineering), level)
			frame:AddButtonWithArgs(labels.Jewelcrafting, bank.Jewelcrafting, MarkAltAsBank, clickedLine, nil, DataStore:IsBankType(character, bank.Jewelcrafting), level)
			frame:AddButtonWithArgs(labels.Inscription, bank.Inscription, MarkAltAsBank, clickedLine, nil, DataStore:IsBankType(character, bank.Inscription), level)
			frame:AddTitle(nil, nil, level)
			frame:AddButtonWithArgs(labels.BattlePets, bank.BattlePets, MarkAltAsBank, clickedLine, nil, DataStore:IsBankType(character, bank.BattlePets), level)
			
		elseif subMenu == 3 then			-- Mark as expansion bank
			local _, _, _, character = Characters.GetInfo(clickedLine)
			local minBank = DataStore.Enum.BankTypes.MinimumExpansion
		
			for i = 0, GetExpansionLevel() do
				frame:AddButtonWithArgs(_G["EXPANSION_NAME" .. i], minBank + i, MarkAltAsBank, clickedLine, nil, DataStore:IsBankType(character, minBank + i), level)
			end
		
		elseif subMenu == 4 then			-- Add to group
			local _, _, _, character = Characters.GetInfo(clickedLine)

			DataStore.AltGroups:Iterate(function(groupName, groupMembers) 
				if not DataStore.AltGroups:Contains(groupName, character) then
					frame:AddButtonWithArgs(groupName, groupName, AddToAltGroup, clickedLine, nil, nil, level)	
				end
			end)
			
		elseif subMenu == 5 then			-- Remove from group
			local _, _, _, character = Characters.GetInfo(clickedLine)

			DataStore.AltGroups:Iterate(function(groupName, groupMembers) 
				if DataStore.AltGroups:Contains(groupName, character) then
					frame:AddButtonWithArgs(groupName, groupName, RemoveFromAltGroup, clickedLine, nil, nil, level)	
				end
			end)
		end
	
	end
end

local function Name_OnClick(frame, button)
	-- clickedLine = line containing info about the alt on which action should be taken (delete, ..)
	clickedLine = frame:GetParent():GetID()
	if clickedLine == 0 or Characters.IsTotalLine(clickedLine) then return end

	if button == "RightButton" then
		local scrollFrame = frame:GetParent():GetParent().ScrollFrame
		local menu = scrollFrame:GetParent():GetParent().ContextualMenu
		
		menu:Initialize(NameRightClickMenu_Initialize, "LIST")
		menu:Close()
		
		if Characters.IsRealmLine(clickedLine) then
			menu:Toggle(frame, frame:GetWidth() - 300, 10)
		else
			menu:Toggle(frame, frame:GetWidth() - 20, 10)
		end
		return
	elseif button == "LeftButton" and Characters.IsCharacterLine(clickedLine) then
		local character = Characters.GetKey(clickedLine)

		AltoholicFrame:SwitchToTab("Characters")
		AltoholicFrame.TabCharacters:SetCharacter(character)
		AltoholicFrame.TabCharacters.CategoriesList:ClickCategory("key", character)
		AltoholicFrame.TabCharacters:ShowPanel("Containers")
	end
end


-- *** Specific sort functions ***
local function GetCharacterLevel(self, character)
	local level = DataStore:GetCharacterLevel(character) or 0
	local rate = DataStore:GetXPRate(character) or 0

	return level + (rate / 100)
end

local function GetGuildOrRank(self, character)
	local guildName = DataStore:GetGuildName(character)
	local guildID = DataStore:GetCharacterGuildID(character)
	local guildRank, rankIndex = DataStore:GetGuildInfo(character, guildID)

	--	return the combination of guild, rank + index to ensure sort order is preserved on refresh !
	return format("%s.%s.%s", guildName or "", rankIndex or "", guildRank or "")
end


-- ** Account Summary **
Columns.RegisterColumn("Name", {
	-- Header
	headerWidth = 150,
	headerLabel = NAME,
	headerSort = DataStore.GetCharacterName,
	
	-- Content
	Width = 150,
	JustifyH = "LEFT",
	GetText = function(character) 
			local name = DataStore:GetColoredCharacterName(character)
			local class = DataStore:GetCharacterClass(character)
			local icon = icons[DataStore:GetCharacterFaction(character)] or "Interface/Icons/INV_BannerPVP_03"

			return format("%s %s (%s)", Formatter.Texture18(icon), name, class)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local tt = AddonFactory_Tooltip
		
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), DataStore:GetColoredCharacterFaction(character))
			tt:AddLine(format("%s %s%s |r%s %s", LEVEL, 
				colors.green, DataStore:GetCharacterLevel(character), DataStore:GetCharacterRace(character), DataStore:GetCharacterClass(character)),1,1,1)

			local zone, subZone = DataStore:GetLocation(character)
			tt:AddLine(format("%s: %s%s |r(%s%s|r)", ZONE, colors.gold, zone, colors.gold, subZone),1,1,1)
			
			local guildName = DataStore:GetGuildName(character)
			if guildName then
				tt:AddLine(format("%s: %s%s", GUILD, colors.green, guildName),1,1,1)
			end

			-- local suggestion = addon:GetSuggestion("Leveling", DataStore:GetCharacterLevel(character))
			-- if suggestion then
				-- tt:AddLine(" ")
				-- tt:AddLine(L["Suggested leveling zone: "],1,1,1)
				-- tt:AddLine(format("%s%s:", colors.teal, suggestion),1,1,1)
			-- end

			-- parse saved instances
			local bLineBreak = true

			local dungeons = DataStore:GetSavedInstances(character)
			if dungeons then
				for key, _ in pairs(dungeons) do
					local hasExpired, expiresIn = DataStore:HasSavedInstanceExpired(character, key)
					
					if hasExpired then
						DataStore:DeleteSavedInstance(character, key)
					else
						if bLineBreak then
							tt:AddLine(" ")		-- add a line break only once
							bLineBreak = nil
						end
						
						local instanceName, instanceID = strsplit("|", key)
						tt:AddDoubleLine(format("%s%s (%sID: %s%s|r)", colors.gold, instanceName, colors.white, colors.green, instanceID), Formatter.TimeString(expiresIn))
					end
				end
			end

			tt:AddLine(" ")
			tt:AddLine(format("%s%s", colors.green, L["Right-Click for options"]))
			tt:Show()
		end,
	OnClick = Name_OnClick,
	GetTotal = function(line) return format("  %s", L["Totals"]) end,
})

Columns.RegisterColumn("Level", {
	-- Header
	headerWidth = 60,
	headerLabel = L["COLUMN_LEVEL_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_LEVEL_TITLE"],
	tooltipSubTitle = L["COLUMN_LEVEL_SUBTITLE"],
	headerSort = GetCharacterLevel,
	
	-- Content
	Width = 50,
	GetText = function(character) 
		local level = DataStore:GetCharacterLevel(character)
		if level ~= MAX_PLAYER_LEVEL and Altoholic_SummaryTab_Options["ShowLevelDecimals"] then
			local rate = DataStore:GetXPRate(character)
			level = format("%.1f", level + (rate/100))		-- show level as 98.4 if not level cap
		end
	
		return format("%s%s", colors.green, level)
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Inventory", character) then
				return
			end
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["COLUMN_LEVEL_TITLE"])
			tt:AddLine(format("%s %s%s |r%s %s", LEVEL, 
				colors.green, DataStore:GetCharacterLevel(character), DataStore:GetCharacterRace(character), DataStore:GetCharacterClass(character)),1,1,1)
			
			tt:AddLine(" ")
			tt:AddLine(format("%s %s%s%s/%s%s%s (%s%s%%%s)", EXPERIENCE_COLON,
				colors.green, DataStore:GetXP(character), colors.white,
				colors.green, DataStore:GetXPMax(character), colors.white,
				colors.green, DataStore:GetXPRate(character), colors.white),1,1,1)
			tt:Show()
		end,
	OnClick = function(frame, button)
			-- Toggle the option
			local options = Altoholic_SummaryTab_Options
			options["ShowLevelDecimals"] = not options["ShowLevelDecimals"]
			
			AltoholicFrame.TabSummary:Update()
		end,
	GetTotal = function(line) return Characters.GetField(line, "level") end,
})

Columns.RegisterColumn("RestXP", {
	-- Header
	headerWidth = 65,
	headerLabel = L["COLUMN_RESTXP_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_RESTXP_TITLE"],
	tooltipSubTitle = L["COLUMN_RESTXP_SUBTITLE"],
	headerOnEnter = function(frame, tooltip)
			tooltip:AddLine(" ")
			tooltip:AddLine(L["COLUMN_RESTXP_DETAIL_1"], 1,1,1)
			tooltip:AddLine(L["COLUMN_RESTXP_DETAIL_2"], 1,1,1)
			tooltip:AddLine(L["COLUMN_RESTXP_DETAIL_3"], 1,1,1)
			tooltip:AddLine(" ")
			tooltip:AddLine(format(L["COLUMN_RESTXP_DETAIL_4"], 100, 100))
			tooltip:AddLine(format(L["COLUMN_RESTXP_DETAIL_4"], 150, 150))
		end,
	headerSort = DataStore.GetRestXPRate,
	
	-- Content
	Width = 65,
	GetText = function(character) 
		if DataStore:GetCharacterLevel(character) == MAX_PLAYER_LEVEL then
			return format("%s0%%", colors.white)	-- show 0% at max level
		end

		local text = GetRestedXP(character)
		
		if not DataStore:IsResting(character) then
			text = format("%s %s!", text, colors.gold)
		end
		
		return text
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Inventory", character) then
				return
			end

			local restXP = DataStore:GetRestXP(character)
			-- if not restXP or restXP == 0 then return end
			if not restXP or DataStore:GetCharacterLevel(character) == MAX_PLAYER_LEVEL then return end

			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddLine(DataStore:GetColoredCharacterName(character),1,1,1)
			tt:AddLine(" ")
			
			local rate, _, savedXP, savedRate, rateEarnedResting, xpEarnedResting, maxXP, isFullyRested, timeUntilFullyRested = GetRestedXP(character)
			
			tt:AddLine(format("%s: %s%d", L["COLUMN_MAXRESTXP_TITLE"], colors.green, maxXP),1,1,1)
			tt:AddLine(format("%s: %s%d %s(%2.1f%%)", L["COLUMN_SAVEDRESTXP_TITLE"], colors.green, savedXP, colors.yellow, savedRate),1,1,1)
			tt:AddLine(format("%s: %s%d %s(%2.1f%%)", L["COLUMN_EARNEDRESTXP_TITLE"], colors.green, xpEarnedResting, colors.yellow, rateEarnedResting),1,1,1)
			tt:AddLine(" ")
			if isFullyRested then
				tt:AddLine(format("%s", L["Fully rested"]),1,1,1)
			else
				tt:AddLine(format("%s%s: %s", colors.white, L["Fully rested in"], Formatter.TimeString(timeUntilFullyRested)))
			end
			
			if not DataStore:IsResting(character) then
				tt:AddLine(" ")
				tt:AddLine(format("%s%s", colors.red, L["CHARACTER_NOT_IN_RESTING_AREA"]))
			end
			
			tt:Show()
		end,
	OnClick = function(frame, button)
			-- Toggle the option
			local options = Altoholic_SummaryTab_Options
			options["ShowRestXP150pc"] = not options["ShowRestXP150pc"]
			
			AltoholicFrame.TabSummary:Update()
		end,	
})

Columns.RegisterColumn("Money", {
	-- Header
	headerWidth = 135,
	headerLabel = format("%s  %s", Formatter.Texture18("Interface\\Icons\\inv_misc_coin_01"), L["COLUMN_MONEY_TITLE_SHORT"]),
	tooltipTitle = L["COLUMN_MONEY_TITLE"],
	tooltipSubTitle = L["COLUMN_MONEY_SUBTITLE_"..random(5)],
	headerSort = DataStore.GetMoney,
	
	-- Content
	Width = 130,
	JustifyH = "RIGHT",
	GetText = function(character) 
		return Formatter.MoneyString(DataStore:GetMoney(character))
	end,
	GetTotal = function(line) return Formatter.MoneyString(Characters.GetField(line, "money"), colors.white) end,
})

Columns.RegisterColumn("Played", {
	-- Header
	headerWidth = 100,
	headerLabel = L["COLUMN_PLAYED_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_PLAYED_TITLE"],
	tooltipSubTitle = L["COLUMN_PLAYED_SUBTITLE"],
	headerSort = DataStore.GetPlayTime,
	
	-- Content
	Width = 100,
	JustifyH = "RIGHT",
	GetText = function(character) 
		return Formatter.TimeString(DataStore:GetPlayTime(character))
	end,
	OnClick = function(frame, button)
			-- Toggle the option
			DataStore_Characters_Options.HideRealPlayTime = not DataStore_Characters_Options.HideRealPlayTime
			AltoholicFrame.TabSummary:Update()
		end,
	GetTotal = function(line) return Characters.GetField(line, "played") end,
})

Columns.RegisterColumn("AiL", {
	-- Header
	headerWidth = 55,
	headerLabel = L["COLUMN_ILEVEL_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_ILEVEL_TITLE"],
	tooltipSubTitle = L["COLUMN_ILEVEL_SUBTITLE"],
	headerSort = DataStore.GetAverageItemLevel,
	
	-- Content
	Width = 60,
	GetText = function(character) 
		local AiL = DataStore:GetAverageItemLevel(character) or 0
		if Altoholic_SummaryTab_Options["ShowILevelDecimals"] then
			return format("%s%.1f", colors.yellow, AiL)
		else
			return format("%s%d", colors.yellow, AiL)
		end
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Inventory", character) then
				return
			end
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddLine(DataStore:GetColoredCharacterName(character),1,1,1)
			tt:AddLine(format("%s%s: %s%.1f",
				colors.white, L["COLUMN_ILEVEL_TITLE"],
				colors.green, DataStore:GetAverageItemLevel(character)
			),1,1,1)

			-- addon:AiLTooltip()
			tt:Show()
		end,
	OnClick = function(frame, button)
			-- Toggle the option
			local options = Altoholic_SummaryTab_Options
			options["ShowILevelDecimals"] = not options["ShowILevelDecimals"]
			
			AltoholicFrame.TabSummary:Update()
		end,
	GetTotal = function(line) return format("%s%.1f", colors.white, Characters.GetField(line, "realmAiL")) end,
})

Columns.RegisterColumn("LastOnline", {
	-- Header
	headerWidth = 90,
	headerLabel = L["COLUMN_LASTONLINE_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_LASTONLINE_TITLE"],
	tooltipSubTitle = L["COLUMN_LASTONLINE_SUBTITLE"],
	headerSort = DataStore.GetLastLogout,
	
	-- Content
	Width = 60,
	GetText = function(character) 
		if DataStore:IsCurrentPlayerKey(character) then
			return format("%s%s", colors.green, GUILD_ONLINE_LABEL)
		end
		
		local lastLogout = DataStore:GetLastLogout(character)
		if lastLogout == MAX_LOGOUT_TIMESTAMP then
			return UNKNOWN
		end
		
		return format("%s%s", colors.white, Formatter.Delay(lastLogout))
	end,
	OnEnter = function(frame)
		local character = frame:GetParent().character
		if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Inventory", character) then
			return
		end
		
		local text
		
		if DataStore:IsCurrentPlayerKey(character) then
			-- current player ? show ONLINE
			text = format("%s%s", colors.green, GUILD_ONLINE_LABEL)
		else
			-- other player, show real time since last online
			local lastLogout = DataStore:GetLastLogout(character)
			
			if lastLogout == MAX_LOGOUT_TIMESTAMP then
				text = UNKNOWN
			else
				text = format("%s: %s", LASTONLINE, SecondsToTime(time() - lastLogout))
			end
		end
		
		local tt = AddonFactory_Tooltip
		tt:ClearLines()
		tt:SetOwner(frame, "ANCHOR_RIGHT")
		tt:AddLine(DataStore:GetColoredCharacterName(character),1,1,1)
		tt:AddLine(" ")
		-- then - now = x seconds
		tt:AddLine(text,1,1,1)
		tt:Show()
	end,
})

-- ** Experience **
Columns.RegisterColumn("MaxRestXP", {
	-- Header
	headerWidth = 80,
	headerLabel = L["COLUMN_MAXRESTXP_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_MAXRESTXP_TITLE"],
	tooltipSubTitle = L["COLUMN_MAXRESTXP_SUBTITLE"],
	headerSort = function(self, character)
		return select(6, DataStore:GetRestXPRate(character)) 
	end,
	
	-- Content
	Width = 80,
	GetText = function(character) 
		local level = DataStore:GetCharacterLevel(character)
		if level == MAX_PLAYER_LEVEL then
			return Formatter.GreyIfEmpty()
		end
	
		return format("%d", select(7, GetRestedXP(character)))
	end,
})

Columns.RegisterColumn("SavedRestXP", {
	-- Header
	headerWidth = 100,
	headerLabel = L["COLUMN_SAVEDRESTXP_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_SAVEDRESTXP_TITLE"],
	tooltipSubTitle = L["COLUMN_SAVEDRESTXP_SUBTITLE"],
	headerSort = function(self, character)
		return select(2, DataStore:GetRestXPRate(character)) 
	end,
	
	-- Content
	Width = 100,
	GetText = function(character) 
		local _, _, savedXP, savedRate = GetRestedXP(character)
		return format("%d %s(%2.1f%%)", savedXP, colors.white, savedRate)
	end,
})

Columns.RegisterColumn("EarnedRestXP", {
	-- Header
	headerWidth = 100,
	headerLabel = L["COLUMN_EARNEDRESTXP_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_EARNEDRESTXP_TITLE"],
	tooltipSubTitle = L["COLUMN_EARNEDRESTXP_SUBTITLE"],
	headerSort = function(self, character)
		return select(5, DataStore:GetRestXPRate(character)) 
	end,
	
	-- Content
	Width = 100,
	GetText = function(character)
		local level = DataStore:GetCharacterLevel(character)
		if level == MAX_PLAYER_LEVEL then
			return Formatter.GreyIfEmpty()
		end
		
		local _, _, _, _, rateEarnedResting, xpEarnedResting = GetRestedXP(character)
		return format("%d %s(%2.1f%%)", xpEarnedResting, colors.white, rateEarnedResting)
	end,
})

Columns.RegisterColumn("FullyRestedIn", {
	-- Header
	headerWidth = 110,
	headerLabel = L["Fully rested in"],
	headerSort = function(self, character)
		local _, _, _, _, _, _, isFullyRested, timeUntilFullyRested = DataStore:GetRestXPRate(character)
		local level = DataStore:GetCharacterLevel(character)
		
		if level == MAX_PLAYER_LEVEL then
			return -1
		elseif isFullyRested then
			return 0
		else
			return timeUntilFullyRested
		end
	end,
	
	-- Content
	Width = 110,
	GetText = function(character) 
		local _, _, _, _, _, _, _, isFullyRested, timeUntilFullyRested = GetRestedXP(character)
		local level = DataStore:GetCharacterLevel(character)
		
		if level == MAX_PLAYER_LEVEL then
			return format("%s%s", colors.white, GUILD_RECRUITMENT_MAXLEVEL )
		elseif isFullyRested or timeUntilFullyRested == 0 then
			return format("%s", L["Fully rested"])
		else
			return Formatter.TimeString(timeUntilFullyRested)
		end
	end,
})

-- ** Level **


-- ** Guild **
Columns.RegisterColumn("GuildName", {
	-- Header
	headerWidth = 120,
	headerLabel = format("%s  %s", Formatter.Texture18("Interface\\Icons\\inv_shirt_guildtabard_01"), GUILD),
	tooltipTitle = L["COLUMN_GUILD_TITLE"],
	-- tooltipSubTitle = L["COLUMN_GUILD_SUBTITLE"],
	headerSort = GetGuildOrRank,
	
	-- Content
	Width = 120,
	GetText = function(character) 
		return Formatter.GreyIfEmpty(DataStore:GetGuildName(character), colors.green)
	end,
})

Columns.RegisterColumn("GuildRank", {
	-- Header
	headerWidth = 120,
	headerLabel = format("%s  %s", Formatter.Texture18("Interface\\Icons\\inv_helm_crown_c_01_gold"), L["COLUMN_GUILDRANK_TITLE_SHORT"]),
	tooltipTitle = L["COLUMN_GUILDRANK_TITLE"],
	tooltipSubTitle = L["COLUMN_GUILDRANK_SUBTITLE"],
	headerSort = GetGuildOrRank,
	
	-- Content
	Width = 120,
	GetText = function(character) 
		local guildID = DataStore:GetCharacterGuildID(character)
		local guildRank, rankIndex = DataStore:GetGuildInfo(character, guildID)
		local color = colors.white
		
		if rankIndex == 0 then
			color = colors.gold		-- Gold for guild master
		end
		
		return Formatter.GreyIfEmpty(guildRank, color)
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			local guildName = DataStore:GetGuildName(character)
			local guildID = DataStore:GetCharacterGuildID(character)
			local guildRank, rankIndex = DataStore:GetGuildInfo(character, guildID)			

			if not guildName or not guildRank or not rankIndex then return end
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["COLUMN_GUILDRANK_TITLE"])
			tt:AddLine(format("%s %s%s |r%s %s", LEVEL, 
				colors.green, DataStore:GetCharacterLevel(character), DataStore:GetCharacterRace(character), DataStore:GetCharacterClass(character)),1,1,1)
			
			tt:AddLine(" ")
			tt:AddLine(format("%s%s: %s%s", colors.white, GUILD, colors.green, guildName),1,1,1)
			tt:AddLine(format("%s%s: %s%s", colors.white, RANK , colors.green, guildRank),1,1,1)
			
			local actualRank = _G[format("GUILD_RANK%d_DESC", rankIndex)]
			if actualRank then
				tt:AddLine(" ")
				tt:AddLine(format("%s%s", colors.white, actualRank),1,1,1)
			end
			tt:Show()
		end,
})

Columns.RegisterColumn("GuildRep", {
	-- Header
	headerWidth = 140,
	headerLabel = format("%s  %s", Formatter.Texture18("Interface\\Icons\\inv_misc_tournaments_tabard_human"), L["COLUMN_GUILDREP_TITLE"]),
	tooltipTitle = L["COLUMN_GUILDREP_TITLE"],
	tooltipSubTitle = L["COLUMN_GUILDREP_SUBTITLE"],
	headerSort = DataStore.GetGuildReputation,
	
	-- Content
	Width = 140,
	GetText = function(character) 
		local guildName = DataStore:GetGuildName(character)
		local level = DataStore:GetReputationInfo(character, guildName)
		local color = colors.white
		
		if level == FACTION_STANDING_LABEL8 then
			color = colors.gold		-- Gold for exalted
		end
		
		return Formatter.GreyIfEmpty(level, color)
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			local guildName = DataStore:GetGuildName(character)
			
			-- "Revered", 15400, 21000, 73%
			local level, numerator, denominator, ratio = DataStore:GetReputationInfo(character, guildName)
			if not level then return end
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), GUILD_REPUTATION)
			tt:AddLine(format("%s %s%s |r%s %s", LEVEL, 
				colors.green, DataStore:GetCharacterLevel(character), DataStore:GetCharacterRace(character), DataStore:GetCharacterClass(character)),1,1,1)
			
			tt:AddLine(" ")
			tt:AddLine(format("%s%s%s: %s", colors.green, guildName, colors.white, level),1,1,1)
			tt:AddLine(format("%s%d %s/ %s%d %s(%s%2.1f%%%s)", 
				colors.green, numerator, colors.white,
				colors.green, denominator, colors.white, 
				colors.green, ratio, colors.white),1,1,1)
			tt:Show()
		end,
})

-- ** Location **
Columns.RegisterColumn("Hearthstone", {
	-- Header
	headerWidth = 120,
	headerLabel = format("%s  %s", Formatter.Texture18("Interface\\Icons\\inv_misc_rune_01"), L["COLUMN_HEARTHSTONE_TITLE"]),
	tooltipTitle = L["COLUMN_HEARTHSTONE_TITLE"],
	tooltipSubTitle = L["COLUMN_HEARTHSTONE_SUBTITLE"],
	headerSort = DataStore.GetBindLocation,
	
	-- Content
	Width = 120,
	GetText = function(character) 
		return Formatter.GreyIfEmpty(DataStore:GetBindLocation(character))
	end,
})

Columns.RegisterColumn("Zone", {
	-- Header
	headerWidth = 140,
	headerLabel = format("%s  %s", Formatter.Texture18("Interface\\Icons\\achievement_zone_easternkingdoms_01"), ZONE),
	headerSort = function(self, character)
		return select(1, DataStore:GetLocation(character)) 
	end,
	
	-- Content
	Width = 140,
	GetText = function(character)
		local zone = DataStore:GetLocation(character)
		return Formatter.GreyIfEmpty(zone)
	end,
})

Columns.RegisterColumn("SubZone", {
	-- Header
	headerWidth = 150,
	headerLabel = format("%s  %s", Formatter.Texture18("Interface\\Icons\\achievement_zone_arathihighlands_01"), L["COLUMN_SUBZONE_TITLE"]),
	headerSort = function(self, character)
		return select(2, DataStore:GetLocation(character)) 
	end,
	
	-- Content
	Width = 150,
	GetText = function(character)
		local _, subZone = DataStore:GetLocation(character)
		return Formatter.GreyIfEmpty(subZone)
	end,
})

-- ** Miscellaneous **
Columns.RegisterColumn("ClassAndSpec", {
	-- Header
	headerWidth = 170,
	headerLabel = format("%s   %s / %s", Formatter.Texture18("Interface\\Icons\\Spell_Nature_NatureGuardian"), CLASS, SPECIALIZATION),
	tooltipTitle = format("%s / %s", CLASS, SPECIALIZATION),
	tooltipSubTitle = L["COLUMN_CLASS_SUBTITLE"],
	headerSort = DataStore.GetCharacterClass,
	
	-- Content
	Width = 170,
	GetText = function(character)
	
		local class = DataStore:GetCharacterClass(character)
		local spec = DataStore:GetActiveSpecInfo(character)
		local color = DataStore:GetCharacterClassColor(character)
		
		return format("%s%s |r/ %s", color, class, Formatter.GreyIfEmpty(spec, color))
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			-- if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Talents", character) then
			if not character then
				return
			end
			
			-- Exit if no specialization yet
			local specName, specIndex, role = DataStore:GetActiveSpecInfo(character)
			if not specIndex or not specName or specName == "" then return end
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), SPECIALIZATION)			-- Warlock
			tt:AddDoubleLine(
				format("%s%s", DataStore:GetCharacterClassColor(character), specName), 
				_G[role])

			tt:AddLine(" ")
			
			local _, class = DataStore:GetCharacterClass(character)
			
			DataStore:IterateTalentTiers(function(tierIndex, level) 
				
				-- Get the selected talent in this tier ..
				local choice = DataStore:GetSpecializationTierChoice(character, specIndex, tierIndex)
				
				-- Has talent been set yet ?
				if choice == 0 then
					tt:AddLine(format("%s%d: |r%s", colors.green, level, TALENT_NOT_SELECTED ))
				else
					-- .. then get the talent information ..
					local _, talentName, icon = DataStore:GetTalentInfo(class, specIndex, tierIndex, choice)
					if talentName and icon then
						tt:AddLine(format("%s%d: %s %s%s", colors.green, level, Formatter.Texture18(icon), colors.white, talentName))
					else
						-- it may occasionally happen that information is no longer is the cache
						tt:AddLine(format("%s%d: %s-", colors.green, level, colors.white))
					end					
				end
			end)

			tt:Show()
		end,
	
	OnClick = function(frame, button)
			local character = frame:GetParent().character
			if not character then return end

			-- Exit if no specialization yet
			local spec = DataStore:GetActiveSpecInfo(character)
			if not spec or spec == "" then return end

			AltoholicFrame:SwitchToTab("Characters")
			AltoholicFrame.TabCharacters:SetCharacter(character)
			AltoholicFrame.TabCharacters.CategoriesList:ClickCategory("key", character)
			AltoholicFrame.TabCharacters:ShowPanel("Talents")
		end,	
})

Columns.RegisterColumn("BankType", {
	-- Header
	headerWidth = 150,
	headerLabel = format("%s  %s", Formatter.Texture18("Interface\\Icons\\trade_archaeology_chestoftinyglassanimals"), L["COLUMN_BANK_TYPE_MARKS"]),
	tooltipTitle = L["COLUMN_BANK_TYPE_MARKS"],
	tooltipSubTitle = L["COLUMN_BANK_TYPE_MARKS_SUBTITLE"],
	headerSort = function(self, character)
		return DataStore:GetBankTypes(character)
	end,
	
	-- Content
	Width = 150,
	GetText = function(character)
		local types = DataStore:GetBankTypes(character)
		
		return Formatter.GreyIfEmpty(types)
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			local _, types = DataStore:GetBankTypes(character)
			if not character or not types then return end
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["COLUMN_BANK_TYPE_MARKS"])
			tt:AddLine(" ")

			table.sort(types)
			
			for _, bankTypeMark in pairs(types) do
				tt:AddLine(format("%s%s", colors.gold, bankTypeMark))
			end
			tt:Show()
		end,
})

Columns.RegisterColumn("AltGroup", {
	-- Header
	headerWidth = 120,
	headerLabel = format("%s  %s", Formatter.Texture18("Interface\\Icons\\Achievement_GuildPerk_Everyones a Hero_rank2"), L["FILTER_ALT_GROUPS"]),
	-- tooltipTitle = L["COLUMN_BANK_TYPE_MARKS"],
	-- tooltipSubTitle = L["COLUMN_BANK_TYPE_MARKS_SUBTITLE"],
	headerSort = function(self, character)
		return DataStore.AltGroups:Get(character)
	end,
	
	-- Content
	Width = 120,
	GetText = function(character)
		local groups = DataStore.AltGroups:Get(character)
		
		return Formatter.GreyIfEmpty(groups)
	end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			local _, groups = DataStore.AltGroups:Get(character)
			if not character or not groups or #groups == 0 then return end
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["FILTER_ALT_GROUPS"])
			tt:AddLine(" ")

			table.sort(groups)
			
			for _, groupName in pairs(groups) do
				tt:AddLine(format("%s%s", colors.gold, groupName))
			end
			tt:Show()
		end,
})

-- ** Equipment **

Columns.RegisterColumn("Inv_HighestLevel", {
	-- Header
	headerWidth = 60,
	headerLabel = L["COLUMN_EQUIP_HIGHEST_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_EQUIP_HIGHEST_TITLE"],
	tooltipSubTitle = L["COLUMN_EQUIP_HIGHEST_SUBTITLE"],
	headerSort = DataStore.GetHighestItemLevel,
	
	-- Content
	Width = 60,
	GetText = function(character) 
		local level = DataStore:GetHighestItemLevel(character)
		local color = level == 0 and colors.grey or colors.gold
	
		return format("%s%s", color, level)
	end,
})

Columns.RegisterColumn("Inv_LowestLevel", {
	-- Header
	headerWidth = 60,
	headerLabel = L["COLUMN_EQUIP_LOWEST_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_EQUIP_LOWEST_TITLE"],
	tooltipSubTitle = L["COLUMN_EQUIP_LOWEST_SUBTITLE"],
	headerSort = DataStore.GetLowestItemLevel,
	
	-- Content
	Width = 60,
	GetText = function(character) 
		local level = DataStore:GetLowestItemLevel(character)
		local color = level == 0 and colors.grey or colors.gold
	
		return format("%s%s", color, level)
	end,
})

Columns.RegisterColumn("Inv_NumEpics", {
	-- Header
	headerWidth = 60,
	headerLabel = addon:GetItemQualityLabel(4),
	tooltipTitle = L["COLUMN_EQUIP_NUM_EPICS_TITLE"],
	tooltipSubTitle = L["COLUMN_EQUIP_NUM_EPICS_SUBTITLE"],
	headerSort = DataStore.GetNumEpicEquipment,
	
	-- Content
	Width = 60,
	GetText = function(character) 
		local level = DataStore:GetNumEpicEquipment(character)
		local color = level == 0 and colors.grey or colors.gold
	
		return format("%s%s", color, level)
	end,
})

Columns.RegisterColumn("Inv_NumBlues", {
	-- Header
	headerWidth = 60,
	headerLabel = addon:GetItemQualityLabel(3),
	tooltipTitle = L["COLUMN_EQUIP_NUM_BLUES_TITLE"],
	tooltipSubTitle = L["COLUMN_EQUIP_NUM_BLUES_SUBTITLE"],
	headerSort = DataStore.GetNumRareEquipment,
	
	-- Content
	Width = 60,
	GetText = function(character) 
		local level = DataStore:GetNumRareEquipment(character)
		local color = level == 0 and colors.grey or colors.gold
	
		return format("%s%s", color, level)
	end,
})

Columns.RegisterColumn("Inv_NumGreens", {
	-- Header
	headerWidth = 80,
	headerLabel = addon:GetItemQualityLabel(2),
	tooltipTitle = L["COLUMN_EQUIP_NUM_GREENS_TITLE"],
	tooltipSubTitle = L["COLUMN_EQUIP_NUM_GREENS_SUBTITLE"],
	headerSort = DataStore.GetNumUncommonEquipment,
	
	-- Content
	Width = 80,
	GetText = function(character) 
		local level = DataStore:GetNumUncommonEquipment(character)
		local color = level == 0 and colors.grey or colors.gold
	
		return format("%s%s", color, level)
	end,
})

Columns.RegisterColumn("Inv_NumHeirlooms", {
	-- Header
	headerWidth = 80,
	headerLabel = addon:GetItemQualityLabel(7),
	tooltipTitle = L["COLUMN_EQUIP_NUM_HEIRLOOMS_TITLE"],
	tooltipSubTitle = L["COLUMN_EQUIP_NUM_HEIRLOOMS_SUBTITLE"],
	headerSort = DataStore.GetNumHeirloomEquipment,
	
	-- Content
	Width = 80,
	GetText = function(character) 
		local level = DataStore:GetNumHeirloomEquipment(character)
		local color = level == 0 and colors.grey or colors.gold
	
		return format("%s%s", color, level)
	end,
})

