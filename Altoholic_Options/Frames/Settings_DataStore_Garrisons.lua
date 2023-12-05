local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local module = "DataStore_Garrisons"

addon:Controller("AltoholicUI.TabOptions.SettingsDataStoreGarrisons.ReportLevel", { "AltoholicUI.Options", function(Options)
	return {
		OnBind = function(frame)
			frame:SetMinMaxValues(350, 975)
			frame.Low:SetText("350")
			frame.High:SetText("975")
			frame:SetValueStep(5)
			frame.tooltipText = L["REPORT_LEVEL_TITLE"]
			frame.tooltipRequirement = L["REPORT_LEVEL_TOOLTIP"]
			
			frame:SetScript("OnValueChanged", function(self) 
				local value = math.floor(self:GetValue())
				value = math.floor(value / 5) * 5	-- ensure the proper stepping is respected

				self:Update(value)
				DataStore:SetOption(module, "ReportLevel", value)
			end)
		end,
		Update = function(frame, value)
			frame.Text:SetText(format(L["REPORT_LEVEL_LABEL"], colors.green, value))
		end,
	}
end})

addon:Controller("AltoholicUI.TabOptions.SettingsDataStoreGarrisons", { "AltoholicUI.Options", function(Options)
	
	return {
		OnBind = function(frame)
			-- Attach to the parent
			local parent = AltoholicFrame.TabOptions
			
			frame:SetParent(parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel(12, frame)

			-- Setup localization & clear localized value after use (no longer needed)
			local colors = addon.Colors
			
			frame.Title:SetText(format("%s%s", colors.white, L["DataStore_Garrisons' Options"]))
			L["DataStore_Garrisons' Options"] = nil
			
			frame.ReportLevel:SetValue(DataStore:GetOption(module, "ReportLevel"))
		end,
		Update = function(frame, isResizing)
		
			frame.ReportLevel:Update(DataStore:GetOption(module, "ReportLevel"))
			frame.ReportUncollected:SetChecked(DataStore:GetOption(module, "ReportUncollected"))
			
			frame:Show()
		end,
	}
end})
