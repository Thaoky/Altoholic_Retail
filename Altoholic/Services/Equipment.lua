local addonName, addon = ...
local colors = addon.Colors

addon:Service("AltoholicUI.Equipment", function() 

	-- 4/08/2021 : this service is working for now. I am not satisfied with the tables etc.. but since the implementation
	-- in-game is crappy, it will do until there is a way to do it better. Data is really not consistent, it's a nightmare to manage.

	local inventoryIDToSlotID = {	
		-- 3/08/2021 : source https://wowpedia.fandom.com/wiki/Enum.InventoryType
		
		["INVTYPE_HEAD"] = 1,
		["INVTYPE_NECK"] = 2,
		["INVTYPE_SHOULDER"] = 3,
		["INVTYPE_BODY"] = 4,
		["INVTYPE_CHEST"] = 5,
		["INVTYPE_ROBE"] = 5,
		["INVTYPE_WAIST"] = 6,
		["INVTYPE_LEGS"] = 7,
		["INVTYPE_FEET"] = 8,
		["INVTYPE_WRIST"] = 9,
		["INVTYPE_HAND"] = 10,
		["INVTYPE_FINGER"] = 11,
		["INVTYPE_TRINKET"] = 12,
		["INVTYPE_WEAPON"] = 16,
		["INVTYPE_SHIELD"] = 17,
		["INVTYPE_RANGED"] = 16,
		["INVTYPE_CLOAK"] = 16,
		["INVTYPE_2HWEAPON"] = 16,
		["INVTYPE_TABARD"] = 19,

		["INVTYPE_WEAPONMAINHAND"] = 16,
		["INVTYPE_WEAPONOFFHAND"] = 23,
		["INVTYPE_HOLDABLE"] = 17,
		["INVTYPE_THROWN"] = 16,
		["INVTYPE_RANGEDRIGHT"] = 16,
	}
	
	local inventoryIDToEquipLoc = {
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
	}
	
	-- These two tables are necessary to find equivalences between INVTYPEs returned by GetItemInfo and the actual equipment slots.
	-- For instance, the "ranged" slot can contain bows/guns/wands/relics/thrown weapons.
	local inventoryTypes = {
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
	}

	local slotNames = {
		[1] = INVTYPE_HEAD,
		[2] = INVTYPE_SHOULDER,
		[3] = INVTYPE_CHEST,
		[4] = INVTYPE_WRIST,
		[5] = INVTYPE_HAND,
		[6] = INVTYPE_WAIST,
		[7] = INVTYPE_LEGS,
		[8] = INVTYPE_FEET,
		[9] = INVTYPE_NECK,
		[10] = INVTYPE_CLOAK,
		[11] = INVTYPE_FINGER,
		[12] = INVTYPE_TRINKET,
		[13] = INVTYPE_WEAPON,
		[14] = INVTYPE_2HWEAPON,
		[15] = INVTYPE_WEAPONMAINHAND,
		[16] = INVTYPE_WEAPONOFFHAND,
		[17] = INVTYPE_SHIELD,
		[18] = INVTYPE_RANGED
	}

	local slotTypeInfo = {
		{ color = colors.classMage, name = INVTYPE_HEAD },
		{ color = colors.classHunter, name = INVTYPE_NECK },
		{ color = colors.classMage, name = INVTYPE_SHOULDER },
		{ color = colors.white, name = INVTYPE_BODY },
		{ color = colors.classMage, name = INVTYPE_CHEST },
		{ color = colors.classMage, name = INVTYPE_WAIST },
		{ color = colors.classMage, name = INVTYPE_LEGS },
		{ color = colors.classMage, name = INVTYPE_FEET },
		{ color = colors.classMage, name = INVTYPE_WRIST },
		{ color = colors.classMage, name = INVTYPE_HAND },
		{ color = colors.orange, name = format("%s 1", INVTYPE_FINGER) },
		{ color = colors.orange, name = format("%s 2", INVTYPE_FINGER) },
		{ color = colors.orange, name = format("%s 1", INVTYPE_TRINKET) },
		{ color = colors.orange, name = format("%s 2", INVTYPE_TRINKET) },
		{ color = colors.classHunter, name = INVTYPE_CLOAK },
		{ color = colors.yellow, name = INVTYPE_WEAPONMAINHAND },
		{ color = colors.yellow, name = INVTYPE_WEAPONOFFHAND },
		{ color = colors.classHunter, name = INVTYPE_RANGED },
		{ color = colors.white, name = INVTYPE_TABARD }
	}

	local slotIcons = {
		"Head", "Neck", "Shoulder", "Shirt", "Chest",
		"Waist", "Legs", "Feet", "Wrists", "Hands",
		"Finger", "Finger", "Trinket", "Trinket",
		"Chest",	"MainHand",	"SecondaryHand", "Ranged",	"Tabard"
	}

	return {
		GetSlotIDFromInventory = function(index)
			-- to review
			return inventoryIDToSlotID[index]
		end,
		GetInventoryTypeIndex = function(index)
			return inventoryTypes[index]
		end,
		GetInventoryTypeName = function(index)
			return slotNames[ inventoryTypes[index] ]
		end,
		GetEquipLocFromInventoryType = function(inventoryType)
			return inventoryIDToEquipLoc[inventoryType]
		end,
		GetSlotName = function(index)
			return slotNames[index]
		end,
		GetNumSlotTypes = function()
			return #slotTypeInfo
		end,
		GetSlotTypeInfo = function(index)
			local item = slotTypeInfo[index]
			return item.name, item.color
		end,
		GetSlotIcon = function(index) 
			if index and slotIcons[index] then
				return format("Interface\\PaperDoll\\UI-PaperDoll-Slot-%s", slotIcons[index])
			end
		end,
	}
end)
