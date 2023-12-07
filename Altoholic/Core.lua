local addonName = ...

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0", "AceSerializer-3.0", "AceTimer-3.0", "LibMVC-1.0")

local addon = _G[addonName]

addon.Version = "v10.2.008"
-- addon.VersionNum = 902006
addon.VersionNum = 1002008

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local commPrefix = addonName

-- Reminder: binding is done in bindings.xml
BINDING_HEADER_ALTOHOLIC = addonName
BINDING_NAME_ALTOHOLIC_TOGGLE = "Altoholic - Toggle UI"

local options = { 
	type = "group",
	args = {
		search = {
			type = "input",
			name = SEARCH,
			usage = "<item name>",
			desc = L["Search in bags"],
			get = false,
			set = "CmdSearchBags",
		},
		show = {
			type = "execute",
			name = SHOW,
			desc = L["Shows the UI"],
			func = function() AltoholicFrame:Show() end
		},
		hide = {
			type = "execute",
			name = HIDE,
			desc = L["Hides the UI"],
			func = function() AltoholicFrame:Hide() end
		},
		toggle = {
			type = "execute",
			name = "toggle",
			desc = L["Toggles the UI"],
			func = function() AltoholicFrame:ToggleUI() end
		},
	},
}
 
local AddonDB_Defaults = {
	global = {
		Guilds = {
			['*'] = {			-- ["Account.Realm.Name"] 
				hideInTooltip = nil,		-- true if this guild should not be shown in the tooltip counters
			},
		},
		Characters = {
			['*'] = {					-- ["Account.Realm.Name"] 
			},
		},
		Sharing = {
			Clients = {},
			SharedContent = {			-- lists the shared content
				--	["Account.Realm.Name"]  = true means the char is shared,
				--	["Account.Realm.Name.Module"]  = true means the module is shared for that char
			},
			Domains = {
				['*'] = {			-- ["Account.Realm"] 
					lastSharingTimestamp = nil,	-- a date, the last time information from this realm/account was queried and successfully saved.
					lastUpdatedWith = nil,		-- last player with whom the account sharing took place
				},
			},
		},
		unsafeItems = {},
		moreRecentVersion = nil,
		options = {
			-- ** Summary tab options **
			["UI.Tabs.Summary.ShowRestXP150pc"] = false,						-- display max rest xp in normal 100% mode or in level equivalent 150% mode ?
			["UI.Tabs.Summary.CurrentMode"] = 1,								-- current mode (1 = account summary, 2 = bags, ...)
			["UI.Tabs.Summary.CurrentColumn"] = "Name",						-- current column (default = "Name")
			["UI.Tabs.Summary.CurrentRealms"] = 2,								-- selected realms (current/all in current/all accounts)
			["UI.Tabs.Summary.CurrentAltGroup"] = 0,							-- selected alt group
			["UI.Tabs.Summary.CurrentFactions"] = 3,							-- 1 = Alliance, 2 = Horde, 3 = Both
			["UI.Tabs.Summary.CurrentLevels"] = 1,								-- 1 = All
			["UI.Tabs.Summary.CurrentLevelsMin"] = 1,							
			["UI.Tabs.Summary.CurrentLevelsMax"] = 70,					
			["UI.Tabs.Summary.CurrentBankType"] = 0,							-- 0 = All
			["UI.Tabs.Summary.CurrentClasses"] = 0,							-- 0 = All
			["UI.Tabs.Summary.CurrentTradeSkill"] = 0,						-- 0 = All
			["UI.Tabs.Summary.CurrentMisc"] = 0,								-- 
			["UI.Tabs.Summary.UseColorForTradeSkills"] = true,				-- Use color coding for tradeskills, or neutral
			["UI.Tabs.Summary.SortAscending"] = true,							-- ascending or descending sort order
			["UI.Tabs.Summary.ShowLevelDecimals"] = true,					-- display character level with decimals or not
			["UI.Tabs.Summary.ShowILevelDecimals"] = true,					-- display character level with decimals or not
			["UI.Tabs.Summary.ShowGuildRank"] = false,						-- display the guild rank or the guild name
			
			-- ** Character tab options **
			["UI.Tabs.Characters.ViewBags"] = true,
			["UI.Tabs.Characters.ViewBank"] = true,
			["UI.Tabs.Characters.ViewBagsAllInOne"] = false,
			["UI.Tabs.Characters.ViewVoidStorage"] = true,
			["UI.Tabs.Characters.ViewReagentBank"] = true,
			["UI.Tabs.Characters.ViewBagsRarity"] = 0,						-- rarity level of items (not a boolean !)
			["UI.Tabs.Characters.GarrisonMissions"] = 1,						-- available missions = 1, active missions = 2
			["UI.Tabs.Characters.SortAscending"] = true,						-- ascending or descending sort order
			["UI.Tabs.Characters.ViewLearnedRecipes"] = true,				-- View learned recipes ?
			["UI.Tabs.Characters.ViewUnlearnedRecipes"] = false,			-- View unlearned recipes ?
			["UI.Tabs.Characters.ViewQuestLogCategory"] = 0,				-- Quest log category to show
			["UI.Tabs.Characters.ViewSpellTab"] = 1,							-- Spellbook tab to show
						
			-- ** Search tab options **
			["UI.Tabs.Search.ItemInfoAutoQuery"] = false,
			["UI.Tabs.Search.IncludeNoMinLevel"] = true,				-- include items with no minimum level
			["UI.Tabs.Search.IncludeMailboxItems"] = true,
			["UI.Tabs.Search.IncludeGuildBankItems"] = true,
			["UI.Tabs.Search.IncludeKnownRecipes"] = true,
			["UI.Tabs.Search.CurrentLocation"] = 1,
			["UI.Tabs.Search.UseColorsForAlts"] = true,
			["UI.Tabs.Search.UseColorsForRealms"] = true,
			["UI.Tabs.Search.SortAscending"] = true,							-- ascending or descending sort order
			TotalLoots = 0,					-- make at least one search in the loot tables to initialize these values
			UnknownLoots = 0,
			
			-- ** Guild Bank tab options **
			["UI.Tabs.Guild.BankItemsRarity"] = 0,								-- rarity filter in the guild bank tab
			["UI.Tabs.Guild.BankAutoUpdate"] = false,							-- can the guild bank tabs update requests be answered automatically or not.
			["UI.Tabs.Guild.SortAscending"] = true,							-- ascending or descending sort order
			
			-- ** Grids tab options **
			["UI.Tabs.Grids.Reputations.CurrentXPack"] = 1,					-- Current expansion pack 
			["UI.Tabs.Grids.Reputations.CurrentFactionGroup"] = 1,		-- Current faction group in that xpack
			["UI.Tabs.Grids.Currencies.CurrentTokenType"] = nil,			-- Current token type (default to nil = all-in-one)
			["UI.Tabs.Grids.Companions.CurrentXPack"] = 1,					-- Current expansion pack 
			["UI.Tabs.Grids.Mounts.CurrentFaction"] = 1,						-- Current faction 
			["UI.Tabs.Grids.Tradeskills.CurrentXPack"] = 1,					-- Current expansion pack 
			["UI.Tabs.Grids.Tradeskills.CurrentTradeSkill"] = 1,			-- Current tradeskill index
			["UI.Tabs.Grids.Archaeology.CurrentRace"] = 1,					-- Current race index
			["UI.Tabs.Grids.Dungeons.CurrentXPack"] = 1,						-- Current expansion pack 
			["UI.Tabs.Grids.Dungeons.CurrentRaids"] = 1,						-- Current raid index
			["UI.Tabs.Grids.Garrisons.CurrentBuildings"] = 1,				-- Current building type
			["UI.Tabs.Grids.Garrisons.CurrentFollowers"] = 1,				-- Current follower type
			["UI.Tabs.Grids.Garrisons.CurrentStats"] = 1,					-- Current stats (abilities = 1, traits = 2, counters = 3)
			["UI.Tabs.Grids.Sets.IncludePVE"] = true,							-- Include PVE Sets
			["UI.Tabs.Grids.Sets.IncludePVP"] = true,							-- Include PVP Sets
			["UI.Tabs.Grids.Sets.CurrentXPack"] = 1,							-- Current expansion pack 
			["UI.Tabs.Grids.Emissaries.ShowXPack6"] = true,					-- Show Legion Emissaries
			["UI.Tabs.Grids.Emissaries.ShowXPack7"] = true,					-- Show BfA Emissaries
			["UI.Tabs.Grids.Emissaries.ShowXPack8"] = true,					-- Show Shadowlands Emissaries

			-- ** Tooltip options **
			["UI.Tooltip.ShowItemSource"] = true,
			["UI.Tooltip.ShowItemXPack"] = true,
			["UI.Tooltip.ShowItemCount"] = true,
			["UI.Tooltip.ShowSimpleCount"] = false,				-- display just the counter, without details (like AH, equipped, etc..)
			["UI.Tooltip.ShowTotalItemCount"] = true,
			["UI.Tooltip.ShowKnownRecipes"] = true,
			["UI.Tooltip.ShowItemID"] = false,						-- display item id & item level in the tooltip (default: off)
			["UI.Tooltip.ShowGatheringNodesCount"] = true,		-- display counters when mousing over a gathering node (default:  on)
			["UI.Tooltip.ShowCrossFactionCount"] = true,			-- display counters for both factions on a pve server
			["UI.Tooltip.ShowMergedRealmsCount"] = true,			-- display counters for characters on connected realms
			["UI.Tooltip.ShowAllRealmsCount"] = true,				-- display counters for all realms (for BoA items)
			["UI.Tooltip.ShowAllAccountsCount"] = true,			-- display counters for all accounts on the same realm
			["UI.Tooltip.ShowGuildBankCount"] = true,				-- display guild bank counters
			["UI.Tooltip.ShowGuildBankRealm"] = false,			-- display the realm of the guild bank
			["UI.Tooltip.ShowHearthstoneCount"] = true,			-- display hearthstone counters
			["UI.Tooltip.IncludeGuildBankInTotal"] = true,		-- total count = alts + guildbank (1) or alts only (0)
			["UI.Tooltip.ShowGuildBankCountPerTab"] = false,	-- guild count = guild:count or guild (tab 1: x, tab2: y ..)
			["UI.Tooltip.ShowCouldBeStoredOn"] = false,			-- display "could be stored on" information
			
			-- ** Mail options **
			["UI.Mail.GuildMailWarning"] = true,					-- be informed when a guildie sends a mail to one of my alts
			["UI.Mail.AutoCompleteRecipient"] = true,				-- Auto complete recipient name when sending a mail
			["UI.Mail.AutoCompletePriority"] = 1,					-- Auto complete priority (1 = alphabetical, 2 = most played, 3 = most recent)
			["UI.Mail.LastExpiryWarning"] = 0,						-- Last time a mail expiry warning was triggered
			["UI.Mail.TimeToNextWarning"] = 3,						-- Time before the warning is repeated ('3' = no warning for 3 hours)
			
			-- ** Minimap options **
			["UI.Minimap.ShowIcon"] = true,
			["UI.Minimap.IconAngle"] = 180,
			["UI.Minimap.IconRadius"] = 102,
			
			-- ** Calendar options **
			["UI.Calendar.WarningsEnabled"] = true,
			["UI.Calendar.UseDialogBoxForWarnings"] = false,	-- use a dialog box for warnings (true), or default chat frame (false)
			["UI.Calendar.WeekStartsOnMonday"] = false,

			WarningType1 = "30,15,10,5,4,3,2,1",		-- for profession cooldowns
			WarningType2 = "30,15,10,5,4,3,2,1",		-- for dungeon resets
			WarningType3 = "30,15,10,5,4,3,2,1",		-- for calendar events
			WarningType4 = "30,15,10,5,4,3,2,1",		-- for item timers (like mysterious egg)
			
			-- ** Global options **
			["UI.AHColorCoding"] = true,					-- color coded recipes at the AH
			["UI.VendorColorCoding"] = true,				-- color coded recipes at vendors
			["UI.AccountSharing.IsEnabled"] = false,	-- account sharing communication handler is disabled by default
			
			["UI.Scale"] = 1.0,
			["UI.Transparency"] = 1.0,
			["UI.ClampWindowToScreen"] = false,

		},
	}
}

addon.Colors = {
	white	= "|cFFFFFFFF",
	red = "|cFFFF0000",
	darkred = "|cFFF00000",
	green = "|cFF00FF00",
	orange = "|cFFFF7F00",
	yellow = "|cFFFFFF00",
	gold = "|cFFFFD700",
	teal = "|cFF00FF9A",
	cyan = "|cFF1CFAFE",
	lightBlue = "|cFFB0B0FF",
	battleNetBlue = "|cff82c5ff",
	grey = "|cFF909090",
	
	-- classes
	classMage = "|cFF69CCF0",
	classHunter = "|cFFABD473",
	
	-- recipes
	recipeGrey = "|cFF808080",
	recipeGreen = "|cFF40C040",
	recipeOrange = "|cFFFF8040",
	
	-- rarity : http://wow.gamepedia.com/Quality
	common = "|cFFFFFFFF",
	uncommon = "|cFF1EFF00",
	rare = "|cFF0070DD",
	epic = "|cFFA335EE",
	legendary = "|cFFFF8000",
	heirloom = "|cFFE6CC80",

	Alliance = "|cFF2459FF",
	Horde = "|cFFFF0000"
}

addon.Icons = {
	ready = "\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t",
	waiting = "\124TInterface\\RaidFrame\\ReadyCheck-Waiting:14\124t",
	notReady = "\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t",
	questionMark = "Interface\\RaidFrame\\ReadyCheck-Waiting",

	Alliance = "Interface\\Icons\\INV_BannerPVP_02",
	Horde = "Interface\\Icons\\INV_BannerPVP_01",
	Neutral = "Interface\\Icons\\Achievement_character_pandaren_female",
}

-- Place Enums in a separate file when there are enough to justify it
addon.Enum = {
	ArmorTypes = {
		[1] = GetItemSubClassInfo(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Cloth), -- "Cloth"
		[2] = GetItemSubClassInfo(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Leather), -- "Leather"
		[3] = GetItemSubClassInfo(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Mail), -- "Mail"
		[4] = GetItemSubClassInfo(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Plate) -- "Plate"
	},
}

addon.TradeSkills = {
	Recipes = {},
	-- spell IDs in alphabetical order (english), primary then secondary
	spellIDs = { 2259, 3100, 7411, 4036, 45357, 25229, 2108, 2656, 3908, 2550 },
	firstSecondarySkillIndex = 10, -- index of the first secondary profession in the table
	
	AccountSummaryFiltersSpellIDs = { 2259, 3100, 7411, 4036, 2366, 45357, 25229, 2108, 2575, 8613, 3908, 2550, 131474, 78670 },
	AccountSummaryFirstSecondarySkillIndex = 12, -- index of the first secondary profession in the table
		
	Names = {
		ALCHEMY = GetSpellInfo(2259),
		ARCHAEOLOGY = GetSpellInfo(78670),
		BLACKSMITHING = GetSpellInfo(3100),
		COOKING = GetSpellInfo(2550),
		ENCHANTING = GetSpellInfo(7411),
		ENGINEERING = GetSpellInfo(4036),
		FISHING = GetSpellInfo(131474),
		HERBALISM = GetSpellInfo(2366),
		INSCRIPTION = GetSpellInfo(45357),
		JEWELCRAFTING = GetSpellInfo(25229),
		LEATHERWORKING = GetSpellInfo(2108),
		MINING = GetSpellInfo(2575),
		SKINNING = GetSpellInfo(8613),
		SMELTING = GetSpellInfo(2656),
		TAILORING = GetSpellInfo(3908),
	},
}

-- One empty function to rule them all
addon.EmptyFunc = function() end

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
	local serializedData = addon:Serialize(messageType, ...)
	addon:SendCommMessage(commPrefix, serializedData, "GUILD")
end

local function GuildWhisper(player, messageType, ...)
	if DataStore:IsGuildMemberOnline(player) then
		local serializedData = addon:Serialize(messageType, ...)
		addon:SendCommMessage(commPrefix, serializedData, "WHISPER", player)
	end
end

local function SaveVersion(sender, version)
	guildMembersVersion[sender] = version
end

function addon:OnInitialize()
	addon.db = LibStub("AceDB-3.0"):New(addonName .. "DB", AddonDB_Defaults)
	LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, options)

	addon:RegisterChatCommand("Altoholic", "ChatCommand")
	addon:RegisterChatCommand("Alto", "ChatCommand")
	
	DataStore:SetGuildCommCallbacks(commPrefix, {
		[MSG_SEND_VERSION] = function(sender, version, versionNum)
			if sender ~= UnitName("player") then								-- don't send back to self
				GuildWhisper(sender, MSG_VERSION_REPLY, addon.Version)		-- reply by sending my own version
			end
			SaveVersion(sender, version)											-- .. and save it
			
			if versionNum and versionNum > addon.VersionNum and not addon.db.global.moreRecentVersion then
				addon:Print(L["NEW_VERSION_AVAILABLE"])
				addon:Print(L["OFFICIAL_SOURCES"])
				
				addon.db.global.moreRecentVersion = addon.VersionNum
			end
		end,
		[MSG_VERSION_REPLY] = function(sender, version)
			SaveVersion(sender, version)
		end,
	})
	
	addon:RegisterMessage("DATASTORE_ANNOUNCELOGIN", function(self, guildName)
		GuildBroadcast(MSG_SEND_VERSION, addon.Version, addon.VersionNum)
	end)

	addon:RegisterComm(commPrefix, DataStore:GetGuildCommHandler())
	
	local MVC = LibStub("LibMVC-1.0")
	local Options = MVC:GetService("AltoholicUI.Options")
	local colors = addon.Colors
	
	-- this event MUST stay here, we have to be able to respond to a request event if the guild tab is not loaded
	addon:RegisterMessage("DATASTORE_BANKTAB_REQUESTED", function(event, sender, tabName)
		if Options.Get("UI.Tabs.Guild.BankAutoUpdate") then
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
		
			-- On no
			function() DataStore:RejectBankTabRequest(sender) end)

	end)
	
	addon:RegisterMessage("DATASTORE_GUILD_MAIL_RECEIVED", function(event, sender, recipient)
		if Options.Get("UI.Mail.GuildMailWarning") then
			addon:Print(format(L["%s|r has received a mail from %s"], format("%s%s", colors.green, recipient), format("%s%s", colors.green, sender)))
		end
	end)

	addon:RegisterMessage("DATASTORE_GLOBAL_MAIL_EXPIRY", function(event, threshold) 
		-- at least one mail has expired
		
		local lastWarning = Options.Get("UI.Mail.LastExpiryWarning")
		local timeToNext = Options.Get("UI.Mail.TimeToNextWarning")
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
		
		Options.Set("UI.Mail.LastExpiryWarning", now)
	end)
	
	addon:RegisterMessage("DATASTORE_AUCTIONS_NOT_CHECKED_SINCE", function(event, character, key, days, threshold)
		if days >= threshold then
			addon:Print(format(L["AUCTION_HOUSE_NOT_VISITED_WARNING"], DataStore:GetColoredCharacterName(key), days))
		end
	end)
	
	local global = addon.db.global
	if global.moreRecentVersion and addon.VersionNum >= global.moreRecentVersion then
		global.moreRecentVersion = nil
	end
end

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

function addon:ChatCommand(input)
	if not input then
		LibStub("AceConfigDialog-3.0"):Open(addonName)
	else
		LibStub("AceConfigCmd-3.0").HandleCommand(addon, "Alto", addonName, input)
	end
end

function addon:CmdSearchBags(arg1, searchText)

	if not searchText or string.len(searchText) == 0 then
		addon:Print("Usage = /altoholic search <item name>")
		return
	end
	
	if not (AltoholicFrame:IsVisible()) then
		AltoholicFrame:Show()
	end
	
	searchText = strlower(searchText)
	
	AltoholicFrame.SearchBox:SetText(searchText)
	AltoholicFrame:SwitchToTab("Search")
	AltoholicFrame.TabSearch:Find(searchText)
end	
