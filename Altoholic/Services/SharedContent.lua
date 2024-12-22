local addonName, addon = ...

addon:Service("AltoholicUI.SharedTableOfContent", function() 
	-- Warning : this service is used for both sides of the account sharing process.
	-- The sender will use it to manage the source table of content,
	-- while the receiver will use for the destination table of content.
	
	local toc
	
	return {
		Initialize = function(inputToC)
			-- empty table for the sender
			-- or the parameter for the receiver (aka : destination ToC)
			toc = inputToC or {}
		end,
		Get = function() return toc end,
		GetSize = function() return (toc) and #toc or 0	end,
		GetLine = function(index)
			return strsplit(";", toc[index])
		end,
		
		-- ** Add Lines **
		AddRealm = function(realm)
			table.insert(toc, format("1;%s", realm))
		end,
		AddGuild = function(guildName, guildMoney)
			table.insert(toc, format("2;%s;%s", guildName, guildMoney or 0))
		end,
		AddGuildBankTab = function(tabName, tabID, size, lastUpdate)
			table.insert(toc, format("3;%s;%s;%s;%s", tabName, tabID, size, lastUpdate or 0))
		end,
		AddCharacter = function(characterName, class, size, lastUpdate)
			table.insert(toc, format("4;%s;%s;%s;%s", characterName, class, size, lastUpdate or 0))
		end,
		AddDataStoreModule = function(module, size, lastUpdate)
			table.insert(toc, format("5;%s;%d;%d", module, size, lastUpdate or 0))
		end,
		AddClassReference = function(class, size)
			table.insert(toc, format("6;%s;%s", class, size))
		end,
		
		IsLineRealm = function(index) return toc[index]:sub(1, 1) == "1" end,
		IsLineGuild = function(index) return toc[index]:sub(1, 1) == "2" end,
		IsLineGuildBankTab = function(index) return toc[index]:sub(1, 1) == "3" end,
		IsLineCharacter = function(index) return toc[index]:sub(1, 1) == "4" end,
		IsLineDataStoreModule = function(index) return toc[index]:sub(1, 1) == "5" end,
		IsLineClassReference = function(index) return toc[index]:sub(1, 1) == "6" end,
	}
end)

addon:Service("AltoholicUI.SharedContentView", { "AltoholicUI.Formatter", function(Formatter)
	
	-- This service manages the view
	local view

	local L = AddonFactory:GetLocale(addonName)

	local colors = AddonFactory.Colors
	local icons = AddonFactory.Icons
	
	local GUILD_HEADER = 1
	local GUILD_BANK_TAB = 2
	local CHARACTER_HEADER = 3
	local DATASTORE_MODULE = 4
	
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
	
	local function GetGuildLabel(data)
		local icon = icons[DataStore:GetGuildFaction(data.name, data.realm)] or "Interface/Icons/INV_BannerPVP_03"
		return format("%s %s%s|r / %s / %s%s", Formatter.Texture18(icon), colors.white, data.realm, GUILD_BANK, colors.green, data.name)
	end
	
	local function GetGuildBankTabLabel(data)
		local guild = DataStore:GetGuild(data.name, data.realm)
		return format("%s%s %s%s", colors.gold, GUILDBANK_TAB_COLON, colors.white, DataStore:GetGuildBankTabName(guild, data.tabID))
	end
	
	local function GetCharacterLabel(data)
		local character = data.key
		
		local _, realm = strsplit(".", character)
		local name = DataStore:GetColoredCharacterName(character)
		local icon = icons[DataStore:GetCharacterFaction(character)] or "Interface/Icons/INV_BannerPVP_03"
		
		return format("%s %s%s|r / %s", Formatter.Texture18(icon), colors.white, realm, name)
	end
	
	local function GetDataStoreLabel(data)
		return moduleLabels[data.module]
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
		AddGuildHeader = function(realm, guildName)
			table.insert(view, { lineType = GUILD_HEADER, realm = realm, name = guildName, offset = 24, GetText = GetGuildLabel } )
		end,
		AddGuildBankTab = function(realm, guildName, tabID)
			table.insert(view, { lineType = GUILD_BANK_TAB, realm = realm, name = guildName, tabID = tabID, offset = 40, GetText = GetGuildBankTabLabel } )
		end,
		AddCharacterHeader = function(characterKey)
			table.insert(view, { lineType = CHARACTER_HEADER, key = characterKey, offset = 24, GetText = GetCharacterLabel } )
		end,
		AddCharacterDataStoreLine = function(characterKey, dataStoreModule)
			table.insert(view, { lineType = DATASTORE_MODULE, key = characterKey, module = dataStoreModule, offset = 40, GetText = GetDataStoreLabel } )
		end,
		
		-- ** Line information **
		GetLine = function(lineIndex)
			return view[lineIndex]
		end,
		GetText = function(lineIndex)
			local line = view[lineIndex]
			
			return line.GetText(line)
		end,
		GetLineDataKey = function(lineIndex)
			local line = view[lineIndex]
		
			if line.lineType == GUILD_HEADER then
				return format("%s.%s.%s", DataStore.ThisAccount, line.realm, line.name)
			elseif line.lineType == GUILD_BANK_TAB then
				return format("%s.%s.%s.%s", DataStore.ThisAccount, line.realm, line.name, line.tabID)
			elseif line.lineType == CHARACTER_HEADER then
				return line.key
			else
				return format("%s.%s", line.key, line.module)
			end
		end,
		
		IsHeaderLine = function(lineIndex)
			local line = view[lineIndex]
			
			return (line.lineType == GUILD_HEADER or line.lineType == CHARACTER_HEADER)
		end,
	}
end})

addon:Service("AltoholicUI.SharedContent", { "AltoholicUI.SharedContentView", "AltoholicUI.SharedTableOfContent", function(View, SourceToC)

	-- This service manages the database content that the current account agrees to share

	local content					-- dereference database table
	local collapsedHeaders
	
	-- mandatory modules are sent anyway (if the character is shared, of course)
	local mandatoryModules = { "DataStore_Characters", "DataStore_Stats" }

	-- this also defines the order in which modules should be listed
	local optionalModules = {
		"DataStore_Achievements",
		"DataStore_Auctions",
		"DataStore_Containers",
		"DataStore_Crafts",
		"DataStore_Currencies",
		"DataStore_Garrisons",
		"DataStore_Inventory",
		"DataStore_Mails",
		-- "DataStore_Pets",
		"DataStore_Quests",
		"DataStore_Reputations",
		"DataStore_Spells",
		"DataStore_Talents",
	}
	
	return {
		Initialize = function()
			content = Altoholic_Sharing_Options.SharedContent
		end,
		
		BuildView = function()
			collapsedHeaders = collapsedHeaders or {}
			View.Initialize()

			-- Loop through all realms on this account
			for realm in pairs(DataStore:GetRealms()) do
			
				-- Add the guilds
				for guildName, guild in pairs(DataStore:GetGuilds(realm)) do
					View.AddGuildHeader(realm, guildName)
					
					local index = format("%s.%s.%s", DataStore.ThisAccount, realm, guildName)
					
					if not collapsedHeaders[index] then
						-- add guild bank tabs
						for tabID = 1, 8 do		
							local tabName = DataStore:GetGuildBankTabName(guild, tabID)
							if tabName then
								View.AddGuildBankTab(realm, guildName, tabID)
							end
						end
					end
				end
			
				-- Add the characters
				for characterName, character in pairs(DataStore:GetCharacters(realm)) do
					View.AddCharacterHeader(character)
					
					if not collapsedHeaders[character] then
						for _, module in pairs(optionalModules) do
							View.AddCharacterDataStoreLine(character, module)
						end
					end
				end
			end
		end,	
		
		ToggleAll = function(isCollapsed)
			-- Loop through all realms on this account
			for realm in pairs(DataStore:GetRealms()) do
				for guildName, _ in pairs(DataStore:GetGuilds(realm)) do
					local index = format("%s.%s.%s", DataStore.ThisAccount, realm, guildName)
					collapsedHeaders[index] = isCollapsed
				end
			
				for characterName, character in pairs(DataStore:GetCharacters(realm)) do
					collapsedHeaders[character] = isCollapsed
				end
			end

			View:Invalidate()
		end,
		
		CheckAll = function(isChecked)
			-- Loop through all realms on this account
			for realm in pairs(DataStore:GetRealms()) do
				
				-- guilds
				for guildName, guild in pairs(DataStore:GetGuilds(realm)) do
					local index = format("%s.%s.%s", DataStore.ThisAccount, realm, guildName)
					content[index] = isChecked
					
					-- add guild bank tabs
					for tabID = 1, 8 do		
						if DataStore:GetGuildBankTabName(guild, tabID) then
							index = format("%s.%s.%s.%s", DataStore.ThisAccount, realm, guildName, tabID)
							content[index] = isChecked
						end
					end
				end
			
				-- characters
				for characterName, character in pairs(DataStore:GetCharacters(realm)) do
					content[character] = isChecked
					
					for _, module in pairs(optionalModules) do
						content[format("%s.%s", character, module)] = isChecked
					end
				end
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
		
		Share = function(index, isShared)
			-- set if this content is actually shared or not
			content[index] = isShared
		end,
		
		IsContentShared = function(lineIndex)
			-- Get the content index from the line in the view
			local index = View.GetLineDataKey(lineIndex)
			
			-- return the saved info about this content
			return content[index]
		end,
		
		GetSourceTableOfContent = function()
			-- prepares the table of content that will be sent to the user requesting account sharing
			
			-- This method adds all realms, all guilds, all characters on the current account, assuming they are shared
			-- Reference data (available classes) is always sent, and mandatory modules in datastore are not sent (they're implicit, if a character is shared, they must be sent)
			
			-- on the receiving side, display mandatory items as part of the list, but greyed out/disabled and automatically selected for transfer
			
			local LibSerialize = LibStub:GetLibrary("LibSerialize")

			local serializedData, lastUpdate
			SourceToC.Initialize()

			-- All realms on this account
			for realm in pairs(DataStore:GetRealms()) do			
				SourceToC.AddRealm(realm)
			
				-- Add guilds
				for guildName, guild in pairs(DataStore:GetGuilds(realm)) do
					local index = format("%s.%s.%s", DataStore.ThisAccount, realm, guildName)
					local guildMoney = DataStore:GetGuildBankMoney(guild)
				
					-- is guild shared ?
					if content[index] then
						SourceToC.AddGuild(guildName, guildMoney)
						
						for tabID = 1, 8 do		-- add guild bank tabs
							local tabName = DataStore:GetGuildBankTabName(guild, tabID)
							
							-- if this bank tab is shared ...
							-- if tabName and isGuildBankTabShared(realm, guildName, tabID) then
							if tabName and content[format("%s.%s.%s.%s", DataStore.ThisAccount, realm, guildName, tabID)] then
								serializedData = LibSerialize:Serialize(DataStore:GetGuildBankTab(guild, tabID))
								lastUpdate = DataStore:GetGuildBankTabLastUpdate(guild, tabID)

								SourceToC.AddGuildBankTab(tabName, tabID, strlen(serializedData), lastUpdate)
							end
						end
					end
				end
			
				-- Add characters
				for characterName, character in pairs(DataStore:GetCharacters(realm)) do
					-- is character shared ?
					if content[character] then
						-- get the size of mandatory modules
						local size = 0
						for _, module in pairs(mandatoryModules) do
							serializedData = LibSerialize:Serialize(DataStore:GetCharacterTable(module, characterName, realm))
							size = size + strlen(serializedData)
						end
						
						local _, class = DataStore:GetCharacterClass(character)
						lastUpdate = DataStore:GetModuleLastUpdateByKey("DataStore_Characters", character)
						
						SourceToC.AddCharacter(characterName, class, size, lastUpdate)

						for _, module in ipairs(optionalModules) do
							local index = format("%s.%s", character, module)
							
							-- is character data shared ?
							if content[index] then
								-- evaluate the size of transferred data
								serializedData = LibSerialize:Serialize(DataStore:GetCharacterTable(module, characterName, realm))
								lastUpdate = DataStore:GetModuleLastUpdateByKey(module, character)
							
								-- Set the right datastore module (ex: DataStore_Crafts)
								SourceToC.AddDataStoreModule(module, strlen(serializedData), lastUpdate)
							end
						end
					end
				end
			end
			
			-- Add reference here
			-- 30/06/2024, sharing feature fix: this most likely disappears
			
			-- for class, _ in pairs(DataStore:GetReferenceTable()) do
				-- serializedData = LibSerialize:Serialize(DataStore:GetClassReference(class))
				
				-- SourceToC.AddClassReference(class, strlen(serializedData))
			-- end
			
			return SourceToC.Get()
		end,
	}
end})
