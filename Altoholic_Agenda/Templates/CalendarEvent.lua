local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

addon:Controller("AltoholicUI.CalendarEvent", { "AltoholicUI.EventsList", function(EventsList)
	return {
		SetDate = function(frame, dateString)
			frame.Date:SetText(dateString)
			frame.Date:Show()
			frame.Background:Show()

			frame.Hour:Hide()
			frame.Character:Hide()
			frame.Title:Hide()
		end,
		SetInfo = function(frame, event)
			frame.event = event
			
			local characterName, eventTime, title = EventsList.GetEventInfo(event)
			
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
			if not frame.event then return end
			
			local tooltip = AddonFactory_Tooltip
			tooltip:SetOwner(frame, "ANCHOR_RIGHT")
			tooltip:ClearLines()

			local char, eventTime, title, desc = EventsList.GetEventInfo(frame.event)
			
			tooltip:AddDoubleLine(format("%s%s %s", colors.white, eventTime, char), title)
			if desc then
				tooltip:AddLine(" ")
				tooltip:AddLine(desc)
			end
			tooltip:Show()
		end,
	}
end})
