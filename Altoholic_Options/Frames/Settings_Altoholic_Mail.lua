local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local OPTION_TIME_TO_NEXT = "UI.Mail.TimeToNextWarning"

addon:Controller("AltoholicUI.TabOptions.SettingsAltoholicMail.TimeToNextWarning", { "AltoholicUI.Options", function(Options)
	return {
		OnBind = function(frame)
			frame:SetMinMaxValues(1, 12)
			frame.Low:SetText("1")
			frame.High:SetText("12")
			frame:SetValueStep(1)
			frame.tooltipText = L["TIME_TO_NEXT_WARNING_TEXT"]
			frame.tooltipRequirement = L["TIME_TO_NEXT_WARNING_TOOLTIP"]
			
			frame:SetScript("OnValueChanged", function(self) 
				local timeToNext = self:GetValue()

				self:Update(timeToNext)
				Options.Set(OPTION_TIME_TO_NEXT, timeToNext)
			end)
		end,
		Update = function(frame, value)
			frame.Text:SetText(format("%s (%s)", L["TIME_TO_NEXT_WARNING_TEXT"], format(D_HOURS, value)))
		end,
	}
end})

addon:Controller("AltoholicUI.TabOptions.SettingsAltoholicMail", { "AltoholicUI.Options", function(Options)

	local priorityTypes = {
		L["AUTO_COMPLETE_BY_NAME"],
		L["AUTO_COMPLETE_BY_MOST_PLAYED"],
		L["AUTO_COMPLETE_BY_LAST_PLAYED"]
	}

	local function TogglePriority(self)
		Options.Set("UI.Mail.AutoCompletePriority", self.value)
	end
	
	local function AutoCompletePriority_Initialize(self)
		local info = self:CreateInfo()
		local currentPriority = Options.Get("UI.Mail.AutoCompletePriority")
		
		for i, priority in ipairs(priorityTypes) do
			info.text = priority
			info.value = i
			info.func = TogglePriority
			info.checked = (currentPriority == i)
			
			self:AddButtonInfo(info, 1)
		end
	end

	return {
		OnBind = function(frame)
			-- Attach to the parent
			local parent = AltoholicFrame.TabOptions
			
			frame:SetParent(parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel(2, frame)

			local colors = addon.Colors
			
			-- Setup localization & clear localized value after use (no longer needed)
			frame.Title:SetText(format("%s%s", colors.white, L["Mail Options"]))
			L["Mail Options"] = nil
			
			local f = frame.AutoCompletePriority
			f:SetMenuWidth(160) 
			f:SetButtonWidth(20) 
			f:SetText(L["AUTO_COMPLETE_PRIORITY"])
			f:Initialize(AutoCompletePriority_Initialize)
			
			frame.TimeToNextWarning:SetValue(Options.Get(OPTION_TIME_TO_NEXT))
		end,
		Update = function(frame, isResizing)
			frame.TimeToNextWarning:Update(Options.Get(OPTION_TIME_TO_NEXT))
		
			frame.GuildMailWarning:SetChecked(Options.Get("UI.Mail.GuildMailWarning"))
			frame.AutoCompleteRecipient:SetChecked(Options.Get("UI.Mail.AutoCompleteRecipient"))
			
			frame:Show()
		end,
	}
end})
