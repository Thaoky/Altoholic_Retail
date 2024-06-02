local addonName = "Altoholic"
local addon = _G[addonName]
local L = DataStore:GetLocale(addonName)

addon:Controller("AltoholicUI.TabAgenda", { "AltoholicUI.Events", function(Events)

	local tab		-- small shortcut to easily address the frame (set in OnBind)
	local currentPanelKey = "Calendar"

	local function OnCalendarDataUpdated(event, itemID)
		Events.BuildList()
		
		local Calendar = tab.Panels["Calendar"]
		Calendar.EventList:InvalidateView()
		Calendar:InvalidateView()
		
		tab:Update()
	end

	return {
		OnBind = function(frame)
			tab = frame

			DataStore:ListenTo("DATASTORE_PROFESSION_COOLDOWN_UPDATED", OnCalendarDataUpdated)
			DataStore:ListenTo("DATASTORE_ITEM_COOLDOWN_UPDATED", OnCalendarDataUpdated)
			DataStore:ListenTo("DATASTORE_CALENDAR_SCANNED", OnCalendarDataUpdated)
			DataStore:ListenTo("DATASTORE_DUNGEON_IDS_SCANNED", OnCalendarDataUpdated)
			DataStore:ListenTo("DATASTORE_DUNGEON_SCANNED", OnCalendarDataUpdated)
			DataStore:ListenTo("ALTOHOLIC_EVENT_EXPIRY", OnCalendarDataUpdated)
		end,
		
		-- ** Panels **
		RegisterPanel = function(frame, key, panel)
			-- a simple list of all the child frames
			frame.Panels = frame.Panels or {}
			frame.Panels[key] = panel
		end,
		HideAllPanels = function(frame)
			for _, panel in pairs(frame.Panels) do
				panel:Hide()
			end
		end,
		ShowPanel = function(frame, panelKey)
			if not panelKey then return end
			
			currentPanelKey = panelKey
			
			frame:HideAllPanels()
			
			local panel = frame.Panels[currentPanelKey]
			
			panel:Show()
			if panel.PreUpdate then
				panel:PreUpdate()
			end
			panel:Update()
		end,

		Update = function(frame)
			frame:ShowPanel(currentPanelKey)
		end,
	}
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