local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

addon:Controller("AltoholicUI.CalendarEvent", { "AltoholicUI.EventsList", function(EventsList)
	return {
		SetDate = function(frame, weekdayName, monthName, day, year, month)
			frame.Date:SetText(format(FULLDATE, weekdayName, monthName, day, year, month))
			frame.Date:Show()
			frame.Background:Show()

			frame.Hour:Hide()
			frame.Character:Hide()
			frame.Title:Hide()
		end,
		SetInfo = function(frame, characterName, eventTime, title)
			frame.Hour:SetText(eventTime)
			frame.Character:SetText(characterName)
			frame.Title:SetText(title)
			
			frame.Hour:Show()
			frame.Character:Show()
			frame.Title:Show()

			frame.Date:Hide()
			frame.Background:Hide()
		end,
		Event_OnEnter = function(frame)
			-- local s = view[frame:GetID()]
			-- if not s or s.linetype == EVENT_DATE then return end
			
			local eventList = frame:GetParent()
			local eventIndex = eventList:GetEventIndex(frame:GetID())
			if not eventIndex then return end
			
			local tooltip = AddonFactory_Tooltip
			tooltip:SetOwner(frame, "ANCHOR_RIGHT")
			tooltip:ClearLines()
			-- local eventDate = format("%04d-%02d-%02d", self.year, self.month, self.day)
			-- local weekday = GetWeekdayIndex(mod(self:GetID(), 7))
			-- tooltip:AddLine(colors.teal..format(FULLDATE, GetFullDate(weekday, self.month, self.day, self.year)));
			
			local char, eventTime, title, desc = EventsList.GetEventInfo(eventIndex)
			
			tooltip:AddDoubleLine(format("%s%s %s", colors.white, eventTime, char), title)
			if desc then
				tooltip:AddLine(" ")
				tooltip:AddLine(desc)
			end
			tooltip:Show()
		end,
	}
end})
