local addonName = "Altoholic"
local addon = _G[addonName]

addon:Service("AltoholicUI.CalendarEventListView", { function() 

	local view

	local EVENT_DATE = 1
	local EVENT_INFO = 2
	
	local function GetDay(fullday)
		-- full day = a date as YYYY-MM-DD
		-- this function is actually different than the one in Blizzard_Calendar.lua, since weekday can't necessarily be determined from a UI button
		local refDate = {}		-- let's use the 1st of current month as reference date
		local refMonthFirstDay
		local _
		
		local CurMonthInfo = C_Calendar.GetMonthInfo()
		refDate.month, refDate.year, refMonthFirstDay = CurMonthInfo.month, CurMonthInfo.year, CurMonthInfo.firstWeekday
		refDate.day = 1

		local t = {}
		local year, month, day = strsplit("-", fullday)
		t.year = tonumber(year)
		t.month = tonumber(month)
		t.day = tonumber(day)

		local numDays = floor(difftime(time(t), time(refDate)) / 86400)
		local weekday = mod(refMonthFirstDay + numDays, 7)
		
		-- at this point, weekday might be negative or 0, simply add 7 to keep it in the proper range
		weekday = (weekday <= 0) and (weekday+7) or weekday
		
		return t.year, t.month, t.day, weekday
	end

	return {
		Initialize = function()
			view = view or {}
			wipe(view)
		end,
		GetSize = function() return #view end,
		
		-- ** Date lines **
		AddDateLine = function(eventDate)
			table.insert(view, { lineType = EVENT_DATE, eventDate = eventDate })
		end,
		IsDateLine = function(index)
			return (view[index].lineType == EVENT_DATE)
		end,
		GetDateLineInfo = function(index)
			local event = view[index]
		
			return GetDay(event.eventDate)
		end,
		GetDateLineIndex = function(eventDate)
			for index, event in pairs(view) do
				if event.lineType == EVENT_DATE and event.eventDate == eventDate then
					return index			-- if the date line is found, return its index
				end
			end
		end,
		
		-- ** Info lines **
		AddInfoLine = function(source)
			table.insert(view, { lineType = EVENT_INFO, source = source })
		end,
		IsInfoLine = function(index)
			return (view[index].lineType == EVENT_INFO)
		end,
		GetInfoLineSource = function(index)
			-- Get the index of the event that was associated to this entry in the EventList
			local event = view[index]
			
			if event and event.lineType == EVENT_INFO then
				return event.source
			end
		end,
	}
end})

addon:Controller("AltoholicUI.CalendarEventList", { "AltoholicUI.EventsList", "AltoholicUI.Events", "AltoholicUI.CalendarEventListView", 
function(EventsList, Events, View)

	local isViewValid
		
	local function BuildView()
		View.Initialize()
		
		--[[
			the following list of events : 10/05, 10/05, 12/05, 14/05, 14/05
			turns into this view : 
				"10/05"
				event 1
				event 2
				"12/05"
				event 1
				"14/05"
				event 1
				event 2
		--]]
		
		Events.BuildList()
		
		local eventDate = ""
		
		for index, event in pairs(Events:GetList()) do
			if eventDate ~= event.eventDate then
				View.AddDateLine(event.eventDate)
				eventDate = event.eventDate
			end
			View.AddInfoLine(index)
		end
		
		isViewValid = true
	end

	return {
		Update = function(frame)
			if not isViewValid then
				BuildView()
			end

			local calendar = frame:GetParent()

			local scrollFrame = frame.ScrollFrame
			local numRows = scrollFrame.numRows
			local offset = scrollFrame:GetOffset()

			for rowIndex = 1, numRows do
				local rowFrame = scrollFrame:GetRow(rowIndex)
				local line = rowIndex + offset
				
				if line <= View.GetSize() then

					if View.IsDateLine(line) then
						local year, month, day, weekday = View.GetDateLineInfo(line)
						
						rowFrame:SetDate(calendar:GetFullDate(weekday, month, day, year))
					
					elseif View.IsInfoLine(line) then
						local source = View.GetInfoLineSource(line)
						
						rowFrame:SetInfo(EventsList.GetEventInfo(source))
					end

					rowFrame:SetID(line)
					rowFrame:Show()
				else
					rowFrame:Hide()
				end
			end

			-- scrollFrame:Update(View.GetSize())
			local maxDisplayedRows = View.GetSize() > 18 and 18 or View.GetSize()
			
			scrollFrame:Update(View.GetSize(), maxDisplayedRows)
		end,
		InvalidateView = function(frame)
			isViewValid = nil
		end,
		
		GetEventDateLineIndex = function(frame, year, month, day)
			local eventDate = format("%04d-%02d-%02d", year, month, day)
			
			return View.GetDateLineIndex(eventDate)
		end,
		SetEventLineOffset = function(frame, offset)
			local scrollFrame = frame.ScrollFrame
			local numRows = scrollFrame.numRows

			-- if the view has less entries than can be displayed, don't change the offset
			local size = View.GetSize()
			if size <= numRows then return end

			if offset <= 0 then
				offset = 0
			elseif offset > (size - numRows) then
				offset = (size - numRows)
			end
			
			local scrollFrame = frame.GetParent()
			scrollFrame:SetOffset(offset)
			scrollFrame.ScrollBar:SetValue(offset * 18)
		end,
		GetEventIndex = function(frame, id)
			-- Get the index of the event that was associated to this entry in the EventList
			return View.GetInfoLineSource(id)
		end,
	}
end})
