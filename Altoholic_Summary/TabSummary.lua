local addonTabName = ...
local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = DataStore:GetLocale(addonName)
local MVC = LibStub("LibMVC-1.0")
local AccountSharing = MVC:GetService("AltoholicUI.AccountSharing")

local OPTION_REALMS = "CurrentRealms"
local OPTION_ALTGROUPS = "CurrentAltGroup"
local OPTION_FACTIONS = "CurrentFactions"
local OPTION_LEVELS = "CurrentLevels"
local OPTION_LEVELS_MIN = "CurrentLevelsMin"
local OPTION_LEVELS_MAX = "CurrentLevelsMax"
local OPTION_CLASSES = "CurrentClasses"
local OPTION_MISC = "CurrentMisc"
local OPTION_BANKTYPE = "CurrentBankType"
local OPTION_TRADESKILL = "CurrentTradeSkill"
local OPTION_COLORED_SKILLS = "UseColorForTradeSkills"

local tab		-- small shortcut to easily address the frame (set in OnBind)
local options

-- ** Icon events **

local function OnRealmFilterChange(frame)
	options[OPTION_REALMS] = frame.value
	AltoholicFrame.TabSummary:Update()
end

local function OnAltGroupChange(frame)
	options[OPTION_ALTGROUPS] = frame.value
	AltoholicFrame.TabSummary:Update()
end

local function OnCreateAltGroup(frame)
	AltoMessageBox:AskWithInput(format("%s%s\n|r%s", colors.white, L["ENTER_GROUP_NAME"], L["ENTER_GROUP_NAME_WARNING"]), function(userInput) 
		-- exit if length is zero
		if not userInput or userInput:len() == 0 then return end
		
		local isOk = DataStore.AltGroups:Create(userInput)
		
		if isOk then
			addon:Print(format(L["ALT_GROUP_CREATED"], userInput))
		else
			addon:Print(format(L["ALT_GROUP_ALREADY_EXISTS"], userInput))
		end
		
		-- rebuild the main character table, and all the menus
		AltoholicFrame.TabSummary:Update()
	end)
end

local function OnRenameAltGroup(frame)
	frame:GetParent():Close()
	local oldGroup = frame.value

	local question = format("%s%s\n|r%s",	colors.white, format(L["CHANGE_GROUP_NAME"], colors.green, oldGroup),	L["ENTER_GROUP_NAME_WARNING"])
	
	AltoMessageBox:AskWithInput(question, function(newGroup) 
		-- exit if length is zero
		if not newGroup or newGroup:len() == 0 then return end
		
		local isOk = DataStore.AltGroups:Rename(oldGroup, newGroup)
		
		if isOk then
			addon:Print(format(L["ALT_GROUP_RENAMED"], oldGroup, newGroup))
		else
			addon:Print(format(L["ALT_GROUP_NOT_RENAMED"], oldGroup, newGroup))
		end
		
		-- rebuild the main character table, and all the menus
		AltoholicFrame.TabSummary:Update()
	end)
end

local function OnDeleteAltGroup(frame)
	frame:GetParent():Close()
	local group = frame.value

	AltoMessageBox:Ask(format("%s%s\n|r%s%s", colors.white, L["DELETE_GROUP_NAME"], colors.green, group), function()
		
		local isOk = DataStore.AltGroups:Delete(group)
		
		if isOk then
			addon:Print(format(L["ALT_GROUP_DELETED"], group))
		else
			addon:Print(format(L["ALT_GROUP_NOT_FOUND"], group))
		end
		
		-- If the group being shown is the one we just deleted, reset to All
		local groupOption = options[OPTION_ALTGROUPS]
		if groupOption == group then
			options[OPTION_ALTGROUPS] = 0
		end
		
		-- rebuild the main character table, and all the menus
		AltoholicFrame.TabSummary:Update()
	end)
end

local function OnFactionFilterChange(frame)
	options[OPTION_FACTIONS] = frame.value
	AltoholicFrame.TabSummary:Update()
end

local function OnLevelFilterChange(frame, minLevel, maxLevel)
	options[OPTION_LEVELS] = frame.value
	options[OPTION_LEVELS_MIN] = minLevel
	options[OPTION_LEVELS_MAX] = maxLevel
	AltoholicFrame.TabSummary:Update()
end

local function OnTradeSkillFilterChange(frame)
	frame:GetParent():Close()
	
	options[OPTION_TRADESKILL] = frame.value
	AltoholicFrame.TabSummary:Update()
end

local function OnTradeSkillLevelColorChange(frame)
	-- Toggle the option
	options[OPTION_COLORED_SKILLS] = not options[OPTION_COLORED_SKILLS]
	AltoholicFrame.TabSummary:Update()
end

local function OnClassFilterChange(frame)
	options[OPTION_CLASSES] = frame.value
	AltoholicFrame.TabSummary:Update()
end

local function OnMiscFilterChange(frame)
	options[OPTION_MISC] = frame.value
	
	if frame.value == 1 or frame.value == 2 then
		AltoholicFrame.TabSummary.CategoriesList:ClickCategory("profile", 9)
	elseif frame.value == 5 or frame.value == 6 then
		AltoholicFrame.TabSummary.CategoriesList:ClickCategory("profile", 4)
	elseif frame.value == 7 then
		AltoholicFrame.TabSummary.CategoriesList:ClickCategory("profile", 8)
	end
	
	AltoholicFrame.TabSummary:Update()
end

local function OnBankTypeFilterChange(frame)
	options[OPTION_BANKTYPE] = frame.value
	AltoholicFrame.TabSummary:Update()
end

local function ResetAllData()
	AltoMessageBox:Ask(format("%s%s\n|r%s", colors.white, L["WIPE_DATABASE"], L["WIPE_WARNING"]), function() 
		-- reset all data stored in datastore modules
		DataStore:ClearAllData()
		addon:Print(L["DATABASE_WIPED"])
		
		-- rebuild the main character table, and all the menus
		AltoholicFrame.TabSummary:Update()
	end)
end

-- ** Menu Icons **

local locationLabels = {
	format("%s %s(%s)", L["This realm"], colors.green, L["This account"]),
	format("%s %s(%s)", L["This realm"], colors.green, L["All accounts"]),
	format("%s %s(%s)", L["All realms"], colors.green, L["This account"]),
	format("%s %s(%s)", L["All realms"], colors.green, L["All accounts"]),
}

local armorTypeLabels = {
	[1] = GetItemSubClassInfo(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Cloth),
	[2] = GetItemSubClassInfo(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Leather),
	[3] = GetItemSubClassInfo(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Mail),
	[4] = GetItemSubClassInfo(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Plate)
}

local roleTypeLabels = { TANK, HEALER, DAMAGER}

local function RealmsIcon_Initialize(frame, level)
	if not level then return end
	
	-- Rename & delete alt group have 2 levels
	if level == 2 then
		local subMenu = frame:GetCurrentOpenMenuValue()
		
		if subMenu == 1 then
			-- Rename
			DataStore.AltGroups:Iterate(function(groupName, groupMembers) 
				frame:AddButton(groupName, groupName, OnRenameAltGroup, nil, nil, level)
			end)
			
		elseif subMenu == 2 then
			DataStore.AltGroups:Iterate(function(groupName, groupMembers)
				frame:AddButton(groupName, groupName, OnDeleteAltGroup, nil, nil, level)
			end)		
		end
		
		
		return
	end
	
	-- ** Realms **
	frame:AddTitle(L["FILTER_REALMS"])
	local option = options[OPTION_REALMS]

	-- add specific account/realm filters
	for key, text in ipairs(locationLabels) do
		frame:AddButton(text, key, OnRealmFilterChange, nil, (key == option))
	end
	
	-- ** Alt Groups **
	frame:AddTitle()
	frame:AddTitle(L["FILTER_ALT_GROUPS"])
	local groupOption = options[OPTION_ALTGROUPS]
	
	frame:AddButton(ALL, 0, OnAltGroupChange, nil, (groupOption == 0))
	
	DataStore.AltGroups:Iterate(function(groupName, groupMembers) 
		frame:AddButton(groupName, groupName, OnAltGroupChange, nil, (groupName == groupOption))
	end)
	
	frame:AddTitle()
	-- frame:AddButton(L["FILTER_GROUP_CREATE"], nil, OnCreateAltGroup, nil, (option == 1))
	frame:AddButton(L["FILTER_GROUP_CREATE"], nil, OnCreateAltGroup, nil, nil)
	
	frame:AddCategoryButton(L["FILTER_GROUP_RENAME"], 1, level)
	frame:AddCategoryButton(L["FILTER_GROUP_DELETE"], 2, level)
	
	-- frame:AddButton(L["FILTER_GROUP_RENAME"], nil, OnRenameAltGroup, nil, (option == 1))
	-- frame:AddButton(L["FILTER_GROUP_DELETE"], nil, OnDeleteAltGroup, nil, (option == 1))
	frame:AddButtonWithArgs(HELP_LABEL, 30, addon.ShowOptionsPanel, 12)
	frame:AddCloseMenu()
end

local function FactionIcon_Initialize(frame, level)
	local option = options[OPTION_FACTIONS]

	frame:AddTitle(L["FILTER_FACTIONS"])
	frame:AddButton(FACTION_ALLIANCE, 1, OnFactionFilterChange, nil, (option == 1))
	frame:AddButton(FACTION_HORDE, 2, OnFactionFilterChange, nil, (option == 2))
	frame:AddButton(L["Both factions"], 3, OnFactionFilterChange, nil, (option == 3))
	frame:AddButton(L["This faction"], 4, OnFactionFilterChange, nil, (option == 4))
	frame:AddCloseMenu()
end

local function LevelIcon_Initialize(frame, level)
	local option = options[OPTION_LEVELS]
	
	frame:AddTitle(L["FILTER_LEVELS"])
	frame:AddButtonWithArgs(ALL, 1, OnLevelFilterChange, 1, 120, (option == 1))
	frame:AddTitle()
	frame:AddButtonWithArgs("1-9", 2, OnLevelFilterChange, 1, 9, (option == 2))
	frame:AddButtonWithArgs("10-19", 3, OnLevelFilterChange, 10, 19, (option == 3))
	frame:AddButtonWithArgs("20-29", 4, OnLevelFilterChange, 20, 29, (option == 4))
	frame:AddButtonWithArgs("30-39", 5, OnLevelFilterChange, 30, 39, (option == 5))
	frame:AddButtonWithArgs("40-49", 6, OnLevelFilterChange, 40, 49, (option == 6))
	frame:AddButtonWithArgs("50-59", 7, OnLevelFilterChange, 50, 59, (option == 7))
	frame:AddButtonWithArgs("60-69", 8, OnLevelFilterChange, 60, 69, (option == 8))
	frame:AddButtonWithArgs("70", 9, OnLevelFilterChange, 70, 70, (option == 9))
	frame:AddTitle()
	frame:AddButtonWithArgs("1-44", 10, OnLevelFilterChange, 1, 44, (option == 10))
	frame:AddButtonWithArgs(format("45+ %s(%s)", colors.green, EXPANSION_NAME7), 11, OnLevelFilterChange, 45, 70, (option == 11))
	frame:AddButtonWithArgs(format("50+ %s(%s)", colors.green, EXPANSION_NAME8), 12, OnLevelFilterChange, 50, 70, (option == 12))
	frame:AddButtonWithArgs(format("60+ %s(%s)", colors.green, EXPANSION_NAME9), 13, OnLevelFilterChange, 60, 70, (option == 13))
	frame:AddCloseMenu()
end

local function ProfessionsIcon_Initialize(frame, level)
	if not level then return end

	local tradeskills = addon.TradeSkills.AccountSummaryFiltersSpellIDs
	local option = options[OPTION_TRADESKILL]
	
	if level == 1 then
		frame:AddTitle(L["FILTER_PROFESSIONS"])
		frame:AddButton(ALL, 0, OnTradeSkillFilterChange, nil, (option == 0))
		frame:AddTitle()
		frame:AddCategoryButton(PRIMARY_SKILLS, 1, level)
		frame:AddCategoryButton(SECONDARY_SKILLS, 2, level)
		frame:AddTitle()
		frame:AddButton(L["COLORED_SKILL_LEVELS"], nil, OnTradeSkillLevelColorChange, nil, (options[OPTION_COLORED_SKILLS] == true))
		frame:AddCloseMenu()
	
	elseif level == 2 then
		local spell, icon, _
		local firstSecondarySkill = addon.TradeSkills.AccountSummaryFirstSecondarySkillIndex
	
		local subMenu = frame:GetCurrentOpenMenuValue()
	
		if subMenu == 1 then				-- Primary professions
			for i = 1, (firstSecondarySkill - 1) do
				spell, _, icon = GetSpellInfo(tradeskills[i])
				frame:AddButton(spell, i, OnTradeSkillFilterChange, icon, (option == i), level)
			end
		
		elseif subMenu == 2 then		-- Secondary professions
			for i = firstSecondarySkill, #tradeskills do
				spell, _, icon = GetSpellInfo(tradeskills[i])
				
				frame:AddButton(spell, i, OnTradeSkillFilterChange, icon, (option == i), level)
			end
		end
	end
end

local function ClassIcon_Initialize(frame, level)
	if not level then return end
	
	local option = options[OPTION_CLASSES]
	
	if level == 1 then
		frame:AddTitle(L["FILTER_CLASSES"])
		frame:AddButton(ALL, 0, OnClassFilterChange, nil, (option == 0))
		frame:AddTitle()
		frame:AddCategoryButton(ARMOR, 1, level)
		frame:AddCategoryButton(COMMUNITY_MEMBER_LIST_DROP_DOWN_ROLES, 2, level)
		frame:AddTitle()
		
		-- See constants.lua
		for key, value in ipairs(CLASS_SORT_ORDER) do
			frame:AddButton(
				format("|c%s%s", RAID_CLASS_COLORS[value].colorStr, LOCALIZED_CLASS_NAMES_MALE[value]), 
				key, OnClassFilterChange, nil, (option == key)
			)
		end
		frame:AddTitle()
		frame:AddCloseMenu()
		
	elseif level == 2 then
		local subMenu = frame:GetCurrentOpenMenuValue()
	
		if subMenu == 1 then				-- Armor types
			-- Add the armor types
			for index, armorType in ipairs(addon.Enum.ArmorTypes) do
				-- keep a numeric index, just add +20 since we have only 13 classes
				frame:AddButton(armorType, index + 20, OnClassFilterChange, nil, (option == index + 20), level)	
			end
		
		elseif subMenu == 2 then		-- Role types
		
			-- Add the role types
			for index, roleType in ipairs(roleTypeLabels) do
				-- keep a numeric index, just add +30 since we have only 3 roles
				frame:AddButton(roleType, index + 30, OnClassFilterChange, nil, (option == index + 30), level)	
			end		
		end
	end
end

local function MiscIcon_Initialize(frame, level)
	local option = options[OPTION_MISC]
	
	frame:AddTitle(L["FILTER_MISC"])
	
	frame:AddButton(ALL, 0, OnMiscFilterChange, nil, (option == 0))
	frame:AddTitle()	
	frame:AddButton(L["FILTER_MISC_HAVE_MAILS"], 1, OnMiscFilterChange, nil, (option == 1))
	frame:AddButton(L["FILTER_MISC_HAVE_MAILS_EXPIRE_SOON"], 2, OnMiscFilterChange, nil, (option == 2))
	-- frame:AddButton(L["FILTER_MISC_HAVE_AUCTIONS_EXPIRE_SOON"], 3, OnMiscFilterChange, nil, (option == 3))
	frame:AddTitle()
	frame:AddButton(L["Fully rested"], 4, OnMiscFilterChange, nil, (option == 4))
	frame:AddButton(L["FILTER_MISC_GUILD_EXALTED"], 5, OnMiscFilterChange, nil, (option == 5))
	frame:AddButton(L["FILTER_MISC_GUILD_NOT_EXALTED"], 6, OnMiscFilterChange, nil, (option == 6))
	frame:AddButton(L["FILTER_MISC_UPGRADE_RIDING_SKILL"], 7, OnMiscFilterChange, nil, (option == 7))

	frame:AddCloseMenu()
end

local function BankIcon_Initialize(frame, level)
	local bank = DataStore.Enum.BankTypes
	local labels = DataStore.Enum.BankTypesLabels
	local option = options[OPTION_BANKTYPE]
		
	frame:AddTitle(L["FILTER_BANKTYPE"])
	
	frame:AddButton(ALL, 0, OnBankTypeFilterChange, nil, (option == 0))
	frame:AddButton(L["Any"], -1, OnBankTypeFilterChange, nil, (option == -1))
	frame:AddTitle()
	frame:AddButton(labels.Cooking, bank.Cooking, OnBankTypeFilterChange, nil, (option == bank.Cooking))
	frame:AddButton(labels.Fishing, bank.Fishing, OnBankTypeFilterChange, nil, (option == bank.Fishing))
	frame:AddTitle()
	frame:AddButton(labels.Herb, bank.Herb, OnBankTypeFilterChange, nil, (option == bank.Herb))
	frame:AddButton(labels.Cloth, bank.Cloth, OnBankTypeFilterChange, nil, (option == bank.Cloth))
	frame:AddButton(labels.Leather, bank.Leather, OnBankTypeFilterChange, nil, (option == bank.Leather))
	frame:AddButton(labels.Metal, bank.Metal, OnBankTypeFilterChange, nil, (option == bank.Metal))
	frame:AddTitle()
	frame:AddButton(labels.Elemental, bank.Elemental, OnBankTypeFilterChange, nil, (option == bank.Elemental))
	frame:AddButton(labels.Enchanting, bank.Enchanting, OnBankTypeFilterChange, nil, (option == bank.Enchanting))
	frame:AddButton(labels.Engineering, bank.Engineering, OnBankTypeFilterChange, nil, (option == bank.Engineering))
	frame:AddButton(labels.Jewelcrafting, bank.Jewelcrafting, OnBankTypeFilterChange, nil, (option == bank.Jewelcrafting))
	frame:AddButton(labels.Inscription, bank.Inscription, OnBankTypeFilterChange, nil, (option == bank.Inscription))
	frame:AddTitle()
	frame:AddButton(labels.BattlePets, bank.BattlePets, OnBankTypeFilterChange, nil, (option == bank.BattlePets))
	frame:AddTitle()
	frame:AddButtonWithArgs(HELP_LABEL, 30, addon.ShowOptionsPanel, 11)
	frame:AddCloseMenu()
end

local function AltoholicOptionsIcon_Initialize(frame, level)
	frame:AddTitle(format("%s: %s", GAMEOPTIONS_MENU, addonName))

	frame:AddButton(GENERAL, 1, addon.ShowOptionsPanel)
	frame:AddButton(MAIL_LABEL, 2, addon.ShowOptionsPanel)
	frame:AddButton(L["Tooltip"], 3, addon.ShowOptionsPanel)
	frame:AddButton(L["Calendar"], 4, addon.ShowOptionsPanel)
	frame:AddButton(MISCELLANEOUS, 5, addon.ShowOptionsPanel)
	
	frame:AddTitle()
	frame:AddTitle(OTHER)	
	-- frame:AddButton("What's new?", AltoholicWhatsNew, addon.ShowOptionsPanel)
	frame:AddButtonWithArgs(L["Getting support"], 30, addon.ShowOptionsPanel, 6)
	frame:AddButtonWithArgs(L["Memory used"], 30, addon.ShowOptionsPanel, 9)
	frame:AddButtonWithArgs(HELP_LABEL, 30, addon.ShowOptionsPanel, 2)
	
	frame:AddCloseMenu()
end

local addonList = {
	"DataStore_Auctions",
	"DataStore_Characters",
	"DataStore_Garrisons",
	"DataStore_Inventory",
	"DataStore_Mails",
	"DataStore_Quests",
}

local function DataStoreOptionsIcon_Initialize(frame, level)
	frame:AddTitle(format("%s: %s", GAMEOPTIONS_MENU, "DataStore"))
	
	local panelID = 10
	for _, module in ipairs(addonList) do
		if _G[module] then	-- only add loaded modules
			frame:AddButton(module, panelID, addon.ShowOptionsPanel)
		end
		panelID = panelID + 1
	end
	
	frame:AddTitle()
	frame:AddButton(L["Reset all data"], nil, ResetAllData)
	frame:AddButtonWithArgs(L["Memory used"], 30, addon.ShowOptionsPanel, 10)
	frame:AddButtonWithArgs(HELP_LABEL, 30, addon.ShowOptionsPanel, 4)
	frame:AddCloseMenu()
end

local menuIconCallbacks = {
	RealmsIcon_Initialize,
	FactionIcon_Initialize,
	LevelIcon_Initialize,
	ProfessionsIcon_Initialize,
	ClassIcon_Initialize,
	MiscIcon_Initialize,
	BankIcon_Initialize,
	AltoholicOptionsIcon_Initialize,
	DataStoreOptionsIcon_Initialize,
}

addon:Controller("AltoholicUI.TabSummary", { 
	"AltoholicUI.Characters", "AltoholicUI.TabSummaryColumns", "AltoholicUI.TabSummaryColumnProfiles",
	function(characters, columnsData, columnProfiles)

	local function ColumnHeader_OnEnter(frame)
		local column = frame.column
		if not frame.column then return end		-- invalid data ? exit
		
		local tt = AddonFactory_Tooltip
		
		tt:ClearLines()
		tt:SetOwner(frame, "ANCHOR_BOTTOM")
		
		-- Add the tooltip title
		if column.tooltipTitle then
			tt:AddLine(column.tooltipTitle)
		end

		-- Add the tooltip subtitle in cyan
		if column.tooltipSubTitle then
			tt:AddLine(column.tooltipSubTitle, 0, 1, 1)
		end

		-- Add the extra tooltip content, if any
		if column.headerOnEnter then
			column.headerOnEnter(frame, tt)
		end
		
		tt:Show()
	end

	return {
		OnBind = function(frame)
			tab = frame
			
			-- Handle resize
			frame:SetScript("OnSizeChanged", function(self, width, height)
				if not frame:IsVisible() then return end
			
				self.HeaderContainer:LimitWidth(self.Background:GetWidth())
				frame:Update(true)
			end)
			
			-- frame:SetColumns(1)
			-- frame.CategoriesList.Entry2:Button_OnClick("LeftButton")
			-- frame:Update()
			
			DataStore:ListenTo("DATASTORE_GUILD_LEFT", function() 
				frame:Update()
			end)
			DataStore:ListenTo("DATASTORE_PROFESSION_LINKS_UPDATED", function() 
				frame:Update()
			end)
			
		end,
		FilterIcon_OnEnter = function(frame, icon)
			local currentMenuID = icon:GetID()
			
			local menu = frame.ContextualMenu
			
			menu:Initialize(menuIconCallbacks[currentMenuID], "LIST")
			menu:Close()
			menu:Toggle(icon, 0, 0)
		end,
		
		AccountSharingButton_OnEnter = function(frame, button)
			local tooltip = AddonFactory_Tooltip
			
			tooltip:SetOwner(button, "ANCHOR_RIGHT")
			tooltip:ClearLines()
			tooltip:SetText(L["ACCOUNT_SHARING_BUTTON_TITLE"])
			tooltip:AddLine(L["ACCOUNT_SHARING_BUTTON_INFO"],1,1,1)
			tooltip:Show()
		end,
		AccountSharingButton_OnClick = function(frame)
			AltoholicFrame:SwitchToTab("Options")
			
			local tab = AltoholicFrame.TabOptions
			
			if AccountSharing.HasBeenUsedBefore() then
				-- if the player has used account sharing before, go to the right panel
				tab.CategoriesList:ClickCategory("panel", 22)
				tab:ShowPanel(22)	
			else
				-- otherwise go to the help panel
				tab.CategoriesList:ClickCategory("helpID", 1)
				tab:SetHelp(1)
				tab:ShowPanel(30)	
			end
		end,

		SortBy = function(frame, columnName)
			-- Sort the whole view by a given column
			-- Toggle the option
			options["SortAscending"] = not options["SortAscending"]
			options["CurrentColumn"] = columnName
			
			frame:Update()
		end,
		SetColumns = function(frame, profileIndex)
			options["CurrentMode"] = profileIndex
			
			-- add the appropriate columns for this mode
			local hc = frame.HeaderContainer
			local profiles = columnProfiles.Get(profileIndex)
				
			-- Setup active buttons
			for i, columnName in ipairs(profiles) do
				local column = columnsData.Get(columnName)
				
				hc:SetButton(i, column.headerLabel, column.headerWidth, column.headerOnClick)
				
				local button = hc.SortButtons[i]
				button.column = column
				button:SetScript("OnEnter", ColumnHeader_OnEnter)
				button:SetScript("OnLeave", function() AddonFactory_Tooltip:Hide() end)
				button:Show()
			end
			
			-- Remove text from additional buttons, to be sure they will be hidden
			for i = #profiles + 1, hc.numButtons do
				local button = hc.SortButtons[i]
				button:SetText()
			end
			
			hc:LimitWidth(frame.Background:GetWidth())
		end,
		Update = function(frame, isResizing)
			if not options then return end
			
			local scrollFrame = frame.Summary.ScrollFrame
			local numRows = scrollFrame.numRows
			local offset = scrollFrame:GetOffset()

			local isRealmShown
			local numRealms = 0				-- number of realms in the view
			local numVisibleRows = 0
			local numDisplayedRows = 0

			-- This handles the resize
			local maxDisplayedRows = math.floor(scrollFrame:GetHeight() / 23)
			-- print(format("Scroll height: %d", scrollFrame:GetHeight()))
			-- print(format("frame height: %d, width: %d", frame:GetHeight(), frame:GetWidth()))
			
			local currentModeIndex = options["CurrentMode"]
			local currentProfile = columnProfiles.Get(currentModeIndex)
			
			-- rebuild and get the view, then sort it
			if not isResizing then
				-- be sure not to force a rebuild of the view when resizing => high memory usage
				characters.InvalidateView()
			end
			
			local view = characters.GetView(isResizing)
			
			if not isResizing then
				local hc = frame.HeaderContainer
				local sortOrder = options["SortAscending"]
				local currentColumn = options["CurrentColumn"]
				local column = columnsData.Get(currentColumn)
				
				if column then	-- an old column name might still be in the DB.
					characters.Sort(sortOrder, column.headerSort)
				end

				-- attempt to restore the arrow to the right sort button
				for i = 1, #currentProfile do
					if currentProfile[i] == currentColumn then
						hc.SortButtons[i]:DrawArrow(sortOrder)
					else
						hc.SortButtons[i]:HideArrow()
					end
				end
			end
			
			local rowIndex = 1
			
			for _, line in pairs(view) do
				local isRealmLine = characters.IsRealmLine(line)
				if isRealmLine then numRealms = numRealms + 1 end

				-- if the line will not be visible
				if (offset > 0) or (numDisplayedRows >= numRows) or (numDisplayedRows > maxDisplayedRows) then
					-- then keep track of counters
					if isRealmLine then								
						isRealmShown = not characters.IsRealmCollapsed(line)
						
						numVisibleRows = numVisibleRows + 1
						offset = offset - 1		-- no further control, nevermind if it goes negative
					elseif isRealmShown then
						numVisibleRows = numVisibleRows + 1
						offset = offset - 1		-- no further control, nevermind if it goes negative
					end
					
				else		-- line will be displayed
					local rowFrame = scrollFrame:GetRow(rowIndex)
					
					if isRealmLine then
						isRealmShown = not characters.IsRealmCollapsed(line)
						
						if not (isResizing and rowFrame:IsVisible()) then
							local _, realm, account = characters.GetInfo(line)
							rowFrame:DrawRealmLine(line, realm, account, isRealmShown)
						end
					
						rowIndex = rowIndex + 1
						numVisibleRows = numVisibleRows + 1
						numDisplayedRows = numDisplayedRows + 1
					elseif isRealmShown then
					
						if not (isResizing and rowFrame:IsVisible()) then
							if characters.IsCharacterLine(line) then
								rowFrame:DrawCharacterLine(line, currentProfile)
							elseif characters.IsTotalLine(line) then
								rowFrame:DrawTotalLine(line, currentProfile)
							end
						end

						rowIndex = rowIndex + 1
						numVisibleRows = numVisibleRows + 1
						numDisplayedRows = numDisplayedRows + 1
					end
				end
			end
			
			while rowIndex <= numRows do
				local rowFrame = scrollFrame:GetRow(rowIndex) 
				
				rowFrame:SetID(0)
				rowFrame:Hide()
				rowIndex = rowIndex + 1
			end

			-- Update the filters text
			if numRealms == 0 then
				frame.Filters:SetText(format(L["%s%d%s characters found : did you set your filters properly ?"], colors.red, 0, colors.white))
			else
				-- the number of alts = all lines in the view, minus the number of realms * 2
				-- because for each realm there is a realm line + a total line
				local numAlts = #view - (numRealms * 2)	
			
				local filtersText = format("%s%s: %s%d%s, %s: %s%d", 
					colors.white, L["Characters"], colors.green, numAlts,
					colors.white, L["Realms"], colors.green, numRealms)
					
				local groupOption = options[OPTION_ALTGROUPS]
				if type(groupOption) == "string" then
					filtersText = format("%s %s(%s)", filtersText, colors.yellow, groupOption)
				end
			
				frame.Filters:SetText(filtersText)
			end
			
			-- Update the totals text
			local totalMoney, totalPlayed, totalLevels = characters.GetStats()
			
			local levels = format("%s%s |rLv", colors.white, BreakUpLargeNumbers(totalLevels))
			local gold = format(GOLD_AMOUNT_TEXTURE_STRING, BreakUpLargeNumbers(floor(totalMoney / 10000)), 13, 13)
			local played = format("%s%sd", BreakUpLargeNumbers(floor(totalPlayed / 86400)), colors.gold)
	
			frame.Totals:SetText(format("%s: %s%s / %s%s / %s", L["Totals"], levels, colors.white, gold, colors.white, played))
			
			-- numVisibleRows = number of items in the list
			-- maxDisplayedRows = number of items that will actually be displayed
			scrollFrame:Update(numVisibleRows, maxDisplayedRows)
		end,
	}
end})

local function categoriesList_OnClick(categoryData)
	AltoholicFrame.TabSummary:SetColumns(categoryData.profile)
	AltoholicFrame.TabSummary:Update()
end

addon:Controller("AltoholicUI.TabSummaryCategoriesList", {
	OnBind = function(frame)
	
		-- Profiles are in Services/Columns.lua : AltoholicUI.TabSummaryColumnProfiles
	
		local categories = {
			{ text = L["Character Information"], isExpanded = true, subMenu = {
				{ text = L["Account Summary"], profile = 1 },
				{ text = L["Experience"], profile = 2 },
				{ text = L["Levels"], profile = 3 },
				{ text = GUILD, profile = 4 },
				{ text = L["Location"], profile = 5 },
				{ text = MISCELLANEOUS, profile = 6 },
			}},
			{ text = L["Bag Usage"], profile = 7 },
			{ text = SKILLS, profile = 8 },
			{ text = L["Activity"], profile = 9 },
			{ text = L["Currencies"], subMenu = {
				{ text = MISCELLANEOUS, profile = 10 },
				{ text = EXPANSION_NAME3, profile = 11 },
				{ text = EXPANSION_NAME4, profile = 12 },
				{ text = EXPANSION_NAME5, profile = 13 },
				{ text = EXPANSION_NAME6, profile = 14 },
				{ text = EXPANSION_NAME7, profile = 15 },
				{ text = EXPANSION_NAME8, subMenu = {
					{ text = format("%s9.0|r %s", colors.green, L["PATCH_X.0"]), profile = 16 },
					{ text = format("%s9.1|r %s", colors.green, L["PATCH_9.1"]), profile = 17 },
					{ text = format("%s9.2|r %s", colors.green, L["PATCH_9.2"]), profile = 23 },
				}},
				{ text = EXPANSION_NAME9, subMenu = {
					{ text = format("%s10.0|r %s", colors.green, L["PATCH_X.0"]), profile = 27 },
					{ text = format("%s10.1|r %s", colors.green, L["PATCH_10.1"]), profile = 28 },
					{ text = format("%s10.2|r %s", colors.green, L["PATCH_10.2"]), profile = 29 },
				}},				
			}},
			-- Expansion Features
			{ text = GetCategoryInfo(15301), subMenu = {
				-- Draenor
				{ text = EXPANSION_NAME5, subMenu = {
					-- Garrisons
					{ text = GetCategoryInfo(15303), profile = 18 },
				}},
				
				-- Legion
				-- { text = EXPANSION_NAME6, subMenu = {
					-- Class Hall
					-- { text = GetCategoryInfo(15304), profile = 19 },
				-- }},
				
				-- Battle for Azeroth
				-- { text = EXPANSION_NAME7, subMenu = {
					-- War effort
					-- { text = GetCategoryInfo(15308) },
				-- }},
				
				-- Shadowlands
				{ text = EXPANSION_NAME8, subMenu = {
					-- Covenant Sanctums
					{ text = GetCategoryInfo(15441), profile = 20 },
					-- Sanctum Reservoir
					{ text = COVENANT_SANCTUM_TAB_UPGRADES, profile = 21 },
					-- Campain Progress
					{ text = L["COLUMN_CAMPAIGNPROGRESS_TITLE"], profile = 24 },
					-- Cypher Research
					{ text = format("%s9.2|r %s", colors.green, CYPHER_RESEARCH_TOAST), profile = 25 },
					-- Torghast
					-- { text = GetCategoryInfo(15440), profile = 23 },
				}},
				
				-- Dragonflight
				{ text = EXPANSION_NAME9, subMenu = {
					-- Campain Progress
					{ text = L["COLUMN_CAMPAIGNPROGRESS_TITLE"], profile = 31 },
				}},				
			}},
			{ text = CHALLENGES, subMenu = {
				-- Weekly Best
				{ text = L["Mythic+ Keystone"], profile = 22 },
				-- Weekly Best Runs per dungeon
				{ text = CHALLENGE_MODE_WEEKLY_BEST, profile = 30 },
				-- Weekly Rewards
				{ text = REWARDS, profile = 26 },
			}},
		}
	
		-- Initialize categories (auto-fill the on-click callback)
		frame:IterateCategories(categories, function(category) 
			if category.profile then
				category.callback = categoriesList_OnClick
			end
		end)	
	
		frame:SetCategories(categories)
	end,
})

DataStore:OnAddonLoaded(addonTabName, function() 
	Altoholic_SummaryTab_Options = Altoholic_SummaryTab_Options or {
		["ShowRestXP150pc"] = false,					-- display max rest xp in normal 100% mode or in level equivalent 150% mode ?
		["CurrentMode"] = 1,								-- current mode (1 = account summary, 2 = bags, ...)
		["CurrentColumn"] = "Name",					-- current column (default = "Name")
		["CurrentRealms"] = 2,							-- selected realms (current/all in current/all accounts)
		["CurrentAltGroup"] = 0,						-- selected alt group
		["CurrentFactions"] = 3,						-- 1 = Alliance, 2 = Horde, 3 = Both
		["CurrentLevels"] = 1,							-- 1 = All
		["CurrentLevelsMin"] = 1,							
		["CurrentLevelsMax"] = 70,					
		["CurrentBankType"] = 0,						-- 0 = All
		["CurrentClasses"] = 0,							-- 0 = All
		["CurrentTradeSkill"] = 0,						-- 0 = All
		["CurrentMisc"] = 0,								-- 
		["UseColorForTradeSkills"] = true,			-- Use color coding for tradeskills, or neutral
		["SortAscending"] = true,						-- ascending or descending sort order
		["ShowLevelDecimals"] = true,					-- display character level with decimals or not
		["ShowILevelDecimals"] = true,				-- display character level with decimals or not
		["ShowGuildRank"] = false,						-- display the guild rank or the guild name
	}
	options = Altoholic_SummaryTab_Options
	
	--Temporary: database migration
	if AltoholicDB then
		local source = AltoholicDB.global.options

		for k, v in pairs(source) do
			local arg1, arg2, arg3 = strsplit(".", k)
			
			if arg1 == "UI" and arg2 == "Tabs" and arg3 == "Summary" then
				local prefix = "UI.Tabs.Summary."
				local optionName = k:sub(#prefix + 1)
				
				-- Create the new entries
				options[optionName] = v
				
				-- Delete the old entries
				source[k] = nil
			end
		end
	end
	
	-- Update only when options are ready
	tab.CategoriesList.Entry2:Button_OnClick("LeftButton")
	tab:Update()
end)
