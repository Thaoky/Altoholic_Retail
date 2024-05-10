local addonTabName = ...
local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = DataStore:GetLocale(addonName)
local MVC = LibStub("LibMVC-1.0")
local Equipment = MVC:GetService("AltoholicUI.Equipment")

local tab		-- small shortcut to easily address the frame (set in OnBind)
local options
local currentPanelKey = "Search"

local searchType, searchSubType, searchedValue

local OPTION_LOCATION = "CurrentLocation"
local OPTION_RARITY = "CurrentRarity"
local OPTION_EQUIPMENT = "CurrentSlot"
local OPTION_EXPANSION = "CurrentExpansion"
local OPTION_PROFESSION = "CurrentProfession"
local OPTION_NO_MIN_LEVEL = "IncludeNoMinLevel"
local OPTION_MAILBOXES = "IncludeMailboxItems"
local OPTION_GUILD_BANKS = "IncludeGuildBankItems"
local OPTION_RECIPES = "IncludeKnownRecipes"
local OPTION_COLORED_ALTS = "UseColorsForAlts"
local OPTION_COLORED_REALMS = "UseColorsForRealms"

local function OnSearchLocationChange(frame)
	options[OPTION_LOCATION] = frame.value
	tab:Update()
end

local function OnSearchRarityChange(frame)
	options[OPTION_RARITY] = frame.value
	
	if searchedValue then
		tab:Find(searchedValue)
		tab:Update()
	end
end

local function OnSearchEquipmentSlotChange(frame, itemType, itemSubType)
	options[OPTION_EQUIPMENT] = frame.value
	
	if frame.value == 0 then
		searchType = nil
		searchSubType = nil
	end
	
	-- Only overwrite existing filters if values are actually passed as argument
	if itemType then 
		searchType = GetItemClassInfo(itemType)
		
		if itemSubType then
			searchSubType = GetItemSubClassInfo(itemType, itemSubType) 	
		end
	else
		searchType = nil
		searchSubType = nil
	end
	
	if searchedValue then
		tab:Find(searchedValue)
		tab:Update()
	end
end

local function OnSearchExpansionChange(frame)
	options[OPTION_EXPANSION] = frame.value
	
	if searchedValue then
		tab:Find(searchedValue)
		tab:Update()
	end
end

local function OnSearchProfessionChange(frame)
	options[OPTION_PROFESSION] = frame.value
	tab:Update()
end

local function OnSearchOptionsChange(frame)
	-- Toggle the option
	local option = frame.value
	options[option] = not options[option]
	
	tab:Update()
end

-- ** Menu Icons **
local function LocationIcon_Initialize(frame, level)
	local option = options[OPTION_LOCATION]

	frame:AddTitle(L["FILTER_SEARCH_LOCATION"])
	frame:AddButton(L["This character"], 1, OnSearchLocationChange, nil, (option == 1))
	frame:AddButton(format("%s %s(%s)", L["This realm"], colors.green, L["This faction"]), 2, OnSearchLocationChange, nil, (option == 2))
	frame:AddButton(format("%s %s(%s)", L["This realm"], colors.green, L["Both factions"]), 3, OnSearchLocationChange, nil, (option == 3))
	frame:AddButton(L["All realms"], 4, OnSearchLocationChange, nil, (option == 4))
	frame:AddButton(L["All accounts"], 5, OnSearchLocationChange, nil, (option == 5))
	frame:AddCloseMenu()
end

local function RarityIcon_Initialize(frame, level)
	local option = options[OPTION_RARITY]

	frame:AddTitle(L["FILTER_SEARCH_RARITY"])
	
	for i = 0, Enum.ItemQuality.Heirloom do		-- Quality: 0 = poor .. 5 = legendary ..
		local quality = format("|c%s%s", select(4, GetItemQualityColor(i)), _G[format("ITEM_QUALITY%d_DESC", i)])
		
		frame:AddButton(quality, i, OnSearchRarityChange, nil, (option == i))
	end
	
	frame:AddCloseMenu()
end

local function EquipmentIcon_Initialize(frame, level)
	local option = options[OPTION_EQUIPMENT]

	frame:AddTitle(L["FILTER_SEARCH_SLOT"])
	frame:AddButton(L["Any"], 0, OnSearchEquipmentSlotChange, nil, (option == 0))
	
	local e = Enum.InventoryType
	
	frame:AddTitle()
	frame:AddTitle(ARMOR)
	frame:AddButton(INVTYPE_HEAD, e.IndexHeadType, OnSearchEquipmentSlotChange, nil, (option == e.IndexHeadType))
	frame:AddButton(INVTYPE_SHOULDER, e.IndexShoulderType, OnSearchEquipmentSlotChange, nil, (option == e.IndexShoulderType))
	frame:AddButton(INVTYPE_CHEST, e.IndexChestType, OnSearchEquipmentSlotChange, nil, (option == e.IndexChestType))
	frame:AddButton(INVTYPE_WAIST, e.IndexWaistType, OnSearchEquipmentSlotChange, nil, (option == e.IndexWaistType))
	frame:AddButton(INVTYPE_LEGS, e.IndexLegsType, OnSearchEquipmentSlotChange, nil, (option == e.IndexLegsType))
	frame:AddButton(INVTYPE_FEET, e.IndexFeetType, OnSearchEquipmentSlotChange, nil, (option == e.IndexFeetType))
	frame:AddButton(INVTYPE_WRIST, e.IndexWristType, OnSearchEquipmentSlotChange, nil, (option == e.IndexWristType))
	frame:AddButton(INVTYPE_HAND, e.IndexHandType, OnSearchEquipmentSlotChange, nil, (option == e.IndexHandType))

	frame:AddTitle()
	frame:AddTitle(MISCELLANEOUS)
	
	frame:AddButton(INVTYPE_NECK, e.IndexNeckType, OnSearchEquipmentSlotChange, nil, (option == e.IndexNeckType))
	frame:AddButtonWithArgs(INVTYPE_CLOAK, e.IndexCloakType, OnSearchEquipmentSlotChange, Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Cloth, (option == e.IndexCloakType))
	frame:AddButton(INVTYPE_FINGER, e.IndexFingerType, OnSearchEquipmentSlotChange, nil, (option == e.IndexFingerType))
	frame:AddButton(INVTYPE_TRINKET, e.IndexTrinketType, OnSearchEquipmentSlotChange, nil, (option == e.IndexTrinketType))
	
	-- Note, use negative values for special cases, to avoid filtering on item slot (for shields, only type & subtype are needed)
	frame:AddButtonWithArgs(GetItemSubClassInfo(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Shield), -1,
		OnSearchEquipmentSlotChange, Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Shield, (option == -1))
	frame:AddButtonWithArgs(INVTYPE_HOLDABLE, "INVTYPE_HOLDABLE",
		OnSearchEquipmentSlotChange, Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Generic, (option == "INVTYPE_HOLDABLE"))
	
	frame:AddTitle()
	-- frame:AddTitle(AUCTION_CATEGORY_WEAPONS)
	
	frame:AddCloseMenu()
end

local function ExpansionsIcon_Initialize(frame, level)
	local option = options[OPTION_EXPANSION]

	frame:AddTitle(L["FILTER_SEARCH_EXPANSION"])
	frame:AddButton(L["Any"], 0, OnSearchExpansionChange, nil, (option == 0))	
	frame:AddTitle()
	
	for index, expansion in ipairs(DataStore.Enum.ExpansionPacks) do
		frame:AddButton(expansion, index, OnSearchExpansionChange, nil, (option == index))
	end
	
	frame:AddTitle()
	frame:AddCloseMenu()
end

local function ProfessionsIcon_Initialize(frame, level)
	local option = options[OPTION_PROFESSION]

	-- frame:AddTitle(L["FILTER_SEARCH_SLOT"])
	-- frame:AddButton(L["Any"], 0, OnSearchProfessionChange, nil, (option == i))
	-- frame:AddCloseMenu()
end

local function SearchOptionsIcon_Initialize(frame, level)
	frame:AddTitle(L["FILTER_SEARCH_OPTIONS"])
	frame:AddButton(L["Include items without level requirement"], OPTION_NO_MIN_LEVEL, OnSearchOptionsChange, nil, (options[OPTION_NO_MIN_LEVEL] == true))
	frame:AddButton(L["Include mailboxes"], OPTION_MAILBOXES, OnSearchOptionsChange, nil, (options[OPTION_MAILBOXES] == true))
	frame:AddButton(L["Include guild banks"], OPTION_GUILD_BANKS, OnSearchOptionsChange, nil, (options[OPTION_GUILD_BANKS] == true))
	frame:AddButton(L["Include known recipes"], OPTION_RECIPES, OnSearchOptionsChange, nil, (options[OPTION_RECIPES] == true))
	
	frame:AddTitle()
	frame:AddButton(L["USE_CLASS_COLOR"], OPTION_COLORED_ALTS, OnSearchOptionsChange, nil, (options[OPTION_COLORED_ALTS] == true))
	frame:AddButton(L["USE_FACTION_COLOR"], OPTION_COLORED_REALMS, OnSearchOptionsChange, nil, (options[OPTION_COLORED_REALMS] == true))
	frame:AddTitle()
	frame:AddButtonWithArgs(HELP_LABEL, 30, addon.ShowOptionsPanel, 13)
	
	frame:AddCloseMenu()
end

local menuIconCallbacks = {
	LocationIcon_Initialize,
	RarityIcon_Initialize,
	EquipmentIcon_Initialize,
	ExpansionsIcon_Initialize,
	ProfessionsIcon_Initialize,
	SearchOptionsIcon_Initialize,
}

addon:Controller("AltoholicUI.TabSearch", { "AltoholicUI.ItemFilters", "AltoholicUI.DataBrowser", "AltoholicUI.SearchResults",
	function(ItemFilters, DataBrowser, Results)

	return {
		OnBind = function(frame)
			tab = frame
			
			local hc = frame.HeaderContainer
		
			hc:SetButton(1, RARITY, 60, function() frame:SortBy("rarity", 1) end)
			hc:SetButton(2, NAME, 240, function() frame:SortBy("name", 2) end)
			hc:SetButton(3, "iLvl", 50, function() frame:SortBy("level", 3) end)
			hc:SetButton(4, format("%s/%s", PLAYER, BANK), 140, function() frame:SortBy("source", 4) end)
			hc:SetButton(5, "Realm" , 140, function() frame:SortBy("realm", 5) end)
		end,
		Reset_OnClick = function(frame)
			-- Note: do not auto reset, let the user choose with the reset button

			searchType = nil
			searchSubType = nil
			searchedValue = nil
			
			options[OPTION_RARITY] = 0
			options[OPTION_EQUIPMENT] = 0
			options[OPTION_EXPANSION] = 0
			
			-- reset also min max
			frame.MinLevel:SetText("")
			frame.MaxLevel:SetText("")
			AltoholicFrame.SearchBox:SetText("")
			ItemFilters.Clear()
			Results.Clear()
			frame:Update()
			frame:SetStatus("")
			collectgarbage()
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
		SortBy = function(frame, columnName, buttonIndex)
			-- Toggle the option
			options["SortAscending"] = not options["SortAscending"]
			
			-- Sort the whole view by a given column
			local hc = frame.HeaderContainer
			local sortOrder = options["SortAscending"]
			
			hc.SortButtons[buttonIndex]:DrawArrow(sortOrder)
			
			Results.Sort(columnName, sortOrder)
			frame:Update()
		end,
		Update = function(frame)
			frame:ShowPanel(currentPanelKey)
		end,

		Find = function(frame, value)
			searchedValue = value
			
			-- Set Filters
			ItemFilters.Clear()
			ItemFilters.EnableFilter("Existence")	-- should be first in the list !
			
			if value ~= "" then
				ItemFilters.SetFilterValue("itemName", strlower(value))
				ItemFilters.EnableFilter("Name")
			end
			
			if searchType then
				ItemFilters.SetFilterValue("itemType", searchType)
				ItemFilters.EnableFilter("Type")
			end

			if searchSubType then
				ItemFilters.SetFilterValue("itemSubType", searchSubType)
				ItemFilters.EnableFilter("SubType")
			end
				
			local itemMinLevel = frame.MinLevel:GetNumber()
			ItemFilters.SetFilterValue("itemMinLevel", itemMinLevel)
			ItemFilters.EnableFilter("MinLevel")
			
			local itemMaxLevel = frame.MaxLevel:GetNumber()	
			if itemMaxLevel ~= 0 then			-- enable the filter only if a max level has been set
				ItemFilters.SetFilterValue("itemMaxLevel", itemMaxLevel)
				ItemFilters.EnableFilter("Maxlevel")
			end	
			
			local itemSlot = options[OPTION_EQUIPMENT]
			
			if itemSlot then
				if type(itemSlot) == "string" then			-- for special inventory types, like INVTYPE_HOLDABLE (off-hands)
					ItemFilters.SetFilterValue("itemSlot", itemSlot)
					ItemFilters.EnableFilter("EquipmentSlotText")

				-- don't apply filter if = 0, it means we take them all
				elseif type(itemSlot) == "number" and itemSlot > 0 then
					ItemFilters.SetFilterValue("itemSlot", itemSlot)
					ItemFilters.EnableFilter("EquipmentSlot")				
				end
			end
			
			local itemRarity = options[OPTION_RARITY]
			if itemRarity and itemRarity > 0 then	-- don't apply filter if = 0, it means we take them all
				ItemFilters.SetFilterValue("itemRarity", itemRarity)
				ItemFilters.EnableFilter("Rarity")
			end
			
			local itemExpansion = options[OPTION_EXPANSION]
			if itemExpansion and itemExpansion > 0 then	-- don't apply filter if = 0, it means we take them all
				ItemFilters.SetFilterValue("itemExpansion", itemExpansion - 1)
				ItemFilters.EnableFilter("Expansion")
			end
			
			-- print(ItemFilters.GetFiltersString())
			DataBrowser.Find()		-- The actual search happens in here
			
			frame:Update()
		end,
	}
end})

local function categoriesList_OnClick(categoryData)
	tab.ContextualMenu:Close()
	
	-- If we filter by category, the search box will be deleted
	AltoholicFrame.SearchBox:SetText("")

	searchType = GetItemClassInfo(categoryData.itemType)
	searchSubType = GetItemSubClassInfo(categoryData.itemType, categoryData.subType) 
	options[OPTION_EQUIPMENT] = categoryData.slot

	tab:Find("")
	tab:Update()
end

local function GetCategoryName(category)
	return format("%s%s", colors.gold, category)
end

addon:Controller("AltoholicUI.TabSearchCategoriesList", {
	OnBind = function(frame)
		local classIDs = {
			Enum.ItemClass.Container,
			Enum.ItemClass.Gem,
			Enum.ItemClass.ItemEnhancement,
			Enum.ItemClass.Consumable,
			Enum.ItemClass.Glyph,
			Enum.ItemClass.Tradegoods,
			Enum.ItemClass.Recipe,
			--Enum.ItemClass.Battlepet,
		}
	
		-- info : https://wowpedia.fandom.com/wiki/ItemType
	
		local categories = {
			{ text = GetCategoryName(AUCTION_CATEGORY_WEAPONS), subMenu = {
				{ text = AUCTION_SUBCATEGORY_ONE_HANDED, subMenu = {
					{ itemType = Enum.ItemClass.Weapon, subType = Enum.ItemWeaponSubclass.Axe1H },
					{ itemType = Enum.ItemClass.Weapon, subType = Enum.ItemWeaponSubclass.Mace1H },
					{ itemType = Enum.ItemClass.Weapon, subType = Enum.ItemWeaponSubclass.Sword1H },
					{ itemType = Enum.ItemClass.Weapon, subType = Enum.ItemWeaponSubclass.Warglaive },
					{ itemType = Enum.ItemClass.Weapon, subType = Enum.ItemWeaponSubclass.Dagger },
					{ itemType = Enum.ItemClass.Weapon, subType = Enum.ItemWeaponSubclass.Unarmed },
					{ itemType = Enum.ItemClass.Weapon, subType = Enum.ItemWeaponSubclass.Wand },
				} },
				{ text = AUCTION_SUBCATEGORY_TWO_HANDED, subMenu = {
					{ itemType = Enum.ItemClass.Weapon, subType = Enum.ItemWeaponSubclass.Axe2H },
					{ itemType = Enum.ItemClass.Weapon, subType = Enum.ItemWeaponSubclass.Mace2H },
					{ itemType = Enum.ItemClass.Weapon, subType = Enum.ItemWeaponSubclass.Sword2H },
					{ itemType = Enum.ItemClass.Weapon, subType = Enum.ItemWeaponSubclass.Polearm },
					{ itemType = Enum.ItemClass.Weapon, subType = Enum.ItemWeaponSubclass.Staff },
				} },
				{ text = AUCTION_SUBCATEGORY_RANGED, subMenu = {
					{ itemType = Enum.ItemClass.Weapon, subType = Enum.ItemWeaponSubclass.Bows },
					{ itemType = Enum.ItemClass.Weapon, subType = Enum.ItemWeaponSubclass.Crossbow },
					{ itemType = Enum.ItemClass.Weapon, subType = Enum.ItemWeaponSubclass.Guns },
					{ itemType = Enum.ItemClass.Weapon, subType = Enum.ItemWeaponSubclass.Thrown },
				} },
				{ text = AUCTION_SUBCATEGORY_MISCELLANEOUS, subMenu = {
					{ itemType = Enum.ItemClass.Weapon, subType = Enum.ItemWeaponSubclass.Fishingpole },
					{ itemType = Enum.ItemClass.Weapon, subType = Enum.ItemWeaponSubclass.Generic },
				} },
			} },
			{ text = GetCategoryName(AUCTION_CATEGORY_ARMOR), subMenu = {
				{ text = GetItemSubClassInfo(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Plate), subMenu = {

					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Plate, slot = Enum.InventoryType.IndexHeadType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Plate,
						slot = Enum.InventoryType.IndexShoulderType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Plate, slot = Enum.InventoryType.IndexChestType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Plate, slot = Enum.InventoryType.IndexWaistType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Plate, slot = Enum.InventoryType.IndexLegsType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Plate, slot = Enum.InventoryType.IndexFeetType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Plate, slot = Enum.InventoryType.IndexWristType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Plate, slot = Enum.InventoryType.IndexHandType },
				} },
				{ text = GetItemSubClassInfo(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Mail), subMenu = {
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Mail, slot = Enum.InventoryType.IndexHeadType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Mail,
						slot = Enum.InventoryType.IndexShoulderType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Mail, slot = Enum.InventoryType.IndexChestType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Mail, slot = Enum.InventoryType.IndexWaistType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Mail, slot = Enum.InventoryType.IndexLegsType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Mail, slot = Enum.InventoryType.IndexFeetType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Mail, slot = Enum.InventoryType.IndexWristType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Mail, slot = Enum.InventoryType.IndexHandType },
				} },
				{ text = GetItemSubClassInfo(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Leather), subMenu = {
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Leather, slot = Enum.InventoryType.IndexHeadType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Leather,
						slot = Enum.InventoryType.IndexShoulderType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Leather,
						slot = Enum.InventoryType.IndexChestType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Leather,
						slot = Enum.InventoryType.IndexWaistType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Leather, slot = Enum.InventoryType.IndexLegsType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Leather, slot = Enum.InventoryType.IndexFeetType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Leather,
						slot = Enum.InventoryType.IndexWristType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Leather, slot = Enum.InventoryType.IndexHandType },
				} },
				{ text = GetItemSubClassInfo(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Cloth), subMenu = {
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Cloth, slot = Enum.InventoryType.IndexHeadType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Cloth,
						slot = Enum.InventoryType.IndexShoulderType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Cloth, slot = Enum.InventoryType.IndexChestType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Cloth, slot = Enum.InventoryType.IndexWaistType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Cloth, slot = Enum.InventoryType.IndexLegsType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Cloth, slot = Enum.InventoryType.IndexFeetType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Cloth, slot = Enum.InventoryType.IndexWristType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Cloth, slot = Enum.InventoryType.IndexHandType },
				} },
				{ text = GetItemSubClassInfo(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Generic), subMenu = {
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Generic, slot = Enum.InventoryType.IndexNeckType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Cloth, slot = Enum.InventoryType.IndexCloakType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Generic,
						slot = Enum.InventoryType.IndexFingerType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Generic,
						slot = Enum.InventoryType.IndexTrinketType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Generic, slot = "INVTYPE_HOLDABLE" },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Shield },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Generic, slot = Enum.InventoryType.IndexBodyType },
					{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Generic, slot = Enum.InventoryType.IndexHeadType },
				} },
				{ itemType = Enum.ItemClass.Armor, subType = Enum.ItemArmorSubclass.Cosmetic },
			} },
			{ text = GetCategoryName(AUCTION_CATEGORY_CONTAINERS), subMenu = {} },
			{ text = GetCategoryName(AUCTION_CATEGORY_GEMS), subMenu = {} },
			{ text = GetCategoryName(AUCTION_CATEGORY_ITEM_ENHANCEMENT), subMenu = {} },
			{ text = GetCategoryName(AUCTION_CATEGORY_CONSUMABLES), subMenu = {} },
			{ text = GetCategoryName(AUCTION_CATEGORY_GLYPHS), subMenu = {} },
			{ text = GetCategoryName(AUCTION_CATEGORY_TRADE_GOODS), subMenu = {} },
			{ text = GetCategoryName(AUCTION_CATEGORY_RECIPES), subMenu = {} },
			--{ text = GetCategoryName(AUCTION_CATEGORY_BATTLE_PETS), subMenu = {} },
			{ itemType = Enum.ItemClass.Questitem, subType = 0 },
			{ text = GetCategoryName(AUCTION_CATEGORY_MISCELLANEOUS), subMenu = {
				{ itemType = Enum.ItemClass.Miscellaneous, subType = Enum.ItemMiscellaneousSubclass.Junk },
				{ itemType = Enum.ItemClass.Miscellaneous, subType = Enum.ItemMiscellaneousSubclass.Reagent },
				{ itemType = Enum.ItemClass.Miscellaneous, subType = Enum.ItemMiscellaneousSubclass.CompanionPet },
				{ itemType = Enum.ItemClass.Miscellaneous, subType = Enum.ItemMiscellaneousSubclass.Holiday },
				{ itemType = Enum.ItemClass.Miscellaneous, subType = Enum.ItemMiscellaneousSubclass.Other },
				{ itemType = Enum.ItemClass.Miscellaneous, subType = Enum.ItemMiscellaneousSubclass.Mount },
				{ itemType = Enum.ItemClass.Miscellaneous, subType = Enum.ItemMiscellaneousSubclass.MountEquipment },
			} },
		}

		-- Dynamically fill these categories
		for i, classID in ipairs(classIDs) do
			local menu = categories[i + 2].subMenu
			
			for _, subClassID in ipairs(C_AuctionHouse.GetAuctionItemSubClasses(classID)) do
				table.insert(menu, { 
					text = GetItemSubClassInfo(classID, subClassID),
					itemType = classID,
					subType = subClassID
				})
			end
		end
		
		-- Initialize categories (auto-fill .callback)
		frame:IterateCategories(categories, function(category) 
			-- if no text has been set, get one from the available data
			if not category.text then
				if category.slot then
					if type(category.slot) == "string" then
						category.text = _G[category.slot]		-- "INVTYPE_HOLDABLE" => "Held In Off-hand"
					else
						category.text = GetItemInventorySlotInfo(category.slot)
					end
				elseif category.itemType and category.subType then
					category.text = GetItemSubClassInfo(category.itemType, category.subType)
				end
			end
			
			-- set the onClick callback, if there is no submenu, we are at the lowest level
			if not category.subMenu then
				category.callback = categoriesList_OnClick
			end
		end)
		
		frame:SetCategories(categories)
	end,

})


DataStore:OnAddonLoaded(addonTabName, function() 
	Altoholic_SearchTab_Options = Altoholic_SearchTab_Options or {
		["ItemInfoAutoQuery"] = false,
		["IncludeNoMinLevel"] = true,				-- include items with no minimum level
		["IncludeMailboxItems"] = true,
		["IncludeGuildBankItems"] = true,
		["IncludeKnownRecipes"] = true,
		["CurrentLocation"] = 1,
		["UseColorsForAlts"] = true,
		["UseColorsForRealms"] = true,
		["SortAscending"] = true,					-- ascending or descending sort order
	}
	options = Altoholic_SearchTab_Options
		
	--Temporary: database migration	
	local source = AltoholicDB.global.options

	for k, v in pairs(source) do
		local arg1, arg2, arg3 = strsplit(".", k)
		
		if arg1 == "UI" and arg2 == "Tabs" and arg3 == "Search" then
			local prefix = "UI.Tabs.Search."
			local optionName = k:sub(#prefix + 1)
			
			-- Create the new entries
			options[optionName] = v
			
			-- Delete the old entries
			source[k] = nil
		end
		
	end
end)