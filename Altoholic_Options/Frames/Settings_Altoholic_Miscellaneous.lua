local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.TabOptions.SettingsAltoholicMiscellaneous", { "AltoholicUI.Options", function(Options)

	return {
		OnBind = function(frame)
			-- Attach to the parent
			local parent = AltoholicFrame.TabOptions
			
			frame:SetParent(parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel(5, frame)

			-- Setup localization & clear localized value after use (no longer needed)
			local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
			local colors = addon.Colors
			
			frame.Title:SetText(format("%s%s", colors.white, L["Miscellaneous Options"]))
			frame.AHColorCoding.Text:SetText(L["Use color-coding for recipes at the AH"])
			frame.VendorColorCoding.Text:SetText(L["Use color-coding for recipes at vendors"])
			L["Miscellaneous Options"] = nil
			L["Use color-coding for recipes at the AH"] = nil
			L["Use color-coding for recipes at vendors"] = nil
		end,
		Update = function(frame, isResizing)
			frame.AHColorCoding:SetChecked(Options.Get("UI.AHColorCoding"))
			frame.VendorColorCoding:SetChecked(Options.Get("UI.VendorColorCoding"))
			
			frame:Show()
		end,
	}
end})
