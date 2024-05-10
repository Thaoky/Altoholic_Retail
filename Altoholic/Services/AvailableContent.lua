local addonName, addon = ...

addon:Service("AltoholicUI.AvailableContentView", { "AltoholicUI.Formatter", function(Formatter)
	
	-- This service manages the view
	local view

	local L = DataStore:GetLocale(addonName)

	local colors = addon.Colors
	
	local GUILD_HEADER = 1
	local GUILD_BANK_TAB = 2
	local CHARACTER_HEADER = 3
	local DATASTORE_MODULE = 4
	local CLASS_REFERENCE = 5
	
	local moduleLabels = {
		["DataStore_Achievements"] = ACHIEVEMENT_BUTTON,		-- "Achievements"
		["DataStore_Auctions"] = format("%s & %s", AUCTIONS, BIDS),
		["DataStore_Containers"] = L["Containers"],
		["DataStore_Crafts"] = TRADE_SKILLS,
		["DataStore_Currencies"] = CURRENCY,
		["DataStore_Garrisons"] = SPLASH_NEW_FEATURE1_TITLE,		-- "Garrisons"
		["DataStore_Inventory"] = L["Equipment"],
		["DataStore_Mails"] = L["Mails"],
		["DataStore_Pets"] = COMPANIONS,
		["DataStore_Quests"] = L["Quests"],
		["DataStore_Reputations"] = L["Reputations"],
		["DataStore_Spells"] = SPELLBOOK,
		["DataStore_Talents"] = TALENTS,
	}
	
	local function FirstCap(s)
		-- first letter in cap, the rest lowercase
		return format("%s%s", strupper(s:sub(1,1)), strlower(s:sub(2)))
	end
	
	local function GetGuildLabel(data)
		return format("%s%s|r / %s / %s%s", colors.white, data.realm, GUILD_BANK, colors.green, data.name)
	end
	
	local function GetGuildBankTabLabel(data)
		return format("%s%s %s%s", colors.gold, GUILDBANK_TAB_COLON, colors.white, data.name)
	end
	
	local function GetCharacterLabel(data)
		local _, realm, name = strsplit(".", data.key)

		return format("%s%s|r / %s", colors.white, realm, format("%s%s", DataStore:GetClassColor(data.class), name))
	end
	
	local function GetDataStoreLabel(data)
		return moduleLabels[data.module]
	end
	
	local function GetClassReferenceLabel(data)
		return format("%s%s : ", L["Talent Tree Reference"], FirstCap(data.class))
	end
	
	return {
		Initialize = function()
			view = view or {}
			wipe(view)
		end,
		Invalidate = function() view = nil end,
		IsValid = function() return (view ~= nil) end,
		GetSize = function() return #view end,
	
		-- ** Add Lines to the view **
		AddGuildHeader = function(realm, guildName, id)
			table.insert(view, { lineType = GUILD_HEADER, realm = realm, name = guildName, parentID = id, offset = 24, GetText = GetGuildLabel } )
		end,
		AddGuildBankTab = function(tabName, tabID, size, lastUpdate, id)
			table.insert(view, { lineType = GUILD_BANK_TAB, 
				name = tabName, 
				tabID = tabID, 
				size = size, 
				offset = 40,
				lastUpdate = lastUpdate,
				GetText = GetGuildBankTabLabel,
				parentID = id })
		end,
		AddCharacterHeader = function(characterKey, class, size, lastUpdate, id)
			table.insert(view, { lineType = CHARACTER_HEADER, 
				key = characterKey, 
				class = class, 
				size = size, 
				offset = 24,
				lastUpdate = lastUpdate,
				GetText = GetCharacterLabel,
				parentID = id })
		end,
		AddCharacterDataStoreLine = function(characterKey, dataStoreModule, size, lastUpdate, id)
			table.insert(view, { lineType = DATASTORE_MODULE, 
				key = characterKey, 
				module = dataStoreModule, 
				size = size, 
				offset = 40,
				lastUpdate = lastUpdate,
				GetText = GetDataStoreLabel,
				parentID = id })
		end,
		AddClassReferenceLine = function(class, size, id)
			table.insert(view, { lineType = CLASS_REFERENCE, class = class, size = size, parentID = id, offset = 24, GetText = GetClassReferenceLabel })
		end,
		
		-- ** Line information **
		GetLine = function(lineIndex)
			return view[lineIndex]
		end,
		GetText = function(lineIndex)
			local line = view[lineIndex]
			
			return line.GetText(line)
		end,
		
		IsHeaderLine = function(lineIndex)
			local line = view[lineIndex]
			
			return (line.lineType == GUILD_HEADER or line.lineType == CHARACTER_HEADER)
		end,
		IsCharacterHeaderLine = function(lineIndex)
			local line = view[lineIndex]
			return (line.lineType == CHARACTER_HEADER)
		end,
		IsGuildHeaderLine = function(lineIndex)
			local line = view[lineIndex]
			return (line.lineType == GUILD_HEADER)
		end,
	}
end})

addon:Service("AltoholicUI.AvailableContent", { 
	"AltoholicUI.AvailableContentView", "AltoholicUI.SharedTableOfContent", function(View, DestinationToC)

	-- This service manages the database content that the remote account has sent to us.

	local collapsedHeaders		-- a table containing the collapsed headers (character keys)
	local checkedItems			-- a table containing the items checked in the TOC (index = true)
	local clientAccountName
	
	return {
		Initialize = function()
		end,
		BuildView = function()
			collapsedHeaders = collapsedHeaders or {}
			checkedItems = checkedItems or {}
			View.Initialize()

			local realm, guildName, character
			
			for i = 1, DestinationToC.GetSize() do
				local tocType, arg1, arg2, arg3, arg4 = DestinationToC.GetLine(i)
				
				if DestinationToC.IsLineRealm(i) then
					realm = arg1
					checkedItems[i] = true		-- we must mark the realm lines, otherwise the SetRealm transfer is not happening !
					
				elseif DestinationToC.IsLineGuild(i) then
					guildName = arg1
					View.AddGuildHeader(realm, guildName, i)

				elseif DestinationToC.IsLineGuildBankTab(i) then
					local index = format("%s.%s.%s", clientAccountName, realm, guildName)
					
					if not collapsedHeaders[index] then
						View.AddGuildBankTab(arg1, tonumber(arg2), tonumber(arg3), tonumber(arg4), i)
					end
					
				elseif DestinationToC.IsLineCharacter(i) then
					character = format("%s.%s.%s", clientAccountName, realm, arg1)
					View.AddCharacterHeader(character, arg2, tonumber(arg3), tonumber(arg4), i)
					
				elseif DestinationToC.IsLineDataStoreModule(i) then
					if not collapsedHeaders[character] then
						View.AddCharacterDataStoreLine(character, arg1, tonumber(arg2), tonumber(arg3), i)
					end
					
				elseif DestinationToC.IsLineClassReference(i) then
					if not DataStore:IsClassKnown(arg1) then		-- filter to only list classes that are not yet available
						View.AddClassReferenceLine(arg1, tonumber(arg2), i)
					end
				end
			end			
		end,	
	
		SetAccount = function(account)
			clientAccountName = account
		end,
		GetAccount = function()
			return clientAccountName
		end,
	
		ToggleAll = function(isCollapsed)
			-- parse the whole view
			for i = 1, View.GetSize() do
				local line = View.GetLine(i)
				local index
				
				if View.IsGuildHeaderLine(i) then
					index = format("%s.%s.%s", clientAccountName, line.realm, line.name)
				elseif View.IsCharacterHeaderLine(i) then
					index = line.key
				end
				
				-- expand or collapse all
				if index then
					collapsedHeaders[index] = isCollapsed
				end
			end

			View:Invalidate()
		end,
		
		CheckAll = function(isChecked)
			for i = 1, DestinationToC.GetSize() do
				-- check or uncheck all, except realm lines which are always checked
				checkedItems[i] = DestinationToC.IsLineRealm(i) and true or isChecked
			end
			
			View:Invalidate()
		end,
		
		IsHeaderCollapsed = function(header)
			return collapsedHeaders[header]
		end,
		
		ToggleHeader = function(header)
			if not collapsedHeaders[header] then
				collapsedHeaders[header] = true
			else
				collapsedHeaders[header] = nil
			end
		end,
		
		ToggleCheck = function(id)
			if not checkedItems[id] then
				checkedItems[id] = true
			else
				checkedItems[id] = nil
			end
		end,
		
		IsItemChecked = function(id)
			return checkedItems[id]
		end,
	
		Clear = function()
			-- clear command, after a successful transfer
			
			wipe(collapsedHeaders)
			wipe(checkedItems)
		end
	
	}
end})
