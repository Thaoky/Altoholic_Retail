local addonName = "Altoholic"
local addon = _G[addonName]

addon:Service("AltoholicUI.CalendarEventListView", { function() 

	local view

	local EVENT_DATE = 1
	local EVENT_INFO = 2

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
			local year, month, day = strsplit("-", event.eventDate)
		
			return tonumber(year), tonumber(month), tonumber(day)		
		end,
		GetDateLineIndex = function(eventDate)
			for index, event in pairs(view) do
				if event.lineType == EVENT_DATE and event.eventDate == eventDate then
					return index			-- if the date line is found, return its index
				end
			end
		end,
		
		-- ** Info lines **
		AddInfoLine = function(eventInfo)
			table.insert(view, { lineType = EVENT_INFO, info = eventInfo })
		end,
		IsInfoLine = function(index)
			return (view[index].lineType == EVENT_INFO)
		end,
		GetInfoLineSource = function(index)
			-- Get the index of the event that was associated to this entry in the EventList
			local event = view[index]
			
			if event and event.lineType == EVENT_INFO then
				return event.info
			end
		end,
	}
end})

addon:Controller("AltoholicUI.CalendarEventList", { "AltoholicUI.EventsList", "AltoholicUI.CalendarEventListView", "AddonFactory.Dates",
function(EventsList, View, Dates)

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
		
		EventsList.BuildList()
		
		local eventDate = ""
		
		for index, event in pairs(EventsList.GetEvents()) do
			if eventDate ~= event.eventDate then
				View.AddDateLine(event.eventDate)
				eventDate = event.eventDate
			end
			View.AddInfoLine(event)
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
						
						rowFrame:SetDate(Dates.GetFullDate(year, month, day))
					
					elseif View.IsInfoLine(line) then
						rowFrame:SetInfo(View.GetInfoLineSource(line))
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

