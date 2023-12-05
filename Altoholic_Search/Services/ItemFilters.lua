local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local LII = LibStub("LibItemInfo-1.0")

addon:Service("AltoholicUI.ItemFilters", { "AltoholicUI.Options", "AltoholicUI.Equipment", function(Options, Equipment)

	local filters = {}
	local searchedItem = {}

	local methods = {
		["Existence"] = function()
			-- if both values are valid, the item exists in the game's item cache
			if searchedItem["itemName"] and searchedItem["itemRarity"] then return true end
		end,

		["Type"] = function()
			local itemType = filters["itemType"]
			
			-- no filter, or searched item is the same type as filter, keep it
			if not itemType or searchedItem["itemType"] == itemType then return true end
		end,

		["SubType"] = function()
			local subType = filters["itemSubType"]
			
			-- no filter, or searched item is the same sub type as filter, keep it
			if not subType or searchedItem["itemSubType"] == subType then return true end
		end,
		
		["Rarity"] = function()
			local rarity = filters["itemRarity"]
			
			-- no filter, or searched item has higher rarity than filter, keep it
			if not rarity or searchedItem["itemRarity"] >= rarity then return true end
		end,
		
		["Expansion"] = function()
			local expansion = filters["itemExpansion"]
			
			-- no filter, or searched item is the same expansion as filter, keep it
			if not expansion or searchedItem["itemExpansion"] == expansion then return true end
		end,
		
		["ItemLevel"] = function()
			-- searched item has higher iLvl than filter, keep it (strictly superior, fully intentional)
			if searchedItem["itemLevel"] > filters["itemLevel"] then return true end
		end,
		
		["EquipmentSlot"] = function()
			-- same slot as filter, keep the item
			if Equipment.GetSlotIDFromInventory(searchedItem["itemEquipLoc"]) == filters["itemSlot"] then return true end
		end,
		["EquipmentSlotText"] = function()
			-- Compare "INVTYPE_HOLDABLE" with "INVTYPE_HOLDABLE", mandatory for certain inventory types
			if searchedItem["itemEquipLoc"] == filters["itemSlot"] then return true end
		end,
		
		["Name"] = function()
			-- name contains the filter value, keep the item
			if string.find(strlower(searchedItem["itemName"]), filters["itemName"], 1, true) then return true end
		end,
		
		["MinLevel"] = function()
			local minLevel = searchedItem["itemMinLevel"]
			
			if minLevel == 0 then
				-- include items with no minimum requirement
				if Options.Get("UI.Tabs.Search.IncludeNoMinLevel") then return true end
			else
				-- include if within the right level boundaries
				if minLevel >= filters["itemMinLevel"] then return true end
			end
		end,
		
		["Maxlevel"] = function() 
			-- item min level is below max filter, keep the item
			if searchedItem["itemMinLevel"] <= filters["itemMaxLevel"] then return true end 
		end,
	}
	
	local activeFilters
	
	return {
		-- ** Filters **
		SetFilterValue = function(field, value) filters[field] = value end,
		GetFilterValue = function(field) return filters[field] end,

		EnableFilter = function(filter)
			if methods[filter] then
				activeFilters = activeFilters or {}
				table.insert(activeFilters, methods[filter])
			end
		end,
		GetFiltersString = function()
			local out = {}
			local color = colors.cyan
			
			if filters["itemName"] then
				table.insert(out, format("%s %s%s|r", "Name contains", color, filters["itemName"]))
			end
			
			if filters["itemType"] then
				table.insert(out, format("%s = %s%s|r", TYPE, color, filters["itemType"]))
			end
			
			if filters["itemSubType"] then
				table.insert(out, format("%s = %s%s|r", "Subtype", color, filters["itemSubType"]))
			end
			
			if type(filters["itemSlot"]) == "string" then
				table.insert(out, format("%s = %s%s|r", "Slot", color, _G[filters["itemSlot"]]))
			elseif type(filters["itemSlot"]) == "number" then
				table.insert(out, format("%s = %s%s|r", "Slot", color, Equipment.GetEquipLocFromInventoryType(filters["itemSlot"])))
			end
			
			if filters["itemRarity"] then
				local rarity = filters["itemRarity"]
				local rarityLabel = format("|c%s%s", select(4, GetItemQualityColor(rarity)), _G[format("ITEM_QUALITY%d_DESC", rarity)])
			
				table.insert(out, format("%s >= %s|r", RARITY, rarityLabel))
			end
			
			if filters["itemExpansion"] then
				local expansion = filters["itemExpansion"]
			
				table.insert(out, format("%s = %s%s|r", EXPANSION_FILTER_TEXT, color, _G["EXPANSION_NAME"..expansion]))
			end
			
			local filtersString = table.concat(out, ", ")
			
			return (filtersString:len() > 0) and filtersString or "No active filter"
		end,

		ItemPassesFilters = function()

			-- Exclusive approach:
			-- 	by default, it is considered that no item is filtered out unless a specific filter is enabled.
			-- 	ex: if a user wants to filter items based on their level in the UI, it means he doesn't want to see items 
			--		outside of the specified boundaries, so the filter "Level" is enabled, and items are filtered out.

			if activeFilters then		-- there might not be any filter
				for name, func in pairs(activeFilters) do
				
					-- if any of the filters returns false/nil, exit
					if not func() then return end
				end
			end
			
			return true			-- return true if all filters have returned true
		end,

		TryFilter = function(filter) if methods[filter] then return methods[filter]() end end,
		
		-- ** Currently searched item **
		SetSearchedItem = function(itemID, itemLink, isBattlePet)
			local s = searchedItem
			local _

			-- dirty hack, this should go somewhere else
			if isBattlePet then
				_, _, s.itemRarity, _, _, _, s.itemName = DataStore:GetBattlePetInfoFromLink(itemLink)
			else
				s.itemID = itemID
				s.itemName, s.itemLink, s.itemRarity, s.itemLevel,	s.itemMinLevel = GetItemInfo(itemLink or itemID)
				s.itemType,	s.itemSubType, s.itemEquipLoc = select(2, GetItemInfoInstant(itemLink or itemID))
			end
			
			s.itemExpansion = select(3, LII:GetItemSource(itemID))
		end,

		GetSearchedItemInfo = function(field) return searchedItem[field] end,
		
		Clear = function()
			wipe(filters)
			wipe(searchedItem) 
			if activeFilters then wipe(activeFilters) end
		end,
	}
end})
