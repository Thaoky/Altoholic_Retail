local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

addon:Controller("AltoholicUI.ToggleableOption", { "AltoholicUI.Options", function(Options)
	return {
		OnBind = function(frame)
			-- Set Label
			if frame.locLabel then
				frame.Text:SetText(L[frame.locLabel] or "")
			end
				
			-- Set the tooltip
			if frame.locTitle then
				frame.tooltipText = L[frame.locTitle]
			end
				
			if frame.locEnabled and frame.locDisabled then
				frame.tooltipRequirement = format("\n%s%s|r:\n%s\n\n%s%s|r:\n%s", 
					colors.green, L["Enabled"], L[frame.locEnabled], 
					colors.red, L["Disabled"], L[frame.locDisabled])
			end
		end,
		Button_OnClick = function(frame)
			if frame.module and _G[frame.module] then
				DataStore:ToggleOption(frame, frame.module, frame.option)
			else
				Options.Toggle(frame, frame.option)
			end
		end,
	}
end})