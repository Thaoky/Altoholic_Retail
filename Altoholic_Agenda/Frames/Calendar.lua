local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.TabAgenda.Calendar", { "AddonFactory.Dates", function(Dates)
	return {
		OnBind = function(frame)
			local parent = AltoholicFrame.TabAgenda
			
			frame:SetParent(parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel("Calendar", frame)
		
			--	<Anchor point="BOTTOM" relativeKey="AltoholicFrame.TabAgenda.Background" />
			frame.EventList:SetPoint("BOTTOM", AltoholicFrame.TabAgenda.Background, "BOTTOM", 0, 0)
			
			-- by default, the week starts on Sunday, adjust first day of the week if necessary
			if Altoholic_Calendar_Options["WeekStartsOnMonday"] then
				Dates.SetFirstDayOfWeek(2)
			end
			
			-- Texture data
			local texWidth = 90 / 256 - 0.001		-- fudge factor to prevent texture seams
			local texHeight = 28 / 256 - 0.001		-- fudge factor to prevent texture seams
			local texLeft = 0.0
			local texTop = 180 / 256
			local texBottom = texTop + texHeight
			
			local band = bit.band
			
			-- initialize weekdays
			for i = 1, 7 do
				local bg = frame[format("Weekday%dBackground", i)]
				local left = (band(i, 1) * texWidth) + texLeft		-- mod(index, 2) * width
				local right = left + texWidth

				bg:SetTexCoord(left, right, texTop, texBottom)
				bg:Show()
			end

			frame:Update()
		end,
		Update = function(frame)
			-- taken from CalendarFrame_Update() in Blizzard_Calendar.lua, adjusted for my needs.
			-- The event list must be updated at the beginning !
			frame.EventList:Update()
			
			local DateInfo = C_DateAndTime.GetCurrentCalendarTime()
			
			local prevMonth, prevYear, prevNumDays = Dates.GetMonthInfo(-1)
			local thisMonth, thisYear, numDays, firstWeekday = Dates.GetMonthInfo()
			
			-- set title
			frame.MonthYear:SetText(Dates.GetMonthYearString(thisMonth, thisYear))
			
			-- initialize weekdays
			for i = 1, 7 do
				frame[format("Weekday%dName", i)]:SetText(Dates.GetWeekDayShort(Dates.GetWeekdayIndex(i)))
			end

			-- set the previous month's days before the first day of the week
			local viewablePrevMonthDays = mod((firstWeekday - Dates.GetFirstDayOfWeek() - 1) + 7, 7)
			local day = prevNumDays - viewablePrevMonthDays
			local buttonIndex = 1
			
			-- Set the current day in a given month/year
			local function SetDay(month, year, isDarkened)
				frame[format("Day%d", buttonIndex)]:Update(day, month, year, isDarkened)
				
				buttonIndex = buttonIndex + 1
				day = day + 1
			end
			
			-- set the days of the previous month
			while Dates.GetWeekdayIndex(buttonIndex) ~= firstWeekday do
				SetDay(prevMonth, prevYear, true)
			end

			-- set the days of this month
			day = 1
			while day <= numDays do
				SetDay(thisMonth, thisYear, false)
			end
			
			-- set the first days of the next month
			local nextMonth, nextYear = Dates.GetMonthInfo(1)
			
			day = 1
			while buttonIndex <= Dates.GetMaxDaysInMonth() do
				SetDay(nextMonth, nextYear, true)
			end
			
			frame:Show()
		end,
		InvalidateView = function(frame)
			isViewValid = nil
			if frame:IsVisible() then
				frame:Update()
			end
		end,

	}
end})
