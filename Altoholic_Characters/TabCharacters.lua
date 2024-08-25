local addonTabName = ...
local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = DataStore:GetLocale(addonName)
local MVC = LibStub("LibMVC-1.0")
local Equipment = MVC:GetService("AltoholicUI.Equipment")

local ICON_BAGS_HALLOWSEND = "Interface\\Icons\\INV_Misc_Bag_28_Halloween"
local ICON_VIEW_BAGS = "Interface\\Icons\\INV_MISC_BAG_09"

local SKILL_ANY = 4

-- Mini easter egg, the bag icon changes depending on the amount of chars at level max (on the current realm), or based on the time of the year
local BAG_ICONS = {
	"Interface\\Icons\\INV_MISC_BAG_09",			-- mini pouch
	"Interface\\Icons\\INV_MISC_BAG_10_BLUE",		-- small bag
	"Interface\\Icons\\INV_Misc_Bag_12",			-- larger bag
	"Interface\\Icons\\INV_Misc_Bag_19",			-- bag 14
	"Interface\\Icons\\INV_Misc_Bag_08",			-- bag 16
	"Interface\\Icons\\INV_Misc_Bag_23_Netherweave",	-- 18
	"Interface\\Icons\\INV_Misc_Bag_EnchantedMageweave",	-- 20
	"Interface\\Icons\\INV_Misc_Bag_25_Mooncloth",
	"Interface\\Icons\\INV_Misc_Bag_26_Spellfire",
	"Interface\\Icons\\INV_Misc_Bag_33",
	"Interface\\Icons\\inv_misc_basket_05",
	"Interface\\Icons\\inv_tailoring_hexweavebag",
}

local tab		-- small shortcut to easily address the frame (set in OnBind)
local options
local currentPanelKey

-- ** Icon events **
local function OnContainerChange(self)
	-- Toggle the option
	local option = self.value
	options[option] = not options[option]

	currentPanelKey = "Containers"
	tab:Update()
end

local function OnRarityChange(self)
	options["ViewBagsRarity"] = self.value
	currentPanelKey = "Containers"
	tab:Update()
end

local function OnQuestHeaderChange(self)
	options["ViewQuestLogCategory"] = self.value or 0
	currentPanelKey = "QuestLog"
	tab:Update()
end

local function OnAuctionsChange(self, listType)
	CloseDropDownMenus()
	Altoholic_UI_Options.ViewAuctionHouse = listType
	currentPanelKey = self.value
	tab:Update()
end

local function OnClearAHEntries(self, character)
	local listType = Altoholic_UI_Options.ViewAuctionHouse
	
	if (self.value == 1) or (self.value == 3) then	-- clean this faction's data
		DataStore:ClearAuctionEntries(character, listType, 0)
	end
	
	if (self.value == 2) or (self.value == 3) then	-- clean goblin AH
		DataStore:ClearAuctionEntries(character, listType, 1)
	end
	
	tab.Panels["Auctions"]:InvalidateView()
	tab:Update()
end

local function OnMenuChange(self)
	-- Generic callback, shared by multiple drop down menus
	CloseDropDownMenus()
	currentPanelKey = self.value
	tab:Update()
end

local function OnSpellTabChange(self)
	CloseDropDownMenus()
	options["ViewSpellTab"] = self.value
	currentPanelKey = "Spellbook"
	tab:Update()
end

local function OnProfessionChange(self)
	CloseDropDownMenus()
	
	currentProfession = self.value

	local recipes = tab.Panels.Recipes

	recipes:SetCurrentProfession(currentProfession)
	recipes:ResetFilters()

	currentPanelKey = "Recipes"
	tab:Update()
end

local function OnProfessionColorChange(self)
	CloseDropDownMenus()
	
	if not self.value then return end
	
	tab.Panels.Recipes:SetCurrentColor(self.value)
	currentPanelKey = "Recipes"
	tab:Update()
end

local function OnProfessionSlotChange(self)
	CloseDropDownMenus()
	
	if not self.value then return end
	
	tab.Panels.Recipes:SetCurrentSlots(self.value)
	currentPanelKey = "Recipes"
	tab:Update()
end

local function OnProfessionCategoryChange(self, mainCategory, subCategory)
	CloseDropDownMenus()
	
	if not self.value then return end
	
	local previousProfession = currentProfession
	local professionName, mainCategory, subCategory = strsplit(",", self.value)
	currentProfession = professionName
	
	local recipes = tab.Panels.Recipes
	
	-- if profession has changed, reset the slots filter
	if previousProfession and previousProfession ~= currentProfession then
		recipes:SetCurrentColor(SKILL_ANY)
		recipes:SetCurrentSlots(ALL_INVENTORY_SLOTS)
	end
	
	recipes:SetCurrentProfession(currentProfession)
	recipes:SetMainCategory(tonumber(mainCategory))
	recipes:SetSubCategory(tonumber(subCategory))
	
	currentPanelKey = "Recipes"
	tab:Update()
end

local function OnShowLearned(self)
	CloseDropDownMenus()
	
	-- Toggle the option
	options["ViewLearnedRecipes"] = not options["ViewLearnedRecipes"]

	currentPanelKey = "Recipes"
	tab:Update()
end

local function OnShowUnlearned(self)
	-- Toggle the option
	options["ViewUnlearnedRecipes"] = not options["ViewUnlearnedRecipes"]
	
	currentPanelKey = "Recipes"
	tab:Update()
end

local function OnGarrisonMenuChange(self)
	CloseDropDownMenus()
	options["GarrisonMissions"] = self.value
	currentPanelKey = "GarrisonMissions"
	tab:Update()
end

local function OnCovenantChange(self)
	CloseDropDownMenus()
	options["CovenantSanctum"] = self.value
	currentPanelKey = self.value
	tab:Update()
end

local function OnClearMailboxEntries(self)
	local character = self.value
	
	DataStore:ClearMailboxEntries(character)
	tab:Update()
end


-- ** Menu Icons **
local function BagsIcon_Initialize(frame, level)
	local character = tab:GetCharacter()
	if not character then return end

	frame:AddTitle(format("%s / %s", L["Containers"], DataStore:GetColoredCharacterName(character)))

	frame:AddButton(L["View"], nil, function() tab:ShowPanel("Containers") end)
	frame:AddButton(L["Bags"], "ViewBags", OnContainerChange, nil, options["ViewBags"])
	frame:AddButton(L["Bank"], "ViewBank", OnContainerChange, nil, options["ViewBank"])
	frame:AddButton(VOID_STORAGE, "ViewVoidStorage", OnContainerChange, nil, options["ViewVoidStorage"])
	frame:AddButton(REAGENT_BANK , "ViewReagentBank", OnContainerChange, nil, options["ViewReagentBank"])
	frame:AddButton(L["All-in-one"], "ViewBagsAllInOne", OnContainerChange, nil, options["ViewBagsAllInOne"])
		
	frame:AddTitle(" ")
	frame:AddTitle(format("|r%s", RARITY))
	local rarity = options["ViewBagsRarity"]
	frame:AddButton(L["Any"], 0, OnRarityChange, nil, (rarity == 0))
	
	for i = Enum.ItemQuality.Uncommon, Enum.ItemQuality.Heirloom do		-- Quality: 0 = poor .. 5 = legendary
		frame:AddButton(format("|c%s%s", select(4, GetItemQualityColor(i)), _G["ITEM_QUALITY"..i.."_DESC"]), i, OnRarityChange, nil, (rarity == i))
	end
	
	frame:AddCloseMenu()
end

local function QuestsIcon_Initialize(frame, level)
	local character = tab:GetCharacter()
	if not character then return end
	
	local questLogCategory = options["ViewQuestLogCategory"]
	
	frame:AddTitle(format("%s / %s", QUESTS_LABEL, DataStore:GetColoredCharacterName(character)))
	frame:AddButton(ALL, 0, OnQuestHeaderChange, nil, (questLogCategory == 0))
	
	-- get the list of quest headers/categories
	local sortedHeaders = {}
	for headerIndex, header in pairs(DataStore:GetQuestHeaders(character)) do
		table.insert(sortedHeaders, { name = header, index = headerIndex })
	end
	-- sort them
	table.sort(sortedHeaders, function(a, b) return a.name < b.name end)

	-- then add them to the drop-down
	for _, v in pairs(sortedHeaders) do
		frame:AddButton(v.name, v.index, OnQuestHeaderChange, nil, (questLogCategory == v.index))
	end
	
	frame:AddTitle("|r ")
	frame:AddTitle(GAMEOPTIONS_MENU)
	if DataStore_Quests then
		frame:AddButton("DataStore Quests", 15, addon.ShowOptionsPanel)
	end
	frame:AddCloseMenu()
end

local function TalentsIcon_Initialize(frame, level)
	local character = tab:GetCharacter()
	if not character then return end
	
	frame:AddTitle(format("%s / %s", TALENTS, DataStore:GetColoredCharacterName(character)))
	frame:AddTitle(" ")
	frame:AddButton(TALENTS, "Talents", OnMenuChange)
	frame:AddCloseMenu()
end

local function AuctionIcon_Initialize(frame, level)
	local character = tab:GetCharacter()
	if not character then return end
	
	frame:AddTitle(format("%s / %s", BUTTON_LAG_AUCTIONHOUSE, DataStore:GetColoredCharacterName(character)))
	
	local numAuctions = DataStore:GetNumAuctions(character) or 0
	if numAuctions == 0 then
		frame:AddButton(format("%s %s(%d)", AUCTIONS, colors.grey, 0))
	else
		frame:AddButtonWithArgs(format("%s %s(%d)", AUCTIONS, colors.green, numAuctions), "Auctions", OnAuctionsChange, "Auctions")
	end
	
	local numBids = DataStore:GetNumBids(character) or 0
	if numBids == 0 then
		frame:AddButton(format("%s %s(%d)", BIDS, colors.grey, 0))
	else
		frame:AddButtonWithArgs(format("%s %s(%d)", BIDS, colors.green, numBids), "Auctions", OnAuctionsChange, "Bids")
	end
	
	-- actions
	frame:AddTitle(" ")
	frame:AddButtonWithArgs(format("%s%s", colors.white, L["Clear your faction's entries"]), 1, OnClearAHEntries, character)
	frame:AddButtonWithArgs(format("%s%s", colors.white, L["Clear goblin AH entries"]), 2, OnClearAHEntries, character)
	frame:AddButtonWithArgs(format("%s%s", colors.white, L["Clear all entries"]), 3, OnClearAHEntries, character)
	
	frame:AddTitle("|r ")
	frame:AddTitle(GAMEOPTIONS_MENU)
	if DataStore_Auctions then
		frame:AddButton("DataStore Auctions", 10, addon.ShowOptionsPanel)
	end
	frame:AddCloseMenu()
end

local function MailIcon_Initialize(frame, level)
	local character = tab:GetCharacter()
	if not character then return end
		
	frame:AddTitle(format("%s / %s", MINIMAP_TRACKING_MAILBOX, DataStore:GetColoredCharacterName(character)))

	local numMails = DataStore:GetNumMails(character) or 0
	if numMails == 0 then
		frame:AddButton(format("%s %s(%d)", L["Mails"], colors.grey, 0))
	else
		frame:AddButton(format("%s %s(%d)", L["Mails"], colors.green, numMails), "Mails", OnMenuChange)
	end

	frame:AddButton(format("%s%s", colors.white, L["Clear all entries"]), character, OnClearMailboxEntries)
	frame:AddTitle("|r ")
	frame:AddTitle(GAMEOPTIONS_MENU)
	frame:AddButton(MAIL_LABEL, 2, addon.ShowOptionsPanel)
	if DataStore_Mails then
		frame:AddButton("DataStore Mails", 14, addon.ShowOptionsPanel)
	end
	
	frame:AddCloseMenu()
end

local function SpellbookIcon_Initialize(frame, level)
	local character = tab:GetCharacter()
	if not character then return end
	
	frame:AddTitle(format("%s / %s", SPELLBOOK, DataStore:GetColoredCharacterName(character)))
	
	for index, spellTab in ipairs(DataStore:GetSpellTabs(character)) do
		frame:AddButton(spellTab, spellTab, OnSpellTabChange, nil, (options["ViewSpellTab"] == spellTab))
	end
	frame:AddCloseMenu()
end

local function ProfessionsIcon_Initialize(frame, level)
	local character = tab:GetCharacter()
	if not character then return end
	
	local recipes = tab.Panels.Recipes
	
	if level == 1 then
		frame:AddTitle(format("%s / %s", TRADE_SKILLS, DataStore:GetColoredCharacterName(character)))

		local last = DataStore:GetModuleLastUpdateByKey("DataStore_Crafts", character)
		local rank, maxRank, professionName, _

		-- Cooking
		rank, maxRank = DataStore:GetCookingRank(character)
		if maxRank > 0 then
			if last and rank then
				local info = frame:CreateInfo()
				
				info.text = format("%s %s(%s)", PROFESSIONS_COOKING, colors.green, rank )
				info.hasArrow = 1
				info.checked = (PROFESSIONS_COOKING == (currentProfession or ""))
				info.value = PROFESSIONS_COOKING
				info.func = OnProfessionChange
				frame:AddButtonInfo(info, level)
			else
				frame:AddButton(colors.grey..PROFESSIONS_COOKING, nil, nil)
			end
		end
		
		-- Profession 1
		rank, maxRank = DataStore:GetProfession1Rank(character)
		if maxRank > 0 then
			professionName = DataStore:GetProfession1Name(character)
		
			if last and rank and professionName then
				local info = frame:CreateInfo()
				
				info.text = format("%s %s(%s)", professionName, colors.green, rank )
				info.hasArrow = 1
				info.checked = (professionName == (currentProfession or ""))
				info.value = professionName
				info.func = OnProfessionChange
				frame:AddButtonInfo(info, level)
				
			elseif professionName then
				frame:AddButton(format("%s%s", colors.grey, professionName), nil, nil)
			end
		end
		
		-- Profession 2
		rank, maxRank = DataStore:GetProfession2Rank(character)
		if maxRank > 0 then
			professionName = DataStore:GetProfession2Name(character)
				
			if last and rank and professionName then
				local info = frame:CreateInfo()
				
				info.text = format("%s %s(%s)", professionName, colors.green, rank )
				info.hasArrow = 1
				info.checked = (professionName == (currentProfession or ""))
				info.value = professionName
				info.func = OnProfessionChange
				frame:AddButtonInfo(info, level)
				
			elseif professionName then
				frame:AddButton(format("%s%s", colors.grey, professionName), nil, nil)
			end
		end
		
		frame:AddTitle(" ")
		frame:AddButton(TRADE_SKILLS_LEARNED_TAB, nil, OnShowLearned, nil, options["ViewLearnedRecipes"])
		frame:AddButton(TRADE_SKILLS_UNLEARNED_TAB, nil, OnShowUnlearned, nil, options["ViewUnlearnedRecipes"])
		frame:AddTitle(" ")
		frame:AddTitle(FILTERS)
		
		if currentProfession then		-- if a profession is visible, display filters
			local info = frame:CreateInfo()

			info.text = format("%s%s", colors.white, COLOR)
			info.hasArrow = 1
			info.checked = nil
			info.value = "colors"
			info.func = nil
			frame:AddButtonInfo(info, level)

			info.text = format("%s%s", colors.white, SLOT_ABBR)
			info.hasArrow = 1
			info.checked = nil
			info.value = "slots"
			info.func = nil
			frame:AddButtonInfo(info, level)
			
		else		-- grey out filters
			frame:AddButton(format("%s%s", colors.grey, COLOR), nil, nil)
			frame:AddButton(format("%s%s", colors.grey, SLOT_ABBR), nil, nil)
		end
		
		frame:AddCloseMenu()
		
	elseif level == 2 then	-- ** filters **
		local info = frame:CreateInfo()
		local currentMenu = frame:GetCurrentOpenMenuValue()

		if currentMenu == "colors" then
			for index = 0, 3 do 
				info.text = recipes:GetRecipeColorName(index)
				info.value = index
				info.checked = (recipes:GetCurrentColor() == index)
				info.func = OnProfessionColorChange
				frame:AddButtonInfo(info, level)
			end

			info.text = L["Any"]
			info.value = SKILL_ANY
			info.checked = (recipes:GetCurrentColor() == SKILL_ANY)
			info.func = OnProfessionColorChange
			frame:AddButtonInfo(info, level)
			
		elseif currentMenu == "slots" then
			info.text = ALL_INVENTORY_SLOTS
			info.value = ALL_INVENTORY_SLOTS
			info.checked = (recipes:GetCurrentSlots() == ALL_INVENTORY_SLOTS)
			info.func = OnProfessionSlotChange
			frame:AddButtonInfo(info, level)
			
			local invSlots = {}
			local profession = DataStore:GetProfession(character, currentProfession)
			
			DataStore:IterateRecipes(profession, 0, 0, function(recipeData)
				local color, recipeID = DataStore:GetRecipeInfo(recipeData)
				local itemID = DataStore:GetCraftResultItem(recipeID)
				if not itemID then return end
					
				local _, _, _, _, _, itemType, _, _, itemEquipLoc = GetItemInfo(itemID)

				if itemEquipLoc and strlen(itemEquipLoc) > 0 then
					local slot = Equipment.GetInventoryTypeName(itemEquipLoc)
					if slot then
						invSlots[slot] = itemEquipLoc
					end
				end
			end)

			for k, v in pairs(invSlots) do		-- add all the slots found
				info.text = k
				info.value = v
				info.checked = (recipes:GetCurrentSlots() == v)
				info.func = OnProfessionSlotChange
				frame:AddButtonInfo(info, level)
			end

			--NONEQUIPSLOT = "Created Items"; -- Items created by enchanting
			info.text = NONEQUIPSLOT
			info.value = NONEQUIPSLOT
			info.checked = (recipes:GetCurrentSlots() == NONEQUIPSLOT)
			info.func = OnProfessionSlotChange
			frame:AddButtonInfo(info, level)
			
		else
			local currentMenu = frame:GetCurrentOpenMenuValue()
			local profession = DataStore:GetProfession(character, currentMenu)
			
			for index = 1, DataStore:GetNumRecipeCategories(profession) do
				local categoryID, name, rank, maxRank = DataStore:GetRecipeCategoryInfo(profession, index)
				
				if rank and maxRank then
					local color = (maxRank == 0) and colors.red or colors.green
					name = format("%s (%s%s|r / %s%s|r)", name, color, rank, color, maxRank)
				end
				
				info.text = name
				info.value = format("%s,%d,0", currentMenu, index)		-- "Tailoring,1,0"
				info.hasArrow = (DataStore:GetNumRecipeCategorySubItems(profession, index) > 0) and 1 or nil
				info.checked = ((recipes:GetCurrentProfession() == currentMenu) and (recipes:GetMainCategory() == index))
				info.func = OnProfessionCategoryChange
				frame:AddButtonInfo(info, level)	
			end
		end
	
	elseif level == 3 then	-- ** filters **
		
		local info = frame:CreateInfo()
		local currentMenu = frame:GetCurrentOpenMenuValue()
		local professionName, categoryIndex = strsplit(",", currentMenu)
		
		local profession = DataStore:GetProfession(character, professionName)
		categoryIndex = tonumber(categoryIndex)
		
		for subCatIndex = 1, DataStore:GetNumRecipeCategorySubItems(profession, categoryIndex) do
			local categoryID, name = DataStore:GetRecipeSubCategoryInfo(profession, categoryIndex, subCatIndex)
			info.text = name
			info.value = format("%s,%d,%d", professionName, categoryIndex, subCatIndex)		-- "Tailoring,1,2"
			info.checked = (
				(recipes:GetCurrentProfession() == professionName) and 
				(recipes:GetMainCategory() == categoryIndex) and 
				(recipes:GetSubCategory() == subCatIndex)
			)
			info.func = OnProfessionCategoryChange
			frame:AddButtonInfo(info, level)	
		end
	end
end

local garrisonTypes = {
	Enum.GarrisonFollowerType.FollowerType_6_0_GarrisonFollower,
	Enum.GarrisonFollowerType.FollowerType_7_0_GarrisonFollower,
	Enum.GarrisonFollowerType.FollowerType_8_0_GarrisonFollower,
	Enum.GarrisonFollowerType.FollowerType_9_0_GarrisonFollower
}

local garrisonHeaders = {
	GARRISON_MISSIONS_TITLE,
	ORDER_HALL_MISSIONS,
	WAR_CAMPAIGN,
	GARRISON_TYPE_9_0_LANDING_PAGE_TITLE
}

local function GarrisonIcon_Initialize(frame, level)
	local character = tab:GetCharacter()
	if not character then return end
	
	local currentMenu = options["GarrisonMissions"]
	local index = 1
	local num
	
	for i, garrisonType in ipairs(garrisonTypes) do
		frame:AddTitle(garrisonHeaders[i])
		
		-- Available missions
		num = DataStore:GetNumAvailableMissions(character, garrisonType)
		frame:AddButton(format(GARRISON_LANDING_AVAILABLE, num), index, OnGarrisonMenuChange, nil, (currentMenu == index))
		index = index + 1
		
		-- Active missions
		num = DataStore:GetNumActiveMissions(character, garrisonType)
		frame:AddButton(format(GARRISON_LANDING_IN_PROGRESS, num), index, OnGarrisonMenuChange, nil, (currentMenu == index))
		index = index + 1
		frame:AddTitle(" ")
	end
	
	frame:AddCloseMenu()
end

local function CovenantIcon_Initialize(frame, level)

	local currentMenu = options["CovenantSanctum"] or ""

	frame:AddTitle(GARRISON_TYPE_9_0_LANDING_PAGE_TITLE)
	
	frame:AddButton(LANDING_PAGE_RENOWN_LABEL, "Renown", OnCovenantChange, nil, (currentMenu == "Renown"))
	frame:AddButton(COVENANT_PREVIEW_SOULBINDS, "Soulbinds", OnCovenantChange, nil, (currentMenu == "Soulbinds"))
	frame:AddButton(COVENANT_SANCTUM_TAB_UPGRADES, "Reservoir", OnCovenantChange, nil, (currentMenu == "Reservoir"))
	-- frame:AddButton(ANIMA_DIVERSION_ORIGIN_TOOLTIP, 4, OnCovenantChange)	-- Anima Conductor
	
	frame:AddTitle(" ")
	frame:AddCloseMenu()
end

local menuIconCallbacks = {
	BagsIcon_Initialize,
	QuestsIcon_Initialize,
	TalentsIcon_Initialize,
	AuctionIcon_Initialize,
	MailIcon_Initialize,
	SpellbookIcon_Initialize,
	ProfessionsIcon_Initialize,
	GarrisonIcon_Initialize,
	CovenantIcon_Initialize,
}

addon:Controller("AltoholicUI.TabCharacters", { "AltoholicUI.Characters", function(characters)
	local currentAltKey
	
	return {
		OnBind = function(frame)
			tab = frame
		
			-- Mini easter egg, change the bag icon depending on the amount of level max or the time of year :)
			-- if you find this code, please don't spoil it :)

			local day = (tonumber(date("%m")) * 100) + tonumber(date("%d"))	-- ex: dec 15 = 1215, for easy tests below
			local bagIcon = ICON_VIEW_BAGS

			-- bag icon gets better with more chars at lv max
			local LVMax = 60
			local numLvMax = 0
			for _, character in pairs(DataStore:GetCharacters()) do
				if DataStore:GetCharacterLevel(character) >= LVMax then
					numLvMax = numLvMax + 1
				end
			end

			if numLvMax > 0 then
				if numLvMax > #BAG_ICONS then
					numLvMax = #BAG_ICONS
				end
				
				bagIcon = BAG_ICONS[numLvMax]
			end
			
			if (day >= 1018) and (day <= 1031) then		-- hallow's end
				bagIcon = ICON_BAGS_HALLOWSEND
			end
			
			frame.BagsIcon.Icon:SetTexture(bagIcon)
			frame:SetStatus(format("%s%s", colors.white, L["Select a character on the left"]))
		end,
		FilterIcon_OnEnter = function(frame, icon)
			local currentMenuID = icon:GetID()
			
			local menu = frame.ContextualMenu
			
			menu:Initialize(menuIconCallbacks[currentMenuID], "LIST")
			menu:Close()
			menu:Toggle(icon, 0, 0)
		end,
		RegisterPanel = function(frame, key, panel)
			-- a simple list of all the child frames
			frame.Panels = frame.Panels or {}
			frame.Panels[key] = panel
		end,
		HideAllPanels = function(frame)
			for _, panel in pairs(frame.Panels) do
				panel:Hide()
			end
		end,
		ShowPanel = function(frame, panelKey)
			if not panelKey then return end
			
			currentPanelKey = panelKey
			
			frame:HideAllPanels()
			
			local panel = frame.Panels[currentPanelKey]
			
			panel:Show()
			if panel.PreUpdate then
				panel:PreUpdate()
			end
			panel:Update()
		end,
		SetStatus = function(frame, text)
			frame.Status:SetText(text)
		end,
		GetCharacter = function(frame)
			return currentAltKey
		end,
		SetCharacter = function(frame, key)
			currentAltKey = key
		end,
		SortBy = function(frame, columnName, buttonIndex)
			-- Toggle the option
			options["SortAscending"] = not options["SortAscending"]
			
			-- Sort the whole view by a given column
			local hc = frame.HeaderContainer
			local sortOrder = options["SortAscending"]
			
			hc.SortButtons[buttonIndex]:DrawArrow(sortOrder)
			
			if currentPanelKey == "Mails" then
				frame.Panels.Mails:Sort(columnName, sortOrder)
			elseif currentPanelKey == "Auctions" then
				frame.Panels.Auctions:Sort(columnName, sortOrder)
			end
			frame:Update()
		end,
		SetColumns = function(frame, panel)
			if not panel then return end
			
			local hc = frame.HeaderContainer
		
			if panel == "Mails" then
				hc:SetButton(1, MAIL_SUBJECT_LABEL, 280, function() frame:SortBy("name", 1) end)
				hc:SetButton(2, FROM, 140, function() frame:SortBy("from", 2) end)
				hc:SetButton(3, L["Expiry:"], 200, function() frame:SortBy("expiry", 3) end)
				hc:Show()
				
			elseif panel == "Auctions" then
				hc:SetButton(1, HELPFRAME_ITEM_TITLE, 280, function() frame:SortBy("name", 1) end)
				hc:SetButton(2, HIGH_BIDDER, 160, function() frame:SortBy("highBidder", 2) end)
				hc:SetButton(3, CURRENT_BID, 170, function() frame:SortBy("buyoutPrice", 3) end)
				hc:Show()
				
			elseif panel == "Bids" then
				hc:SetButton(1, HELPFRAME_ITEM_TITLE, 280, function() frame:SortBy("name", 1) end)
				hc:SetButton(2, NAME, 160, function() frame:SortBy("owner", 2) end)
				hc:SetButton(3, CURRENT_BID, 170, function() frame:SortBy("buyoutPrice", 3) end)
				hc:Show()
				
			else
				hc:Hide()
			end
			
			-- hc:LimitWidth(frame.Background:GetWidth())
		end,
		Update = function(frame)
			frame:SetColumns(currentPanelKey)
			frame:ShowPanel(currentPanelKey)
		end,
	}
end})

local function categoriesList_OnClick(categoryData)
	local character = categoryData.key
	
	tab:SetCharacter(character)
	tab:SetStatus(DataStore:GetColoredCharacterName(character))
	tab:Update()
end

addon:Controller("AltoholicUI.TabCharactersCategoriesList", {
	OnBind = function(frame)
		local categories = {}
	
		local realmTable
		local accountTable
		local currentRealm = ""
		local currentAccount = ""
	
		DataStore:IterateCharactersSorted(nil, nil, function(account, realm, characterName, character) 
			-- Sequence break on the account ? add an account line
			if account ~= currentAccount then
				table.insert(categories, { text = format("%s%s: %s%s", colors.white, L["Account"], colors.green, account), isExpanded = (account == DataStore.ThisAccount) })
				accountTable = categories[#categories]
				
				currentAccount = account
			end
			
			-- Sequence break on the realm ? add a realm line
			if realm ~= currentRealm then
				accountTable.subMenu = accountTable.subMenu or {}
				table.insert(accountTable.subMenu, { text = format("%s%s", colors.gold, realm), subMenu = {} })
				realmTable = accountTable.subMenu[#accountTable.subMenu]
				
				currentRealm = realm
			end
			
			-- Add the character and its key
			table.insert(realmTable.subMenu, { text = DataStore:GetColoredCharacterName(character), key = character })
		end)
		
		-- Initialize categories (auto-fill the on-click callback)
		frame:IterateCategories(categories, function(category) 
			if category.key then
				category.callback = categoriesList_OnClick
			end
		end)
	
		frame:SetCategories(categories)
	end,

})

DataStore:OnAddonLoaded(addonTabName, function() 
	AddonFactory:SetOptionsTable("Altoholic_CharactersTab_Options", {
		ViewBags = true,
		ViewBank = true,
		ViewBagsAllInOne = false,
		ViewVoidStorage = true,
		ViewReagentBank = true,
		ViewBagsRarity = 0,						-- rarity level of items (not a boolean !)
		GarrisonMissions = 1,					-- available missions = 1, active missions = 2
		SortAscending = true,					-- ascending or descending sort order
		ViewLearnedRecipes = true,			-- View learned recipes ?
		ViewUnlearnedRecipes = false,		-- View unlearned recipes ?
		ViewQuestLogCategory = 0,				-- Quest log category to show
		ViewSpellTab = 1,						-- Spellbook tab to show
	})
	
	options = Altoholic_CharactersTab_Options
		
	--Temporary: database migration
	if AltoholicDB and AltoholicDB.global and AltoholicDB.global.options then
		local source = AltoholicDB.global.options

		for k, v in pairs(source) do
			local arg1, arg2, arg3 = strsplit(".", k)
			
			if arg1 == "UI" and arg2 == "Tabs" and arg3 == "Characters" then
				local prefix = "UI.Tabs.Characters."
				local optionName = k:sub(#prefix + 1)
				
				-- Create the new entries
				options[optionName] = v
				
				-- Delete the old entries
				source[k] = nil
			end
		end
	end
end)
