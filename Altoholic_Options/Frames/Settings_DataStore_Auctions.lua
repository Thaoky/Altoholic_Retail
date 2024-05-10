local addonName = "Altoholic"
local addon = _G[addonName]

local L = DataStore:GetLocale(addonName)
local options = DataStore_Auctions_Options

addon:Controller("AltoholicUI.TabOptions.SettingsDataStoreAuctions.SliderLastVisit", function()
	return {
		OnBind = function(frame)
			frame:SetMinMaxValues(10, 30)
			frame.Low:SetText("10")
			frame.High:SetText("30")
			frame:SetValueStep(1)
			frame.tooltipText = L["LAST_VISIT_SLIDER_TITLE"]
			frame.tooltipRequirement = L["LAST_VISIT_SLIDER_TOOLTIP"]
			
			frame:SetScript("OnValueChanged", function(self) 
				local value = math.floor(self:GetValue())

				self:Update(value)
				options.CheckLastVisitThreshold = value
			end)
		end,
		Update = function(frame, value)
			frame.Text:SetText(format("%s (%d)", L["LAST_VISIT_SLIDER_LABEL"], value))
		end,
}end)

addon:Controller("AltoholicUI.TabOptions.SettingsDataStoreAuctions", function()

	
	return {
		OnBind = function(frame)
			-- Attach to the parent
			local parent = AltoholicFrame.TabOptions
			
			frame:SetParent(parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel(10, frame)

			local colors = addon.Colors
			
			-- Setup localization & clear localized value after use (no longer needed)
			frame.Title:SetText(format("%s%s", colors.white, L["DataStore_Auctions' Options"]))
			L["DataStore_Auctions' Options"] = nil
			
			frame.SliderLastVisit:SetValue(options.CheckLastVisitThreshold)
		end,
		Update = function(frame, isResizing)
			frame.SliderLastVisit:Update(options.CheckLastVisitThreshold)
			frame.CheckLastVisit:SetChecked(options.CheckLastVisit)
			frame.AutoClearExpiredItems:SetChecked(options.AutoClearExpiredItems)
			
			frame:Show()
		end,
}end)
