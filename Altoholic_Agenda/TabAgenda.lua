local addonName = "Altoholic"
local addon = _G[addonName]
local L = AddonFactory:GetLocale(addonName)

local tab		-- small shortcut to easily address the frame (set in OnBind)

addon:Controller("AltoholicUI.TabAgenda", { "AddonFactory.Classes", "AltoholicUI.Events", "AltoholicUI.EventsList", "AddonFactory.Dates", function(oop, Events, EventsList, Dates)

	local currentPanelKey = "Calendar"
	
	local currentDate, currentEvent, currentChar

	local function UpdateEventList()
		local Calendar = tab.Panels["Calendar"]
		Calendar.EventList:InvalidateView()
		Calendar:InvalidateView()
		
		tab:Update()
	end

	local function OnCalendarDataUpdated(event, itemID)
		Events.BuildList()
		UpdateEventList()
	end

	local function OnCharacterFilterChange(frame)
		currentChar = frame.value ~= ALL and frame.value or nil
		
		EventsList.SetView(currentDate, currentEvent, currentChar)
		UpdateEventList()
	end

	local function OnDateFilterChange(frame)
		currentDate = frame.value ~= ALL and frame.value or nil
		
		EventsList.SetView(currentDate, currentEvent, currentChar)
		UpdateEventList()
	end

	local function OnEventFilterChange(frame)
		currentEvent = frame.value ~= ALL and frame.value or nil
		
		EventsList.SetView(currentDate, currentEvent, currentChar)
		UpdateEventList()
	end

	local function CharacterFilterIcon_Initialize(frame, level)
		frame:AddTitle(L["Character Filter"])
		frame:AddButton(ALL, nil, OnCharacterFilterChange, nil, (currentChar == nil))
		frame:AddTitle()
		
		for _, character in ipairs(EventsList.GetEventOwners()) do
			local name = DataStore:GetColoredCharacterName(character)
		
			frame:AddButton(name, character, OnCharacterFilterChange, nil, (currentChar == character))
		end
		
		frame:AddCloseMenu()
	end

	local function DateFilterIcon_Initialize(frame, level)
		frame:AddTitle(L["Date Filter"])
		frame:AddButton(ALL, nil, OnDateFilterChange, nil, (currentDate == nil))
		frame:AddTitle()
		
		for _, eventDay in ipairs(EventsList.GetEventDates()) do
			frame:AddButton(Dates.GetFullDateFromString(eventDay), eventDay, OnDateFilterChange, nil, (currentDate == eventDay))
		end
		
		frame:AddCloseMenu()
	end

	local function EventFilterIcon_Initialize(frame, level)
		frame:AddTitle(L["Event Filter"])
		frame:AddButton(ALL, nil, OnEventFilterChange, nil, (currentEvent == nil))
		frame:AddTitle()
		
		for _, name in ipairs(EventsList.GetEventNames()) do
			frame:AddButton(name, name, OnEventFilterChange, nil, (currentEvent == name))
		end
		
		frame:AddCloseMenu()
	end

	local menuIconCallbacks = {
		CharacterFilterIcon_Initialize,
		DateFilterIcon_Initialize,
		EventFilterIcon_Initialize,
	}

	return oop:New("AuctionHouseUI.Tab", {
		OnBind = function(frame)
			tab = frame

			DataStore:ListenTo("DATASTORE_PROFESSION_COOLDOWN_UPDATED", OnCalendarDataUpdated)
			DataStore:ListenTo("DATASTORE_ITEM_COOLDOWN_UPDATED", OnCalendarDataUpdated)
			DataStore:ListenTo("DATASTORE_CALENDAR_SCANNED", OnCalendarDataUpdated)
			DataStore:ListenTo("DATASTORE_DUNGEON_IDS_SCANNED", OnCalendarDataUpdated)
			DataStore:ListenTo("DATASTORE_DUNGEON_SCANNED", OnCalendarDataUpdated)
			DataStore:ListenTo("ALTOHOLIC_EVENT_EXPIRY", OnCalendarDataUpdated)
		end,
		FilterIcon_OnEnter = function(frame, icon)
			local currentMenuID = icon:GetID()
			
			local menu = frame.ContextualMenu
			
			menu:Initialize(menuIconCallbacks[currentMenuID], "LIST")
			menu:Close()
			menu:Toggle(icon, 0, 0)
		end,
	})

end})

local function categoriesList_OnClick(categoryData)
	-- tab:InitializeGrid(categoryData.menuID)
	tab:Update()
end


addon:Controller("AltoholicUI.TabAgendaCategoriesList", {
	OnBind = function(frame)
		local categories = {
			{ text = L["Calendar"], callback = categoriesList_OnClick, menuID = 1 },
		}
		
		frame:SetCategories(categories)
	end,

})