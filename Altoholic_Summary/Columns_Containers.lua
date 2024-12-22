local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors
local icons = AddonFactory.Icons

local L = AddonFactory:GetLocale(addonName)
local MVC = LibStub("LibMVC-1.0")
local Columns = MVC:GetService("AltoholicUI.TabSummaryColumns")
local Formatter = MVC:GetService("AltoholicUI.Formatter")
local Characters = MVC:GetService("AltoholicUI.Characters")

-- *** Utility functions ***
local function FormatBagType(link, bagType)
	link = link or ""
	if bagType and strlen(bagType) > 0 then
		return format("%s %s(%s)", link, colors.yellow, bagType)
	end
	
	-- not bag type ? just return the link
	return link
end

local function FormatBagSlots(size, free)
	return format(L["NUM_SLOTS_AND_FREE"], colors.cyan, size, colors.white, colors.green, free, colors.white)
end

local bankSlotPrices = { 1000, 10000, 100000, 250000, 250000, 250000, 250000 }

-- ** Bags & Banks **
Columns.RegisterColumn("BagSlots", {
	-- Header
	headerWidth = 120,
	headerLabel = format("%s  %s", Formatter.Texture18("Interface\\Icons\\inv_misc_bag_08"), L["COLUMN_BAGS_TITLE_SHORT"]),
	tooltipTitle = L["COLUMN_BAGS_TITLE"],
	tooltipSubTitle = L[format("COLUMN_BAGS_SUBTITLE_%d", random(2))],
	headerSort = DataStore.GetNumBagSlots,
	
	-- Content
	Width = 120,
	JustifyH = "LEFT",
	GetText = function(character)
			if not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return UNKNOWN
			end
			
			return format("%s/%s|r/%s|r/%s|r/%s|r/%s",
					DataStore:GetContainerSize(character, 0),
					DataStore:GetColoredContainerSize(character, 1),
					DataStore:GetColoredContainerSize(character, 2),
					DataStore:GetColoredContainerSize(character, 3),
					DataStore:GetColoredContainerSize(character, 4),
					DataStore:GetColoredContainerSize(character, 5)
			)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return
			end
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["COLUMN_BAGS_TITLE"])
			tt:AddLine(" ")
			
			local link, size, free, bagType = DataStore:GetContainerInfo(character, 0)
			tt:AddDoubleLine(format("%s[%s]", colors.white, BACKPACK_TOOLTIP), FormatBagSlots(size, free))
			
			for i = 1, 5 do
				link, size, free, bagType = DataStore:GetContainerInfo(character, i)

				if size ~= 0 then
					tt:AddDoubleLine(FormatBagType(link, bagType), FormatBagSlots(size, free))
				end
			end
			tt:Show()
		end,
	GetTotal = function(line) return format("%s%s |r%s", colors.white, Characters.GetField(line, "bagSlots"), L["slots"]) end,
	TotalJustifyH = "CENTER",
})

Columns.RegisterColumn("FreeBagSlots", {
	-- Header
	headerWidth = 70,
	headerLabel = L["COLUMN_FREEBAGSLOTS_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_FREEBAGSLOTS_TITLE"],
	tooltipSubTitle = L["COLUMN_FREEBAGSLOTS_SUBTITLE"],
	headerSort = DataStore.GetNumFreeBagSlots,
	
	-- Content
	Width = 70,
	GetText = function(character)
			if not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return 0
			end
			
			local numSlots = DataStore:GetNumBagSlots(character)
			local numFree = DataStore:GetNumFreeBagSlots(character)
			local color = ((numFree / numSlots) <= 0.1) and colors.red or colors.green
			
			return format("%s%s|r/%s%s", color, numFree, colors.cyan, numSlots)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return
			end
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["COLUMN_FREEBAGSLOTS_TITLE"])
			tt:AddLine(" ")
			tt:AddLine(FormatBagSlots(DataStore:GetNumBagSlots(character), DataStore:GetNumFreeBagSlots(character)))
			tt:Show()
		end,
	GetTotal = function(line) return format("%s%s", colors.white, Characters.GetField(line, "freeBagSlots")) end,
})

Columns.RegisterColumn("BankSlots", {
	-- Header
	headerWidth = 160,
	headerLabel = format("%s  %s", Formatter.Texture18("Interface\\Icons\\achievement_guildperk_mobilebanking"), L["COLUMN_BANK_TITLE_SHORT"]),
	tooltipTitle = L["COLUMN_BANK_TITLE"],
	tooltipSubTitle = L[format("COLUMN_BANK_SUBTITLE_%d", random(2))],
	headerSort = DataStore.GetNumBankSlots,
	
	-- Content
	Width = 160,
	JustifyH = "LEFT",
	GetText = function(character)
			if not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return UNKNOWN
			end

			if not DataStore:HasPlayerVisitedBank(character) then
				return L["Bank not visited yet"]
			end

			return format("%s/%s|r/%s|r/%s|r/%s|r/%s|r/%s|r/%s",
				DataStore:GetContainerSize(character, -1),
				DataStore:GetColoredContainerSize(character, 6),
				DataStore:GetColoredContainerSize(character, 7),
				DataStore:GetColoredContainerSize(character, 8),
				DataStore:GetColoredContainerSize(character, 9),
				DataStore:GetColoredContainerSize(character, 10),
				DataStore:GetColoredContainerSize(character, 11),
				DataStore:GetColoredContainerSize(character, 12)
			)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return
			end
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["COLUMN_BANK_TITLE"])
			tt:AddLine(" ")
			
			if not DataStore:HasPlayerVisitedBank(character) then
				tt:AddLine(L["Bank not visited yet"],1,1,1)
				tt:Show()
				return
			end
			
			local link, size, free, bagType
			size, free = DataStore:GetPlayerBankInfo(character)
			tt:AddDoubleLine(format("%s[%s]", colors.white, L["Bank"]), FormatBagSlots(size, free))
			
			local numPurchasedSlots = DataStore:GetNumPurchasedBankSlots(character)
			
			for i = 6, 12 do
				local slotIndex = i - 5		-- ie: id 6 = first bag, 7 = 2nd bag ...
				link, size, free, bagType = DataStore:GetContainerInfo(character, i)

				-- if this slot was not purchased yet..
				if numPurchasedSlots and numPurchasedSlots < slotIndex then
					tt:AddDoubleLine(L["Not purchased yet"], Formatter.MoneyStringShort(bankSlotPrices[slotIndex]))
				elseif size ~= 0 then
					tt:AddDoubleLine(FormatBagType(link, bagType), FormatBagSlots(size, free))
				end
			end
			tt:Show()
		end,
	GetTotal = function(line) return format("%s%s |r%s", colors.white, Characters.GetField(line, "bankSlots"), L["slots"]) end,
	TotalJustifyH = "CENTER",
})

Columns.RegisterColumn("FreeBankSlots", {
	-- Header
	headerWidth = 70,
	headerLabel = L["COLUMN_FREEBANKLOTS_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_FREEBANKLOTS_TITLE"],
	tooltipSubTitle = L["COLUMN_FREEBANKLOTS_SUBTITLE"],
	headerSort = DataStore.GetNumFreeBankSlots,
	
	-- Content
	Width = 70,
	GetText = function(character)
			if not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return 0
			end
			
			local numSlots = DataStore:GetNumBankSlots(character)
			if numSlots == 0 then		-- Bank not visited yet
				return 0			
			end
			
			local numFree = DataStore:GetNumFreeBankSlots(character)
			local color = ((numFree / numSlots) <= 0.1) and colors.red or colors.green
			
			return format("%s%s|r/%s%s", color, numFree, colors.cyan, numSlots)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Containers", character) then
				return
			end
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["COLUMN_FREEBANKLOTS_TITLE"])
			tt:AddLine(" ")
			tt:AddLine(FormatBagSlots(DataStore:GetNumBankSlots(character), DataStore:GetNumFreeBankSlots(character)))
			tt:Show()
		end,
	GetTotal = function(line) return format("%s%s", colors.white, Characters.GetField(line, "freeBankSlots")) end,
})
