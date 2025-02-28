local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors
local icons = AddonFactory.Icons

local MVC = LibStub("LibMVC-1.0")
local L = AddonFactory:GetLocale(addonName)
local PARAGON_LABEL = "Paragon"

-- *** Reputations ***
local Factions = {
	-- Factions reference table, based on http://www.wowwiki.com/Factions
	{	-- [1]
		name = EXPANSION_NAME0,	-- "Classic"
		{	-- [1]
			name = FACTION_ALLIANCE,	-- 469
			{ name = DataStore:GetFactionName(69), icon = "Achievement_Character_Nightelf_Female" },	-- "Darnassus"
			{ name = DataStore:GetFactionName(930), icon = "Achievement_Character_Draenei_Male" },	--  name = "Exodar"
			{ name = DataStore:GetFactionName(54), icon = "Achievement_Character_Gnome_Female" },	-- "Gnomeregan"
			{ name = DataStore:GetFactionName(47), icon = "Achievement_Character_Dwarf_Male" },		-- "Ironforge"
			{ name = DataStore:GetFactionName(72), icon = "Achievement_Character_Human_Male" },		-- "Stormwind"
			{ name = DataStore:GetFactionName(1134), icon = "Interface\\Glues\\CharacterCreate\\UI-CHARACTERCREATE-RACES", left = 0.625, right = 0.75, top = 0, bottom = 0.25 },	-- "Gilneas"
			{ name = DataStore:GetFactionName(1353), icon = "Interface\\Glues\\CharacterCreate\\UI-CHARACTERCREATE-RACES", left = 0.75, right = 0.875, top = 0, bottom = 0.25 },	-- "Tushui Pandaren"
			{ name = DataStore:GetFactionName(469), icon = "INV_BannerPVP_02" },	-- "Alliance"
		},
		{	-- [2]
			name = FACTION_HORDE,
			{ name = DataStore:GetFactionName(530), icon = "Achievement_Character_Troll_Male" },		-- "Darkspear Trolls"
			{ name = DataStore:GetFactionName(76), icon = "Achievement_Character_Orc_Male" },		-- "Orgrimmar"
			{ name = DataStore:GetFactionName(81), icon = "Achievement_Character_Tauren_Male" },		-- "Thunder Bluff"
			{ name = DataStore:GetFactionName(68), icon = "Achievement_Character_Undead_Female" },		-- "Undercity"
			{ name = DataStore:GetFactionName(911), icon = "Achievement_Character_Bloodelf_Male" },		-- "Silvermoon City"
			{ name = DataStore:GetFactionName(1133), icon = "Interface\\Glues\\CharacterCreate\\UI-CHARACTERCREATE-RACES", left = 0.625, right = 0.75, top = 0.25, bottom = 0.5 },	--  name = "Bilgewater Cartel"
			{ name = DataStore:GetFactionName(1352), icon = "Interface\\Glues\\CharacterCreate\\UI-CHARACTERCREATE-RACES", left = 0.75, right = 0.875, top = 0.25, bottom = 0.5 },	-- "Huojin Pandaren" 
			{ name = DataStore:GetFactionName(67), icon = "INV_BannerPVP_01" },	-- "Horde" 
		},
		{	-- [3]
			name = L["Alliance Forces"],	-- 891
			{ name = DataStore:GetFactionName(509), icon = "Achievement_BG_winAB" },	--  name = "The League of Arathor" 
			{ name = DataStore:GetFactionName(890), icon = "Achievement_BG_captureflag_WSG" },	-- "Silverwing Sentinels" 
			{ name = DataStore:GetFactionName(730), icon = "Achievement_BG_winAV" },		-- "Stormpike Guard"
		},
		{	-- [4]
			name = L["Horde Forces"],
			{ name = DataStore:GetFactionName(510), icon = "Achievement_BG_winAB" },		-- "The Defilers" 
			{ name = DataStore:GetFactionName(889), icon = "Achievement_BG_captureflag_WSG" },	-- "Warsong Outriders" 
			{ name = DataStore:GetFactionName(729), icon = "Achievement_BG_winAV" },		-- "Frostwolf Clan" 
		},
		{	-- [5]
			name = L["Steamwheedle Cartel"],
			{ name = DataStore:GetFactionName(21), icon = "Achievement_Zone_Stranglethorn_01" },		-- "Booty Bay" 
			{ name = DataStore:GetFactionName(577), icon = "Achievement_Zone_Winterspring" },		-- "Everlook" 
			{ name = DataStore:GetFactionName(369), icon = "Achievement_Zone_Tanaris_01" },		-- "Gadgetzan" 
			{ name = DataStore:GetFactionName(470), icon = "Achievement_Zone_Barrens_01" },		-- "Ratchet" 
		},
		{	-- [6]
			name = OTHER,
			{ name = DataStore:GetFactionName(529), icon = "INV_Jewelry_Talisman_07" },		-- "Argent Dawn" 
			{ name = DataStore:GetFactionName(87), icon = "INV_Helmet_66" },		-- "Bloodsail Buccaneers" 
			{ name = DataStore:GetFactionName(910), icon = "INV_Misc_Head_Dragon_Bronze" },		-- "Brood of Nozdormu" 
			{ name = DataStore:GetFactionName(609), icon = "Achievement_Zone_Silithus_01" },		-- "Cenarion Circle" 
			{ name = DataStore:GetFactionName(909), icon = "INV_Misc_Ticket_Darkmoon_01" },		-- "Darkmoon Faire" 
			{ name = DataStore:GetFactionName(92), icon = "INV_Misc_Head_Centaur_01" },			-- "Gelkis Clan Centaur" 
			{ name = DataStore:GetFactionName(749), icon = "Spell_Frost_SummonWaterElemental_2" },		-- "Hydraxian Waterlords" 
			{ name = DataStore:GetFactionName(93), icon = "INV_Misc_Head_Centaur_01" },		-- "Magram Clan Centaur" 
			{ name = DataStore:GetFactionName(349), icon = "INV_ThrowingKnife_04" },		-- "Ravenholdt" 
			{ name = DataStore:GetFactionName(809), icon = "Achievement_Zone_Feralas" },		-- "Shen'dralar" 
			{ name = DataStore:GetFactionName(70), icon = "INV_Misc_ArmorKit_03" },		-- "Syndicate" 
			{ name = DataStore:GetFactionName(59), icon = "INV_Ingot_Thorium" },		-- "Thorium Brotherhood" 
			{ name = DataStore:GetFactionName(576), icon = "Achievement_Reputation_timbermaw" },		-- "Timbermaw Hold" 
			{ name = DataStore:GetFactionName(922), icon = "Achievement_Zone_Ghostlands" },		-- "Tranquillien" 
			{ name = DataStore:GetFactionName(589), icon = "Ability_Mount_PinkTiger" },		-- "Wintersaber Trainers" 
			{ name = DataStore:GetFactionName(270), icon = "INV_Bijou_Green" },		-- "Zandalar Tribe" 
		}
	},
	{	-- [2]
		name = EXPANSION_NAME1,	-- "The Burning Crusade"
		{	-- [1]
			name = GetRealZoneText(530),	-- Outland
			{ name = DataStore:GetFactionName(1012), icon = "Achievement_Reputation_AshtongueDeathsworn" },	-- "Ashtongue Deathsworn" 
			{ name = DataStore:GetFactionName(942), icon = "Achievement_Reputation_GuardiansofCenarius" },	-- "Cenarion Expedition" 
			{ name = DataStore:GetFactionName(933), icon = "INV_Enchant_ShardPrismaticLarge" },		-- "The Consortium" 
			{ name = DataStore:GetFactionName(946), icon = "Spell_Misc_HellifrePVPHonorHoldFavor" },	-- "Honor Hold" 
			{ name = DataStore:GetFactionName(978), icon = "INV_Misc_Foot_Centaur" },		-- "Kurenai" 
			{ name = DataStore:GetFactionName(941), icon = "Achievement_Zone_Nagrand_01" },	-- "The Mag'har" 
			{ name = DataStore:GetFactionName(1015), icon = "Ability_Mount_NetherdrakePurple" },		-- "Netherwing" 
			{ name = DataStore:GetFactionName(1038), icon = "Achievement_Reputation_Ogre" },		-- "Ogri'la" 
			{ name = DataStore:GetFactionName(970), icon = "INV_Mushroom_11" },	-- "Sporeggar" 
			{ name = DataStore:GetFactionName(947), icon = "Spell_Misc_HellifrePVPThrallmarFavor" },	-- "Thrallmar" 
		},
		{	-- [2]
			name = C_Map.GetMapInfo(111).name,	-- "Shattrath City"
			{ name = DataStore:GetFactionName(1011), icon = "Achievement_Zone_Terrokar" },		-- "Lower City" 
			{ name = DataStore:GetFactionName(1031), icon = "Ability_Hunter_Pet_NetherRay" },		-- "Sha'tari Skyguard" 
			{ name = DataStore:GetFactionName(1077), icon = "INV_Shield_48" },		-- "Shattered Sun Offensive" 
			{ name = DataStore:GetFactionName(932), icon = "Achievement_Character_Draenei_Female" },	-- "The Aldor" 
			{ name = DataStore:GetFactionName(934), icon = "Achievement_Character_Bloodelf_Female" },		-- "The Scryers" 
			{ name = DataStore:GetFactionName(935), icon = "Achievement_Zone_Netherstorm_01" },		-- "The Sha'tar" 
		},
		{	-- [3]
			name = OTHER,
			{ name = DataStore:GetFactionName(989), icon = "Achievement_Zone_HillsbradFoothills" },		-- "Keepers of Time" 
			{ name = DataStore:GetFactionName(990), icon = "INV_Enchant_DustIllusion" },	-- "The Scale of the Sands" 
			{ name = DataStore:GetFactionName(967), icon = "Spell_Holy_MindSooth" },		-- "The Violet Eye" 
		}
	},
	{	-- [3]
		name = EXPANSION_NAME2,	-- "Wrath of the Lich King"
		{	-- [1]
			name = GetRealZoneText(571),	-- Northrend
			{ name = DataStore:GetFactionName(1106), icon = "Achievement_Reputation_ArgentCrusader" },		-- "Argent Crusade"
			{ name = DataStore:GetFactionName(1090), icon = "Achievement_Reputation_KirinTor" },		-- "Kirin Tor" 
			{ name = DataStore:GetFactionName(1073), icon = "Achievement_Reputation_Tuskarr" },	-- "The Kalu'ak" 
			{ name = DataStore:GetFactionName(1091), icon = "Achievement_Reputation_WyrmrestTemple" },		-- "The Wyrmrest Accord" 
			{ name = DataStore:GetFactionName(1098), icon = "Achievement_Reputation_KnightsoftheEbonBlade" },	-- "Knights of the Ebon Blade" 
			{ name = DataStore:GetFactionName(1119), icon = "Achievement_Boss_Hodir_01" },		-- "The Sons of Hodir" 
			{ name = DataStore:GetFactionName(1156), icon = "Achievement_Reputation_ArgentCrusader" },		-- "The Ashen Verdict" 
		},
		{	-- [2]
			name = DataStore:GetFactionName(1037), 	-- "Alliance Vanguard"
			{ name = DataStore:GetFactionName(1037), icon = "Spell_Misc_HellifrePVPHonorHoldFavor" },	-- "Alliance Vanguard" 
			{ name = DataStore:GetFactionName(1068), icon = "Achievement_Zone_HowlingFjord_02" },	-- "Explorers' League" 
			{ name = DataStore:GetFactionName(1126), icon = "Achievement_Zone_StormPeaks_01" },		-- "The Frostborn" 
			{ name = DataStore:GetFactionName(1094), icon = "Achievement_Zone_CrystalSong_01" },		-- "The Silver Covenant" 
			{ name = DataStore:GetFactionName(1050), icon = "Achievement_Zone_BoreanTundra_01" },	-- "Valiance Expedition" 	
		},
		{	-- [3]
			name = DataStore:GetFactionName(1052), 	-- "Horde Expedition"
			{ name = DataStore:GetFactionName(1052), icon = "Spell_Misc_HellifrePVPThrallmarFavor" },		-- "Horde Expedition" 
			{ name = DataStore:GetFactionName(1067), icon = "Achievement_Zone_HowlingFjord_02" },		-- "The Hand of Vengeance" 
			{ name = DataStore:GetFactionName(1124), icon = "Achievement_Zone_CrystalSong_01" },			-- "The Sunreavers" 
			{ name = DataStore:GetFactionName(1064), icon = "Achievement_Zone_BoreanTundra_02" },		-- "The Taunka" 
			{ name = DataStore:GetFactionName(1085), icon = "Achievement_Zone_BoreanTundra_03" },		-- "Warsong Offensive" 
		},
		{	-- [4]
			name = C_Map.GetMapInfo(119).name,	-- "Sholazar Basin"
			{ name = DataStore:GetFactionName(1104), icon = "Ability_Mount_WhiteDireWolf" },		-- "Frenzyheart Tribe" 
			{ name = DataStore:GetFactionName(1105), icon = "Achievement_Reputation_MurlocOracle" },	-- "The Oracles" 
		},
	},
	{	-- [4]
		name = EXPANSION_NAME3,	-- "Cataclysm"
		{	-- [1]
			name = OTHER,
			{ name = DataStore:GetFactionName(1158), icon = "Achievement_Zone_mount hyjal" },		-- "Guardians of Hyjal" 
			{ name = DataStore:GetFactionName(1135), icon = "Spell_Nature_EarthElemental_Totem" },		-- "The Earthen Ring" 
			{ name = DataStore:GetFactionName(1171), icon = "inv_misc_tabard_therazane" },		-- "Therazane" 
			{ name = DataStore:GetFactionName(1174), icon = "inv_misc_tabard_wildhammerclan" },		-- "Wildhammer Clan" 
			{ name = DataStore:GetFactionName(1173), icon = "inv_misc_tabard_tolvir" },		-- "Ramkahen" 
			{ name = DataStore:GetFactionName(1177), icon = "inv_misc_tabard_baradinwardens" },		-- "Baradin's Wardens" 
			{ name = DataStore:GetFactionName(1172), icon = "inv_misc_tabard_dragonmawclan" },		-- "Dragonmaw Clan" 
			{ name = DataStore:GetFactionName(1178), icon = "inv_misc_tabard_hellscream" },		-- "Hellscream's Reach" 
			{ name = DataStore:GetFactionName(1204), icon = "inv_neck_hyjaldaily_04" },		-- "Avengers of Hyjal" 
		}
	},
	{	-- [5]
		name = EXPANSION_NAME4,	-- "Mists of Pandaria"
		{	-- [1]
			name = DataStore:GetFactionName(1302), 	-- "The Anglers"
			{ name = DataStore:GetFactionName(1358), icon = "achievement_faction_anglers" },		-- "Nat Pagle" 
		},
		{	-- [2]
			name = DataStore:GetFactionName(1272), 	-- "The Tillers"
			{ name = DataStore:GetFactionName(1277), icon = "achievement_faction_tillers" },		-- "Chee Chee" 
			{ name = DataStore:GetFactionName(1275), icon = "achievement_faction_tillers" },		-- "Ella" 
			{ name = DataStore:GetFactionName(1283), icon = "achievement_faction_tillers" },		-- "Farmer Fung" 
			{ name = DataStore:GetFactionName(1282), icon = "achievement_faction_tillers" },		-- "Fish Fellreed" 
			{ name = DataStore:GetFactionName(1281), icon = "achievement_faction_tillers" },		-- "Gina Mudclaw" 
			{ name = DataStore:GetFactionName(1279), icon = "achievement_faction_tillers" },		-- "Haohan Mudclaw" 
			{ name = DataStore:GetFactionName(1273), icon = "achievement_faction_tillers" },		-- "Jogu the Drunk" 
			{ name = DataStore:GetFactionName(1276), icon = "achievement_faction_tillers" },		-- "Old Hillpaw" 
			{ name = DataStore:GetFactionName(1278), icon = "achievement_faction_tillers" },		-- "Sho" 
			{ name = DataStore:GetFactionName(1280), icon = "achievement_faction_tillers" },		-- "Tina Mudclaw" 
		},
		{	-- [3]
			name = OTHER,
			{ name = DataStore:GetFactionName(1375), icon = "achievement_general_hordeslayer" },		-- "Dominance Offensive" 
			{ name = DataStore:GetFactionName(1228), icon = "inv_misc_fish_58" },		-- "Forest Hozen" 
			{ name = DataStore:GetFactionName(1269), icon = "achievement_faction_goldenlotus" },		-- "Golden Lotus" 
			{ name = DataStore:GetFactionName(1387), icon = "achievement_reputation_kirintor_offensive" },		-- "Kirin Tor Offensive" 
			{ name = DataStore:GetFactionName(1376), icon = "achievement_general_allianceslayer" },		-- "Operation: Shieldwall" 
			{ name = DataStore:GetFactionName(1271), icon = "achievement_faction_serpentriders" },		-- "Order of the Cloud Serpent" 
			{ name = DataStore:GetFactionName(1242), icon = "inv_misc_fish_58" },		-- "Pearlfin Jinyu" 
			{ name = DataStore:GetFactionName(1270), icon = "achievement_faction_shadopan" },		-- "Shado-Pan" 
			{ name = DataStore:GetFactionName(1435), icon = "achievement_faction_shadopan" },		-- "Shado-Pan Assault" 
			{ name = DataStore:GetFactionName(1216), icon = "inv_misc_book_07" },		-- "Shang Xi's Academy" 
			{ name = DataStore:GetFactionName(1388), icon = "achievement_faction_sunreaveronslaught" },		-- "Sunreaver Onslaught" 
			{ name = DataStore:GetFactionName(1302), icon = "achievement_faction_anglers" },		-- "The Anglers" 
			{ name = DataStore:GetFactionName(1341), icon = "achievement_faction_celestials" },		-- "The August Celestials" 
			{ name = DataStore:GetFactionName(1359), icon = "inv_misc_head_dragon_black" },		-- "The Black Prince" 
			{ name = DataStore:GetFactionName(1351), icon = "inv_cask_02" },		-- "The Brewmasters" 
			{ name = DataStore:GetFactionName(1337), icon = "achievement_faction_klaxxi" },		-- "The Klaxxi" 
			{ name = DataStore:GetFactionName(1345), icon = "achievement_faction_lorewalkers" },		-- "The Lorewalkers" 
			{ name = DataStore:GetFactionName(1272), icon = "achievement_faction_tillers" },		-- "The Tillers" 
			{ name = DataStore:GetFactionName(1492), icon = "ability_monk_quipunch" },		-- "Emperor Shaohao"
		}
	},
	{	-- [6]
		name = EXPANSION_NAME5,	-- "Warlords of Draenor"
		{	-- [1]
			name = FACTION_ALLIANCE,	-- 469
			{ name = DataStore:GetFactionName(1710), icon = "inv_tabard_a_shataridefense" },		-- Sha'tari Defense
			{ name = DataStore:GetFactionName(1682), icon = "inv_tabard_a_78wrynnvanguard" },	-- Wrynn's Vanguard
			{ name = DataStore:GetFactionName(1847), icon = "inv_tabard_a_78wrynnvanguard" },	-- Hand of the Prophet
		},
		{	-- [2]
			name = FACTION_HORDE,
			{ name = DataStore:GetFactionName(1708), icon = "inv_tabard_a_80laughingskull" },	-- Laughing Skull Orcs
			{ name = DataStore:GetFactionName(1681), icon = "inv_tabard_a_77voljinsspear" },		-- Vol'jin's Spear
			{ name = DataStore:GetFactionName(1848), icon = "inv_tabard_a_77voljinsspear" },	-- Vol'jin's Headh
		},
		{	-- [3]
			name = OTHER,
			{ name = DataStore:GetFactionName(1515), icon = "inv_tabard_a_76arakkoaoutcast" },		-- Arrakoa Outcasts
			{ name = DataStore:GetFactionName(1731), icon = "inv_tabard_a_81exarchs" },		-- Council of Exarchs
			{ name = DataStore:GetFactionName(1445), icon = "inv_tabard_a_01frostwolfclan" },		-- Frostwold Orcs
			{ name = DataStore:GetFactionName(1711), icon = "achievement_goblinhead" },		-- Steamwheedle Preservation Society
			{ name = DataStore:GetFactionName(1849), icon = "achievement_goblinhead" },			-- Order of the Awakened
			{ name = DataStore:GetFactionName(1850), icon = "achievement_goblinhead" },			-- The Saberstalkers
		},		
	},	
	{	-- [7]
		name = EXPANSION_NAME6,	-- "Legion"
		{	-- [1]
			name = OTHER,
			{ name = DataStore:GetFactionName(1900), icon = "achievements_zone_azsuna" },		-- Court of Farondis
			{ name = DataStore:GetFactionName(1883), icon = "achievements_zone_valsharah" },		-- Dreamweavers
			{ name = DataStore:GetFactionName(1828), icon = "achievements_zone_highmountain" },		-- Highmountain Tribe
			{ name = DataStore:GetFactionName(1948), icon = "achievements_zone_stormheim" },		-- Valarjar
			{ name = DataStore:GetFactionName(1859), icon = "achievements_zone_suramar" },			-- The Nightfallen
			{ name = DataStore:GetFactionName(1894), icon = "achievements_zone_brokenshore" },			-- The Wardens
			{ name = DataStore:GetFactionName(2045), icon = "achievement_faction_legionfall" },			-- Armies of Legionfall
			{ name = DataStore:GetFactionName(2165), icon = "achievement_admiral_of_the_light" },			-- Army of the Light
			{ name = DataStore:GetFactionName(2170), icon = "achievement_master_of_argussian_reach" },			-- Argussian Reach
			{ name = DataStore:GetFactionName(2135), icon = "achievement_reputation_wyrmresttemple" },          -- Chromie
		},		
		{ -- [2]
			name = L["Fishing Masters"],
			{ name = DataStore:GetFactionName(1975), icon = "inv_elemental_primal_water" }, -- Conjurer Margoss
			{ name = DataStore:GetFactionName(2097), icon = "achievement_profession_fishing_oldmanbarlowned" }, -- Ilyssia of the Waters
			{ name = DataStore:GetFactionName(2099), icon = "achievement_profession_fishing_oldmanbarlowned" }, -- Akule Riverhorn
			{ name = DataStore:GetFactionName(2101), icon = "achievement_profession_fishing_oldmanbarlowned" }, -- Sha'leth
			{ name = DataStore:GetFactionName(2100), icon = "achievement_profession_fishing_oldmanbarlowned" }, -- Corbyn
			{ name = DataStore:GetFactionName(2102), icon = "achievement_profession_fishing_oldmanbarlowned" }, -- Impus
			{ name = DataStore:GetFactionName(2098), icon = "achievement_profession_fishing_oldmanbarlowned" }, -- Keeper Raynae
		},
	},
	{	-- [8]
		name = EXPANSION_NAME7,	-- "Battle for Azeroth"
		{	-- [1]
			name = FACTION_ALLIANCE,
			{ name = DataStore:GetFactionName(2159), icon = "Inv_tabard_alliancewareffort" },
			{ name = DataStore:GetFactionName(2160), icon = "Inv_tabard_proudmoore" },
			{ name = DataStore:GetFactionName(2161), icon = "Inv_tabard_orderoftheembers" },
			{ name = DataStore:GetFactionName(2162), icon = "Inv_tabard_stormswake" },
			{ name = DataStore:GetFactionName(2164), icon = "Inv_tabard_championsofazeroth" },
			{ name = DataStore:GetFactionName(2163), icon = "Inv_tabard_tortollanseekers" },
			{ name = DataStore:GetFactionName(2400), icon = "inv_faction_akoan" },
		},
		{	-- [2]
			name = FACTION_HORDE,
			{ name = DataStore:GetFactionName(2157), icon = "Inv_tabard_hordewareffort" },
			-- should use the libbabble .. horde / ally factions again..
			{ name = DataStore:GetFactionName(2103) or "Zandalari Empire", icon = "Inv_tabard_zandalariempire" },
			{ name = DataStore:GetFactionName(2156), icon = "Inv_tabard_talanjisexpedition" },
			-- temp fix, on Alliance, 2158 returns nil
			{ name = DataStore:GetFactionName(2158) or "Voldunai", icon = "Inv_tabard_vulpera" },
			{ name = DataStore:GetFactionName(2164), icon = "Inv_tabard_championsofazeroth" },
			{ name = DataStore:GetFactionName(2163), icon = "Inv_tabard_tortollanseekers" },
			{ name = DataStore:GetFactionName(2373), icon = "inv_faction_unshackled" },
		},
		{	-- [3]
			name = OTHER,
			{ name = DataStore:GetFactionName(2164), icon = "Inv_tabard_championsofazeroth" },
			{ name = DataStore:GetFactionName(2163), icon = "Inv_tabard_tortollanseekers" },
			{ name = DataStore:GetFactionName(2391), icon = "inv_mechagon_junkyardtinkeringcrafting" },
			{ name = DataStore:GetFactionName(2415), icon = "inv_faction_83_rajani" },
			{ name = DataStore:GetFactionName(2417), icon = "inv_faction_83_uldumaccord" },
		},
	},
	{ -- [9]
		name = EXPANSION_NAME8, -- "Shadowlands"
		{	-- [1]
			name = OTHER,
			{ name = DataStore:GetFactionName(2413), icon = "inv_tabard_revendreth_d_01" },         -- Court of Harvesters
			{ name = DataStore:GetFactionName(2464), icon = "inv_ardenwealdstagmount_white" },      -- Court of Night
			--{ name = DataStore:GetFactionName(2463), icon = "inv_mothardenwealdmount_mint"},        -- Marasimus                   [uncomment if this is ever fixed]
			{ name = DataStore:GetFactionName(2407), icon = "inv_tabard_bastion_d_01" },            -- The Ascended
			{ name = DataStore:GetFactionName(2439), icon = "inv_deathwargmountpurple" },           -- The Avowed
			{ name = DataStore:GetFactionName(2410), icon = "inv_tabard_maldraxxus_d_01" },         -- The Undying Army
			{ name = DataStore:GetFactionName(2465), icon = "inv_tabard_ardenweald_d_01" },         -- The Wild Hunt
			{ name = DataStore:GetFactionName(2432), icon = "inv_helm_cloth_oribosdungeon_c_01" },  -- Ve'nari
			{ name = DataStore:GetFactionName(2470), icon = "inv_tabard_deathsadvance_b_01" },  	 -- 9.1 Death's Advance
			{ name = DataStore:GetFactionName(2472), icon = "inv_inscription_80_scroll" },  			 -- 9.1 Archivist's Codex
			{ name = DataStore:GetFactionName(2478), icon = "achievement_reputation_enlightenedbrokers" },  	 -- 9.2 The Enlightened
		},
	},
	{ -- [10]
		name = EXPANSION_NAME9, -- "Dragonflight"
		{	-- [1]
			name = OTHER,
			{ name = DataStore:GetFactionName(2507), icon = "ui_majorfaction_expedition" },     		-- Dragonscale Expedition
			{ name = DataStore:GetFactionName(2503), icon = "ui_majorfaction_centaur" },      			-- Maruuk Centaur
			{ name = DataStore:GetFactionName(2511), icon = "ui_majorfaction_tuskarr" },      			-- Iskaara Tuskarr
			{ name = DataStore:GetFactionName(2510), icon = "ui_majorfaction_valdrakken" },      		-- Valdrakken Accord
			{ name = DataStore:GetFactionName(2526), icon = "ui_majorfaction_valdrakken" },      		-- Winterpelt Furbolg
			{ name = DataStore:GetFactionName(2544), icon = "inv_misc_statue_04" },      					-- Artisan's Consortium - Dragon Isles Branch
			{ name = DataStore:GetFactionName(2550), icon = "inv_artifact_stolenpower" },      			-- Cobalt Assembly
			{ name = DataStore:GetFactionName(2517), icon = "inv_crown_02" },      							-- Sabellian
			{ name = DataStore:GetFactionName(2518), icon = "ui_majorfaction_valdrakken" },      		-- inv_crown_02
			{ name = DataStore:GetFactionName(2553), icon = "ability_essence_reapingflames" },      	-- Soridormi
			{ name = DataStore:GetFactionName(2564), icon = "ui_majorfaction_niffen" },      			-- Loamm Niffen
			{ name = DataStore:GetFactionName(2568), icon = "inv_snailrockmount_pink" }, 					-- Glimmerogg Racer Unknown icon
			{ name = DataStore:GetFactionName(2574), icon = "ui_majorfaction_denizens" }, 				-- Dream Wardens 10.2
			{ name = DataStore:GetFactionName(2523), icon = "inv_dracthyrhead03" }, 				-- Dark Talons Dracthyrs
			{ name = DataStore:GetFactionName(2524), icon = "inv_dracthyrhead03" }, 				-- Obsidian Warders Dracthyrs
		},
	},
	{ -- [11]
		name = EXPANSION_NAME10, -- "The War Within"
		{	-- [1]
			name = OTHER,
			{ name = DataStore:GetFactionName(2590), icon = "ui_majorfactions_storm" },     		-- Council of Dornogal
			{ name = DataStore:GetFactionName(2594), icon = "ui_majorfactions_candle" },     	-- The Assembly of the Deeps
			{ name = DataStore:GetFactionName(2570), icon = "ui_majorfactions_flame" },     		-- Hallowfall Arathi
			{ name = DataStore:GetFactionName(2600), icon = "ui_notoriety_theweaver" },     		-- The Severed Threads
			{ name = DataStore:GetFactionName(2605), icon = "ui_notoriety_thegeneral" },     	-- 	The General
			{ name = DataStore:GetFactionName(2607), icon = "ui_notoriety_thevizier" },     		-- 	The Vizier
			{ name = DataStore:GetFactionName(2601), icon = "ui_notoriety_theweaver" },     		-- 	The Weaver
			{ name = DataStore:GetFactionName(2640), icon = "ability_druid_lunarguidance" },    -- Brann Bronzebeard
			
			-- 11.1
			{ name = DataStore:GetFactionName(2673), icon = "Interface\\Glues\\CharacterCreate\\UI-CHARACTERCREATE-RACES", left = 0.625, right = 0.75, top = 0.25, bottom = 0.5 },	-- Bilgewater Cartel
			{ name = DataStore:GetFactionName(2675), icon = "inv_chicken2_mechanical" },    -- Blackwater Cartel
			{ name = DataStore:GetFactionName(2669), icon = "inv_goblinshreddermech_black" },    -- Darkfuse Solutions
			{ name = DataStore:GetFactionName(2685), icon = "inv_inscription_tarot_earthquakecard" },    -- Gallagio Loyalty Rewards Club
			{ name = DataStore:GetFactionName(2677), icon = "achievement_femalegoblinhead" },    -- Steamwheedle Cartel
			{ name = DataStore:GetFactionName(2671), icon = "ui_majorfactions_rocket" },    -- Venture Company
		},
	},
	{	-- [12]
		name = GUILD,
		{	-- [1]
			name = GUILD,
		}
	},
}

local CAT_GUILD = #Factions
local CAT_ALLINONE = CAT_GUILD + 1

local VertexColors = {
	[FACTION_STANDING_LABEL1] = { r = 0.4, g = 0.13, b = 0.13 },	-- hated
	[FACTION_STANDING_LABEL2] = { r = 0.5, g = 0.0, b = 0.0 },		-- hostile
	[FACTION_STANDING_LABEL3] = { r = 0.6, g = 0.4, b = 0.13 },		-- unfriendly
	[FACTION_STANDING_LABEL4] = { r = 0.6, g = 0.6, b = 0.0 },		-- neutral
	[FACTION_STANDING_LABEL5] = { r = 0.0, g = 0.6, b = 0.0 },		-- friendly
	[FACTION_STANDING_LABEL6] = { r = 0.0, g = 0.6, b = 0.6 },		-- honored
	[FACTION_STANDING_LABEL7] = { r = 0.9, g = 0.3, b = 0.9 },		-- revered
	[FACTION_STANDING_LABEL8] = { r = 1.0, g = 1.0, b = 1.0 },		-- exalted
	[PARAGON_LABEL] = { r = 1.0, g = 1.0, b = 1.0 },					-- Paragon
}

local view
local isViewValid

local OPTION_XPACK = "Reputations.CurrentXPack"
local OPTION_FACTION = "Reputations.CurrentFactionGroup"

local currentFaction

local function BuildView()
	view = view or {}
	wipe(view)
	
	local options = Altoholic_GridsTab_Options
	local currentXPack = options[OPTION_XPACK]
	local currentFactionGroup = options[OPTION_FACTION]

	if (currentXPack ~= CAT_ALLINONE) then
		for index, faction in ipairs(Factions[currentXPack][currentFactionGroup]) do
			table.insert(view, faction)	-- insert the table pointer
		end
	else	-- all in one, add all factions
		for xPackIndex, xpack in ipairs(Factions) do		-- all xpacks
			for factionGroupIndex, factionGroup in ipairs(xpack) do 	-- all faction groups
				for index, faction in ipairs(factionGroup) do
					table.insert(view, faction)	-- insert the table pointer
				end
			end
		end
		
		table.sort(view, function(a,b) 	-- sort all factions alphabetically
			if not a.name then
				DEFAULT_CHAT_FRAME:AddMessage(a.icon)
			end
			if not b.name then
				DEFAULT_CHAT_FRAME:AddMessage(b.icon)
			end
			
			return a.name < b.name
		end)
	end
	
	isViewValid = true
end

local function AddGuildsToFactionsTable(realm, account)
	-- get the guilds on this realm/account
	local guilds = AddonFactory:GetTable()
	for guildName, guild in pairs(DataStore:GetGuilds(realm, account)) do
		if DataStore:GetGuildFaction(guildName, realm, account) == FACTION_ALLIANCE then
			guilds[guildName] = "inv_misc_tournaments_banner_human"
		else
			guilds[guildName] = "inv_misc_tournaments_banner_orc"
		end
	end
	
	-- clean the Factions table
	for k, v in ipairs(Factions[CAT_GUILD][1]) do	-- ipairs ! only touch the array part, leave the hash untouched
		Factions[CAT_GUILD][1][k] = nil
	end
	
	-- add them to the Factions table
	for k, v in pairs(guilds) do
		table.insert(Factions[CAT_GUILD][1], { name = k, icon = v } )
	end
	
	AddonFactory:ReleaseTable(guilds)
end

local tab = AltoholicFrame.TabGrids

tab:RegisterGrid(2, {
	InvalidateView = function()
		isViewValid = nil
	end,
	OnUpdate = function() 
			if isViewValid then return end

			local options = Altoholic_GridsTab_Options
			local currentXPack = options[OPTION_XPACK]
			local currentFactionGroup = options[OPTION_FACTION]
			
			if (currentXPack == CAT_GUILD) then
				tab:SetStatus(format("%s%s|r / %s%s", colors.white, L["Reputations"], colors.green, GUILD))
				AddGuildsToFactionsTable(tab:GetRealm())
				
			elseif (currentXPack == CAT_ALLINONE) then
				tab:SetStatus(format("%s%s|r / %s%s", colors.white, L["Reputations"], colors.cyan, L["All-in-one"]))
				
			else
				tab:SetStatus(format("%s%s|r / %s%s|r / %s%s", 
					colors.white, L["Reputations"], 
					colors.white, Factions[currentXPack].name, 
					colors.green, Factions[currentXPack][currentFactionGroup].name))
			end

			BuildView()
		end,
	GetSize = function() return #view end,
	RowSetup = function(self, rowFrame, dataRowID)
			currentFaction = view[dataRowID]

			rowFrame.Name.Text:SetText(format("%s%s", colors.white, currentFaction.name))
			rowFrame.Name.Text:SetJustifyH("LEFT")
		end,
	ColumnSetup = function(self, button, dataRowID, character)
			local faction = currentFaction
			
			if faction.left then		-- if it's not a full texture, use tcoords
				button.Background:SetTexture(faction.icon)
				button.Background:SetTexCoord(faction.left, faction.right, faction.top, faction.bottom)
			else
				button.Background:SetTexture(format("Interface\\Icons\\%s", faction.icon))
				button.Background:SetTexCoord(0, 1, 0, 1)
			end		
			
			button.Name:SetFontObject("GameFontNormalSmall")
			button.Name:SetJustifyH("CENTER")
			button.Name:SetPoint("BOTTOMRIGHT", 5, 0)
			button.Background:SetDesaturated(false)
			
			local status, _, _, rate, isMajorFaction, isFrienshipFaction = DataStore:GetReputationInfo(character, faction.name)
			
			if status and rate then 
				local text
				
				if isMajorFaction then									-- If we are dealing with a major faction ..
					text = format("Lv %d", status)					-- .. status will contain the renown level
					button.Name:SetFontObject("NumberFontNormalSmall")
					button.Name:SetJustifyH("RIGHT")
					button.Name:SetPoint("BOTTOMRIGHT", -2, 0)
				
				elseif status == FACTION_STANDING_LABEL8 then	-- If exalted .. 
					text = icons.ready									-- .. just show the green check
				elseif status == PARAGON_LABEL then					-- Else if paragon levels..
					if rate >= 100 then
						text = icons.waiting
					else
						button.Name:SetFontObject("NumberFontNormalSmall")
						button.Name:SetJustifyH("RIGHT")
						button.Name:SetPoint("BOTTOMRIGHT", 0, 0)
						text = format("%2d%%", floor(rate))
					end
				else
					button.Background:SetDesaturated(true)
					button.Name:SetFontObject("NumberFontNormalSmall")
					button.Name:SetJustifyH("RIGHT")
					button.Name:SetPoint("BOTTOMRIGHT", 0, 0)
					text = format("%2d%%", floor(rate))
				end

				local vc = (isMajorFaction or isFrienshipFaction) and VertexColors[FACTION_STANDING_LABEL4] or VertexColors[status]
				button.Background:SetVertexColor(vc.r, vc.g, vc.b);
				
				local color = colors.white
				if status == FACTION_STANDING_LABEL1 or status == FACTION_STANDING_LABEL2 then
					color = colors.darkred
				elseif status == PARAGON_LABEL then
					color = colors.epic
				end

				button.key = character
				button:SetID(dataRowID)
				button.Name:SetText(format("%s%s", color, text))
			else
				button.Background:SetVertexColor(0.3, 0.3, 0.3)		-- greyed out
				button.Name:SetText(icons.notReady)
				button:SetID(0)
				button.key = nil
			end
		end,
		
	OnEnter = function(frame) 
			local character = frame.key
			if not character then return end

			local faction = view[ frame:GetID() ].name
			local status, currentLevel, maxLevel, rate, isMajorFaction, isFrienshipFaction, factionID = DataStore:GetReputationInfo(character, faction)
			if not status then return end

			local tooltip = AddonFactory_Tooltip
			
			tooltip:SetOwner(frame, "ANCHOR_LEFT")
			tooltip:ClearLines()
			tooltip:AddLine(format("%s %s@ %s%s", 
				DataStore:GetColoredCharacterName(character), colors.white, colors.teal, faction))

			rate = format("%d%%", floor(rate))
			
			if isMajorFaction then
				tooltip:AddLine(format("%s: %d/%d (%s)", format(LEVEL_GAINED, status), currentLevel, maxLevel, rate),1,1,1 )
			elseif isFrienshipFaction then
				local ranks = C_GossipInfo.GetFriendshipReputationRanks(factionID)

				tooltip:AddLine(format("%s %s/%s", RANK, status, ranks.maxLevel), 1,1,1)
				tooltip:AddLine(format("%d/%d (%s)", currentLevel, maxLevel, rate), 1,1,1)
			else
				tooltip:AddLine(format("%s: %d/%d (%s)", status, currentLevel, maxLevel, rate),1,1,1)
				
				local xp = DataStore.Enum.FactionStandingXPPerLevel
				
				tooltip:AddLine(" ",1,1,1)
				tooltip:AddLine(format("%s = %s", icons.notReady, UNKNOWN), 0.8, 0.13, 0.13)
				tooltip:AddDoubleLine(FACTION_STANDING_LABEL1, xp[1], 0.8, 0.13, 0.13)
				tooltip:AddDoubleLine(FACTION_STANDING_LABEL2, xp[2], 1.0, 0.0, 0.0)
				tooltip:AddDoubleLine(FACTION_STANDING_LABEL3, xp[3], 0.93, 0.4, 0.13)
				tooltip:AddDoubleLine(FACTION_STANDING_LABEL4, xp[4], 1.0, 1.0, 0.0)
				tooltip:AddDoubleLine(FACTION_STANDING_LABEL5, xp[5], 0.0, 1.0, 0.0)
				tooltip:AddDoubleLine(FACTION_STANDING_LABEL6, xp[6], 0.0, 1.0, 0.8)
				tooltip:AddDoubleLine(FACTION_STANDING_LABEL7, xp[7], 1.0, 0.4, 1.0)
				
				tooltip:AddLine(format("%s = %s", icons.ready, FACTION_STANDING_LABEL8), 1, 1, 1)
				tooltip:AddLine(format("%s = %s%s", icons.waiting, colors.epic, PARAGON_LABEL), 1, 1, 1)
			end
			
			tooltip:AddLine(" ",1,1,1)
			tooltip:AddLine(format("%s%s", colors.green, L["Shift+Left click to link"]))
			tooltip:Show()
			
		end,
	OnClick = function(frame, button)
			local character = frame.key
			if not character then return end

			local faction = view[ frame:GetParent():GetID() ].name
			local status, currentLevel, maxLevel, rate, isMajorFaction, isFrienshipFaction = DataStore:GetReputationInfo(character, faction)
			if not status then return end
			
			if button == "LeftButton" and IsShiftKeyDown() then
				local chat = ChatEdit_GetLastActiveWindow()
				if chat:IsShown() then
					if isMajorFaction then
						status = format(LEVEL_GAINED, status)
					end
					
					chat:Insert(format(L["%s is %s with %s (%d/%d)"], DataStore:GetCharacterName(character), status, faction, currentLevel, maxLevel))
				end
			end
		end,
	OnLeave = function(self)
			AddonFactory_Tooltip:Hide() 
		end,
})
