local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.TabOptions.SettingsDataStoreInventory", function()
	return {
		OnBind = function(frame)
			-- Attach to the parent
			local parent = AltoholicFrame.TabOptions
			
			frame:SetParent(parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel(13, frame)

			-- Setup localization & clear localized value after use (no longer needed)
			local colors = AddonFactory.Colors
			
			local L = AddonFactory:GetLocale(addonName)
			frame.Title:SetText(format("%s%s", colors.white, L["DataStore_Inventory's Options"]))
			L["DataStore_Inventory's Options"] = nil
		end,
		Update = function(frame, isResizing)
		
			local options = DataStore_Inventory_Options
			frame.AutoClearGuildInventory:SetChecked(options.AutoClearGuildInventory)
			frame.BroadcastAiL:SetChecked(options.BroadcastAiL)
			frame.EquipmentRequestNotification:SetChecked(options.EquipmentRequestNotification)
			
			frame.AutoClearGuildInventory.Text:SetWidth(400)
			frame.BroadcastAiL.Text:SetWidth(400)
			frame.EquipmentRequestNotification.Text:SetWidth(400)
			
			frame:Show()
		end,
}end)
