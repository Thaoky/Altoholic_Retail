local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

local L = AddonFactory:GetLocale(addonName)
local options = Altoholic_UI_Options

addon:Controller("AltoholicUI.TabOptions.SettingsAltoholicGeneral.MinimapIconAngle", function()
	return {
		OnBind = function(frame)
			frame:SetMinMaxValues(1, 360)
			frame.Low:SetText("1")
			frame.High:SetText("360")
			frame:SetValueStep(1)
			frame.tooltipText = L["Minimap Icon Angle"]
			frame.tooltipRequirement = L["Move to change the angle of the minimap icon"]
			
			frame:SetScript("OnValueChanged", function(self) 
				local value = self:GetValue()

				self:Update(value)
				options.Minimap.IconAngle = value
				AltoholicMinimapButton:Move()
			end)
		end,
		Update = function(frame, value)
			frame.Text:SetText(format("%s (%d)", L["Minimap Icon Angle"], value))
		end,
	}
end)

addon:Controller("AltoholicUI.TabOptions.SettingsAltoholicGeneral.MinimapIconRadius", function()
	return {
		OnBind = function(frame)
			frame:SetMinMaxValues(1, 200)
			frame.Low:SetText("1")
			frame.High:SetText("200")
			frame:SetValueStep(1)
			frame.tooltipText = L["Minimap Icon Radius"]
			frame.tooltipRequirement = L["Move to change the radius of the minimap icon"]
			
			frame:SetScript("OnValueChanged", function(self) 
				local value = self:GetValue()

				self:Update(value)
				options.Minimap.IconRadius = value
				AltoholicMinimapButton:Move()
			end)
		end,
		Update = function(frame, value)
			frame.Text:SetText(format("%s (%d)", L["Minimap Icon Radius"], value))
		end,
	}
end)

addon:Controller("AltoholicUI.TabOptions.SettingsAltoholicGeneral.UIScale", function()
	return {
		OnBind = function(frame)
			frame:SetMinMaxValues(0.5, 4.0)
			frame.Low:SetText("0.5")
			frame.High:SetText("4.0")
			frame:SetValueStep(0.1)
			frame.tooltipText = UI_SCALE
			frame.tooltipRequirement = L["UI_SCALE_TOOLTIP"]
			
			frame:SetScript("OnValueChanged", function(self) 
				-- Only update the text, actual change of the UI scale is done via buttons
				self:Update(self:GetValue())
			end)
		end,
		Update = function(frame, value)
			frame.Text:SetText(format("%s (%1.1f)", UI_SCALE, value))
		end,
		Reset = function(frame)
			local defaultValue = 1.0
			
			frame:SetValue(defaultValue)
			frame:Update(defaultValue)
			frame:Apply()
		end,
		Apply = function(frame)
			local value = frame:GetValue()
			
			options.Scale = value
			AltoholicFrame:SetScale(value)
		end,
}end)

addon:Controller("AltoholicUI.TabOptions.SettingsAltoholicGeneral.Transparency", function()
	return {
		OnBind = function(frame)
			frame:SetMinMaxValues(0.1, 1.0)
			frame.Low:SetText("0.1")
			frame.High:SetText("1.0")
			frame:SetValueStep(0.05)
			frame.tooltipText = L["Transparency"]
			frame.tooltipRequirement = L["UI_TRANSPARENCY_TOOLTIP"]
			
			frame:SetScript("OnValueChanged", function(self) 
				local value = self:GetValue()

				self:Update(value)
				options.Transparency = value
				AltoholicFrame:SetAlpha(value)
			end)
		end,
		Update = function(frame, value)
			frame.Text:SetText(format("%s (%1.2f)", L["Transparency"], value))
		end,
}end)

addon:Controller("AltoholicUI.TabOptions.SettingsAltoholicGeneral", function()
	return {
		OnBind = function(frame)
			-- Attach to the parent
			local parent = AltoholicFrame.TabOptions
			
			frame:SetParent(parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel(1, frame)

			-- Setup localization & clear localized value after use (no longer needed)
			frame.Title:SetText(format("%s%s", colors.white, L["General Options"]))
			L["General Options"] = nil
			
			frame.UIScale:SetValue(options.Scale)
			frame.Transparency:SetValue(options.Transparency)
			frame.MinimapIconAngle:SetValue(options.Minimap.IconAngle)
			frame.MinimapIconRadius:SetValue(options.Minimap.IconRadius)
			
			-- Make sur this panel is shown by default, it must happen here, in TabOption's OnBind, not everything is loaded yet.
			parent.CategoriesList:ClickCategory("panel", 1)
			parent:ShowPanel(1)
		end,
		Update = function(frame, isResizing)
			frame.BankAutoUpdate:SetChecked(Altoholic_Sharing_Options.GuildBankAutoUpdate)
			frame.ClampWindowToScreen:SetChecked(options.ClampWindowToScreen)
			frame.ShowMinimapIcon:SetChecked(options.Minimap.ShowIcon)
			
			frame.UIScale:Update(options.Scale)
			frame.Transparency:Update(options.Transparency)
			frame.MinimapIconAngle:Update(options.Minimap.IconAngle)
			frame.MinimapIconRadius:Update(options.Minimap.IconRadius)
			
			frame:Show()
		end,
		ToggleScreenClamping = function(frame, isChecked)
			AltoholicFrame:SetClampedToScreen(isChecked)
			
			if isChecked then 
				options.ClampWindowToScreen = true
			else
				options.ClampWindowToScreen = false
			end
			
		end,
		ToggleMinimapIcon = function(frame, isChecked)
			if isChecked then 
				options.Minimap.ShowIcon = true
				AltoholicMinimapButton:Show()
			else
				options.Minimap.ShowIcon = false
				AltoholicMinimapButton:Hide()
			end
		end,
	}
end)
