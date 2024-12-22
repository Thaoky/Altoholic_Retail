local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

local L = AddonFactory:GetLocale(addonName)

addon:Service("AltoholicUI.ProfessionEquipment", function() 

	local function Tool(profID)
		return format("%s%s %s%d|r: %s%s", colors.white, L["Profession"], colors.green, profID, colors.yellow, L["Tool"])
	end

	local function Accessory(profID, accessoryID)
		return format("%s%s %s%d|r: %s%s %s%d", 
			colors.white, L["Profession"], colors.green, profID, 
			colors.classHunter, L["Accessory"], colors.green, accessoryID)
	end

	local INVTYPE_PROFESSION_TOOL1 = Tool(1)
	local INVTYPE_PROFESSION_ACCESSORY11 = Accessory(1, 1)
	local INVTYPE_PROFESSION_ACCESSORY12 = Accessory(1, 2)
	local INVTYPE_PROFESSION_TOOL2 = Tool(2)
	local INVTYPE_PROFESSION_ACCESSORY21 = Accessory(2, 1)
	local INVTYPE_PROFESSION_ACCESSORY22 = Accessory(2, 2)
	local INVTYPE_COOKING_TOOL = L["COOKING_TOOL"]
	local INVTYPE_COOKING_ACCESSORY = L["COOKING_ACCESSORY"]
	local INVTYPE_FHISING_ROD = L["FISHING_TOOL"]

	local inventoryIDToSlotID = {	
		["INVTYPE_PROFESSION_TOOL1"] = 20,
		["INVTYPE_PROFESSION_ACCESSORY11"] = 22,
		["INVTYPE_PROFESSION_ACCESSORY12"] = 23,
		["INVTYPE_PROFESSION_TOOL2"] = 23,
		["INVTYPE_PROFESSION_ACCESSORY21"] = 24,
		["INVTYPE_PROFESSION_ACCESSORY22"] = 25,
		["INVTYPE_COOKING_TOOL"] = 26,
		["INVTYPE_COOKING_ACCESSORY"] = 27,
		["INVTYPE_FHISING_ROD"] = 28,
	}

	local slotNames = {
		[20] = INVTYPE_PROFESSION_TOOL1,
		[21] = INVTYPE_PROFESSION_ACCESSORY11,
		[22] = INVTYPE_PROFESSION_ACCESSORY12,
		[23] = INVTYPE_PROFESSION_TOOL2,
		[24] = INVTYPE_PROFESSION_ACCESSORY21,
		[25] = INVTYPE_PROFESSION_ACCESSORY22,
		[26] = INVTYPE_COOKING_TOOL,
		[27] = INVTYPE_COOKING_ACCESSORY,
		[28] = INVTYPE_FHISING_ROD
	}

	local slotTypeInfo = {
		-- Dragonflight
		{ color = "", name = INVTYPE_PROFESSION_TOOL1, inventoryId = 20 },
		{ color = "", name = INVTYPE_PROFESSION_ACCESSORY11, inventoryId = 21 },
		{ color = "", name = INVTYPE_PROFESSION_ACCESSORY12, inventoryId = 22 },
		{ color = "", name = INVTYPE_PROFESSION_TOOL2, inventoryId = 23 },
		{ color = "", name = INVTYPE_PROFESSION_ACCESSORY21, inventoryId = 24 },
		{ color = "", name = INVTYPE_PROFESSION_ACCESSORY22, inventoryId = 25 },
		{ color = colors.orange, name = INVTYPE_COOKING_TOOL, inventoryId = 26 },
		{ color = colors.orange, name = INVTYPE_COOKING_ACCESSORY, inventoryId = 27 },
		{ color = colors.classMage, name = INVTYPE_FHISING_ROD, inventoryId = 28 }
	}

	local slotIcons = {
		"MainHand", "Trinket", "Trinket",
		"MainHand", "Trinket", "Trinket",
		"MainHand", "Trinket", "MainHand"
	}

	return {
		GetSlotIDFromInventory = function(index)
			-- to review
			return inventoryIDToSlotID[index]
		end,
		GetSlotName = function(index)
			return slotNames[index]
		end,
		GetNumSlotTypes = function()
			return #slotTypeInfo
		end,
		GetSlotTypeInfo = function(index)
			local item = slotTypeInfo[index]
			return item.name, item.color, item.inventoryId
		end,
		GetSlotIcon = function(index) 
			if index and slotIcons[index] then
				return format("Interface\\PaperDoll\\UI-PaperDoll-Slot-%s", slotIcons[index])
			end
		end,
	}
end)
