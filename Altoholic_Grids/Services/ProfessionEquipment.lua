local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

addon:Service("AltoholicUI.ProfessionEquipment", function() 

	local INVTYPE_PROFESSION_TOOL1 = L["Prof0ToolSlot"]
	local INVTYPE_PROFESSION_ACCESSORY11 = L["Prof0Gear0Slot"]
    local INVTYPE_PROFESSION_ACCESSORY12 = L["Prof0Gear1Slot"]
	local INVTYPE_PROFESSION_TOOL2 = L["Prof1ToolSlot"]
	local INVTYPE_PROFESSION_ACCESSORY21 = L["Prof1Gear0Slot"]
    local INVTYPE_PROFESSION_ACCESSORY22 = L["Prof1Gear1Slot"]
	local INVTYPE_COOKING_TOOL = L["CookingToolSlot"]
	local INVTYPE_COOKING_ACCESSORY = L["CookingGear0Slot"]
	local INVTYPE_FHISING_ROD = L["FishingToolSlot"]
	
	-- 4/08/2021 : this service is working for now. I am not satisfied with the tables etc.. but since the implementation
	-- in-game is crappy, it will do until there is a way to do it better. Data is really not consistent, it's a nightmare to manage.

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
	
	local inventoryIDToEquipLoc = {
--[[
		[Enum.InventoryType.IndexHeadType] = INVTYPE_HEAD,
		[Enum.InventoryType.IndexNeckType] = INVTYPE_NECK,
		[Enum.InventoryType.IndexShoulderType] = INVTYPE_SHOULDER,
		[Enum.InventoryType.IndexBodyType] = INVTYPE_BODY,
		[Enum.InventoryType.IndexChestType] = INVTYPE_CHEST,
		[Enum.InventoryType.IndexWaistType] = INVTYPE_WAIST,
		[Enum.InventoryType.IndexLegsType] = INVTYPE_LEGS,
		[Enum.InventoryType.IndexFeetType] = INVTYPE_FEET,
		[Enum.InventoryType.IndexWristType] = INVTYPE_WRIST,
		[Enum.InventoryType.IndexHandType] = INVTYPE_HAND,
		[Enum.InventoryType.IndexFingerType] = INVTYPE_FINGER,
		[Enum.InventoryType.IndexTrinketType] = INVTYPE_TRINKET,
		[Enum.InventoryType.IndexWeaponType] = INVTYPE_WEAPON,
		[Enum.InventoryType.IndexShieldType] = INVTYPE_SHIELD,
		[Enum.InventoryType.IndexRangedType] = INVTYPE_RANGED,
		[Enum.InventoryType.IndexCloakType] = INVTYPE_CLOAK,
		[Enum.InventoryType.Index2HweaponType] = INVTYPE_2HWEAPON,
		[Enum.InventoryType.IndexTabardType] = INVTYPE_TABARD,
		[Enum.InventoryType.IndexRobeType] = INVTYPE_ROBE,
		[Enum.InventoryType.IndexWeaponmainhandType] = INVTYPE_WEAPONMAINHAND,
		[Enum.InventoryType.IndexWeaponoffhandType] = INVTYPE_WEAPONOFFHAND,
		[Enum.InventoryType.IndexHoldableType] = INVTYPE_HOLDABLE,
		[Enum.InventoryType.IndexThrownType] = INVTYPE_THROWN,
		[Enum.InventoryType.IndexRangedrightType] = INVTYPE_RANGEDRIGHT,
--]]
	}
	
	-- These two tables are necessary to find equivalences between INVTYPEs returned by GetItemInfo and the actual equipment slots.
	-- For instance, the "ranged" slot can contain bows/guns/wands/relics/thrown weapons.
	local inventoryTypes = {
--[[
		["INVTYPE_HEAD"] = 1,		-- 1 means first entry in the EquipmentSlots table (just below this one)
		["INVTYPE_SHOULDER"] = 2,
		["INVTYPE_CHEST"] = 3,
		["INVTYPE_ROBE"] = 3,
		["INVTYPE_WRIST"] = 4,
		["INVTYPE_HAND"] = 5,
		["INVTYPE_WAIST"] = 6,
		["INVTYPE_LEGS"] = 7,
		["INVTYPE_FEET"] = 8,
		
		["INVTYPE_NECK"] = 9,
		["INVTYPE_CLOAK"] = 10,
		["INVTYPE_FINGER"] = 11,
		["INVTYPE_TRINKET"] = 12,
		["INVTYPE_WEAPON"] = 13,
		["INVTYPE_2HWEAPON"] = 14,
		["INVTYPE_WEAPONMAINHAND"] = 15,
		["INVTYPE_WEAPONOFFHAND"] = 16,
		["INVTYPE_HOLDABLE"] = 16,
		["INVTYPE_SHIELD"] = 17,
		["INVTYPE_RANGED"] = 18,
		["INVTYPE_THROWN"] = 18,
		["INVTYPE_RANGEDRIGHT"] = 18,
		["INVTYPE_RELIC"] = 18
--]]		
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
		-- DRAGONFLIGHT
		{ color = colors.yellow, name = INVTYPE_PROFESSION_TOOL1, inventoryId = 20 },
		{ color = colors.orange, name = INVTYPE_PROFESSION_ACCESSORY11, inventoryId = 21 },
		{ color = colors.orange, name = INVTYPE_PROFESSION_ACCESSORY12, inventoryId = 22 },
		{ color = colors.classMage, name = INVTYPE_PROFESSION_TOOL2, inventoryId = 23 },
		{ color = colors.orange, name = INVTYPE_PROFESSION_ACCESSORY21, inventoryId = 24 },
		{ color = colors.orange, name = INVTYPE_PROFESSION_ACCESSORY22, inventoryId = 25 },
		{ color = colors.classHunter, name = INVTYPE_COOKING_TOOL, inventoryId = 26 },
		{ color = colors.orange, name = INVTYPE_COOKING_ACCESSORY, inventoryId = 27 },
		{ color = colors.rare, name = INVTYPE_FHISING_ROD, inventoryId = 28 }
	}

	local slotIcons = {
		  "MainHand", "Trinket", "Trinket"
		, "MainHand", "Trinket", "Trinket"
		, "MainHand", "Trinket"
		, "MainHand"
	}

	return {
		GetSlotIDFromInventory = function(index)
			-- to review
			return inventoryIDToSlotID[index]
		end,
		-- GetInventoryTypeIndex = function(index)
			-- return inventoryTypes[index]
		-- end,
		GetInventoryTypeName = function(index)
			return slotNames[ inventoryTypes[index] ]
		end,
		-- GetEquipLocFromInventoryType = function(inventoryType)
			-- return inventoryIDToEquipLoc[inventoryType]
		-- end,
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
