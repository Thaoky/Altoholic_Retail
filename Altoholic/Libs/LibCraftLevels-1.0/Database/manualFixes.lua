--[[ 
Use this file if you want to correct an auto-generated value in one of the other data files.
Entries are usually stored into a single number, simply for faster loading.

If a spell must be modified, do it like this:

local lib = LibStub("LibCraftLevels-1.0")

Setting the levels of a specific spell:
---------------------------------------
lib:SetCraftLevels(spellID, orange, yellow, green, grey)

--]]