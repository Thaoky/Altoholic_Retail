--	*** LibItemInfo ***
-- Written by : Thaoky, EU-Marécages de Zangar
-- March 2021
-- This list was manually curated (source: mostly Wowhead + in-game).
-- Non-commercial use is permitted as long as credits are preserved, and that Blizzard's terms of services are respected.

--[[ Purpose of this file :

Items stored in this file are "quest items" that are safe to delete after the quest has been completed.
Many of us probably have those items lingering in our bags, this will help players identifying and deleting them.

--]]

local lib = LibStub("LibItemInfo-1.0")

local SetQuestItem = lib.SetQuestItem

lib:RegisterItems({

	-- 1.0 Classic
	[2794] = SetQuestItem(0),				-- An Old History Book
	
	-- 2.0 BC
	
	-- 3.0 WotLK
	[36768] = SetQuestItem(2),				-- Vial of Corrosive Spit
	[45798] = SetQuestItem(2),				-- Heroic Celestial Planetarium Key
	
	-- 4.0 Cataclysm
	
	-- 5.0 Mists of Pandaria
	
	-- 6.0 Warlords of Draenor
	
	-- 7.0 Legion
	[133972] = SetQuestItem(6),			-- Basilisk Meat
	[138272] = SetQuestItem(6),			-- Khadgar's Vial
	[138763] = SetQuestItem(6),			-- Felhound Fledgling
	[139043] = SetQuestItem(6),			-- Tear of Elune
	[141351] = SetQuestItem(6),			-- Tear of Elune
	
	-- 8.0 Battle for Azeroth
	[161247] = SetQuestItem(7),			-- Marshal's Regalia
	
	-- 9.0 Shadowlands
	
	-- 9.1 Shadowlands / Korthia
	
	-- 9.2 Shadowlands / Zereth Mortis
	
	-- 10.0 Dragonflight


})
