local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

addon:Controller("AltoholicUI.TabOptions.SettingsDataStoreCharacters", { "AltoholicUI.Options", function(Options)
	return {
		OnBind = function(frame)
			-- Attach to the parent
			local parent = AltoholicFrame.TabOptions
			
			frame:SetParent(parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel(11, frame)

			local colors = addon.Colors
			
			-- Setup localization & clear localized value after use (no longer needed)
			frame.Title:SetText(format("%s%s", colors.white, L["DataStore_Characters' Options"]))
			L["DataStore_Characters' Options"] = nil
		end,
		Update = function(frame, isResizing)
		
			local module = "DataStore_Characters"
			frame.RequestPlayTime:SetChecked(DataStore:GetOption(module, "RequestPlayTime"))
			frame.HideRealPlayTime:SetChecked(DataStore:GetOption(module, "HideRealPlayTime"))
			
			frame:Show()
		end,
	}
end})
