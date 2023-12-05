local addonName = ...
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local LII = LibStub("LibItemInfo-1.0")
local LOI = LibStub("LibObjectInfo-1.0")
local MVC = LibStub("LibMVC-1.0")
local Options = MVC:GetService("AltoholicUI.Options")
local AccountSharing = MVC:GetService("AltoholicUI.AccountSharing")

local storedLink = nil

local hearthstoneItemIDs = {
	[6948] = true,				-- Hearthstone
	[140192] = true,			-- Dalaran Hearthstone
	[110560] = true,			-- Garrison Hearthstone
	[128353] = true,			-- Admiral's Compass
	[141605] = true,			-- Flight Master's Whistle
}

-- From reagent types in : \Altoholic\Libs\LibItemInfo-1.0\LibItemInfo.lua
-- to bank types in : \DataStore\Enum.lua
local reagentTypeToBankType = {
	
	[1] = 7,		-- Alchemy => Alchemy
	[2] = 6,		-- Blacksmithing => Metal & Stone
	[3] = 8,		-- Enchanting
	[4] = 9,		-- Engineering
	[5] = 3,		-- Herbalism => Herb
	[6] = 11,	-- Inscription
	[7] = 10,	-- Jewelcrafting
	[8] = 5,		-- Leatherworking => Leather
	[9] = 6,		-- Mining => Metal & Stone
	[10] = 5,	-- Skinning => Leather
	[11] = 4,	-- Tailoring => Cloth
	[12] = 1,	-- Cooking
	[14] = 2,	-- Fishing
}

-- *** Utility functions ***
local function GetCraftNameFromRecipeLink(link)
	-- get the craft name from the itemlink (strsplit on | to get the 4th value, then split again on ":" )
	local recipeName = select(4, strsplit("|", link))
	local craftName

	-- try to determine if it's a transmute (has 2 colons in the string --> Alchemy: Transmute: blablabla)
	local pos = string.find(recipeName, L["Transmute"])
	if pos then	-- it's a transmute
		return string.sub(recipeName, pos, -2)
	else
		craftName = select(2, strsplit(":", recipeName))
	end
	
	if craftName == nil then		-- will be nil for enchants
		return string.sub(recipeName, 3, -2)		-- ex: "Enchant Weapon - Striking"
	end
	
	return string.sub(craftName, 2, -2)	-- at this point, get rid of the leading space and trailing square bracket
end

local isTooltipDone, isNodeDone			-- for informant
local cachedItemID, cachedCount, cachedTotal
local cachedRecipeOwners
local cachedAltStorage

local itemCounts = {}
local itemCountsLabels = { L["Bags"], L["Bank"], VOID_STORAGE, REAGENT_BANK, L["AH"], L["Equipped"], L["Mail"], CURRENCY, L["Reagent Bag"] }
local counterLines = {}		-- list of lines containing a counter to display in the tooltip


local function AddCounterLine(owner, counters)
	table.insert(counterLines, { ["owner"] = owner, ["info"] = counters } )
end

local function WriteCounterLines(tooltip)
	if #counterLines == 0 then return end

	if Options.Get("UI.Tooltip.ShowItemCount") then			-- add count per character/guild
		tooltip:AddLine(" ",1,1,1)
		for _, line in ipairs (counterLines) do
			tooltip:AddDoubleLine(line.owner, format("%s%s", colors.teal, line.info))
		end
	end
end

local function WriteTotal(tooltip)
	if Options.Get("UI.Tooltip.ShowTotalItemCount") and cachedTotal then
		tooltip:AddLine(cachedTotal, 1,1,1)
	end
end

local function GetRealmsList(isAccountBound)
	-- returns the list of realms to check, either only this realm, or merged realms too.
	local realms = {}
	table.insert(realms, DataStore.ThisRealm)		-- always "this realm" first
	
	if isAccountBound and Options.Get("UI.Tooltip.ShowAllRealmsCount") then
		for realm, _ in pairs(DataStore:GetRealms()) do
			if realm ~= DataStore.ThisRealm then
				table.insert(realms, realm)
			end
		end
	
	elseif Options.Get("UI.Tooltip.ShowMergedRealmsCount") then
		for _, connectedRealm in pairs(DataStore:GetRealmsConnectedWith(DataStore.ThisRealm)) do
			table.insert(realms, connectedRealm)
		end
	end
	
	return realms
end

local function GetCharacterItemCount(character, searchedID)
	itemCounts[1], itemCounts[2], itemCounts[3], itemCounts[4], itemCounts[9] = DataStore:GetContainerItemCount(character, searchedID)
	itemCounts[5] = DataStore:GetAuctionHouseItemCount(character, searchedID)
	itemCounts[6] = DataStore:GetInventoryItemCount(character, searchedID)
	itemCounts[7] = DataStore:GetMailItemCount(character, searchedID)
	
	local charCount = 0
	for _, v in pairs(itemCounts) do
		charCount = charCount + v
	end
	
	if charCount > 0 then
		local account, realm, char = strsplit(".", character)
		local name = DataStore:GetColoredCharacterName(character) or char		-- if for any reason this char isn't in DS_Characters, use the name part of the key
		
		local isOtherAccount = (account ~= DataStore.ThisAccount)
		local isOtherRealm = (realm ~= DataStore.ThisRealm)
		
		if isOtherAccount and isOtherRealm then		-- other account AND other realm
			name = format("%s%s (%s / %s)", name, colors.yellow, account, realm)
		elseif isOtherAccount then							-- only other account
			name = format("%s%s (%s)", name, colors.yellow, account)
		elseif isOtherRealm then							-- only other realm
			name = format("%s%s (%s)", name, colors.yellow, realm)
		end
		
		local t = {}
		for k, v in pairs(itemCounts) do
			if v > 0 then	-- if there are more than 0 items in this container
				table.insert(t, format("%s%s: %s%s", colors.white, itemCountsLabels[k], colors.teal, v))
			end
		end

		if Options.Get("UI.Tooltip.ShowSimpleCount") then
			AddCounterLine(name, format("%s%s", colors.orange, charCount))
		else
			-- charInfo should look like 	(Bags: 4, Bank: 8, Equipped: 1, Mail: 7), table concat takes care of this
			AddCounterLine(name, format("%s%s%s (%s%s)", colors.orange, charCount, colors.white, table.concat(t, format("%s, ", colors.white)), colors.white))
		end
	end
	
	return charCount
end

local function GetAccountItemCount(account, searchedID, isAccountBound)
	local count = 0

	for _, realm in pairs(GetRealmsList(isAccountBound)) do
		for _, character in pairs(DataStore:GetCharacters(realm, account)) do
			if Options.Get("UI.Tooltip.ShowCrossFactionCount") then
				count = count + GetCharacterItemCount(character, searchedID)
			else
				if	DataStore:GetCharacterFaction(character) == UnitFactionGroup("player") then
					count = count + GetCharacterItemCount(character, searchedID)
				end
			end
		end
	end
	
	return count
end

local function IsItemAccountBound(itemLink)
	if not itemLink then return end
	
	local tooltip = AltoScanningTooltip
	
	tooltip:ClearLines()
	tooltip:SetHyperlink(itemLink)
	
	-- ITEM_BIND_TO_BNETACCOUNT = "Binds to Blizzard account"
	-- ITEM_BNETACCOUNTBOUND = "Blizzard Account Bound"
	
	local tooltipName = tooltip:GetName()
	local numLines = tooltip:NumLines()
	if numLines > 5 then numLines = 5 end
	
	for i = 1, numLines do		-- parse the first 5 lines maximum
		local tooltipText = _G[format("%sTextLeft%d", tooltipName, i)]:GetText()
		
		if tooltipText == ITEM_BIND_TO_BNETACCOUNT or tooltipText == ITEM_BNETACCOUNTBOUND then
			return true
		end
	end
end

local function GetItemCount(searchedID, itemLink)
	-- Return the total amount of times an item is present on this realm, and prepares the counterLines table for later display by the tooltip
	wipe(counterLines)
	local count = 0

	-- determine if the item is account bound
	local isAccountBound = IsItemAccountBound(itemLink)
	
	if Options.Get("UI.Tooltip.ShowAllAccountsCount") and not AccountSharing.IsSharingInProgress() then
		for account in pairs(DataStore:GetAccounts()) do
			count = count + GetAccountItemCount(account, searchedID, isAccountBound)
		end
	else
		count = GetAccountItemCount(DataStore.ThisAccount, searchedID, isAccountBound)
	end
	
	local showCrossFaction = Options.Get("UI.Tooltip.ShowCrossFactionCount")
	
	if Options.Get("UI.Tooltip.ShowGuildBankCount") then
		for _, realm in pairs(GetRealmsList(isAccountBound)) do
			for guildName, guildKey in pairs(DataStore:GetGuilds(realm)) do
				local hideInTooltip = Options.Get(format("%s.HideInTooltip", guildKey)) or false
				local bankFaction = DataStore:GetGuildBankFaction(guildKey)

				-- do not show cross faction counters for guild banks if they were not requested
				if (showCrossFaction or (not showCrossFaction and (DataStore:GetGuildBankFaction(guildKey) == UnitFactionGroup("player")))) 
					and not hideInTooltip
				then
					local guildCount = 0
					
					local guildLabel = format("%s%s|r", colors.green, guildName)
					
					if Options.Get("UI.Tooltip.ShowGuildBankRealm") then
						guildLabel = format("%s %s(%s)|r", guildLabel, colors.yellow, realm)
					end
					
					if Options.Get("UI.Tooltip.ShowGuildBankCountPerTab") then
						local tabCounters = {}
						
						local tabCount
						for tabID = 1, 8 do 
							tabCount = DataStore:GetGuildBankTabItemCount(guildKey, tabID, searchedID)
							if tabCount and tabCount > 0 then
								table.insert(tabCounters,  format("%s%s: %s%d", colors.white, DataStore:GetGuildBankTabName(guildKey, tabID), colors.teal, tabCount))
							end
						end
						
						if #tabCounters > 0 then
							guildCount = DataStore:GetGuildBankItemCount(guildKey, searchedID) or 0
							AddCounterLine(guildLabel, format("%s%d %s(%s%s)", colors.orange, guildCount, colors.white, table.concat(tabCounters, ","), colors.white))
						end
					else
						guildCount = DataStore:GetGuildBankItemCount(guildKey, searchedID) or 0
						if guildCount > 0 then
							AddCounterLine(guildLabel, format("%s(%s: %s%d%s)", colors.white, GUILD_BANK, colors.teal, guildCount, colors.white))
						end
					end
						
					if Options.Get("UI.Tooltip.IncludeGuildBankInTotal") then
						count = count + guildCount
					end
				end
			end
		end
	end

	return count
end

function addon:GetRecipeOwners(professionName, link, recipeLevel)
	local craftName
	local spellID = addon:GetSpellIDFromRecipeLink(link)

	if not spellID then		-- spell id unknown ? let's parse the tooltip
		craftName = GetCraftNameFromRecipeLink(link)
		if not craftName then return end		-- still nothing usable ? then exit
	end
	
	local know = {}				-- list of alts who know this recipe
	local couldLearn = {}		-- list of alts who could learn it
	local willLearn = {}			-- list of alts who will be able to learn it later

	if not recipeLevel then
		-- it seems that some tooltip libraries interfere and cause a recipeLevel to be nil
		return know, couldLearn, willLearn
	end
	
	local profession, isKnownByChar
	for characterName, character in pairs(DataStore:GetCharacters()) do
		profession = DataStore:GetProfession(character, professionName)

		isKnownByChar = nil
		if profession then
			if spellID then			-- if spell id is known, just find its equivalent in the professions
				isKnownByChar = DataStore:IsCraftKnown(profession, spellID)
			else
				DataStore:IterateRecipes(profession, 0, 0, function(recipeData)
					local _, recipeID, isLearned = DataStore:GetRecipeInfo(recipeData)
					local skillName = GetSpellInfo(recipeID) or ""

					if string.lower(skillName) == string.lower(craftName) and isLearned then
						isKnownByChar = true
						return true	-- stop iteration
					end
				end)
			end

			local coloredName = DataStore:GetColoredCharacterName(character)
			
			if isKnownByChar then
				table.insert(know, coloredName)
			else
				local currentLevel = DataStore:GetProfessionInfo(DataStore:GetProfession(character, professionName))
				if currentLevel > 0 then
					if currentLevel < recipeLevel then
						table.insert(willLearn, format("%s |r(%d)", coloredName, currentLevel))
					else
						table.insert(couldLearn, format("%s |r(%d)", coloredName, currentLevel))
					end
				end
			end
		end
	end
	
	return know, couldLearn, willLearn
end

local function GetRecipeOwnersText(professionName, link, recipeLevel)

	local know, couldLearn, willLearn = addon:GetRecipeOwners(professionName, link, recipeLevel)
	
	local lines = {}
	if #know > 0 then
		table.insert(lines, format("%s%s|r : %s%s\n", colors.teal, L["Already known by"], colors.white, table.concat(know, ", ")))
	end
	
	if #couldLearn > 0 then
		table.insert(lines, format("%s%s|r : %s%s\n", colors.yellow, L["Could be learned by"], colors.white, table.concat(couldLearn, ", ")))
	end
	
	if #willLearn > 0 then
		table.insert(lines, format("%s%s|r : %s%s", colors.red, L["Will be learnable by"], colors.white, table.concat(willLearn, ", ")))
	end
	
	return table.concat(lines, "\n")
end

local function AddGlyphOwners(itemID, tooltip)
	local know = {}				-- list of alts who know this glyoh
	local couldLearn = {}		-- list of alts who could learn it

	local knows, could
	for characterName, character in pairs(DataStore:GetCharacters()) do
		knows, could = DataStore:IsGlyphKnown(character, itemID)
		if knows then
			table.insert(know, characterName)
		elseif could then
			table.insert(couldLearn, characterName)
		end
	end
	
	if #know > 0 then
		tooltip:AddLine(" ",1,1,1)
		tooltip:AddLine(format("%s%s|r : %s%s", colors.teal, L["Already known by"], colors.white, table.concat(know, ", ")), 1, 1, 1, 1)
	end
	
	if #couldLearn > 0 then
		tooltip:AddLine(" ",1,1,1)
		tooltip:AddLine(format("%s%s|r : %s%s", colors.yellow, L["Could be learned by"], colors.white, table.concat(couldLearn, ", ")), 1, 1, 1, 1)
	end
end

local function ShowGatheringNodeCounters()
	-- exit if player does not want counters for known gathering nodes
	if Options.Get("UI.Tooltip.ShowGatheringNodesCount") == false then return end

	-- Get the first tooltip line
	local line = _G["GameTooltipTextLeft1"]:GetText()
	if not line then return end 	-- may occasionally be nil
	
	-- The first line is expected to contain the name of the node, but if the player is in altitude, the name
	-- of the node will be preceded by an arrow pointing down. So attempt to detect the |t closing the texture
	-- and make a substring of what follows it.
	local endPos = select(2, line:find("|t", 1))
	
	if endPos then
		line = line:sub(endPos + 1)
	end
	
	local itemID = LOI:IsGatheringNode(line)
	if not itemID or (itemID == cachedItemID) then return end					-- is the item in the tooltip a known type of gathering node ?
	
	if Informant then
		isNodeDone = true
	end

	-- check player bags to see how many times he owns this item, and where
	if Options.Get("UI.Tooltip.ShowItemCount") or Options.Get("UI.Tooltip.ShowTotalItemCount") then
		cachedCount = GetItemCount(itemID) -- if one of the 2 options is active, do the count
		cachedTotal = (cachedCount > 0) and format("%s%s: %s%d", colors.gold, L["Total owned"], colors.teal, cachedCount) or nil
	end
	
	WriteCounterLines(GameTooltip)
	WriteTotal(GameTooltip)
end

local function ProcessTooltip(tooltip, link)
	if Informant and isNodeDone then
		return
	end
	
	local itemID = addon:GetIDFromLink(link)
	if not itemID then return end
	
	if (itemID == 0) and (TradeSkillFrame ~= nil) and TradeSkillFrame:IsVisible() then
		if (GetMouseFocus():GetName()) == "TradeSkillSkillIcon" then
			itemID = tonumber(GetTradeSkillItemLink(TradeSkillFrame.selectedSkill):match("item:(%d+):")) or nil
		else
			for i = 1, 8 do
				if (GetMouseFocus():GetName()) == format("TradeSkillReagent%d", i) then
					itemID = tonumber(GetTradeSkillReagentItemLink(TradeSkillFrame.selectedSkill, i):match("item:(%d+):")) or nil
					break
				end
			end
		end
	end
	
	if (itemID == 0) then return end
	
	-- if there's no cached item id OR if it's different from the previous one ..
	if (not cachedItemID) or 
		(cachedItemID and (itemID ~= cachedItemID)) then

		cachedAltStorage = nil
		cachedRecipeOwners = nil
		cachedItemID = itemID			-- we have searched this ID ..
		
		-- .. then check player bags to see how many times he owns this item, and where
		if Options.Get("UI.Tooltip.ShowItemCount") or Options.Get("UI.Tooltip.ShowTotalItemCount") then
			cachedCount = GetItemCount(itemID, link) -- if one of the 2 options is active, do the count
			cachedTotal = (cachedCount > 0) and format("%s%s: %s%s", colors.gold, L["Total owned"], colors.teal, cachedCount) or nil
		end
	end

	-- add item cooldown text
	local owner = tooltip:GetOwner()
	if owner and owner.startTime then
		tooltip:AddLine(format(ITEM_COOLDOWN_TIME, SecondsToTime(owner.duration - (GetTime() - owner.startTime))),1,1,1)
	end

	local isHearth = hearthstoneItemIDs[itemID] 
	local showHearth = Options.Get("UI.Tooltip.ShowHearthstoneCount")
	
	if showHearth or (not showHearth and not isHearth) then
		WriteCounterLines(tooltip)
		WriteTotal(tooltip)
	end
	
	local itemType, expansion, expansionID, arg1, arg2, arg3 = LII:GetItemSource(itemID)
	
	if Options.Get("UI.Tooltip.ShowItemSource") then
		local TYPE_REAGENT = 1
		local TYPE_DUNGEON_LOOT = 2
		local TYPE_RAID_LOOT = 3
		local TYPE_FACTION_ITEM = 5
		local TYPE_ZONE_ITEM = 6
		local TYPE_QUEST_ITEM = 7	-- Quest items that are safe to delete after quest completion.
		
		if itemType and expansion then
			
			tooltip:AddLine(" ",1,1,1)
			if itemType == TYPE_REAGENT then
				tooltip:AddLine(format("%s%s: %s%s", colors.gold, INFO, colors.teal, arg1), 1,1,1)
				if arg2 then
					tooltip:AddLine(format("%s%s: %s%s", colors.gold, L["Goes in"], colors.teal, arg2), 1,1,1)
				end
			
			elseif itemType == TYPE_DUNGEON_LOOT then
				tooltip:AddLine(format("%s%s: %s%s", colors.gold, ENCOUNTER_JOURNAL_INSTANCE, colors.teal, arg1), 1,1,1)
				tooltip:AddLine(format("%s%s: %s%s", colors.gold, ENCOUNTER_JOURNAL_ENCOUNTER , colors.teal, arg2), 1,1,1)
				
			elseif itemType == TYPE_RAID_LOOT then
				tooltip:AddLine(format("%s%s: %s%s", colors.gold, RAID, colors.teal, arg1), 1,1,1)
				tooltip:AddLine(format("%s%s: %s%s", colors.gold, ENCOUNTER_JOURNAL_ENCOUNTER , colors.teal, arg2), 1,1,1)
			
			elseif itemType == TYPE_FACTION_ITEM then
				tooltip:AddLine(format("%s%s: %s%s", colors.gold, FACTION, colors.teal, arg1), 1,1,1)
				if arg2 then
					tooltip:AddLine(format("%s%s: %s%s", colors.gold, ENCOUNTER_JOURNAL_INSTANCE, colors.teal, arg2), 1,1,1)
				end
				
			elseif itemType == TYPE_ZONE_ITEM then
				tooltip:AddLine(format("%s%s: %s%s", colors.gold, ZONE, colors.teal, arg1), 1,1,1)

				if arg2 > 0 and arg3 > 0 then
					tooltip:AddLine(format("%s%s: %s%2.1f %2.1f", colors.gold, USE, colors.teal, (arg2/10), (arg3/10)), 1,1,1)
					
				end
				
			elseif itemType == TYPE_QUEST_ITEM then
				tooltip:AddLine(format("%s%s: %s%s", colors.gold, USE, colors.teal, arg1), 1,1,1)
			
			end
			
			if Options.Get("UI.Tooltip.ShowItemXPack") then
				tooltip:AddLine(format("%s%s: %s%s %s(%d.0)", colors.gold, EXPANSION_FILTER_TEXT, colors.teal, expansion,
					colors.yellow, expansionID + 1), 1,1,1)
			end
		end
	end
	
	local itemSubType, _, _, _, _, classID, subclassID, bindType = select(7, GetItemInfo(itemID))
	
	-- Show "Could be stored on" info
	if Options.Get("UI.Tooltip.ShowCouldBeStoredOn") and itemType and expansionID and expansionID < GetExpansionLevel() then
		
		local bankType = reagentTypeToBankType[arg3]
		
		-- Only for trade goods, and not soulbound
		if classID == Enum.ItemClass.Tradegoods and bindType == LE_ITEM_BIND_NONE and bankType then
			if not cachedAltStorage then
				local charList = {}
			
				-- Loop on this realm's characters only
				for _, character in pairs(DataStore:GetCharacters()) do
					-- Do not show the current character
					if character ~= DataStore.ThisCharKey and DataStore:IsBankType(character, bankType) then
						table.insert(charList, DataStore:GetColoredCharacterName(character))
					end
				end
				
				-- size may be 0 if only the current alt is the actual bank for this type of item
				if #charList > 0 then
					cachedAltStorage = table.concat(charList, format("%s, ", colors.white))
				end
			end
			
			if cachedAltStorage then
				tooltip:AddLine(" ",1,1,1)
				tooltip:AddLine(format("%s%s: %s", colors.gold, L["Could be stored on"], cachedAltStorage))
			end
		end
	end
	
	
	if Options.Get("UI.Tooltip.ShowItemID") then
		local iLevel = select(4, GetItemInfo(itemID))
		
		if iLevel then
			tooltip:AddLine(" ",1,1,1)
			tooltip:AddDoubleLine(format("Item ID: %s%s", colors.green, itemID), format("iLvl: %s%s", colors.green, iLevel))
		end
	end

	
	-- 25/01/2015: Removed the code that displayed the pet owners, since they have been account wide for a while now..
	
	if classID == Enum.ItemClass.Glyph then
		AddGlyphOwners(itemID, tooltip)
		return
	end
	
	if Options.Get("UI.Tooltip.ShowKnownRecipes") == false then return end -- exit if recipe information is not wanted
	
	if classID ~= Enum.ItemClass.Recipe then return end -- exit if not a recipe
	if subclassID == Enum.ItemRecipeSubclass.Book then return end -- exit if it's a book

	if not cachedRecipeOwners then
		cachedRecipeOwners = GetRecipeOwnersText(itemSubType, link, addon:GetRecipeLevel(link, tooltip))
	end
	
	if cachedRecipeOwners then
		tooltip:AddLine(" ",1,1,1)	
		tooltip:AddLine(cachedRecipeOwners, 1, 1, 1, 1)
		tooltip:AddLine(" ",1,1,1)	
	end	
end

function addon:GetItemCount(searchedID)
	-- "public" for other addons using it, like XLoot
	return GetItemCount(searchedID)
end

addon:Service("AltoholicUI.Tooltip", { function()

	local function Hook_SetCurrencyToken(self, index, ...)
		if not index then return end

		local currency = C_CurrencyInfo.GetCurrencyListInfo(index)
		if not currency then return end

		GameTooltip:AddLine(" ",1,1,1)

		local total = 0
		
		local characters = DataStore:HashValueToSortedArray(DataStore:GetCharacters())
		
		for _, character in pairs(characters) do
			local _, count = DataStore:GetCurrencyInfoByName(character, currency.name)
			if count and count > 0 then
				GameTooltip:AddDoubleLine(DataStore:GetColoredCharacterName(character), format("%s%s", colors.teal, count))
				total = total + count
			end
			
		end
		
		if total > 0 then
			GameTooltip:AddLine(" ",1,1,1)
		end
		GameTooltip:AddLine(format("%s%s: %s%s", colors.gold, L["Total owned"], colors.teal, total ) ,1,1,1)
		GameTooltip:Show()
	end

	return {
		Initialize = function()
			
			-- install a pre-/post-hook on the given tooltip's method
			-- simplified version of LibExtraTip's hooking
			local function InstallHook(tooltip, method, prehook, posthook)
				local orig = tooltip[method]
				
				local stub = function(...)
					if prehook then prehook(...) end
					local a,b,c,d,e,f,g,h,i,j,k = orig(...)
					if posthook then posthook(...) end
					
					return a,b,c,d,e,f,g,h,i,j,k
				end
				
				tooltip[method] = stub
			end
			
			-- ** Setup GameTooltip script hooks **
			
			InstallHook(GameTooltip, "SetCurrencyToken", nil, Hook_SetCurrencyToken)
			InstallHook(GameTooltip, "SetQuestItem", function(self, itemType, index) 
				storedLink = GetQuestItemLink(itemType, index)
			end)
			InstallHook(GameTooltip, "SetQuestLogItem", function(self, itemType, index) 
				storedLink = GetQuestLogItemLink(itemType, index)
			end)
			InstallHook(GameTooltip, "SetRecipeResultItem", function(self, recipeID)
				if recipeID then
					storedLink = C_TradeSkillUI.GetRecipeItemLink(recipeID)
				end
			end)
			InstallHook(GameTooltip, "SetRecipeReagentItem", function(self, recipeID, reagentIndex)
				if recipeID and reagentIndex then
					local schematic = C_TradeSkillUI.GetRecipeSchematic(recipeID, false)
					local reagent = schematic.reagentSlotSchematics[reagentIndex]
					if reagent then
						local itemID = reagent.reagents[1].itemID
					
						storedLink = select(2, GetItemInfo(itemID))
					end
					
					-- print(recipeID, reagentIndex)
					-- storedLink = C_TradeSkillUI.GetRecipeReagentItemLink(recipeID, reagentIndex)
				end
			end)
			
			GameTooltip:HookScript("OnShow", function(self)
				ShowGatheringNodeCounters()
				GameTooltip:Show()
			end)
			
			local function OnTooltipSetItem(self, data)
				if (not isTooltipDone) and self then
					isTooltipDone = true

					local _, link = GetItemInfo(data.id)

					if link then
						ProcessTooltip(self, link)
					end
				end			
			end
			
			TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, OnTooltipSetItem)
			-- Todo : currency link !
			--TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Currency, see if Hook_SetCurrencyToken can be used)

			GameTooltip:HookScript("OnTooltipCleared", function(self)
				isTooltipDone = nil
				isNodeDone = nil		-- for informant
				storedLink = nil
			end)

			-- ** Setup ItemRefTooltip script hooks **
			
			ItemRefTooltip:HookScript("OnShow", function(self)
				addon:ListCharsOnQuest( ItemRefTooltipTextLeft1:GetText(), UnitName("player"), ItemRefTooltip)
				ItemRefTooltip:Show()
			end)

			ItemRefTooltip:HookScript("OnTooltipCleared", function(self)
				isTooltipDone = nil
			end)
			
			-- LinkWrangler support
			if LinkWrangler then
				LinkWrangler.RegisterCallback ("Altoholic", function(frame)
					local _, link = frame:GetItem()
					if link then
						ProcessTooltip(frame, link)
					end
				end, "refresh")
			end
		end,
		RefreshTooltip = function()
			cachedItemID = nil	-- putting this at NIL will force a tooltip refresh in self:ProcessToolTip
		end,

		GetItemCount = function(searchedID)
			-- "public" for other addons using it
			return GetItemCount(searchedID)
		end,
	}
end})
