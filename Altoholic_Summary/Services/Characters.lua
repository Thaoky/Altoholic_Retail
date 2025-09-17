local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

local L = AddonFactory:GetLocale(addonName)
local MVC = LibStub("LibMVC-1.0")
local oop = MVC:GetService("AddonFactory.Classes")
local Formatter = MVC:GetService("AltoholicUI.Formatter")
local AccountSharing = MVC:GetService("AltoholicUI.AccountSharing")

local MAX_PLAYER_LEVEL = 80

local INFO_REALM_LINE = 0
local INFO_CHARACTER_LINE = 1
local INFO_TOTAL_LINE = 2

local THISREALM_THISACCOUNT = 1
local THISREALM_ALLACCOUNTS = 2
local ALLREALMS_THISACCOUNT = 3
local ALLREALMS_ALLACCOUNTS = 4

local options
local characterList
local view
local isViewValid

local function ProcessRealms(func)
	local mode = Altoholic_SummaryTab_Options["CurrentRealms"]
	
	-- this account only
	if mode == THISREALM_THISACCOUNT then
		func(DataStore.ThisAccount, DataStore.ThisRealm)
		
	elseif mode == ALLREALMS_THISACCOUNT then	
		for realm in pairs(DataStore:GetRealms()) do
			func(DataStore.ThisAccount, realm)
		end

	-- all accounts
	elseif mode == THISREALM_ALLACCOUNTS then
		for account in pairs(DataStore:GetAccounts()) do
			for realm in pairs(DataStore:GetRealms(account)) do
				if realm == DataStore.ThisRealm then
					func(account, realm)
				end
			end
		end
		
	elseif mode == ALLREALMS_ALLACCOUNTS then
		for account in pairs(DataStore:GetAccounts()) do
			for realm in pairs(DataStore:GetRealms(account)) do
				func(account, realm)
			end
		end
	end
end

local collapsedRealms = {}

local totalMoney
local totalPlayed
local totalLevels
local realmCount

-- Same order as CLASS_SORT_ORDER
local CLASS_ARMOR_ORDER = {
	[CLASS_SORT_ORDER[1]] = Enum.ItemArmorSubclass.Plate,		-- WARRIOR
	[CLASS_SORT_ORDER[2]] = Enum.ItemArmorSubclass.Plate,		-- DEATHKNIGHT
	[CLASS_SORT_ORDER[3]] = Enum.ItemArmorSubclass.Plate,		-- PALADIN
	[CLASS_SORT_ORDER[4]] = Enum.ItemArmorSubclass.Leather,	-- MONK
	[CLASS_SORT_ORDER[5]] = Enum.ItemArmorSubclass.Cloth,		-- PRIEST
	[CLASS_SORT_ORDER[6]] = Enum.ItemArmorSubclass.Mail,		-- SHAMAN
	[CLASS_SORT_ORDER[7]] = Enum.ItemArmorSubclass.Leather,	-- DRUID
	[CLASS_SORT_ORDER[8]] = Enum.ItemArmorSubclass.Leather,	-- ROGUE
	[CLASS_SORT_ORDER[9]] = Enum.ItemArmorSubclass.Cloth,		-- MAGE
	[CLASS_SORT_ORDER[10]] = Enum.ItemArmorSubclass.Cloth,	-- WARLOCK
	[CLASS_SORT_ORDER[11]] = Enum.ItemArmorSubclass.Mail,		-- HUNTER
	[CLASS_SORT_ORDER[12]] = Enum.ItemArmorSubclass.Leather,	-- DEMONHUNTER
	[CLASS_SORT_ORDER[13]] = Enum.ItemArmorSubclass.Mail,		-- EVOKER
}

-- Roles will be passed as 31 .. 33
local ROLE_ORDER = {
	["TANK"] = 31, 
	["HEALER"] = 32,
	["DAMAGER"] = 33
}

local filterPipeline = oop:New("FilterPipeline")

-- using parameterized closures.
local function FilterByLevel(minLevel, maxLevel)
	return function(character)
		local level = DataStore:GetCharacterLevel(character)
		return level >= minLevel and level <= maxLevel
	end
end

local function FilterByFaction(factions)
	return function(character)
		local faction = DataStore:GetCharacterFaction(character)

		if factions == 1 and faction ~= "Alliance" then return false end
		if factions == 2 and faction ~= "Horde" then return false end
		return true
	end
end

local function FilterByRace(race)
	return function(character)
		if race == 0 then return true end 	-- no filter ? exit
		
		local characterRace = select(3, DataStore:GetCharacterRace(character))
		if characterRace == race then return true end
		
		-- https://wowpedia.fandom.com/wiki/RaceId
		-- if the race is 24, it's a special case for neutral pandarens, so let it pass
		
		-- if it's already a pandaren with a proper faction, it's handled by the previous test.
		-- if it's a neutral pandaren (24), then the filtered race should be 25 or 26 to let it pass
		if characterRace == 24 and (race == 25 or race == 26) then
			return true
		end
	end
end

local function FilterByClass(class)
	return function(character)
		-- If we are filtering by armor type..
		-- class is passed as : 
		-- 	0 for ALL
		if class == 0 then return true end 	-- no filter ? exit
		
		local _, characterClass = DataStore:GetCharacterClass(character)
		
		--		31..33 for role types
		if class > 30 then
			local _, _, role = DataStore:GetActiveSpecInfo(character)
		
			-- Roles are passed as 31..33, so direct comparison is possible
			return ROLE_ORDER[role] == class
		
		--		21..24 for armor types, 
		elseif class > 20 then
			return CLASS_ARMOR_ORDER[characterClass] == (class - 20)
		
		--		1..13 for actual class, 
		else
			return CLASS_SORT_ORDER[class] == characterClass
		end
	end
end

local function FilterByBank(bankType)
	return function(character)
		-- 0 = All types
		if bankType == 0 then return true end
		
		-- -1 = Any bank type
		if bankType == -1 then return DataStore:GetBankType(character) ~= 0 end
		
		return DataStore:IsBankType(character, bankType)
	end
end

local function FilterByAltGroup(altGroup)
	return function(character)
		-- altGroup = 0 means show all
		if type(altGroup) ~= "string" then return true end
		
		if altGroup == L["ALT_GROUP_NOT_GROUPED"] then
			return not DataStore.AltGroups:IsGrouped(character)
		end

		return DataStore.AltGroups:Contains(altGroup, character)
	end
end

local function FilterByMisc(misc)
	return function(character)
		if misc == 0 then return true end  -- no filter ? exit

		if misc == 1 then
			local num = DataStore:GetNumMails(character) or 0
			return num > 0
			
		elseif misc == 2 then
			local num = DataStore:GetNumExpiredMails(character, 5) or 0
			return num > 0
			
		elseif misc == 3 then
			-- To do : auction house not checked in a long time
			return true
		
		elseif misc == 4 then		-- fully rested ?
			local level = DataStore:GetCharacterLevel(character)
			if level == MAX_PLAYER_LEVEL then
				return false
			end
			
			local _, _, _, _, _, _, isFullyRested, timeUntilFullyRested = DataStore:GetRestXPRate(character)
			
			return (isFullyRested or timeUntilFullyRested == 0)
			
		elseif misc == 5 then		-- exalted with guild ?
			return DataStore:IsExaltedWithGuild(character)
			
		elseif misc == 6 then		-- not exalted with guild ?
			return not DataStore:IsExaltedWithGuild(character)
			
		elseif misc == 7 then		-- could upgrade their riding skill ?
			return addon:CanUpgradeRidingSkill(character)
		end
		
		return true
	end
end

local function FilterByTradeskill(tradeskill)
	return function(character)
		if tradeskill == 0 then return true end  -- no filter ? exit
	
		local firstSecondary = addon.TradeSkills.AccountSummaryFirstSecondarySkillIndex
		
		-- primary professions
		if tradeskill < firstSecondary then
			local tradeskillID = addon.TradeSkills.AccountSummaryFiltersSpellIDs[tradeskill]

			local name1 = DataStore:GetProfession1Name(character)
			local name2 = DataStore:GetProfession2Name(character)
			local prof1 = name1 and DataStore:GetProfessionSpellID(name1)
			local prof2 = name2 and DataStore:GetProfessionSpellID(name2)

			return tradeskillID == prof1 or tradeskillID == prof2

		elseif tradeskill == firstSecondary then			-- Cooking
			return (DataStore:GetCookingRank(character) or 0) > 0

		elseif tradeskill == firstSecondary + 1 then		-- Fishing
			return (DataStore:GetFishingRank(character) or 0) > 0

		elseif tradeskill == firstSecondary + 2 then		-- Archaeology
			return (DataStore:GetArchaeologyRank(character) or 0) > 0
		end

		return true -- fallback	
	end
end


local function AddRealm(accountName, realmName)
	
	if AccountSharing.IsSharingInProgress() then
		local clientAccount = AccountSharing.GetClientAccountName()
		
		if clientAccount and clientAccount == accountName and realmName == DataStore.ThisRealm then
			-- if we're trying to add the account + realm we're currently copying, then don't add it now.
			return
		end
	end

	local realmMoney = 0
	local realmPlayed = 0
	local realmLevels = 0
	local realmBagSlots = 0
	local realmFreeBagSlots = 0
	local realmBankSlots = 0
	local realmFreeBankSlots = 0
	local realmAiL = 0
	local realmOffset = realmCount * 3
	local realmEpics = 0
	local realmRares = 0
	local realmUncommons = 0
	local realmHeirlooms = 0
	local numCharacters = 0
	
	-- 1) Add the realm name
	table.insert(characterList, { linetype = INFO_REALM_LINE + realmOffset,
		account = accountName,
		realm = realmName
	})
	
	-- 2) Add the characters (if they pass filters)
	filterPipeline:Run(DataStore:GetCharacters(realmName, accountName), function(character)
		
		realmLevels = realmLevels + (DataStore:GetCharacterLevel(character) or 0)
		realmMoney = realmMoney + (DataStore:GetMoney(character) or 0)
		realmPlayed = realmPlayed + (DataStore:GetPlayTime(character) or 0)
		realmEpics = realmEpics + (DataStore:GetNumEpicEquipment(character) or 0)
		realmRares = realmRares + (DataStore:GetNumRareEquipment(character) or 0)
		realmUncommons = realmUncommons + (DataStore:GetNumUncommonEquipment(character) or 0)
		realmHeirlooms = realmHeirlooms + (DataStore:GetNumHeirloomEquipment(character) or 0)
		
		realmBagSlots = realmBagSlots + (DataStore:GetNumBagSlots(character) or 0)
		realmFreeBagSlots = realmFreeBagSlots + (DataStore:GetNumFreeBagSlots(character) or 0)
		realmBankSlots = realmBankSlots + (DataStore:GetNumBankSlots(character) or 0)
		realmFreeBankSlots = realmFreeBankSlots + (DataStore:GetNumFreeBankSlots(character) or 0)
		realmAiL = realmAiL + (DataStore:GetAverageItemLevel(character) or 0)
		table.insert(characterList, { linetype = INFO_CHARACTER_LINE + realmOffset, key = character } )
		
		numCharacters = numCharacters + 1
	end)


	-- 3) Add the totals
	table.insert(characterList, { linetype = INFO_TOTAL_LINE + realmOffset,
		level = format("%s%d", colors.white, realmLevels),
		money = realmMoney,
		played = Formatter.TimeString(realmPlayed),
		bagSlots = realmBagSlots,
		freeBagSlots = realmFreeBagSlots,
		bankSlots = realmBankSlots,
		freeBankSlots = realmFreeBankSlots,
		realmAiL = (numCharacters ~= 0) and (realmAiL / numCharacters) or 0,
		epics = format("%s%d", colors.white, realmEpics),
		rares = format("%s%d", colors.white, realmRares),
		uncommons = format("%s%d", colors.white, realmUncommons),
		heirlooms = format("%s%d", colors.white, realmHeirlooms),
	} )

	totalMoney = totalMoney + realmMoney
	totalPlayed = totalPlayed + realmPlayed
	totalLevels = totalLevels + realmLevels
	realmCount = realmCount + 1
	
	-- remove empty realms if no characters have passed filters
	if numCharacters == 0 then
		table.remove(characterList)	-- remove the last 2 lines, which are the header and the total if no characters were found
		table.remove(characterList)
	end
end

local function BuildList()
	characterList = characterList or {}
	wipe(characterList)
	
	totalMoney = 0
	totalPlayed = 0
	totalLevels = 0
	realmCount = 0 -- will be required for sorting purposes
	
	options = Altoholic_SummaryTab_Options
	
	-- Setup our filter pipeline
	filterPipeline:Reset()
	
	filterPipeline:AddFilter(FilterByLevel(options.CurrentLevelsMin, options.CurrentLevelsMax))
	
	local factions = options.CurrentFactions
	if factions == 4 then
		factions = (UnitFactionGroup("player") == "Alliance") and 1 or 2
	end
	
	filterPipeline:AddFilter(FilterByFaction(factions))
	filterPipeline:AddFilter(FilterByRace(options.CurrentRaces))
	filterPipeline:AddFilter(FilterByClass(options.CurrentClasses))
	filterPipeline:AddFilter(FilterByBank(options.CurrentBankType))
	filterPipeline:AddFilter(FilterByAltGroup(options.CurrentAltGroup))
	filterPipeline:AddFilter(FilterByMisc(options.CurrentMisc))
	filterPipeline:AddFilter(FilterByTradeskill(options.CurrentTradeSkill))
	
	ProcessRealms(AddRealm)
end

local function AddRealmView(accountName, realmName)
	for index, line in pairs(characterList) do
		if mod(line.linetype, 3) == INFO_REALM_LINE then
			if (line.account == accountName) and (line.realm == realmName) then
				-- insert index to current line (INFO_REALM_LINE)
				table.insert(view, index)
				index = index + 1

				-- insert index to the rest of the realm 
				local linetype = mod(characterList[index].linetype, 3)
				while (linetype ~= INFO_REALM_LINE) do
					table.insert(view, index)
					index = index + 1
					if index > #characterList then
						return
					end
					linetype = mod(characterList[index].linetype, 3)
				end
				return
			end
		end
	end
end

local function BuildView()
	-- The character info index is a small table that basically indexes character info
	-- ex: character info contains data for 4 realms on two accounts, but the index only cares about the summary tab filter,
	-- and indexes just one realm, or one account
	view = view or {}
	wipe(view)
	
	ProcessRealms(AddRealmView)
	isViewValid = true
end

local function SortByFunction(a, b, func, ascending, column)
	if (a.linetype ~= b.linetype) then			-- sort by linetype first ..
		return a.linetype < b.linetype
	else													-- and when they're identical, sort  by func xx
		if mod(a.linetype, 3) ~= INFO_CHARACTER_LINE then
			return false		-- don't swap lines if they're not INFO_CHARACTER_LINE
		end

		local retA = func(self, a.key, column) or 0		-- set to zero if a return value is nil, so that they can be compared
		local retB = func(self, b.key, column) or 0

		-- 2021/02/15
		-- It may happen that an alt's key is not known at all in a DataStore module (ex: talents on low level alts)
		-- In such case, DataStore itself will not see the character key and alway return null (converted to 0 just above)
		-- If the other key is valid and returns a string, we might have a type conflict, so let's not swap lines
		if type(retA) ~= type(retB) then
			return false
		end
		
		if ascending then
			return retA < retB
		else
			return retA > retB
		end
	end
end

local function GetLineType(index)
	return mod(characterList[index].linetype, 3)
end

addon:Service("AltoholicUI.Characters",  function() 
	return {
		Sort = function(ascending, func, column)
			table.sort(characterList, function(a, b) return SortByFunction(a, b, func, ascending, column) end)
		end,
		Get = function(index)
			return characterList[index]
		end,
		GetView = function(isResizing)
			if not isViewValid then
				BuildList()
				BuildView()
			end
			
			-- if we are resizing, be sure to minimize the load and do not rebuild the List, only the view
			if isResizing then	
				BuildView()
			end
			
			return view
		end,
		InvalidateView = function()
			isViewValid = nil
		end,
		GetNum = function()
			return #characterList or 0
		end,
		GetInfo = function(index)
			-- with the line number in the characterList table, return the name, realm & account of a char.
			local lineType = GetLineType(index)
			
			if lineType == INFO_REALM_LINE then
				local line = characterList[index]
				return nil, line.realm, line.account
			elseif lineType == INFO_CHARACTER_LINE then
				local key = characterList[index].key
				local account, realm, name = strsplit(".", key)
				
				return name, realm, account, key
			end
		end,
		GetKey = function(index)
			local lineType = GetLineType(index)
			
			if lineType == INFO_CHARACTER_LINE then
				return characterList[index].key
			end
		end,
		IsRealmLine = function(index)
			return GetLineType(index) == INFO_REALM_LINE
		end,
		IsCharacterLine = function(index)
			return GetLineType(index) == INFO_CHARACTER_LINE
		end,
		IsTotalLine = function(index)
			return GetLineType(index) == INFO_TOTAL_LINE
		end,
		GetField = function(index, field)
			local character = characterList[index]
			if character then
				return character[field]
			end
		end,
		ToggleView = function(frame)
			for _, line in pairs(characterList) do
				if mod(line.linetype, 3) == INFO_REALM_LINE then
					local key = format("%s.%s", line.account, line.realm)
					collapsedRealms[key] = frame.isCollapsed
				end
			end
		end,
		ToggleHeader = function(frame)
			local line = frame:GetParent():GetID()
			if line == 0 then return end

			local header = characterList[line]
			local key = format("%s.%s", header.account, header.realm)

			if not collapsedRealms[key] then
				collapsedRealms[key] = true
			else
				collapsedRealms[key] = nil
			end
		end,
		IsRealmCollapsed = function(index)
			local header = characterList[index]
			local key = format("%s.%s", header.account, header.realm)

			return collapsedRealms[key]
		end,
		GetStats = function()
			return totalMoney, totalPlayed, totalLevels
		end,
}end)
