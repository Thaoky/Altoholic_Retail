local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

local L = AddonFactory:GetLocale(addonName)
local options = DataStore_Quests_Options

addon:Controller("AltoholicUI.TabOptions.SettingsDataStoreQuests", function()

	local dailyResetDDM

	local function DailyResetDropDown_OnClick(self)
		-- set the new reset hour
		local newHour = self.value
		
		options.DailyResetHour = newHour
		dailyResetDDM:SetSelectedValue(newHour)
	end

	local function DailyResetDropDown_Initialize(self)
		local info = self:CreateInfo()
		local selectedHour = options.DailyResetHour
		
		for hour = 0, 23 do
			info.value = hour
			info.text = format(TIMEMANAGER_TICKER_24HOUR, hour, 0)
			info.func = DailyResetDropDown_OnClick
			info.checked = (hour == selectedHour)

			self:AddButtonInfo(info)
		end
	end

	return {
		__Parent = AltoholicFrame.TabOptions,
	
		OnBind = function(frame, parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel(15, frame)

			-- Setup localization & clear localized value after use (no longer needed)
			local colors = AddonFactory.Colors
			
			frame.Title:SetText(format("%s%s", colors.white, L["DataStore_Quests' Options"]))
			L["DataStore_Quests' Options"] = nil
			
			frame.DailyResetDropDownLabel:SetText(format("%s%s:", colors.white, L["DAILY_QUESTS_RESET_LABEL"]))
			
			-- Setup the drop down for the reset hour
			local hour = options.DailyResetHour
			
			dailyResetDDM = frame.DailyResetDropDown
			dailyResetDDM:SetMenuWidth(100) 
			dailyResetDDM:SetButtonWidth(20) 
			dailyResetDDM:SetSelectedValue(hour)
			dailyResetDDM:SetText(format(TIMEMANAGER_TICKER_24HOUR, hour, 0))
			dailyResetDDM:Initialize(DailyResetDropDown_Initialize)
		end,
		Update = function(frame, isResizing)
			frame.TrackTurnIns:SetChecked(options.TrackTurnIns)
			frame.AutoUpdateHistory:SetChecked(options.AutoUpdateHistory)
			
			frame:Show()
		end,
}end)
