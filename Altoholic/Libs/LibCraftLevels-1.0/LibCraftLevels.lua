--[[	*** LibCraftLevels ***
Written by : Thaoky, EU-Marécages de Zangar
September 21st, 2013

This library contains a database of craft levels.

--]]

local LIB_VERSION_MAJOR, LIB_VERSION_MINOR = "LibCraftLevels-1.0", 2
local lib = LibStub:NewLibrary(LIB_VERSION_MAJOR, LIB_VERSION_MINOR)

if not lib then return end -- No upgrade needed

-- *** Bitwise operations ***
local bAnd = bit.band
local bOr = bit.bor
local RShift = bit.rshift
local LShift = bit.lshift

local function RightShift(value, numBits)
	-- for bits beyond bit 31
	return math.floor(value / 2^numBits)
end

--	*** API ***

-- Returns the craft levels of a given spellID
function lib:GetCraftLevels(spellID)
	local attrib = lib.dataSource[spellID]
	
	if attrib then
		local grey = bAnd(attrib, 1023)
		local green = bAnd(RShift(attrib, 10), 1023)
		local yellow = bAnd(RShift(attrib, 20), 1023)
		local orange = bAnd(RightShift(attrib, 30), 1023)
		
		return orange, yellow, green, grey
	end
end

-- Returns the level at which a craft is learned
function lib:GetCraftLearnedAtLevel(spellID)
	local attrib = lib.dataSource[spellID]
	
	if attrib then
		return bAnd(RightShift(attrib, 40), 1023)
	end
end

-- Sets the craft levels of a given spellID
function lib:SetCraftLevels(spellID, learnedAt, orange, yellow, green, grey)
	lib.dataSource[spellID] = LShift(learnedAt, 40) + LShift(orange, 30) + LShift(yellow, 20) + LShift(green, 10) + grey
end