local addonName, addon = ...
local colors = AddonFactory.Colors

local L = AddonFactory:GetLocale(addonName)

addon:Service("AltoholicUI.EventsList", { "AddonFactory.Classes", "AltoholicUI.Formatter", function(oop, Formatter)
	
	local function ExpiryDate(t) return date("%Y-%m-%d", t) end
	local function ExpiryTime(t) return date("%H:%M", t) end
	local function GetCharInfo(character) 
		local _, realm, char = strsplit(".", character)
		return char, realm
	end
	
	local timeTable = {}				-- to pass as an argument to time()	see http://lua-users.org/wiki/OsLibraryTutorial for details
	
	oop:Create("EventLine", {
		Init = function(self, eventType, eventDate, eventTime, character)
			self.eventType = eventType
			self.eventDate = eventDate
			self.eventTime = eventTime
			self.character = character
		end,
		
		GetExpiry = function(self)
			local year, month, day = strsplit("-", self.eventDate)
			local hour, minute = strsplit(":", self.eventTime)

			timeTable.year = tonumber(year)
			timeTable.month = tonumber(month)
			timeTable.day = tonumber(day)
			timeTable.hour = tonumber(hour)
			timeTable.min = tonumber(minute)

			local gap = 0
			if DataStore_Agenda then
				gap = DataStore:GetClientServerTimeGap()
			end
			
			return difftime(time(timeTable), time() + gap)	-- in seconds
		end,
		
		GetWarnings = function(self)
			-- Shared cooldown = same type as normal cooldown
			local warningType = (self.eventType == 5) and 1 or self.eventType

			-- Gets something like "15|5|1"
			return Altoholic_Calendar_Options[format("WarningType%d", warningType)]
		end,
		
		MarkForDeletion = function(self)
			self.markForDeletion = true
		end,
	})
	
	oop:Create("CooldownEventLine", { __inherits = "EventLine",
		Init = function(self, expiresAt, character, id, professionTable)
			self.EventLine.Init(self, 1, ExpiryDate(expiresAt), ExpiryTime(expiresAt), character)
			
			self.parentID = id
			self.source = professionTable
		end,
		
		GetInfo = function(self)
			local title, expiresIn = DataStore:GetCraftCooldownInfo(self.source, self.parentID)
			return title, format("%s %s", COOLDOWN_REMAINING, Formatter.TimeString(expiresIn))
		end,
		
		GetReadyNowWarning = function(self)
			local name = DataStore:GetCraftCooldownInfo(self.source, self.parentID)
			local _, realm, char = strsplit(".", self.character)
			local char, realm = GetCharInfo(self.character)
			
			return format(L["%s is now ready (%s on %s)"], name, char, realm)
		end,
		
		GetReadySoonWarning = function(self, minutes)
			local name = DataStore:GetCraftCooldownInfo(self.source, self.parentID)
			local char, realm = GetCharInfo(self.character)
			
			return format(L["%s will be ready in %d minutes (%s on %s)"], name, minutes, char, realm)
		end,
	})
	
	oop:Create("InstanceEventLine", { __inherits = "EventLine",
		Init = function(self, expiresAt, character, dungeonKey)
			self.EventLine.Init(self, 2, ExpiryDate(expiresAt), ExpiryTime(expiresAt), character)
			
			self.parentID = dungeonKey
			self.char2 = character
		end,
		
		GetInfo = function(self)
			-- title gets the instance name, desc gets the raid id
			local instanceName, raidID = strsplit("|", self.parentID)

			--	CALENDAR_EVENTNAME_FORMAT_RAID_LOCKOUT = "%s Unlocks"; -- %s = Raid Name
			return instanceName, format("%s%s\nID: %s%s", 
				colors.white,	format(CALENDAR_EVENTNAME_FORMAT_RAID_LOCKOUT, instanceName), 
				colors.green, raidID)
		end,
		
		GetReadyNowWarning = function(self)
			local instance = strsplit("|", self.parentID)
			local char, realm = GetCharInfo(self.character)
			
			return format(L["%s is now unlocked (%s on %s)"], instance, char, realm)
		end,
		
		GetReadySoonWarning = function(self, minutes)
			local instance = strsplit("|", self.parentID)
			local char, realm = GetCharInfo(self.character)
			
			return format(L["%s will be unlocked in %d minutes (%s on %s)"], instance, minutes, char, realm)
		end,
	})
	
	oop:Create("CalendarEventLine", { __inherits = "EventLine",
		Init = function(self, eventDate, eventTime, character, index)
			self.EventLine.Init(self, 3, eventDate, eventTime, character)
			
			self.parentID = index
		end,
		
		GetInfo = function(self)
			local _, _, title, eventType, inviteStatus = DataStore:GetCalendarEventInfo(self.character, self.parentID)

			inviteStatus = tonumber(inviteStatus)
			
			local desc
			if type(inviteStatus) == "number" and (inviteStatus > 1) and (inviteStatus < 8) then
				local StatusText = {
					CALENDAR_STATUS_INVITED,		-- CALENDAR_INVITESTATUS_INVITED   = 1
					CALENDAR_STATUS_ACCEPTED,		-- CALENDAR_INVITESTATUS_ACCEPTED  = 2
					CALENDAR_STATUS_DECLINED,		-- CALENDAR_INVITESTATUS_DECLINED  = 3
					CALENDAR_STATUS_CONFIRMED,		-- CALENDAR_INVITESTATUS_CONFIRMED = 4
					CALENDAR_STATUS_OUT,				-- CALENDAR_INVITESTATUS_OUT       = 5
					CALENDAR_STATUS_STANDBY,		-- CALENDAR_INVITESTATUS_STANDBY   = 6
					CALENDAR_STATUS_SIGNEDUP,		-- CALENDAR_INVITESTATUS_SIGNEDUP     = 7
					CALENDAR_STATUS_NOT_SIGNEDUP	-- CALENDAR_INVITESTATUS_NOT_SIGNEDUP = 8
				}
			
				desc = format("%s: %s%s", STATUS, colors.white, StatusText[inviteStatus]) 
			else 
				desc = format("%s", STATUS) 
			end

			return title, desc
		end,
		
		GetReadyNowWarning = function(self)
			local _, _, title = DataStore:GetCalendarEventInfo(self.character, self.parentID)
			local char, realm = GetCharInfo(self.character)
			
			return format("%s (%s/%s)", format(CALENDAR_EVENTNAME_FORMAT_START, title), char, realm)
		end,
		
		GetReadySoonWarning = function(self, minutes)
			local _, _, title = DataStore:GetCalendarEventInfo(self.character, self.parentID)
			local char, realm = GetCharInfo(self.character)
			
			return format(L["%s starts in %d minutes (%s on %s)"], title, minutes, char, realm)
		end,
	})
	
	oop:Create("TimerEventLine", { __inherits = "EventLine",
		Init = function(self, expiresAt, character, index)
			self.EventLine.Init(self, 4, ExpiryDate(expiresAt), ExpiryTime(expiresAt), character, GetTimerInfo)
			
			self.parentID = index
		end,
		
		GetInfo = function(self)
			local title = DataStore:GetItemCooldownInfo(self.character, self.parentID)
			local expiresIn = self:GetExpiry()
			
			return title, format("%s %s", COOLDOWN_REMAINING, Formatter.TimeString(expiresIn))
		end,
		
		GetReadyNowWarning = function(self)
			local item = DataStore:GetItemCooldownInfo(self.character, self.parentID)
			
			if item then
				local char, realm = GetCharInfo(self.character)
				return format(L["%s is now ready (%s on %s)"], item, char, realm)
			end
		end,
		
		GetReadySoonWarning = function(self, minutes)
			local item = DataStore:GetItemCooldownInfo(self.character, self.parentID)
			
			if item then
				local char, realm = GetCharInfo(self.character)
				return format(L["%s will be ready in %d minutes (%s on %s)"], item, minutes, char, realm)
			end
		end,
	})
	
	oop:Create("SharedCooldownEventLine", { __inherits = "EventLine",
		Init = function(self, expiresAt, character, professionName)
			self.EventLine.Init(self, 5, ExpiryDate(expiresAt), ExpiryTime(expiresAt), character, GetSharedCooldownInfo)
			
			self.source = professionName
		end,
		
		GetInfo = function(self)
			local expiresIn = self:GetExpiry()
			
			return self.source, format("%s %s", COOLDOWN_REMAINING, Formatter.TimeString(expiresIn))
		end,
		
		GetReadyNowWarning = function(self)
			local char, realm = GetCharInfo(self.character)
			return format(L["%s is now ready (%s on %s)"], self.source, char, realm)
		end,
		
		GetReadySoonWarning = function(self, minutes)
			local char, realm = GetCharInfo(self.character)
			return format(L["%s will be ready in %d minutes (%s on %s)"], self.source, minutes, char, realm)
		end,
	})

	local events = oop:New("SQLTable", "Events")

	local currentView = events
	
	local currentDate, currentEvent, currentChar
	-- local views = {
		-- ByDate = oop:New("SQLTableView", events, function(r) return r.eventDate == currentDate end),
		-- ByEvent = oop:New("SQLTableView", events, function(r) return r:GetInfo() == currentEvent end),
		-- ByOwner = oop:New("SQLTableView", events, function(r) return r.character == currentChar end),
	-- }
	
	local eventsView = oop:New("SQLTableView", events, function(r)
		if currentDate and r.eventDate ~= currentDate then return false end
		if currentEvent and r:GetInfo() ~= currentEvent then return false end
		if currentChar and r.character ~= currentChar then return false end
		
		return true
	end)

	local function BuildList()
		events:Delete()
		
		local timeGap = DataStore:GetClientServerTimeGap() or 0

		for account in pairs(DataStore:GetAccounts()) do
			for realm in pairs(DataStore:GetRealms(account)) do
				for characterName, character in pairs(DataStore:GetCharacters(realm, account)) do
					-- add all timers, even expired ones. Expiries will be handled elsewhere.
					
					-- Profession Cooldowns
					local professions = DataStore:GetProfessions(character)
					if professions then
						for professionName, profession in pairs(professions) do
							local supportsSharedCD
							if professionName == C_Spell.GetSpellName(2259) or			-- alchemy
								professionName == C_Spell.GetSpellName(3908) or 			-- tailoring
								professionName == C_Spell.GetSpellName(2575) then			-- mining
								supportsSharedCD = true		-- current profession supports shared cooldowns
							end
							
							if supportsSharedCD then
								local sharedCDFound		-- is there a shared cd for this profession ?
								for i = 1, DataStore:GetNumActiveCooldowns(profession) do
									local _, _, _, expiresAt = DataStore:GetCraftCooldownInfo(profession, i)

									if not sharedCDFound then
										sharedCDFound = true
										events:Insert(oop:New("SharedCooldownEventLine", expiresAt, character, professionName))
									end
								end
							else
								for i = 1, DataStore:GetNumActiveCooldowns(profession) do
									local _, _, _, expiresAt = DataStore:GetCraftCooldownInfo(profession, i)
									events:Insert(oop:New("CooldownEventLine", expiresAt, character, i, profession))
								end
							end
						end
					end
					
					-- Saved Instances
					local dungeons = DataStore:GetSavedInstances(character)
					if dungeons then
						for key, _ in pairs(dungeons) do
							local reset, lastCheck = DataStore:GetSavedInstanceInfo(character, key)
							local expires = reset + lastCheck + timeGap

							events:Insert(oop:New("InstanceEventLine", expires, character, key))
						end
					end
					
					-- Calendar Events
					local num = DataStore:GetNumCalendarEvents(character) or 0 
					for i = 1, num do
						local eventDate, eventTime = DataStore:GetCalendarEventInfo(character, i)
						
						-- TODO: do not add declined invitations
						events:Insert(oop:New("CalendarEventLine", eventDate, eventTime, character, i))
					end
					
					-- Other timers (like mysterious egg, etc..)
					num = DataStore:GetNumItemCooldowns(character) or 0
					for i = 1, num do
						local _, lastCheck, duration = DataStore:GetItemCooldownInfo(character, i)
						-- checked in datastore, these should always be numeric
						-- lastCheck = lastCheck or 0
						-- duration = duration or 0

						local expires = duration + lastCheck + timeGap
						
						events:Insert(oop:New("TimerEventLine", expiresAt, character, i))
					end
				end
			end
		end

		-- sort by date first, then by hour, then by alt
		events:Sort("eventDate", "asc", "eventTime", "asc", "character", "asc")
	end

	return {
		Initialize = function()
			events:Delete()
		end,
		SetView = function(viewDate, viewEvent, viewChar)
			currentDate = viewDate
			currentEvent = viewEvent
			currentChar = viewChar
			
			if not currentDate and not currentEvent and not currentChar then
				currentView = events
			else
				eventsView:Update()
				currentView = eventsView
			end
		end,

		BuildList = BuildList,
		
		GetEvents = function()
			return currentView:GetData()
		end,
		GetEventInfo = function(event)
			local name = DataStore:GetColoredCharacterName(event.character)
			local _, realm = GetCharInfo(event.character)
			
			if realm ~= DataStore.ThisRealm then	-- different realm ?
				name = format("%s %s(%s)", name, colors.green, realm)
			end
			
			local title, desc = event:GetInfo(event)

			return name, event.eventTime, title, desc
		end,
		
		GetEventOwners = function()
			local out = {}
			
			events:IterateRows(function(r) 
				out[r.character] = true
			end)
			
			return DataStore:HashToSortedArray(out)
		end,
		GetEventDates = function()
			return events:SelectDistinct("eventDate")
		end,
		GetEventNames = function()
			local out = {}
			
			events:IterateRows(function(r) 
				local title = r.GetInfo(r)
				out[title] = true
			end)
			
			return DataStore:HashToSortedArray(out)
		end,
		
		GetDayCount = function(year, month, day)
			-- returns the number of events on a given day
			local eventDate = format("%04d-%02d-%02d", year, month, day)
			return events:Count(function(r) return r.eventDate == eventDate end)
		end,

		-- ** Deletion **

		ClearMarkedEvents = function()
			events:Delete(function(r) return r.markForDeletion == true end)
		end,
		
	}
	
end})

addon:Service("AltoholicUI.Events", { "AltoholicUI.EventsList", function(EventsList) 

	local timerThresholds = { 30, 15, 10, 5, 4, 3, 2, 1 }

	local function WarningsEnabled()
		return Altoholic_Calendar_Options["WarningsEnabled"]
	end

	local function IsNumberInString(number, str)
		-- ex: with str = "15|10|3" returns true if value is in this string
		for v in str:gmatch("(%d+)") do
			if tonumber(v) == number then
				return true
			end
		end
	end
	
	local function ShowExpiryWarning(event, minutes)
		local warning = minutes == 0
			and event:GetReadyNowWarning()
			or event:GetReadySoonWarning(minutes)
		
		if not warning then return end
		
		-- print instead of dialog box if player is in combat
		if Altoholic_Calendar_Options["UseDialogBoxForWarnings"] and not UnitAffectingCombat("player") then
			
			AltoMessageBox:Ask(format("%s%s\n%s", colors.white, warning, L["Do you want to open Altoholic's calendar for details ?"]), function()
				
				AltoholicFrame:ToggleUI()
				AltoholicFrame:SwitchToTab("Agenda")
				-- AltoholicFrame.TabCharacters.CategoriesList:ClickCategory("key", character)
				-- AltoholicFrame.TabCharacters:ShowPanel("Agenda")
			end)
			
		else
			addon:Print(warning)
		end
	end
	
	local function InitialExpiryCheck()
		-- browse all events
		for _, event in pairs(EventsList.GetEvents()) do
			local expiresIn = event:GetExpiry()
			
			if expiresIn < 0 then			-- if the event has expired
				event:MarkForDeletion()		-- .. mark it for deletion (no table.remove in this pass, to avoid messing up indexes)
				
				-- only report if warnings are enabled
				if WarningsEnabled() then
					ShowExpiryWarning(event, 0)		-- .. and do the appropriate warning
				end
			end
		end
		
		EventsList.ClearMarkedEvents()
	end
	
	local function ClearExpiredEvents()

		for account in pairs(DataStore:GetAccounts()) do
			for realm in pairs(DataStore:GetRealms(account)) do
				for characterName, character in pairs(DataStore:GetCharacters(realm, account)) do
					-- Profession Cooldowns
					local professions = DataStore:GetProfessions(character)
					if professions then
						for professionName, profession in pairs(professions) do
							DataStore:ClearExpiredCooldowns(profession)
						end
					end
					
					-- Saved Instances
					local dungeons = DataStore:GetSavedInstances(character)
					if dungeons then
						for key, _ in pairs(dungeons) do
							if DataStore:HasSavedInstanceExpired(character, key) then
								DataStore:DeleteSavedInstance(character, key)
							end
						end
					end
					
					-- Other timers (like mysterious egg, etc..)
					local num = DataStore:GetNumItemCooldowns(character) or 0
					for i = num, 1, -1 do
						if DataStore:HasItemCooldownExpired(character, i) then
							DataStore:DeleteItemCooldown(character, i)
						end
					end
					
					-- Calendar events 
					num = DataStore:GetNumCalendarEvents(character) or 0 
					for i = num, 1, -1 do
						if DataStore:HasCalendarEventExpired(character, i) then
							DataStore:DeleteCalendarEvent(character, i)
						end
					end
				end
			end
		end
	end

	local function CheckExpiries()
		-- warning here, check the value of self, the elapsed parameter seems wrong, double check this !
		C_Timer.After(60, CheckExpiries)	-- repeating timer
		if not WarningsEnabled() then	-- warnings disabled ? do nothing
			return
		end

		-- called every 60 seconds
		local hasExpired
		
		for _, event in pairs(EventsList.GetEvents()) do
			local minutes = floor(event:GetExpiry() / 60)

			if minutes > -1440 and minutes < 0 then		-- expiry older than 1 day is ignored
				hasExpired = true		-- at least one event has expired
				
			elseif minutes == 0 then
				ShowExpiryWarning(event, 0)
				hasExpired = true		-- at least one event has expired
				
			elseif minutes > 0 and minutes <= 30 then
				for _, threshold in pairs(timerThresholds) do
					if threshold == minutes then			-- if snooze is allowed for this value
						if IsNumberInString(threshold, event:GetWarnings()) then
							ShowExpiryWarning(event, minutes)
						end
						break
						
					-- save some cpu cycles, exit if threshold too low
					elseif threshold < minutes then
						break
					end
				end
			end
		end
		
		-- if at least one event has expired, rebuild the list & Update
		if hasExpired then
			ClearExpiredEvents()
			EventsList.BuildList()
			
			DataStore:Broadcast("ALTOHOLIC_EVENT_EXPIRY")
		end
	end
	
	return {
		Initialize = function(self)
			DataStore:ListenTo("DATASTORE_CS_TIMEGAP_FOUND", function() 
				-- once the Client-Server time gap is known, check for expiries every 60 seconds
				C_Timer.After(60, CheckExpiries)
			end)
		
			-- Sequence of operations : 
			EventsList.BuildList()					-- 1. Build a list of events
			InitialExpiryCheck()						-- 2. Check for expiries + Warning
			ClearExpiredEvents()						-- 3. Clear expiries
			EventsList.BuildList()					-- 4. Rebuild the list of events
		end,
		BuildList = EventsList.BuildList,
	
		GetTimerThresholds = function() return timerThresholds end,
		
		GetList = function() return EventsList.GetEvents() end,
	}
end})
