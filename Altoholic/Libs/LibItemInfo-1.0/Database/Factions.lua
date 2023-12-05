--	*** LibItemInfo ***
-- Written by : Thaoky, EU-Marécages de Zangar
-- March 2021
-- This list was manually curated (source: mostly Wowhead + in-game).
-- Non-commercial use is permitted as long as credits are preserved, and that Blizzard's terms of services are respected.

local lib = LibStub("LibItemInfo-1.0")

local SetFactionItem = lib.SetFactionItem

-- Factions
local THORIUM = 59
local RAVENHOLDT = 349
local ARGENT_DAWN = 529
local TIMBERMAW = 576
local CENARION_CIRCLE = 609
local NOZDORMU = 910
local ALDOR = 932
local CONSORTIUM = 933
local SCRYERS = 934
local CENARION_EXPEDITION = 942
local SPOREGGAR = 970
local KURENAI = 978
local LOWER_CITY = 1011
local NETHERWING = 1015

-- Dungeons/Raids
-- https://wowpedia.fandom.com/wiki/InstanceID
local AQ_RUINS = 509
local AQ_TEMPLE = 531

-- Items that are related to multiple professions
lib:RegisterItems({

	-- 1.0 Classic

	[12840] = SetFactionItem(0, ARGENT_DAWN), -- Minion's Scourgestone 
	[12841] = SetFactionItem(0, ARGENT_DAWN), -- Invader's Scourgestone 
	[12843] = SetFactionItem(0, ARGENT_DAWN), -- Corruptor's Scourgestone  
	[12844] = SetFactionItem(0, ARGENT_DAWN), -- Corruptor's Scourgestone  
	[20404] = SetFactionItem(0, CENARION_CIRCLE), -- Encrypted Twilight Text  
	[21229] = SetFactionItem(0, CENARION_CIRCLE), -- Qiraji Lord's Insignia
	[21377] = SetFactionItem(0, TIMBERMAW), -- Deadwood Headdress Feather
	[21383] = SetFactionItem(0, TIMBERMAW), -- Winterfall Spirit Beads
	[18945] = SetFactionItem(0, THORIUM), -- Dark Iron Residue
	[17124] = SetFactionItem(0, RAVENHOLDT), -- Syndicate Emblem
	[16885] = SetFactionItem(0, RAVENHOLDT), -- Heavy Junkbox
	
	[20858] = SetFactionItem(0, NOZDORMU), -- Stone Scarab
	[20859] = SetFactionItem(0, NOZDORMU), -- Gold Scarab
	[20860] = SetFactionItem(0, NOZDORMU), -- Silver Scarab
	[20861] = SetFactionItem(0, NOZDORMU), -- Bronze Scarab
	[20862] = SetFactionItem(0, NOZDORMU), -- Crystal Scarab
	[20863] = SetFactionItem(0, NOZDORMU), -- Clay Scarab
	[20864] = SetFactionItem(0, NOZDORMU), -- Bone Scarab
	[20865] = SetFactionItem(0, NOZDORMU), -- Ivory Scarab
	
	[20866] = SetFactionItem(0, NOZDORMU, AQ_RUINS), -- Azure Idol
	[20867] = SetFactionItem(0, NOZDORMU, AQ_RUINS), -- Onyx Idol
	[20868] = SetFactionItem(0, NOZDORMU, AQ_RUINS), -- Lambent Idol
	[20869] = SetFactionItem(0, NOZDORMU, AQ_RUINS), -- Amber Idol
	[20870] = SetFactionItem(0, NOZDORMU, AQ_RUINS), -- Jasper Idol
	[20871] = SetFactionItem(0, NOZDORMU, AQ_RUINS), -- Obsidian Idol
	[20872] = SetFactionItem(0, NOZDORMU, AQ_RUINS), -- Vermillion Idol
	[20873] = SetFactionItem(0, NOZDORMU, AQ_RUINS), -- Alabaster Idol
	
	[20874] = SetFactionItem(0, NOZDORMU, AQ_TEMPLE), -- Idol of the Sun
	[20875] = SetFactionItem(0, NOZDORMU, AQ_TEMPLE), -- Idol of Night
	[20876] = SetFactionItem(0, NOZDORMU, AQ_TEMPLE), -- Idol of Death
	[20877] = SetFactionItem(0, NOZDORMU, AQ_TEMPLE), -- Idol of the Sage
	[20878] = SetFactionItem(0, NOZDORMU, AQ_TEMPLE), -- Idol of Rebirth
	[20879] = SetFactionItem(0, NOZDORMU, AQ_TEMPLE), -- Idol of Life
	[20881] = SetFactionItem(0, NOZDORMU, AQ_TEMPLE), -- Idol of Strife
	[20882] = SetFactionItem(0, NOZDORMU, AQ_TEMPLE), -- Idol of War

	
	-- 2.0 BC
	
	[32427] = SetFactionItem(1, NETHERWING), -- Netherwing Crystal
	[32464] = SetFactionItem(1, NETHERWING), -- Nethercite Ore
	[32468] = SetFactionItem(1, NETHERWING), -- Nethercite Ore
	[32470] = SetFactionItem(1, NETHERWING), -- Nethermine Flayer Hide
	[32506] = SetFactionItem(1, NETHERWING), -- Netherwing Egg
	[32509] = SetFactionItem(1, NETHERWING), -- Netherwing Relic
	[32723] = SetFactionItem(1, NETHERWING), -- Nethermine Cargo
	[24401] = SetFactionItem(1, CENARION_EXPEDITION), -- Unidentified Plant Parts
	[25433] = SetFactionItem(1, KURENAI), -- Obsidian Warbeads (also Horde Mag'har)
	[25719] = SetFactionItem(1, LOWER_CITY), -- Arakkoa Feather
	[24245] = SetFactionItem(1, SPOREGGAR), -- Glowcap
	[24246] = SetFactionItem(1, SPOREGGAR), -- Sanguine Hibiscus
	[24290] = SetFactionItem(1, SPOREGGAR), -- Mature Spore Sac
	[24291] = SetFactionItem(1, SPOREGGAR), -- Bog Lord Tendril
	[24449] = SetFactionItem(1, SPOREGGAR), -- Fertile Spores
	[25416] = SetFactionItem(1, CONSORTIUM), -- Oshu'gun Crystal Fragment
	[25463] = SetFactionItem(1, CONSORTIUM), -- Pair of Ivory Tusks
	[29209] = SetFactionItem(1, CONSORTIUM), -- Zaxxis Insignia
	[25802] = SetFactionItem(1, ALDOR), -- Dreadfang Venom Sac
	[29425] = SetFactionItem(1, ALDOR), -- Mark of Kil'jaeden
	[30809] = SetFactionItem(1, ALDOR), -- Mark of Sargeras  
	[29740] = SetFactionItem(1, ALDOR), -- Fel Armament
	[29426] = SetFactionItem(1, SCRYERS), -- Firewing Signet
	[30810] = SetFactionItem(1, SCRYERS), -- Sunfury Signet
	[29739] = SetFactionItem(1, SCRYERS), -- Arcane Tome
	[25744] = SetFactionItem(1, SCRYERS), -- Dampscale Basilisk Eye
	

	
	-- 3.0 WotLK
	
	-- 4.0 Cataclysm
	
	-- 5.0 Mists of Pandaria
	
	-- 6.0 Warlords of Draenor
	
	-- 7.0 Legion
	
	-- 8.0 Battle for Azeroth
	
	-- 9.0 Shadowlands
})
