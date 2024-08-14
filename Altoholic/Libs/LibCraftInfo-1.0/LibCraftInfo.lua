--[[	*** LibCraftInfo ***
Written by : Thaoky, EU-Marécages de Zangar
September 21st, 2013

This library contains various information about crafts, namely:

- the item id that results from a craft
- the item id of the recipe that taught the craft (if any)
- the expansion pack to which that craft is related

--]]

local LIB_VERSION_MAJOR, LIB_VERSION_MINOR = "LibCraftInfo-1.0", 5
local lib = LibStub:NewLibrary(LIB_VERSION_MAJOR, LIB_VERSION_MINOR)

if not lib then return end -- No upgrade needed

--[[ ** Data Format **
format [spellID] = attribute (number, to be read bit by bit)

'attribute' :
	bits 0-3 : internal id of the tradeskill (4 bits)
	bits 4-7 : expansion level (4 bits)
	bits 8-27 : item id (resulting item)
	bits 28-47 : item id (of the recipe item teaching this spell ID)
--]]

-- *** Bitwise operations ***
local bAnd = bit.band
local bOr = bit.bor
local RShift = bit.rshift
local LShift = bit.lshift

local function RightShift(value, numBits)
	-- for bits beyond bit 31
	return math.floor(value / 2^numBits)
end

local function LeftShift(value, numBits)
   -- for bits beyond bit 31
   return value * 2^numBits
end

local professionToInternalID = {
	["Alchemy"] = 0,
	["Blacksmithing"] = 1,
	["Enchanting"] = 2,
	["Engineering"] = 3,
	["Inscription"] = 4,
	["Jewelcrafting"] = 5,
	["Leatherworking"] = 6,
	["Mining"] = 7,
	["Tailoring"] = 8,

	-- Secondary
	["Cooking"] = 9,
	["First Aid"] = 10,
	["Fishing"] = 11,
}

local internalIDToProfession = {
	[0] = 2259,		-- Alchemy
	[1] = 3100,		-- Blacksmithing
	[2] = 7411,		-- Enchanting
	[3] = 4036,		-- Engineering
	[4] = 45357,	-- Inscription
	[5] = 25229,	-- Jewelcrafting
	[6] = 2108,		-- Leatherworking
	[7] = 2656,		-- Mining
	[8] = 3908,		-- Tailoring
	[9] = 2550,		-- Cooking
	[10] = 3273,	-- First Aid 
	[11] = 7732,	-- Fishing (cataclysm)
}

for internalID, spellID in pairs(internalIDToProfession) do
	professionToInternalID[spellID] = internalID		-- add the spellID's as indexes, for reverse lookup
	
	local spellName = C_Spell.GetSpellName(spellID)			-- Get the localized name of this profession
	if spellName then
		professionToInternalID[spellName] = internalID		-- if found, add it too
	end	
end

local function GetProfessionInternalID(name)
	return professionToInternalID[name]
end

--	*** API ***

-- Returns the localized name of the profession to which a given craft belongs
function lib:GetCraftProfession(spellID)
	local attrib = lib.dataSource[spellID]
	
	if attrib then		-- get the internal profession id, then the associated spell id, and return the localized name with GetSpellInfo
		return C_Spell.GetSpellName(internalIDToProfession[bAnd(attrib, 15)])
	end
end

-- Returns the expansion pack of a given craft
function lib:GetCraftXPack(spellID)
	local attrib = lib.dataSource[spellID]
	
	if attrib then
		return bAnd(RightShift(attrib, 4), 15)
	end
end

-- Returns the itemID of the item created by a given spellID
function lib:GetCraftResultItem(spellID)
	local attrib = lib.dataSource[spellID]
	
	if attrib then
		return bAnd(RightShift(attrib, 8), 1048575)	-- 20 bits mask : 2^20 - 1
	end
end

-- Returns the itemID of the item/recipe that taught this spellID
function lib:GetCraftSourceItem(spellID)
	local attrib = lib.dataSource[spellID]
	
	if attrib then
		return RightShift(attrib, 28)
	end
end

-- Returns the name of the profession that created the item
function lib:GetItemSource(itemID)
	local id
	for spellID, attrib in pairs(lib.dataSource) do
		id = bAnd(RightShift(attrib, 8), 1048575)	-- 20 bits mask : 2^20 - 1
		if id == itemID then
			return lib:GetCraftProfession(spellID), spellID			-- Returns the profession name
		end
	end
end

-- Returns the spellID taught by a given itemID (recipe item)
function lib:GetRecipeLearnedSpell(itemID)
	local id
	
	for spellID, attrib in pairs(lib.dataSource) do
		id = RightShift(attrib, 28)
		if id == itemID then
			return spellID
		end
	end
end

-- Returns a list of crafts (=spellID's) for a given profession, for a given expansion
function lib:GetProfessionCraftList(professionSpellID, expansionID)
	
	local searchedID = GetProfessionInternalID(professionSpellID) + (expansionID * 16)
	local tmpID
	
	local out = {}
	
	for spellID, attrib in pairs(lib.dataSource) do
		tmpID = bAnd(attrib, 255)
		if tmpID == searchedID then
			table.insert(out, spellID)
		end
	end

	return out
end

-- Sets information about a given spellID
function lib:SetCraftInfo(professionId, spellID, xpack, itemID, recipeID)
	--[[ ** Stores a new craft into craftInfo **
	format [spellID] = attribute (number, to be read bit by bit)
	
	'attribute' :
		bits 0-3 : internal id of the tradeskill (4 bits)
		bits 4-7 : expansion level (4 bits)
		bits 8-27 : item id (resulting item)
		bits 28-47 : item id (of the recipe item teaching this spell ID)
	--]]

	recipeID = recipeID or 0	-- recipe id is optional, there might not be an item that teaches this spellID
	lib.dataSource[spellID] = LeftShift(recipeID, 28) + LeftShift(itemID, 8) + LeftShift(xpack, 4) + professionId
end

-- Removes craft information for a given spellID
function lib:DeleteCraftInfo(spellID)
	-- use this method if a datamined spellID is no longer recognized in-game, without touching the automatically generated list
	lib.dataSource[spellID] = nil
end
