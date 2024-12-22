local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.TabOptions.SettingsAltoholicMiscellaneous", function()
	local options = Altoholic_UI_Options
	
	return {
		OnBind = function(frame)
			-- Attach to the parent
			local parent = AltoholicFrame.TabOptions
			
			frame:SetParent(parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel(5, frame)

			-- Setup localization & clear localized value after use (no longer needed)
			local L = AddonFactory:GetLocale(addonName)
			local colors = AddonFactory.Colors
			
			frame.Title:SetText(format("%s%s", colors.white, L["Miscellaneous Options"]))
			frame.AHColorCoding.Text:SetText(L["Use color-coding for recipes at the AH"])
			frame.VendorColorCoding.Text:SetText(L["Use color-coding for recipes at vendors"])
			L["Miscellaneous Options"] = nil
			L["Use color-coding for recipes at the AH"] = nil
			L["Use color-coding for recipes at vendors"] = nil
		end,
		Update = function(frame, isResizing)
			frame.AHColorCoding:SetChecked(options.AHColorCoding)
			frame.VendorColorCoding:SetChecked(options.VendorColorCoding)
			
			frame:Show()
		end,
	}
end)
