local addonName = "Altoholic"
local addon = _G[addonName]

addon:Service("AltoholicUI.DataBrowser", { 
	"AltoholicUI.Options", "AltoholicUI.SearchResults", "AltoholicUI.ItemFilters", function(Options, Results, ItemFilters)

	local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
	
	local OPTION_LOCATION = "UI.Tabs.Search.CurrentLocation"
	local OPTION_PROFESSION = "UI.Tabs.Search.CurrentProfession"

	local MYTHIC_KEYSTONE = 138019
	
	local function VerifyItem(location, item, itemLink, itemCount, sourceKey, isBattlePet, isGuildBank)
		if type(item) == "string" then		-- convert a link to its item id, only data saved
		
			if item:match("|Hkeystone:") then
				item = MYTHIC_KEYSTONE			-- mythic keystones are actually all using the same item id
			else
				item = tonumber(item:match("item:(%d+)"))
			end	
		end
		
		if type(itemLink) ~= "string" then              -- a link is not a link - delete it
			itemLink = nil
		end
		
		ItemFilters.SetSearchedItem(item, (item ~= MYTHIC_KEYSTONE) and itemLink or nil, isBattlePet)

		-- All conditions ok ? save it
		if ItemFilters.ItemPassesFilters() then
			Results.AddItem(item, itemLink, sourceKey, itemCount,	location, isBattlePet, isGuildBank)
		end
	end

	local function CraftMatchFound(spellID, value)
		local name = GetSpellInfo(spellID)
		
		if name and string.find(strlower(name), value, 1, true) then
			return true
		end
	end

	local function BrowseCharacter(character)
		
		-- Bags / Bank
		DataStore:IterateContainerSlots(character, function(containerName, itemID, itemLink, itemCount, isBattlePet) 
			local location
			
			if string.sub(containerName, 1, string.len("VoidStorage")) == "VoidStorage" then
				location = VOID_STORAGE
			elseif containerName == "Bag100" then
				location = L["Bank"]
			elseif (containerName == "Bag-2") then
				location = KEYRING
			elseif containerName == "Bag5" then
				location = L["Reagent Bag"]
			else
				local bagNum = tonumber(string.sub(containerName, 4))
				
				if (bagNum >= 0) and (bagNum <= 4) then
					location = L["Bags"]
				elseif bagNum == 5 then
					location = L["Reagent Bag"]
				else
					location = L["Bank"]
				end			
			end
		
			VerifyItem(location, itemID, itemLink, itemCount, character, isBattlePet)
		end)

		-- Equipment
		DataStore:IterateInventory(character, function(item) 
			VerifyItem(L["Equipped"], item, item, 1, character)
		end)
		
		-- Mails
		if Options.Get("UI.Tabs.Search.IncludeMailboxItems") then			
			
			DataStore:IterateMails(character, function(icon, count, itemLink) 
				if itemLink then
					VerifyItem(L["Mail"], itemLink, itemLink, count, character)
				end
			end)
		end
		
		-- Check known recipes ?
		if not Options.Get("UI.Tabs.Search.IncludeKnownRecipes") then return end
		
		-- Get the text we are looking for
		local searchValue = ItemFilters.GetFilterValue("itemName")
		if not searchValue then return end
			
		local professions = DataStore:GetProfessions(character)
		if professions then
			for professionName, profession in pairs(professions) do
			
				DataStore:IterateRecipes(profession, 0, 0, function(recipeData)
					local _, spellID, isLearned = DataStore:GetRecipeInfo(recipeData)
					
					if isLearned and CraftMatchFound(spellID, searchValue) then
						Results.AddCraft(character, professionName, profession, spellID)
					end
				end)
			end
		end
	end

	local function BrowseRealm(realm, account, bothFactions)
		local playerFaction = UnitFactionGroup("player")
		
		for characterName, character in pairs(DataStore:GetCharacters(realm, account)) do
			if bothFactions or DataStore:GetCharacterFaction(character) == playerFaction then
				BrowseCharacter(character)
			end
		end
		
		if Options.Get("UI.Tabs.Search.IncludeGuildBankItems") then	-- Check guild bank(s) ?
			for guildName, guildKey in pairs(DataStore:GetGuilds(realm, account)) do

				if bothFactions or DataStore:GetGuildBankFaction(guildKey) == playerFaction then
					DataStore:IterateGuildBankSlots(guildKey, function(location, itemID, itemLink, itemCount, isBattlePet) 
						VerifyItem(location, itemID, itemLink, itemCount, guildKey, isBattlePet, true)
					end)
				end
			end
		end
	end
	
	local function BrowseAccount(account)
		for realm in pairs(DataStore:GetRealms(account)) do
			BrowseRealm(realm, account, true)
		end
	end
	
	return {
		Find = function()
			
			-- Start the search
			Results.Clear()
			
			local searchLocation = Options.Get(OPTION_LOCATION)

			-- This character
			if searchLocation == 1 then
				BrowseCharacter(DataStore:GetCharacter())
			
			-- This realm/this faction OR This realm/both factions
			elseif searchLocation == 2 or	searchLocation == 3 then
				BrowseRealm(DataStore.ThisRealm, DataStore.ThisAccount, (searchLocation == 3))
			
			-- All realms (this account)
			elseif searchLocation == 4 then
				BrowseAccount(DataStore.ThisAccount)
				
			-- All Accounts
			elseif searchLocation == 5 then
				-- this account first
				BrowseAccount(DataStore.ThisAccount)
				
				-- then all other accounts
				for account in pairs(DataStore:GetAccounts()) do
					if account ~= DataStore.ThisAccount then
						BrowseAccount(account)
					end
				end
			end
		end,
		
	}
end})
