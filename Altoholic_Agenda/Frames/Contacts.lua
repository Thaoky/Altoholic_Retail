local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local parent = "AltoholicFrameContacts"

addon.Contacts = {}

local ns = addon.Contacts		-- ns = namespace

local view
local isViewValid

local function BuildView()
	view = view or {}
	wipe(view)
	
	-- the following list of events : 10/05, 10/05, 12/05, 14/05, 14/05
	-- turns into this view : 
	-- 	"10/05"
	--	event 1
	--	event 2
	--	"12/05"
	--	event 1
	-- 	"14/05"
	--	event 1
	--	event 2
	
	
	-- addon.Events:BuildList()
	
	-- local eventDate = ""
	-- for k, v in pairs(addon.Events:GetList()) do
		-- if eventDate ~= v.eventDate then
			-- table.insert(view, { linetype = EVENT_DATE, eventDate = v.eventDate })
			-- eventDate = v.eventDate
		-- end
		-- table.insert(view, { linetype = EVENT_INFO, parentID = k })
	-- end
	
	isViewValid = true
end

function ns:Update()
end

function ns:OnLoad()
	-- addon.Tabs.Agenda:RegisterChildPane(ns)
end

function ns:InvalidateView()
	isViewValid = nil
	if _G[ parent ]:IsVisible() then
		ns:Update()
	end
end
