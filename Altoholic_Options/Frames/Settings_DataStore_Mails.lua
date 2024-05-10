local addonName = "Altoholic"
local addon = _G[addonName]

local L = DataStore:GetLocale(addonName)
local options = DataStore_Mails_Options

addon:Controller("AltoholicUI.TabOptions.SettingsDataStoreMails.SliderMailExpiry", function()
	return {
		OnBind = function(frame)
			frame:SetMinMaxValues(1, 15)
			frame.Low:SetText("1")
			frame.High:SetText("15")
			frame:SetValueStep(1)
			frame.tooltipText = L["SLIDER_EXPIRY_TITLE"]
			frame.tooltipRequirement = L["SLIDER_EXPIRY_TOOLTIP"]
			
			frame:SetScript("OnValueChanged", function(self) 
				local value = math.floor(self:GetValue())

				self:Update(value)
				options.MailWarningThreshold = value
			end)
		end,
		Update = function(frame, value)
			frame.Text:SetText(format("%s (%d)", L["SLIDER_EXPIRY_TITLE"], value))
		end,
}end)

addon:Controller("AltoholicUI.TabOptions.SettingsDataStoreMails", function()
	return {
		OnBind = function(frame)
			-- Attach to the parent
			local parent = AltoholicFrame.TabOptions
			
			frame:SetParent(parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel(14, frame)

			-- Setup localization & clear localized value after use (no longer needed)
			local colors = addon.Colors
			
			frame.Title:SetText(format("%s%s", colors.white, L["DataStore_Mails' Options"]))
			L["DataStore_Mails' Options"] = nil
			
			frame.SliderMailExpiry:SetValue(options.MailWarningThreshold)
		end,
		Update = function(frame, isResizing)
			frame.SliderMailExpiry:Update(options.MailWarningThreshold)

			frame.CheckMailExpiry:SetChecked(options.CheckMailExpiry)
			frame.ScanMailBody:SetChecked(options.ScanMailBody)
			frame.CheckMailExpiryAllAccounts:SetChecked(options.CheckMailExpiryAllAccounts)
			frame.CheckMailExpiryAllRealms:SetChecked(options.CheckMailExpiryAllRealms)
			frame.ReportExpiredMailsToChat:SetChecked(options.ReportExpiredMailsToChat)
			
			frame:Show()
		end,
}end)
