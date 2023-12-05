local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local OPTION_MINIMAP_SHOW_ICON = "UI.Minimap.ShowIcon"
local OPTION_MINIMAP_ICON_ANGLE = "UI.Minimap.IconAngle"
local OPTION_MINIMAP_ICON_RADIUS = "UI.Minimap.IconRadius"
local OPTION_UI_SCALE = "UI.Scale"
local OPTION_UI_TRANSPARENCY = "UI.Transparency"
local OPTION_UI_CLAMP_TO_SCREEN = "UI.ClampWindowToScreen"

addon:Controller("AltoholicUI.TabOptions.SettingsAltoholicGeneral.MinimapIconAngle", { "AltoholicUI.Options", function(Options)
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
				Options.Set(OPTION_MINIMAP_ICON_ANGLE, value)
				AltoholicMinimapButton:Move()
			end)
		end,
		Update = function(frame, value)
			frame.Text:SetText(format("%s (%d)", L["Minimap Icon Angle"], value))
		end,
	}
end})

addon:Controller("AltoholicUI.TabOptions.SettingsAltoholicGeneral.MinimapIconRadius", { "AltoholicUI.Options", function(Options)
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
				Options.Set(OPTION_MINIMAP_ICON_RADIUS, value)
				AltoholicMinimapButton:Move()
			end)
		end,
		Update = function(frame, value)
			frame.Text:SetText(format("%s (%d)", L["Minimap Icon Radius"], value))
		end,
	}
end})

addon:Controller("AltoholicUI.TabOptions.SettingsAltoholicGeneral.UIScale", { "AltoholicUI.Options", function(Options)
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
			
			Options.Set(OPTION_UI_SCALE, value)
			AltoholicFrame:SetScale(value)
		end,
	}
end})

addon:Controller("AltoholicUI.TabOptions.SettingsAltoholicGeneral.Transparency", { "AltoholicUI.Options", function(Options)
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
				Options.Set(OPTION_UI_TRANSPARENCY, value)
				AltoholicFrame:SetAlpha(value)
			end)
		end,
		Update = function(frame, value)
			frame.Text:SetText(format("%s (%1.2f)", L["Transparency"], value))
		end,
	}
end})

addon:Controller("AltoholicUI.TabOptions.SettingsAltoholicGeneral", { "AltoholicUI.Options", function(Options)
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
			
			frame.UIScale:SetValue(Options.Get(OPTION_UI_SCALE))
			frame.Transparency:SetValue(Options.Get(OPTION_UI_TRANSPARENCY))
			frame.MinimapIconAngle:SetValue(Options.Get(OPTION_MINIMAP_ICON_ANGLE))
			frame.MinimapIconRadius:SetValue(Options.Get(OPTION_MINIMAP_ICON_RADIUS))
			
			-- Make sur this panel is shown by default, it must happen here, in TabOption's OnBind, not everything is loaded yet.
			parent.CategoriesList:ClickCategory("panel", 1)
			parent:ShowPanel(1)
		end,
		Update = function(frame, isResizing)
			frame.BankAutoUpdate:SetChecked(Options.Get("UI.Tabs.Guild.BankAutoUpdate"))
			frame.ClampWindowToScreen:SetChecked(Options.Get(OPTION_UI_CLAMP_TO_SCREEN))
			frame.ShowMinimapIcon:SetChecked(Options.Get(OPTION_MINIMAP_SHOW_ICON))
			
			frame.UIScale:Update(Options.Get(OPTION_UI_SCALE))
			frame.Transparency:Update(Options.Get(OPTION_UI_TRANSPARENCY))
			frame.MinimapIconAngle:Update(Options.Get(OPTION_MINIMAP_ICON_ANGLE))
			frame.MinimapIconRadius:Update(Options.Get(OPTION_MINIMAP_ICON_RADIUS))
			
			frame:Show()
		end,
		ToggleScreenClamping = function(frame, isChecked)
			AltoholicFrame:SetClampedToScreen(isChecked)
			
			if isChecked then 
				Options.Set(OPTION_UI_CLAMP_TO_SCREEN, true)
			else
				Options.Set(OPTION_UI_CLAMP_TO_SCREEN, false)
			end
		end,
		ToggleMinimapIcon = function(frame, isChecked)
			if isChecked then 
				Options.Set(OPTION_MINIMAP_SHOW_ICON, true)
				AltoholicMinimapButton:Show()
			else
				Options.Set(OPTION_MINIMAP_SHOW_ICON, false)
				AltoholicMinimapButton:Hide()
			end
		end,
	}
end})
