local addonName, addon = ...
_G[addonName] = addon

addon.Version = "v11.2.006"
-- addon.VersionNum = 11 00 007
addon.VersionNum = 1102006

LibStub("LibMVC-1.0"):Embed(addon)

local L = AddonFactory:GetLocale(addonName)
local LibSerialize = LibStub:GetLibrary("LibSerialize")
local commPrefix = addonName

AddonFactory:AddKeyBinding("ALTOHOLIC", addonName, "Altoholic - Toggle UI")

local colors = AddonFactory.Colors

addon.TradeSkills = {
	Recipes = {},
	-- spell IDs in alphabetical order (english), primary then secondary
	spellIDs = { 2259, 3100, 7411, 4036, 45357, 25229, 2108, 2656, 3908, 2550 },
	firstSecondarySkillIndex = 10, -- index of the first secondary profession in the table
	
	AccountSummaryFiltersSpellIDs = { 2259, 3100, 7411, 4036, 2366, 45357, 25229, 2108, 2575, 8613, 3908, 2550, 131474, 78670 },
	AccountSummaryFirstSecondarySkillIndex = 12, -- index of the first secondary profession in the table
		
	Names = {
		ALCHEMY = C_Spell.GetSpellName(2259),
		ARCHAEOLOGY = C_Spell.GetSpellName(78670),
		BLACKSMITHING = C_Spell.GetSpellName(3100),
		COOKING = C_Spell.GetSpellName(2550),
		ENCHANTING = C_Spell.GetSpellName(7411),
		ENGINEERING = C_Spell.GetSpellName(4036),
		FISHING = C_Spell.GetSpellName(131474),
		HERBALISM = C_Spell.GetSpellName(2366),
		INSCRIPTION = C_Spell.GetSpellName(45357),
		JEWELCRAFTING = C_Spell.GetSpellName(25229),
		LEATHERWORKING = C_Spell.GetSpellName(2108),
		MINING = C_Spell.GetSpellName(2575),
		SKINNING = C_Spell.GetSpellName(8613),
		SMELTING = C_Spell.GetSpellName(2656),
		TAILORING = C_Spell.GetSpellName(3908),
	},
}

-- ** LDB Launcher **
LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject(addonName, {
	type = "launcher",
	icon = "Interface\\Icons\\INV_Drink_13",
	OnClick = function(clickedframe, button)
		AltoholicFrame:ToggleUI()
	end,
	text = (Broker2FuBar) and addonName or nil,		-- only for fubar,  not for ldb
	label = addonName,
})


-- *** Guild Comm ***
local guildMembersVersion = {} 	-- hash table containing guild member info

-- ** Message types **
local MSG_SEND_VERSION							= 1	-- Send Altoholic's version
local MSG_VERSION_REPLY							= 2	-- Reply

-- *** Utility functions ***
local function GuildBroadcast(messageType, ...)
	local data = LibSerialize:Serialize(messageType, ...)
	DataStore:SendChatMessage(commPrefix, data, "GUILD")
end

local function GuildWhisper(player, messageType, ...)
	if DataStore:IsGuildMemberOnline(player) then
		local data = LibSerialize:Serialize(messageType, ...)
		DataStore:SendChatMessage(commPrefix, data, "WHISPER", player)
	end
end

local function SaveVersion(sender, version)
	guildMembersVersion[sender] = version
end

local function ToggleUI()
	AltoholicFrame:ToggleUI()
end

local function SearchBags(searchText)
	if not searchText or string.len(searchText) == 0 then
		addon:Print("Usage = /altoholic search <item name>")
		return
	end
	
	if not AltoholicFrame:IsVisible() then
		AltoholicFrame:Show()
	end
	
	searchText = strlower(searchText)
	
	AltoholicFrame.SearchBox:SetText(searchText)
	AltoholicFrame:SwitchToTab("Search")
	AltoholicFrame.TabSearch:Find(searchText)
end

local commandLineCommands = {
	["show"] = function() AltoholicFrame:Show() end,
	["hide"] = function() AltoholicFrame:Hide() end,
	["toggle"] = ToggleUI,
	["search"] = SearchBags,
}

local function CommandLineCallback(args)
	-- No arguments ? show the options
	if not args or args == "" then
		local yellow = colors.yellow
	
		addon:Print(format("Arguments to %s/Alto :", yellow))
		print(format("  %sshow|r - %s", yellow, L["Shows the UI"]))
		print(format("  %shide|r - %s", yellow, L["Hides the UI"]))
		print(format("  %stoggle|r - %s", yellow, L["Toggles the UI"]))
		print(format("  %ssearch <item name>|r - %s", yellow, L["Search in bags"]))
		return
	end

	-- Get the command name and its argument
	local name, arg1 = strsplit(" ", args)
	
	if name and commandLineCommands[name] then
		commandLineCommands[name](arg1)
	end
end

local function OnSendVersion(sender, version)
	if sender ~= UnitName("player") then								-- don't send back to self
		GuildWhisper(sender, MSG_VERSION_REPLY, addon.Version)		-- reply by sending my own version
	end
	SaveVersion(sender, version)											-- .. and save it
	
	if versionNum and versionNum > addon.VersionNum and not Altoholic_UI_Options.moreRecentVersion then
		addon:Print(L["NEW_VERSION_AVAILABLE"])
		addon:Print(L["OFFICIAL_SOURCES"])
		
		Altoholic_UI_Options.moreRecentVersion = addon.VersionNum
	end
end

local function OnVersionReply(sender, version)
	SaveVersion(sender, version)
end

local GuildCommCallbacks = {
	[MSG_SEND_VERSION] = OnSendVersion,
	[MSG_VERSION_REPLY] = OnVersionReply,
}


AddonFactory:OnAddonLoaded(addonName, function() 
	addon.ListenTo = function(self, ...) AddonFactory:ListenToEvent(self, ...)	end
	
	AddonFactory:SetOptionsTable("Altoholic_UI_Options", {
		Mail = {
			GuildMailWarning = true,					-- be informed when a guildie sends a mail to one of my alts
			AutoCompleteRecipient = true,				-- Auto complete recipient name when sending a mail
			AutoCompletePriority = 1,					-- Auto complete priority (1 = alphabetical, 2 = most played, 3 = most recent)
			LastExpiryWarning = 0,						-- Last time a mail expiry warning was triggered
			TimeToNextWarning = 3,						-- Time before the warning is repeated ('3' = no warning for 3 hours)
		},
		Minimap = { 
			ShowIcon = true, 
			IconAngle = 180, 
			IconRadius = 102
		},
		Scale = 1.0,
		Transparency = 1.0,
		ClampWindowToScreen = false,
		
		-- ** Global options **
		AHColorCoding = true,							-- color coded recipes at the AH
		VendorColorCoding = true,						-- color coded recipes at vendors
	})
	
	AddonFactory:SetOptionsTable("Altoholic_Tooltip_Options", {
		ShowItemSource = true,
		ShowItemXPack = true,
		ShowItemCount = true,
		ShowSimpleCount = false,				-- display just the counter, without details (like AH, equipped, etc..)
		ShowTotalItemCount = true,
		ShowKnownRecipes = true,
		ShowItemID = false,						-- display item id & item level in the tooltip (default: off)
		ShowGatheringNodesCount = true,		-- display counters when mousing over a gathering node (default:  on)
		ShowCrossFactionCount = true,		-- display counters for both factions on a pve server
		ShowMergedRealmsCount = true,		-- display counters for characters on connected realms
		ShowAllRealmsCount = true,			-- display counters for all realms (for BoA items)
		ShowAllAccountsCount = true,			-- display counters for all accounts on the same realm
		ShowGuildBankCount = true,			-- display guild bank counters
		ShowGuildBankRealm = false,			-- display the realm of the guild bank
		ShowHearthstoneCount = true,			-- display hearthstone counters
		IncludeGuildBankInTotal = true,		-- total count = alts + guildbank (1) or alts only (0)
		ShowGuildBankCountPerTab = false,	-- guild count = guild:count or guild (tab 1: x, tab2: y ..)
		ShowCouldBeStoredOn = false,			-- display "could be stored on" information
		ShowAccountBankCount = true,			-- display account bank counters
		ShowCurrenciesCount = true,			-- display currency counters
		
		HiddenGuilds = {}						-- Guilds that should not be shown in the tooltip
	})	
	
	AddonFactory:SetOptionsTable("Altoholic_Sharing_Options", {
		IsEnabled = false,						-- account sharing communication handler is disabled by default
		GuildBankAutoUpdate = false,			-- can the guild bank tabs update requests be answered automatically or not.
		Clients = {},
		Domains = {},								-- ["Account.Realm"] 
		SharedContent = {							-- lists the shared content
			--	["Account.Realm.Name"]  = true means the char is shared,
			--	["Account.Realm.Name.Module"]  = true means the module is shared for that char
		},
	})
	
	AddonFactory:SetOptionsTable("Altoholic_Calendar_Options", {
		WarningsEnabled = true,
		WeekStartsOnMonday = false,
		UseDialogBoxForWarnings = false,				-- use a dialog box for warnings (true), or default chat frame (false)
		WarningType1 = "30,15,10,5,4,3,2,1",		-- for profession cooldowns
		WarningType2 = "30,15,10,5,4,3,2,1",		-- for dungeon resets
		WarningType3 = "30,15,10,5,4,3,2,1",		-- for calendar events
		WarningType4 = "30,15,10,5,4,3,2,1",		-- for item timers (like mysterious egg)
	})

	AddonFactory:RegisterChatCommand("Altoholic", CommandLineCallback)
	AddonFactory:RegisterChatCommand("Alto", CommandLineCallback)
	
	DataStore:SetGuildCommCallbacks(commPrefix, GuildCommCallbacks)
	DataStore:OnGuildComm(commPrefix, DataStore:GetGuildCommHandler())
	
	addon:ListenTo("DATASTORE_ANNOUNCELOGIN", function(self, guildName)
		GuildBroadcast(MSG_SEND_VERSION, addon.Version, addon.VersionNum)
	end)
	
	-- this event MUST stay here, we have to be able to respond to a request event if the guild tab is not loaded
	addon:ListenTo("DATASTORE_BANKTAB_REQUESTED", function(event, sender, tabName)
		if Altoholic_Sharing_Options.GuildBankAutoUpdate then
			DataStore:SendBankTabToGuildMember(sender, tabName)
			return
		end
		
		AltoMessageBox:SetHeight(130)
		AltoMessageBox.Text:SetHeight(60)
		AltoMessageBox:Ask(format("%s\n\n%s",
				format(L["%s%s|r has requested the bank tab %s%s|r\nSend this information ?"], colors.white, sender, colors.white, tabName),
				format(L["%sWarning:|r make sure this user may view this information before accepting"], colors.white)), 
			
			-- On Yes
			function() DataStore:SendBankTabToGuildMember(sender, tabName) end, 
		
			-- On No
			function() DataStore:RejectBankTabRequest(sender) end)

	end)
	
	addon:ListenTo("DATASTORE_GUILD_MAIL_RECEIVED", function(event, sender, recipient)
		if Altoholic_UI_Options.Mail.GuildMailWarning then
			addon:Print(format(L["%s|r has received a mail from %s"], format("%s%s", colors.green, recipient), format("%s%s", colors.green, sender)))
		end
	end)

	addon:ListenTo("DATASTORE_GLOBAL_MAIL_EXPIRY", function(event, threshold) 
		-- at least one mail has expired
		
		local lastWarning = Altoholic_UI_Options.Mail.LastExpiryWarning
		local timeToNext = Altoholic_UI_Options.Mail.TimeToNextWarning
		local now = time()
		
		if (now - lastWarning) < (timeToNext * 3600) then	-- has enough time passed ?
			return		-- no ? exit !
		end
		
		AltoMessageBox:SetHeight(130)
		AltoMessageBox.Text:SetHeight(60)
		AltoMessageBox:Ask(format("%sAltoholic: %s\n%s\n%s\n\n%s", colors.teal, colors.white, 
			L["Mail is about to expire on at least one character."],
			L["Refer to the activity pane for more details."],
			L["Do you want to view it now ?"]), 
			
			-- On Yes
			function()
				AltoholicFrame:Show()
				AltoholicFrame:SwitchToTab("Summary")
				
				-- Show the activity panel
				local tab = AltoholicFrame.TabSummary
				tab.CategoriesList:ClickCategory("profile", 9)
				tab:Update()
			end)
		
		Altoholic_UI_Options.Mail.LastExpiryWarning = now
	end)
	
	addon:ListenTo("DATASTORE_AUCTIONS_NOT_CHECKED_SINCE", function(event, character, charID, days, threshold)
		if days >= threshold then
			local key = DataStore:GetCharacterKey(charID)
			addon:Print(format(L["AUCTION_HOUSE_NOT_VISITED_WARNING"], DataStore:GetColoredCharacterName(key), days))
		end
	end)
	
	-- if we knew of a more recent version, and we now use an update, then reset the value
	if Altoholic_UI_Options.moreRecentVersion and addon.VersionNum >= Altoholic_UI_Options.moreRecentVersion then
		Altoholic_UI_Options.moreRecentVersion = nil
	end
	
end)

function addon:GetGuildMemberVersion(member)
	if guildMembersVersion[member] then			-- version number of a main ?
		return guildMembersVersion[member]		-- return it immediately
	end
	
	-- check if member is an alt
	local main = DataStore:GetNameOfMain(member)
	if main and guildMembersVersion[main] then
		return guildMembersVersion[main]
	end
end

function addon:Print(text)	
	DEFAULT_CHAT_FRAME:AddMessage(format("|cff33ff99%s|r: %s", addonName, text))
end

AddonFactory:AddToAddonCompartment(addonName, {
	["Click"] = function(addonName, buttonName, menuButtonFrame)
		ToggleUI() 
	end,
	["Enter"] = function(addonName, menuButtonFrame)
		AddonFactory_Tooltip:ShowInfo(menuButtonFrame, format("%s\n%s%s", addonName, colors.white, format(L["Left-click to %sopen"], colors.green)))
	end,
	["Leave"] = function(addonName, menuButtonFrame)
		AddonFactory_Tooltip:Hide()
	end
})
