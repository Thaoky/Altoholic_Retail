local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

addon:Controller("AltoholicUI.TabOptions.SettingsDataStoreAuctions.SliderLastVisit", { "AltoholicUI.Options", function(Options)
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
				DataStore:SetOption("DataStore_Auctions", "CheckLastVisitThreshold", value)
			end)
		end,
		Update = function(frame, value)
			frame.Text:SetText(format("%s (%d)", L["LAST_VISIT_SLIDER_LABEL"], value))
		end,
	}
end})

addon:Controller("AltoholicUI.TabOptions.SettingsDataStoreAuctions", { "AltoholicUI.Options", function(Options)
	local module = "DataStore_Auctions"
	
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
			
			frame.SliderLastVisit:SetValue(DataStore:GetOption(module, "CheckLastVisitThreshold"))
		end,
		Update = function(frame, isResizing)
			frame.SliderLastVisit:Update(DataStore:GetOption(module, "CheckLastVisitThreshold"))
			frame.CheckLastVisit:SetChecked(DataStore:GetOption(module, "CheckLastVisit"))
			frame.AutoClearExpiredItems:SetChecked(DataStore:GetOption(module, "AutoClearExpiredItems"))
			
			frame:Show()
		end,
	}
end})
