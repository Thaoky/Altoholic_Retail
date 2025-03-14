local addonName = "Altoholic"
local addon = _G[addonName]

local L = AddonFactory:GetLocale(addonName)

addon:Controller("AltoholicUI.TabOptions.SettingsDataStoreCharacters", function()
	return {
		__Parent = AltoholicFrame.TabOptions,
	
		OnBind = function(frame, parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel(11, frame)

			local colors = AddonFactory.Colors
			
			-- Setup localization & clear localized value after use (no longer needed)
			frame.Title:SetText(format("%s%s", colors.white, L["DataStore_Characters' Options"]))
			L["DataStore_Characters' Options"] = nil
		end,
		Update = function(frame, isResizing)
		
			local options = DataStore_Characters_Options
			frame.RequestPlayTime:SetChecked(options.RequestPlayTime)
			frame.HideRealPlayTime:SetChecked(options.HideRealPlayTime)
			
			frame:Show()
		end,
}end)
