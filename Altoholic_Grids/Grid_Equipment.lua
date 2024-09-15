local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

local L = DataStore:GetLocale(addonName)

local MVC = LibStub("LibMVC-1.0")
local Equipment = MVC:GetService("AltoholicUI.Equipment")

local tab = AltoholicFrame.TabGrids

tab:RegisterGrid(1, {
	OnUpdate = function() 
			tab:SetStatus(format("%s%s", colors.white, L["Equipment"]))
		end,
	GetSize = function() return Equipment.GetNumSlotTypes() end,
	RowSetup = function(self, rowFrame, dataRowID)
			local name, color = Equipment.GetSlotTypeInfo(dataRowID)

			rowFrame.Name.Text:SetText(format("%s%s", color, name))
			rowFrame.Name.Text:SetJustifyH("LEFT")
		end,
	ColumnSetup = function(self, button, dataRowID, character)
			button.Background:SetDesaturated(false)
			button.Background:SetVertexColor(1.0, 1.0, 1.0)
			button.Background:SetTexCoord(0, 1, 0, 1)
			
			button.Name:SetFontObject("NumberFontNormalSmall")
			button.Name:SetJustifyH("RIGHT")
			button.Name:SetPoint("BOTTOMRIGHT", 0, 0)
			
			local item = DataStore:GetInventoryItem(character, dataRowID)
			if item then
				button.key = character
				
				button.Background:SetTexture(GetItemIcon(item))
				
				-- display the coloured border
				local _, _, itemRarity, itemLevel = GetItemInfo(item)
				if itemRarity and itemRarity >= 2 then
					local r, g, b = GetItemQualityColor(itemRarity)
					button.IconBorder:SetVertexColor(r, g, b, 0.5)
					button.IconBorder:Show()
				end
				
				-- This returns a correct iLvl for upgraded items
				-- There are mistakes though, sometimes for leveling items, it returns an iLvl higher than what is shown in the tooltip (+10, +20)
				if type(item) == "string" then
					itemLevel = GetDetailedItemLevelInfo(item)
				end

				button.Name:SetText(itemLevel)
			else
				button.key = nil
				button.Background:SetTexture(Equipment.GetSlotIcon(dataRowID))
				button.Name:SetText("")
			end
			
			button.id = dataRowID
		end,
		
	OnEnter = function(frame) 
			local character = frame.key
			if not character then return end

			local item = DataStore:GetInventoryItem(character, frame.id)
			if not item then return end

			GameTooltip:SetOwner(frame, "ANCHOR_LEFT")
			local link
			if type(item) == "number" then
				link = select(2, GetItemInfo(item))
			else
				link = item
			end
			
			if not link then
				GameTooltip:AddLine(L["Unknown link, please relog this character"],1,1,1)
				GameTooltip:Show()
				return
			end
			
			GameTooltip:SetHyperlink(link)
			GameTooltip:Show()
		end,
	OnClick = function(frame, button)
			local character = frame.key
			if not character then return end

			local slotID = frame.id
			if slotID == 0 then return end		-- class icon

			local item = DataStore:GetInventoryItem(character, slotID)
			if not item then return end
			
			local link
			if type(item) == "number" then
				link = select(2, GetItemInfo(item))
			else
				link = item
			end
			
			if not link then return end
			
			if button == "LeftButton" and IsControlKeyDown() then
				DressUpItemLink(link)
			elseif button == "LeftButton" and IsShiftKeyDown() then
				local chat = ChatEdit_GetLastActiveWindow()
				if chat:IsShown() then
					chat:Insert(link)
				else
					AltoholicFrame.SearchBox:SetText(GetItemInfo(link))
				end
			end
		end,
	OnLeave = function(self)
			GameTooltip:Hide() 
		end,
})
