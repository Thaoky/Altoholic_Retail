local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

local CALENDAR_DAYBUTTON_NORMALIZED_TEX_WIDTH	= 90 / 256 - 0.001		-- fudge factor to prevent texture seams
local CALENDAR_DAYBUTTON_NORMALIZED_TEX_HEIGHT	= 90 / 256 - 0.001		-- fudge factor to prevent texture seams
local CALENDAR_DAYBUTTON_HIGHLIGHT_ALPHA		= 0.5

addon:Controller("AltoholicUI.CalendarDay", { "AltoholicUI.EventsList", function(EventsList)
	return {
		OnBind = function(frame)
			-- set the normal texture to be the background
			local tex = frame:GetNormalTexture()
			tex:SetDrawLayer("BACKGROUND")
			
			local texLeft = random(0,1) * CALENDAR_DAYBUTTON_NORMALIZED_TEX_WIDTH
			local texRight = texLeft + CALENDAR_DAYBUTTON_NORMALIZED_TEX_WIDTH
			local texTop = random(0,1) * CALENDAR_DAYBUTTON_NORMALIZED_TEX_HEIGHT
			local texBottom = texTop + CALENDAR_DAYBUTTON_NORMALIZED_TEX_HEIGHT
			tex:SetTexCoord(texLeft, texRight, texTop, texBottom)
			
			-- adjust the highlight texture layer
			tex = frame:GetHighlightTexture()
			tex:SetAlpha(CALENDAR_DAYBUTTON_HIGHLIGHT_ALPHA)
		end,
		Update = function(frame, day, month, year, isDarkened)
			frame.day = day
			frame.month = month
			frame.year = year
			
			-- set date
			local tex = frame:GetNormalTexture()

			frame.Date:SetText(day)
			if isDarkened then
				tex:SetVertexColor(0.4, 0.4, 0.4)
			else
				tex:SetVertexColor(1.0, 1.0, 1.0)
			end
			
			-- set count
			local count = EventsList.GetDayCount(year, month, day)
			
			if count == 0 then
				frame.Count:Hide()
			else
				frame.Count:SetText(count)
				frame.Count:Show()
			end
		end,
		Day_OnEnter = function(frame)
			local year = frame.year
			local month = frame.month
			local day = frame.day
			
			if EventsList.GetDayCount(year, month, day) == 0 then
				return	-- no events on that day ? exit
			end
			
			local calendar = frame:GetParent()
			local tooltip = AddonFactory_Tooltip
			
			tooltip:SetOwner(frame, "ANCHOR_LEFT")
			tooltip:ClearLines()
			
			local eventDate = format("%04d-%02d-%02d", year, month, day)
			local weekday = calendar:GetWeekdayIndex(mod(frame:GetID(), 7)) 
			weekday = (weekday == 0) and 7 or weekday
			
			tooltip:AddLine(colors.teal..format(FULLDATE, calendar:GetFullDate(weekday, month, day, year)))

			for index, event in pairs(EventsList.GetEvents()) do
				if event.eventDate == eventDate then
					local char, eventTime, title = EventsList.GetEventInfo(index)
					tooltip:AddDoubleLine(format("%s%s %s", colors.white, eventTime, char), title)
				end
			end
			tooltip:Show()
		end,
		Day_OnClick = function(frame, button)
			local year = frame.year
			local month = frame.month
			local day = frame.day
			
			if EventsList:GetDayCount(year, month, day) == 0 then
				return	-- no events on that day ? exit
			end	
			
			local calendar = frame:GetParent()
			local index = calendar.EventList:GetEventDateLineIndex(year, month, day)
			if index then
				calendar.EventList:SetEventLineOffset(index - 1)	-- if the date is the 4th line, offset is 3
				calendar.EventList:Update()
			end
		end,
	}
end})
