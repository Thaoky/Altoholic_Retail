local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

local L = AddonFactory:GetLocale(addonName)

addon:Controller("AltoholicUI.ToggleableOption", function()
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
			if frame.module then
				local optionsTable = format("%s_Options", frame.module)

				if _G[optionsTable] then
					DataStore:ToggleOption(frame, optionsTable, frame.option)
				end
			end
		end,
	}
end)
