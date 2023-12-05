local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

addon:Controller("AltoholicUI.TabOptions.SettingsDataStoreInventory", { "AltoholicUI.Options", function(Options)
	return {
		OnBind = function(frame)
			-- Attach to the parent
			local parent = AltoholicFrame.TabOptions
			
			frame:SetParent(parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel(13, frame)

			-- Setup localization & clear localized value after use (no longer needed)
			local colors = addon.Colors
			
			frame.Title:SetText(format("%s%s", colors.white, L["DataStore_Inventory's Options"]))
			L["DataStore_Inventory's Options"] = nil
		end,
		Update = function(frame, isResizing)
		
			local module = "DataStore_Inventory"
			frame.AutoClearGuildInventory:SetChecked(DataStore:GetOption(module, "AutoClearGuildInventory"))
			frame.BroadcastAiL:SetChecked(DataStore:GetOption(module, "BroadcastAiL"))
			frame.EquipmentRequestNotification:SetChecked(DataStore:GetOption(module, "EquipmentRequestNotification"))
			
			frame.AutoClearGuildInventory.Text:SetWidth(400)
			frame.BroadcastAiL.Text:SetWidth(400)
			frame.EquipmentRequestNotification.Text:SetWidth(400)
			
			frame:Show()
		end,
	}
end})
