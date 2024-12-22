local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

local L = AddonFactory:GetLocale(addonName)

local function GetMemoryUsage(addons)
	collectgarbage()
	UpdateAddOnMemoryUsage()

	local totalMem = 0
	local list = "\n\n"

	for _, module in ipairs(addons) do
		local text
		
		if C_AddOns.IsAddOnLoaded(module) then	-- module is enabled
			local memInKb = GetAddOnMemoryUsage(module)
			totalMem = totalMem + memInKb
			
			if memInKb < 1024 then
				text = format("     %s: |r%s%.0f |r%sKB|r", module, colors.green, memInKb, colors.white)
			else
				text = format("     %s: |r%s%.2f |r%sMB|r", module, colors.green, memInKb/1024, colors.white)
			end
		else	-- module is disabled
			text = format("     %s: %s%s|r", module, colors.red, L["TAB_NOT_LOADED_YET"])
		end
		
		list = format("%s%s\n", list, text)
	end
	
	local totalText = format(L["ADDON_MEMORY_USED"], colors.cyan, DataStore:GetNumCharactersInDB())
	
	list = format("     %s\n%s %s", list, totalText, format("%s%.2f %sMB", colors.green, totalMem/1024, colors.white))
	
	return list
end

local dataStoreModules = {
	"DataStore",
	"DataStore_Achievements",
	"DataStore_Agenda",
	"DataStore_Auctions",
	"DataStore_Characters",
	"DataStore_Containers",
	"DataStore_Crafts",
	"DataStore_Currencies",
	"DataStore_Garrisons",
	"DataStore_Inventory",
	"DataStore_Mails",
	"DataStore_Pets",
	"DataStore_Quests",
	"DataStore_Reputations",
	"DataStore_Spells",
	"DataStore_Stats",
	"DataStore_Talents",
}

local altoholicModules = {
	"AddonFactory",
	"Altoholic",
	"Altoholic_Summary",
	"Altoholic_Characters",
	"Altoholic_Search",
	"Altoholic_Guild",
	"Altoholic_Achievements",
	"Altoholic_Agenda",
	"Altoholic_Grids",
	"Altoholic_Options",
}

local function SetTitle(arg1, arg2, arg3)
	return (arg3)
		and format("%s%s|r / %s%s|r / %s%s", colors.white, arg1, colors.white, arg2, colors.green, arg3)
		or format("%s%s|r / %s%s", colors.white, arg1, colors.green, arg2)
end

local helpProfiles = {
	[1] = { title = SetTitle(HELP_LABEL, L["Account Sharing"]), content = L["HELP_SHARING_HOWTO"] },
	[2] = { title = SetTitle(HELP_LABEL, addonName, GENERAL), content = L["HELP_ALTOHOLIC_GENERAL"] },
	[3] = { title = SetTitle(HELP_LABEL, addonName, L["Characters"]), content = L["HELP_ALTOHOLIC_CHARACTERS"] },
	[4] = { title = SetTitle(HELP_LABEL, "DataStore", GENERAL), content = L["HELP_DATASTORE_GENERAL"] },
	[5] = { title = SetTitle(HELP_LABEL, "DataStore", L["Saved Variables"]), content = L["HELP_DATASTORE_SAVEDVARS"] },
	[6] = { title = SetTitle(HELP_LABEL, L["Getting support"]), content = L["HELP_GETTING_SUPPORT"] },
	[7] = { title = SetTitle(L["About"], addonName), content = L["ABOUT_ALTOHOLIC"] },
	[8] = { title = SetTitle(L["About"], "DataStore"), content = L["ABOUT_DATASTORE"] },
	[9] = { title = SetTitle(L["Memory used"], addonName), content = function() return GetMemoryUsage(altoholicModules) end },
	[10] = { title = SetTitle(L["Memory used"], "DataStore"), content = function() return GetMemoryUsage(dataStoreModules) end },
	[11] = { title = SetTitle(HELP_LABEL, addonName, L["Bank characters"]), content = L["HELP_ALTOHOLIC_BANKCHARACTERS"] },
	[12] = { title = SetTitle(HELP_LABEL, addonName, L["Alt groups"]), content = L["HELP_ALTOHOLIC_ALTGROUPS"] },
	[13] = { title = SetTitle(HELP_LABEL, addonName, SEARCH), content = L["HELP_ALTOHOLIC_SEARCH"] },
}

local currentProfile

addon:Controller("AltoholicUI.TabOptions.Help", { 
	OnBind = function(frame)
		-- Attach to the parent
		local parent = AltoholicFrame.TabOptions
		
		frame:SetParent(parent)
		frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
		frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
		parent:RegisterPanel(30, frame)
	end,
	
	SetHelp = function(frame, helpID)
		currentProfile = helpID
	end,
	Update = function(frame, isResizing)
		local profile = helpProfiles[currentProfile]
		if not profile then return end
	
		frame.Title:SetText(profile.title)
		if type(profile.content) == "function" then
			frame.Content:SetText(profile.content())
		else
			frame.Content:SetText(profile.content)
		end
		
		frame:Show()
	end,
})
