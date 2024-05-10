local addonName = "Altoholic"
local addon = _G[addonName]

addon:Service("AltoholicUI.SearchResults", function()

	local results = {}
	
	local TYPE_ITEM = 1
	local TYPE_CRAFT = 2
	local TYPE_GUILD_BANK_ITEM = 3

	local function GetCraftName(char, profession, num)
		-- this is a helper function to quickly retrieve the name of a craft based on a character, profession and line number
		
		local c = addon:GetCharacterTableByLine(char)
		local _, _, spellID = strsplit("^", c.recipes[profession].list[num])
		
		return GetSpellInfo(tonumber(spellID))
	end	
	
	-- ** Sort functions **
	
	local function SortByRarity(a, b, ascending)
		-- Note: this works fine, be careful of the fact that some epic item (4) have a value of 3 because they are upgraded rares
		-- (ex: 9.1 Korthia items)
		local valueA = (a.itemID) and select(3, GetItemInfo(a.itemID)) or 0
		local valueB = (b.itemID) and select(3, GetItemInfo(b.itemID)) or 0
		
		if ascending then
			return valueA < valueB
		else
			return valueA > valueB
		end
	end
	
	local function SortByName(a, b, ascending)
		-- TODO : some crafts do not have an item ID, since no item is created (ex: enchanting)
		local valueA = (a.itemID) and select(1, GetItemInfo(a.itemID)) or 0
		local valueB = (b.itemID) and select(1, GetItemInfo(b.itemID)) or 0
		
		if ascending then
			return valueA < valueB
		else
			return valueA > valueB
		end
	end
	
	local function SortByLevel(a, b, ascending)
		local valueA = (a.itemID) and select(4, GetItemInfo(a.itemID)) or 0
		local valueB = (b.itemID) and select(4, GetItemInfo(b.itemID)) or 0
		
		if ascending then
			return valueA < valueB
		else
			return valueA > valueB
		end
	end
	
	local function SortBySource(a, b, ascending)
		-- the 3rd value of a datastore key will be a character name or guild name
		local valueA = select(3, strsplit(".", a.sourceKey))
		local valueB = select(3, strsplit(".", b.sourceKey))
		
		if valueA == valueB then								-- if it's the same character name ..
			return SortByName(a, b, ascending)			-- .. then sort by item name
		elseif ascending then
			return valueA < valueB
		else
			return valueA > valueB
		end
	end

	local function SortByRealm(a, b, ascending)
		-- the 2nd value of a datastore key will be a realm name
		local valueA = select(2, strsplit(".", a.sourceKey))
		local valueB = select(2, strsplit(".", b.sourceKey))
		
		if valueA == valueB then								-- if it's the same realm ..
			return SortBySource(a, b, ascending)	-- .. then sort by character name
		elseif ascending then
			return valueA < valueB
		else
			return valueA > valueB
		end
	end
	
	return {
		AddItem = function(itemID, itemLink, sourceKey, count, location, isBattlePet, isGuildBank)
			local lineType = isGuildBank and TYPE_GUILD_BANK_ITEM or TYPE_ITEM
		
			table.insert(results, { lineType = lineType, 
				itemID = itemID,
				itemLink = itemLink,
				sourceKey = sourceKey,				-- character or guild key in DataStore
				count = count,
				location = location,
				isBattlePet = isBattlePet
			}) 
		end,
		AddCraft = function(characterKey, professionName, professionTable, spellID)
			table.insert(results, { lineType = TYPE_CRAFT, 
				itemID = DataStore:GetCraftResultItem(spellID),
				sourceKey = characterKey,
				professionName = professionName,
				profession = professionTable,
				spellID = spellID
			}) 
		end,
		
		Clear = function() wipe(results) end,
		GetSize = function() return #results end,
		GetResult = function(index) return results[index] end,
		
		IsPlayerItem = function(index) return results[index].lineType == TYPE_ITEM end,
		IsPlayerCraft = function(index) return results[index].lineType == TYPE_CRAFT end,
		IsGuildItem = function(index) return results[index].lineType == TYPE_GUILD_BANK_ITEM end,
		
		Sort = function(field, sortOrder)
			if #results == 0 then return end
			
			if field == "rarity" then
				table.sort(results, function(a, b) return SortByRarity(a, b, sortOrder) end)
			elseif field == "name" then
				table.sort(results, function(a, b) return SortByName(a, b, sortOrder) end)
			elseif field == "level" then
				table.sort(results, function(a, b) return SortByLevel(a, b, sortOrder) end)
			elseif field == "source" then
				table.sort(results, function(a, b) return SortBySource(a, b, sortOrder) end)
			elseif field == "realm" then
				table.sort(results, function(a, b) return SortByRealm(a, b, sortOrder) end)
			end
		end
}end)
