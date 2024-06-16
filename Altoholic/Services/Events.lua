local addonName, addon = ...
local colors = addon.Colors

local L = DataStore:GetLocale(addonName)

addon:Service("AltoholicUI.EventsList", { "AltoholicUI.Formatter", function(Formatter) 

	local timeTable = {}				-- to pass as an argument to time()	see http://lua-users.org/wiki/OsLibraryTutorial for details
	
	local function GetEventExpiry(event)
		-- returns the number of seconds in which a calendar event expires
		assert(type(event) == "table")

		local year, month, day = strsplit("-", event.eventDate)
		local hour, minute = strsplit(":", event.eventTime)

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
	end
	
	-- ** Constants / Event Types **
	local COOLDOWN_LINE = 1
	local INSTANCE_LINE = 2
	local CALENDAR_LINE = 3
	local TIMER_LINE = 4
	local SHARED_CD_LINE = 5		-- this type is used for shared cooldowns (alchemy, etc..) among others.

	local events
	
	local function GetCooldownInfo(event)
		local title, expiresIn = DataStore:GetCraftCooldownInfo(event.source, event.parentID)
		
		return title, format("%s %s", COOLDOWN_REMAINING, Formatter.TimeString(expiresIn))
	end
	
	local function GetInstanceInfo(event)
		-- title gets the instance name, desc gets the raid id
		local instanceName, raidID = strsplit("|", event.parentID)

		--	CALENDAR_EVENTNAME_FORMAT_RAID_LOCKOUT = "%s Unlocks"; -- %s = Raid Name
		return instanceName, format("%s%s\nID: %s%s", 
			colors.white,	format(CALENDAR_EVENTNAME_FORMAT_RAID_LOCKOUT, instanceName), 
			colors.green, raidID)
	end
	
	local function GetCalendarInfo(event)
		local character = DataStore:GetCharacter(event.char, event.realm)
		local _, _, title, eventType, inviteStatus = DataStore:GetCalendarEventInfo(character, event.parentID)

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
	end
	
	local function GetTimerInfo(event)
		local character = DataStore:GetCharacter(event.char, event.realm)
		local title = DataStore:GetItemCooldownInfo(character, event.parentID)
		local expiresIn = GetEventExpiry(event)
		
		return title, format("%s %s", COOLDOWN_REMAINING, Formatter.TimeString(expiresIn))
	end
	
	local function GetSharedCooldownInfo(event)
		local expiresIn = GetEventExpiry(event)
		
		return event.source, format("%s %s", COOLDOWN_REMAINING, Formatter.TimeString(expiresIn))
	end

	return {
		Initialize = function()
			events = events or {}
			wipe(events)
		end,
		GetEvents = function() return events end,
		GetEvent = function(index) return events[index] end,
		GetEventInfo = function(index)
			local event = events[index]		-- dereference event
			if not event then return end
			
			local character = DataStore:GetCharacter(event.char, event.realm, event.account)
			local char = DataStore:GetColoredCharacterName(character)
			
			if event.realm ~= DataStore.ThisRealm then	-- different realm ?
				char = format("%s %s(%s)", char, colors.green, event.realm)
			end
			
			local title, desc = event.GetInfo(event)

			return char, event.eventTime, title, desc
		end,
		GetExpiry = function(index)
			return GetEventExpiry(events[index])
		end,
		
		GetDayCount = function(year, month, day)
			-- returns the number of events on a given day
			
			local eventDate = format("%04d-%02d-%02d", year, month, day)
			local count = 0
			
			for index, event in pairs(events) do
				if event.eventDate == eventDate then
					count = count + 1
				end
			end
			
			return count
		end,
		
		AddCooldownLine = function(expiresAt, characterName, realm, account, id, professionTable)
			table.insert(events, { 
				eventType = COOLDOWN_LINE, 
				eventDate = date("%Y-%m-%d", expiresAt), 
				eventTime = date("%H:%M", expiresAt), 
				GetInfo = GetCooldownInfo,
				char = characterName,
				realm = realm,
				account = account,
				parentID = id,
				source = professionTable
			})
		end,
		AddInstanceLine = function(expiresAt, characterName, realm, account, dungeonKey)
			table.insert(events, { 
				eventType = INSTANCE_LINE, 
				eventDate = date("%Y-%m-%d", expiresAt), 
				eventTime = date("%H:%M", expiresAt), 
				GetInfo = GetInstanceInfo,
				char = characterName,
				realm = realm,
				account = account,
				parentID = dungeonKey,
				-- source = nil
			})
		end,
		AddCalendarLine = function(eventDate, eventTime, characterName, realm, account, index)
			table.insert(events, { 
				eventType = CALENDAR_LINE, 
				eventDate = eventDate, 
				eventTime = eventTime, 
				GetInfo = GetCalendarInfo,
				char = characterName,
				realm = realm,
				account = account,
				parentID = index,
				-- source = nil
			})
		end,
		AddTimerLine = function(expiresAt, characterName, realm, account, index)
			table.insert(events, { 
				eventType = TIMER_LINE, 
				eventDate = date("%Y-%m-%d", expiresAt), 
				eventTime = date("%H:%M", expiresAt), 
				GetInfo = GetTimerInfo,
				char = characterName,
				realm = realm,
				account = account,
				parentID = index,
				-- source = nil
			})
		end,
		AddSharedCooldown = function(expiresAt, characterName, realm, account, professionName)
			table.insert(events, { 
				eventType = SHARED_CD_LINE, 
				eventDate = date("%Y-%m-%d", expiresAt), 
				eventTime = date("%H:%M", expiresAt), 
				GetInfo = GetSharedCooldownInfo,
				char = characterName,
				realm = realm,
				account = account,
				-- parentID = nil,
				source = professionName
			})
		end,

		SortByTime = function()
			table.sort(events, function(a, b)
				if (a.eventDate ~= b.eventDate) then			-- sort by date first ..
					return a.eventDate < b.eventDate
					
				elseif (a.eventTime ~= b.eventTime) then		-- .. then by hour
					return a.eventTime < b.eventTime
					
				elseif (a.char ~= b.char) then					-- .. then by alt
					return a.char < b.char
				end
			end)
		end,

		-- ** Warnings **
		GetWarnings = function(index)
			local event = events[index]
			
			if event then
				-- shared cooldown = same type as normal cooldown
				local warningType = (event.eventType == SHARED_CD_LINE) and COOLDOWN_LINE or event.eventType
				-- Gets something like "15|5|1"

				return Altoholic_Calendar_Options[format("WarningType%d", warningType)]
			end
		end,
		GetReadyNowWarning = function(index)
			local event = events[index]
		
			if event.eventType == COOLDOWN_LINE then
				local name = DataStore:GetCraftCooldownInfo(event.source, event.parentID)
				return format(L["%s is now ready (%s on %s)"], name, event.char, event.realm)

			elseif event.eventType == INSTANCE_LINE then
				local instance = strsplit("|", event.parentID)
				return format(L["%s is now unlocked (%s on %s)"], instance, event.char, event.realm)
				
			elseif event.eventType == CALENDAR_LINE then
				local character = DataStore:GetCharacter(event.char, event.realm)
				local _, _, title = DataStore:GetCalendarEventInfo(character, event.parentID)
				
				return format("%s (%s/%s)", format(CALENDAR_EVENTNAME_FORMAT_START, title), event.char, event.realm)
				
			elseif event.eventType == TIMER_LINE then
				local character = DataStore:GetCharacter(event.char, event.realm)
				local item = DataStore:GetItemCooldownInfo(character, event.parentID)
				
				if item then
					return format(L["%s is now ready (%s on %s)"], item, event.char, event.realm)
				end
				
			elseif event.eventType == SHARED_CD_LINE then
				
				return format(L["%s is now ready (%s on %s)"], event.source, event.char, event.realm)
			end
		end,
		GetReadySoonWarning = function(index, minutes)
			local event = events[index]
			
			if event.eventType == COOLDOWN_LINE then
				local name = DataStore:GetCraftCooldownInfo(event.source, event.parentID)
				return format(L["%s will be ready in %d minutes (%s on %s)"], name, minutes, event.char, event.realm)

			elseif event.eventType == INSTANCE_LINE then
				local instance = strsplit("|", event.parentID)
				return format(L["%s will be unlocked in %d minutes (%s on %s)"], instance, minutes, event.char, event.realm)
				
			elseif event.eventType == CALENDAR_LINE then
				local character = DataStore:GetCharacter(event.char, event.realm)
				local _, _, title = DataStore:GetCalendarEventInfo(character, event.parentID)
				
				return format(L["%s starts in %d minutes (%s on %s)"], title, minutes, event.char, event.realm)
				
			elseif event.eventType == TIMER_LINE then
				local character = DataStore:GetCharacter(event.char, event.realm)
				local item = DataStore:GetItemCooldownInfo(character, event.parentID)
				
				if item then
					return format(L["%s will be ready in %d minutes (%s on %s)"], item, minutes, event.char, event.realm)
				end
				
			elseif event.eventType == SHARED_CD_LINE then
				
				return format(L["%s will be ready in %d minutes (%s on %s)"], event.source, minutes, event.char, event.realm)
			end
		end,
		
		-- ** Deletion **
		MarkForDeletion = function(i)
			events[i].markForDeletion = true		
		end,
		ClearMarkedEvents = function()
			for i = #events, 1, -1 do			-- browse the event table backwards
				if events[i].markForDeletion then	-- erase marked events
					table.remove(events, i)
				end
			end
		
		end,
	}
end})

addon:Service("AltoholicUI.Events", { "AltoholicUI.EventsList", function(EventsList) 

	local timerThresholds = { 30, 15, 10, 5, 4, 3, 2, 1 }

	local function IsNumberInString(number, str)
		-- ex: with str = "15|10|3" returns true if value is in this string
		for v in str:gmatch("(%d+)") do
			if tonumber(v) == number then
				return true
			end
		end
	end
	
	local function ShowExpiryWarning(index, minutes)
		local warning
		
		if minutes == 0 then
			warning = EventsList.GetReadyNowWarning(index)
		else
			warning = EventsList.GetReadySoonWarning(index, minutes)
		end
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
		local events = EventsList.GetEvents()
	
		for index, event in pairs(events) do			-- browse all events
			local expiresIn = EventsList.GetExpiry(index)
			
			if expiresIn < 0 then							-- if the event has expired
				EventsList.MarkForDeletion(index)		-- .. mark it for deletion (no table.remove in this pass, to avoid messing up indexes)
				
				-- only report if warnings are enabled
				if Altoholic_Calendar_Options["WarningsEnabled"] == true then
					ShowExpiryWarning(index, 0)		-- .. and do the appropriate warning
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

	local function BuildList()
		EventsList.Initialize()
		
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
							if professionName == GetSpellInfo(2259) or			-- alchemy
								professionName == GetSpellInfo(3908) or 			-- tailoring
								professionName == GetSpellInfo(2575) then			-- mining
								supportsSharedCD = true		-- current profession supports shared cooldowns
							end
							
							if supportsSharedCD then
								local sharedCDFound		-- is there a shared cd for this profession ?
								for i = 1, DataStore:GetNumActiveCooldowns(profession) do
									local _, _, _, expiresAt = DataStore:GetCraftCooldownInfo(profession, i)

									if not sharedCDFound then
										sharedCDFound = true
										EventsList.AddSharedCooldown(expiresAt, characterName, realm, account, professionName)
									end
								end
							else
								for i = 1, DataStore:GetNumActiveCooldowns(profession) do
									local _, _, _, expiresAt = DataStore:GetCraftCooldownInfo(profession, i)
									EventsList.AddCooldownLine(expiresAt, characterName, realm, account, i, profession)
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
							
							EventsList.AddInstanceLine(expires, characterName, realm, account, key)
						end
					end
					
					-- Calendar Events
					local num = DataStore:GetNumCalendarEvents(character) or 0 
					for i = 1, num do
						local eventDate, eventTime = DataStore:GetCalendarEventInfo(character, i)
						
						-- TODO: do not add declined invitations
						EventsList.AddCalendarLine(eventDate, eventTime, characterName, realm, account, i)
					end
					
					-- Other timers (like mysterious egg, etc..)
					num = DataStore:GetNumItemCooldowns(character) or 0
					for i = 1, num do
						local _, lastCheck, duration = DataStore:GetItemCooldownInfo(character, i)
						if duration == nil then
							duration = 0
						end
						if lastCheck == nil then
							lastCheck = 0
						end
						local expires = duration + lastCheck + timeGap
						
						EventsList.AddTimerLine(expires, characterName, realm, account, i)
					end
				end
			end
		end

		EventsList.SortByTime()
	end
	
	local function CheckExpiries()
		-- warning here, check the value of self, the elapsed parameter seems wrong, double check this !
		C_Timer.After(60, CheckExpiries)	-- repeating timer
		if Altoholic_Calendar_Options["WarningsEnabled"] == false then	-- warnings disabled ? do nothing
			return
		end

		-- called every 60 seconds
		local hasExpired
		
		for index, event in pairs(EventsList.GetEvents()) do
			local minutes = floor(EventsList.GetExpiry(index) / 60)

			if minutes > -1440 and minutes < 0 then		-- expiry older than 1 day is ignored
				hasExpired = true		-- at least one event has expired
				
			elseif minutes == 0 then
				ShowExpiryWarning(index, 0)
				hasExpired = true		-- at least one event has expired
				
			elseif minutes > 0 and minutes <= 30 then
				for _, threshold in pairs(timerThresholds) do
					if threshold == minutes then			-- if snooze is allowed for this value
						if IsNumberInString(threshold, EventsList.GetWarnings(index)) then
							ShowExpiryWarning(index, minutes)
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
			BuildList()
			
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
			BuildList()									-- 1. Build a list of events
			InitialExpiryCheck()						-- 2. Check for expiries  + Warning
			ClearExpiredEvents()						-- 3. Clear expiries
			BuildList()									-- 4. Rebuild the list of events
		end,
		BuildList = BuildList,
	
		GetTimerThresholds = function() return timerThresholds end,
		
		GetList = function() return EventsList.GetEvents() end,
	}
end})

