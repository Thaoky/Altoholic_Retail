local addonTabName = ...
local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors
local icons = addon.Icons

local L = DataStore:GetLocale(addonName)
local ICON_NOT_STARTED = "Interface\\RaidFrame\\ReadyCheck-NotReady" 
local ICON_PARTIAL = "Interface\\RaidFrame\\ReadyCheck-Waiting"
local ICON_COMPLETED = "Interface\\RaidFrame\\ReadyCheck-Ready" 

local tab		-- small shortcut to easily address the frame (set in OnBind)
local cat = DataStore.Enum.AchievementCategories

local currentPanelKey = "Achievements"
local currentPage
local MAX_PAGES = 12	-- good for 144 alts, should be enough, 1 page per class is even possible

addon:Controller("AltoholicUI.TabAchievements", {
	OnBind = function(frame)
		tab = frame
		
		currentPage = 1
		frame.PageNumber:SetText(format(MERCHANT_PAGE_NUMBER, currentPage, MAX_PAGES))
	
		frame.SelectRealm:RegisterClassEvent("RealmChanged", function(self, account, realm) 
				frame.ClassIcons:Update(account, realm, 1)	-- page 1 when changing realm
				frame.Status:SetText("")
				frame:Update()
			end)
			
		frame.SelectRealm:RegisterClassEvent("DropDownInitialized", function(self) 
				self:AddTitle()
				self:AddTitle(format("%s%s", colors.gold, L["Not started"]), ICON_NOT_STARTED)
				self:AddTitle(format("%s%s", colors.gold, L["Started"]), ICON_PARTIAL)
				self:AddTitle(format("%s%s", colors.gold, COMPLETE), ICON_COMPLETED)
			end)
			
		frame.ClassIcons.OnCharacterChanged = function(self)
				local account, realm = frame.SelectRealm:GetCurrentRealm()
				self:Update(account, realm, currentPage)
				frame:Update()
			end
	
		addon:ListenTo("ACHIEVEMENT_EARNED", function(event, id)
			if id then frame:Update() end
		end)
		
	end,
	RegisterPanel = function(frame, key, panel)
		-- a simple list of all the child frames
		frame.Panels = frame.Panels or {}
		frame.Panels[key] = panel
	end,
	HideAllPanels = function(frame)
		for _, panel in pairs(frame.Panels) do
			panel:Hide()
		end
	end,
	ShowPanel = function(frame, panelKey)
		if not panelKey then return end
		
		currentPanelKey = panelKey
		
		frame:HideAllPanels()
		
		local panel = frame.Panels[currentPanelKey]
		
		panel:Show()
		if panel.PreUpdate then
			panel:PreUpdate()
		end
		panel:Update()
	end,
	SetStatus = function(frame, text)
		frame.Status:SetText(text)
	end,
	SetCategory = function(frame, categoryID)
		local panel = frame.Panels[currentPanelKey]
		panel:SetCategory(categoryID)
	end,
	Update = function(frame)
		frame:ShowPanel(currentPanelKey)
	end,
	
	-- ** Pagination **
	GoToPreviousPage = function(frame)
		frame:SetPage(currentPage - 1)
	end,
	GoToNextPage = function(frame)
		frame:SetPage(currentPage + 1)
	end,
	GetPage = function(frame)
		return currentPage
	end,
	SetPage = function(frame, pageNum)
		currentPage = pageNum

		-- fix minimum page number
		currentPage = (currentPage < 1) and 1 or currentPage
		
		if currentPage == 1 then
			frame.PrevPage:Disable()
		else
			frame.PrevPage:Enable()
		end
		
		-- fix maximum page number
		currentPage = (currentPage > MAX_PAGES) and MAX_PAGES or currentPage
		
		if currentPage == MAX_PAGES then
			frame.NextPage:Disable()
		else
			frame.NextPage:Enable()
		end
		
		local account, realm = frame.SelectRealm:GetCurrentRealm()
		frame.ClassIcons:Update(account, realm, currentPage)
		frame.PageNumber:SetText(format(MERCHANT_PAGE_NUMBER, currentPage, MAX_PAGES))	
		frame:Update()
	end,
	GetRealm = function(frame)
		local account, realm = frame.SelectRealm:GetCurrentRealm()
		return realm, account
	end,
})

local function categoriesList_OnClick(categoryData)
	tab:SetCategory(categoryData.id)
	tab:Update()
end

local function FormatRaid(patch, mapID)
	return format("%s%s|r %s%s", colors.green, patch, colors.yellow, C_Map.GetAreaInfo(mapID))
end

addon:Controller("AltoholicUI.TabAchievementsCategoriesList", {
	OnBind = function(frame)
		local categories = {
			{ text = GetCategoryInfo(cat.Character), id = cat.Character, subMenu = {
				{ text = LEVEL, id = cat.CharacterLevel },
				{ text = MONEY, id = cat.CharacterMoney },
				{ text = L["Riding"], id = cat.CharacterRiding },
			}},
			{ text = GetCategoryInfo(cat.Quests), id = cat.Quests, subMenu = {
				{ text = format("%s%s", colors.cyan, "Zones"), subMenu = {
					{ id = cat.QuestsEasternKingdoms },
					{ id = cat.QuestsKalimdor },
					{ id = cat.QuestsOutland },
					{ id = cat.QuestsNorthrend },
					{ id = cat.QuestsCataclysm },
					{ id = cat.QuestsPandaria },
					{ id = cat.QuestsDraenor },
					{ id = cat.QuestsLegion },
					{ id = cat.QuestsBfA },
					{ id = cat.QuestsShadowlands },
					{ text = FormatRaid("9.2", 13536), id = cat.QuestsShadowlands92 },		-- Zereth Mortis
					{ id = cat.QuestsDragonflight },
					{ text = format("%s10.1|r %s%s", colors.green, colors.yellow, "Zaralek Cavern"), id = cat.QuestsDragonflight101 },
					{ text = format("%s10.2|r %s%s", colors.green, colors.yellow, "Emerald Dream"), id = cat.QuestsDragonflight102 },
				}},
				{ text = TRACKER_FILTER_COMPLETED_QUESTS, id = cat.QuestsCompleted },
				{ text = L["Daily Quests"], id = cat.QuestsDaily },
				{ text = TRACKER_HEADER_WORLD_QUESTS , id = cat.QuestsWorld },
				{ text = L["Dungeon Quests"], id = cat.QuestsDungeon },
			}},
			{ text = GetCategoryInfo(cat.Exploration), id = cat.Exploration, subMenu = {
				{ text = format("%s%s", colors.cyan, "Zones"), subMenu = {
					{ id = cat.ExplorationEasternKingdoms },
					{ id = cat.ExplorationKalimdor },
					{ id = cat.ExplorationOutland },
					{ id = cat.ExplorationNorthrend },
					{ id = cat.ExplorationCataclysm },
					{ id = cat.ExplorationPandaria },
					{ id = cat.ExplorationDraenor },
					{ id = cat.ExplorationLegion },
					{ id = cat.ExplorationBfA },
					{ id = cat.ExplorationShadowlands },
					-- Zereth Mortis
					{ text = format("%s9.2|r %s%s", colors.green, colors.yellow, C_Map.GetAreaInfo(13536)), id = cat.ExplorationShadowlands92 },
					{ id = cat.ExplorationDragonflight },
				}},
				{ text = L["Explorer"], id = cat.ExplorationExplorer },
			}},
			{ text = GetCategoryInfo(cat.PvP), id = cat.PvP, subMenu = {
				{ text = format("%s%s", colors.cyan, "Battlegrounds"), subMenu = {
					{ id = cat.PvPWarsongGulch },
					{ id = cat.PvPArathi },
					{ id = cat.PvPEyeOfTheStorm },
					{ id = cat.PvPAlteracValley },
					{ id = cat.PvPAshran },
					{ id = cat.PvPIsleOfConquest },
					{ id = cat.PvPWintergrasp },
					{ id = cat.PvPBattleForGilneas },
					{ id = cat.PvPTwinPeaks },
					{ id = cat.PvPSilvershardMines },
					{ id = cat.PvPTempleOfKotmogu },
					{ id = cat.PvPSeethingShore },
					{ id = cat.PvPDeepwindGorge },
				}},
				{ text = L["Battleground"], id = cat.PvPBattleground },
				{ text = L["Honor"], id = cat.PvPHonor },
				{ text = L["Honorable Kills"], id = cat.PvPHonorableKills },
				{ id = cat.PvPRatedBattleground },
				{ id = cat.PvPArena },
				{ text = L["Kills"], id = cat.PvPKills },
			}},
			{ text = L["Dungeons"], subMenu = {
				{ text = format("%s%s", colors.cyan, "Expansions"), subMenu = {
					{ text = EXPANSION_NAME0, id = cat.DungeonsClassic },
					{ text = EXPANSION_NAME1, id = cat.DungeonsBurningCrusade },
					{ text = EXPANSION_NAME2, id = cat.DungeonsLichKing },
					{ text = EXPANSION_NAME3, id = cat.DungeonsCataclysm },
					{ text = EXPANSION_NAME4, id = cat.DungeonsPandaria },
					{ text = EXPANSION_NAME5, id = cat.DungeonsDraenor },
					{ text = EXPANSION_NAME6, id = cat.DungeonsLegion },
					{ text = EXPANSION_NAME7, id = cat.DungeonsBfA },
					{ text = EXPANSION_NAME8, id = cat.DungeonsShadowlands },
					{ text = EXPANSION_NAME9, id = cat.DungeonsDragonflight },
				}},
				{ text = "Dungeon Hero", id = cat.DungeonHero },
				{ text = "Hero's Glory", id = cat.DungeonGloryHero },
				{ text = OTHER, id = cat.DungeonsOther },
				-- by exp
			}},
			{ text = L["Raids"], subMenu = {
				-- Source for C_Map.GetAreaInfo id's : https://wow.tools/dbc/?dbc=areatable
				{ text = EXPANSION_NAME0, id = cat.RaidsClassic },
				{ text = EXPANSION_NAME1, id = cat.RaidsBurningCrusade },
				{ text = EXPANSION_NAME2, subMenu = {
					-- 3.0 Vault of Archavon
					{ text = FormatRaid("3.0", 4603), id = cat.RaidsLichKingVaultOfArchavon },
					-- 3.0 Naxxramas
					{ text = FormatRaid("3.0", 4234), id = cat.RaidsLichKingNaxxramas },
					-- 3.0 Obsidian Sanctum
					{ text = FormatRaid("3.0", 4493), id = cat.RaidsLichKingObsidianSanctum },
					-- 3.0 Eye of Eternity
					{ text = FormatRaid("3.0", 4500), id = cat.RaidsLichKingEyeOfEternity },
					-- 3.1 Ulduar
					{ text = FormatRaid("3.1", 4273), id = cat.RaidsLichKingUlduar },
					-- 3.2 Trial of the Crusader
					{ text = FormatRaid("3.2", 4722), id = cat.RaidsLichKingTrialOfTheCrusader },
					-- 3.2 Onyxia's Lair
					{ text = FormatRaid("3.2", 2159), id = cat.RaidsLichKingOnyxiasLair },
					-- 3.3 Icecrown Citadel
					{ text = FormatRaid("3.3", 4522), id = cat.RaidsLichKingIcecrownCitadel },
					-- 3.3 Ruby Sanctum
					{ text = FormatRaid("3.3", 4987), id = cat.RaidsLichKingRubySanctum },
				}},
				{ text = EXPANSION_NAME3, subMenu = {
					-- 4.0 Blackwing Descent
					{ text = FormatRaid("4.0", 5094), id = cat.RaidsCataclysmBlackwingDescent },
					-- 4.0 Bastion of Twilight
					{ text = FormatRaid("4.0", 5334), id = cat.RaidsCataclysmBastionOfTwilight },
					-- 4.0 Throne of the Four Winds
					{ text = FormatRaid("4.0", 5638), id = cat.RaidsCataclysmThroneOfTheFourWinds },
					-- 4.2 Firelands
					{ text = FormatRaid("4.2", 5723), id = cat.RaidsCataclysmFirelands },
					-- 4.3 Dragon Soul
					{ text = FormatRaid("4.3", 5892), id = cat.RaidsCataclysmDragonSoul },
				}},
				{ text = EXPANSION_NAME4, id = cat.RaidsPandaria, subMenu = {
					-- 5.0 Mogu'Shan Vaults
					{ text = FormatRaid("5.0", 6125), id = cat.RaidsPandariaMoguShanVaults },
					-- 5.0 Heart of Fear
					{ text = FormatRaid("5.0", 6297), id = cat.RaidsPandariaHeartOfFear },
					-- 5.0 Terrace of Endless Spring
					{ text = FormatRaid("5.0", 6067), id = cat.RaidsPandariaTerraceOfEndlessSpring },
					-- 5.2 Throne of Thunder
					{ text = FormatRaid("5.2", 6622), id = cat.RaidsPandariaThroneOfThunder },
					-- 5.4 Siege of Orgrimmar
					{ text = FormatRaid("5.4", 6738), id = cat.RaidsPandariaSiegeOfOrgrimmar },
				}},
				{ text = EXPANSION_NAME5, id = cat.RaidsDraenor, subMenu = {
					-- 6.0 Highmaul
					{ text = FormatRaid("6.0", 6996), id = cat.RaidsDraenorHighmaul },
					-- 6.0 Blackrock Foundry
					{ text = FormatRaid("6.0", 6967), id = cat.RaidsDraenorBlackrockFoundry },
					-- 6.2 Hellfire Citadel
					{ text = FormatRaid("6.2", 7545), id = cat.RaidsDraenorHellfireCitadel },
				}},
				{ text = EXPANSION_NAME6, id = cat.RaidsLegion, subMenu = {
					-- 7.0 Emerald Nightmare
					{ text = FormatRaid("7.0", 8026), id = cat.RaidsLegionEmeraldNightmare },
					-- 7.1 Trial of Valor
					{ text = FormatRaid("7.1", 8440), id = cat.RaidsLegionTrialOfValor },
					-- 7.1 The Nighthold
					{ text = FormatRaid("7.1", 8025), id = cat.RaidsLegionNighthold },
					-- 7.2 Tomb of Sargeras
					{ text = FormatRaid("7.2", 8524), id = cat.RaidsLegionTombOfSargeras },
					-- 7.3 Antorus, the Burning Throne
					{ text = FormatRaid("7.3", 8638), id = cat.RaidsLegionAntorus },
				}},
				{ text = EXPANSION_NAME7, id = cat.RaidsBfA, subMenu = {
					-- 8.0 Uldir
					{ text = FormatRaid("8.0", 9389), id = cat.RaidsBfAUldir },
					-- 8.1 Battle of Dazar'alor
					{ text = FormatRaid("8.1", 10076), id = cat.RaidsBfABattleOfDazaralor },
					-- 8.1 Crucible of Storms
					{ text = FormatRaid("8.1", 10057), id = cat.RaidsBfACrucibleOfStorms },
					-- 8.2 The Eternal Palace
					{ text = FormatRaid("8.2", 10425), id = cat.RaidsBfAEternalPalace },
					-- 8.3 Ny'alotha
					{ text = FormatRaid("8.3", 10522), id = cat.RaidsBfANyalotha },
				}},
				{ text = EXPANSION_NAME8, id = cat.RaidsShadowlands, subMenu = {
					-- 9.0 Castle Nathria
					{ text = FormatRaid("9.0", 13224), id = cat.RaidsShadowlandsCastleNathria },
					-- 9.1 Sanctum of Domination
					{ text = FormatRaid("9.1", 13561), id = cat.RaidsShadowlandsSanctumOfDomination },
					-- 9.2 Sepulcher of the First Ones
					{ text = FormatRaid("9.2", 13742), id = cat.RaidsShadowlandsSepulcherOfTheFirstOnes },
				}},
				{ text = EXPANSION_NAME9, id = cat.RaidsDragonflight, subMenu = {
					-- 10.0 Vault of the Incarnates
					{ text = FormatRaid("10.0", 14030), id = cat.RaidsDragonflightVaultOfTheIncarnates },
				}},
				{ text = format("%s%s", colors.cyan, "Raider's Glory"), id = cat.DungeonGloryRaider },
				-- by exp
			}},
			{ id = cat.Professions, subMenu = {
				{ id = cat.ProfessionsCooking, subMenu = {
					{ text = LEVEL, id = cat.ProfessionsCookingLevel },
					{ text = L["Learn"], id = cat.ProfessionsCookingLearn },
					{ text = L["Cook"], id = cat.ProfessionsCookingCook },
					{ text = L["Daily Quests"], id = cat.ProfessionsCookingDailyQuests },
				}},
				{ id = cat.ProfessionsFishing, subMenu = {
					{ text = LEVEL, id = cat.ProfessionsFishingLevel },
					{ text = L["Fish up"], id = cat.ProfessionsFishingFishUp },
					{ text = L["Catch"], id = cat.ProfessionsFishingCatch },
					{ text = L["Daily Quests"], id = cat.ProfessionsFishingDailyQuests },
					{ text = EXPANSION_NAME9, id = cat.ProfessionsFishingDragonflight },
				}},
				{ id = cat.ProfessionsArchaeology, subMenu = {
					{ text = LEVEL, id = cat.ProfessionsArchaeologyLevel },
					{ text = L["Find"], id = cat.ProfessionsArchaeologyFind },
					{ text = EXPANSION_NAME3, id = cat.ProfessionsArchaeologyCataclysm },
					{ text = EXPANSION_NAME4, id = cat.ProfessionsArchaeologyPandaria },
					{ text = format("%s  %s", colors.yellow, L["Collector"]), id = cat.ProfessionsArchaeologyCollector },
					{ text = EXPANSION_NAME5, id = cat.ProfessionsArchaeologyDraenor },
					{ text = EXPANSION_NAME6, id = cat.ProfessionsArchaeologyLegion },
					{ text = EXPANSION_NAME7, id = cat.ProfessionsArchaeologyBfA },
				}},
			}},
			{ id = cat.Reputations, subMenu = {
				{ text = FACTION_STANDING_LABEL8, id = cat.ReputationsExalted },
				{ text = L["Allied Races"], id = cat.ReputationsAlliedRaces },
				{ text = L["Heritage"], id = cat.ReputationsHeritage },
				{ text = format("%s%s", colors.cyan, "Expansions"), subMenu = {
					{ text = EXPANSION_NAME0, id = cat.ReputationsClassic },
					{ text = EXPANSION_NAME1, id = cat.ReputationsBurningCrusade },
					{ text = EXPANSION_NAME2, id = cat.ReputationsLichKing },
					{ text = EXPANSION_NAME3, id = cat.ReputationsCataclysm },
					{ text = EXPANSION_NAME4, id = cat.ReputationsPandaria },
					{ text = EXPANSION_NAME5, id = cat.ReputationsDraenor },
					{ text = EXPANSION_NAME6, id = cat.ReputationsLegion },
					{ text = EXPANSION_NAME7, id = cat.ReputationsBfA },
					{ text = EXPANSION_NAME8, id = cat.ReputationsShadowlands },
					{ text = EXPANSION_NAME9, id = cat.ReputationsDragonflight },
				}},
			}},
			{ id = cat.WorldEvents, subMenu = {
				{ id = cat.WorldEventsLunarFestival },
				{ id = cat.WorldEventsLoveIsInTheAir },
				{ id = cat.WorldEventsNoblegarden },
				{ id = cat.WorldEventsChildrensWeek },
				{ id = cat.WorldEventsMidSummer, subMenu = {
					{ text = L["Desecrate"], id = cat.WorldEventsMidSummerDesecrate },
					{ text = L["Flame Keeper"], id = cat.WorldEventsMidSummerKeepers },
					{ text = L["Flame Warden"], id = cat.WorldEventsMidSummerWardens },
				}},
				{ id = cat.WorldEventsBrewfest },
				{ id = cat.WorldEventsHallowsEnd, subMenu = {
					{ text = L["Tricks and Treats"], id = cat.WorldEventsHallowsEndTricks },
				}},
				{ id = cat.WorldEventsPilgrimsBounty },
				{ id = cat.WorldEventsWinterveil },
				{ id = cat.WorldEventsDarkmoon, subMenu = {
					{ text = L["The Real Race"], id = cat.WorldEventsDarkmoonRealRace },
					{ text = L["The Real Big Race"], id = cat.WorldEventsDarkmoonRealBigRace },
				}},
				{ id = cat.WorldEventsBrawlersGuild },
			}},
			{ id = cat.PetBattles, subMenu = {
				{ id = cat.PetBattlesCollect, subMenu = {
					{ text = ITEM_UNIQUE, id = cat.PetBattlesCollectUnique },
					{ text = select(2, GetAchievementInfo(7934)), id = cat.PetBattlesCollectLeashes },
					{ text = L["Safari"], id = cat.PetBattlesCollectSafari },
				}},
				{ id = cat.PetBattlesBattle, subMenu = {
					{ text = L["Wins"], id = cat.PetBattlesBattleWins },
					{ text = PVP, id = cat.PetBattlesBattlePvP },
					{ text = EXPANSION_NAME6, id = cat.PetBattlesBattleLegion },
					{ text = format("%s  %s", colors.yellow, GetRealZoneText(1669)), id = cat.PetBattlesBattleArgus },
					{ text = EXPANSION_NAME7, id = cat.PetBattlesBattleBfA },
					{ text = EXPANSION_NAME8, id = cat.PetBattlesBattleShadowlands },
					{ text = EXPANSION_NAME9, id = cat.PetBattlesBattleDragonflight },
				}},
				{ id = cat.PetBattlesLevel },
			}},
			{ id = cat.Collections, subMenu = {
				{ id = cat.CollectionsToyBox },
				{ id = cat.CollectionsMounts },
				{ id = cat.CollectionsAppearances, subMenu = {
					{ text = L["Raids"], id = cat.CollectionsAppearancesRaids },
					{ text = PVP, id = cat.CollectionsAppearancesPvP },
				}},
			}},
			{ id = cat.ExpansionFeatures, subMenu = {
				{ id = cat.ExpansionFeaturesArgentTournament },
				{ id = cat.ExpansionFeaturesTolBarad },
				{ id = cat.ExpansionFeaturesPandariaScenarios },
				{ id = cat.ExpansionFeaturesProvingGrounds, subMenu = {
					{ text = DAMAGE, id = cat.ExpansionFeaturesProvingGroundsDamage },
					{ text = HEALER, id = cat.ExpansionFeaturesProvingGroundsHealer },
					{ text = TANK, id = cat.ExpansionFeaturesProvingGroundsTank },
				}},
				{ id = cat.ExpansionFeaturesDraenorGarrisons },
				{ id = cat.ExpansionFeaturesLegionClassHall },
				{ id = cat.ExpansionFeaturesIslandExpeditions },
				{ id = cat.ExpansionFeaturesWarEffort },
				{ id = cat.ExpansionFeaturesHeartOfAzeroth },
				{ id = cat.ExpansionFeaturesVisionsOfNzoth },
				{ id = cat.ExpansionFeaturesTorghast, subMenu = {
					{ text = L["Twisting Corridors"], id = cat.ExpansionFeaturesTorghastCorridors },
					{ text = L["Flawless Runs"], id = cat.ExpansionFeaturesTorghastFlawless },
					{ text = L["Phantasma"], id = cat.ExpansionFeaturesTorghastPhantasma },
				}},
				{ id = cat.ExpansionFeaturesCovenantSanctums, subMenu = {
					{ text = C_Covenants.GetCovenantData(1).name, id = cat.ExpansionFeaturesCovenantSanctumsKyrian },
					{ text = C_Covenants.GetCovenantData(2).name, id = cat.ExpansionFeaturesCovenantSanctumsVenthyr },
					{ text = C_Covenants.GetCovenantData(3).name, id = cat.ExpansionFeaturesCovenantSanctumsNightFae },
					{ text = C_Covenants.GetCovenantData(4).name, id = cat.ExpansionFeaturesCovenantSanctumsNecrolords },
					{ text = COVENANT_MISSIONS_TITLE, id = cat.ExpansionFeaturesCovenantSanctumsAdventures },
				}},
				{ text = GetCategoryInfo(cat.ExpansionFeaturesDragonriderRacing), id = cat.ExpansionFeaturesDragonriderRacing },
				{ text = "Primal Storms", id = cat.ExpansionFeaturesPrimalStorms },
			}},
			{ id = cat.PandariaRemix, subMenu = {
				{ id = cat.PandariaRemixQuests },
				{ id = cat.PandariaRemixReputation },
				{ id = cat.PandariaRemixExploration },
				{ id = cat.PandariaRemixScenarios },
				{ id = cat.PandariaRemixDungeons },
				{ id = cat.PandariaRemixRaids },
			}},
			{ id = cat.FeatsOfStrength, subMenu = {
				{ id = cat.FeatsOfStrengthMounts, subMenu = {
					{ text = GetCategoryInfo(cat.PvPArena), id = cat.FeatsOfStrengthMountsArena },
					{ text = RAF_BUTTON_TOOLTIP_TITLE , id = cat.FeatsOfStrengthMountsRaF },
				}},
				{ id = cat.FeatsOfStrengthDungeons, subMenu = {
					{ text = CHALLENGE_MODE, id = cat.FeatsOfStrengthDungeonsChallenge },
					{ text = EXPANSION_NAME7, id = cat.FeatsOfStrengthDungeonsBfA },
					{ text = EXPANSION_NAME8, id = cat.FeatsOfStrengthDungeonsShadowlands },
					{ text = EXPANSION_NAME9, id = cat.FeatsOfStrengthDungeonsDragonflight },
				}},
				{ id = cat.FeatsOfStrengthRaids, subMenu = {
					{ text = L["Ahead of the Curve"], id = cat.FeatsOfStrengthRaidsAhead },
					{ text = L["Cutting Edge"], id = cat.FeatsOfStrengthRaidsCuttingEdge },
				}},
				{ id = cat.FeatsOfStrengthPvP, subMenu = {
					{ text = EXPANSION_NAME5, id = cat.FeatsOfStrengthPvPDraenor },
					{ text = EXPANSION_NAME6, id = cat.FeatsOfStrengthPvPLegion },
					{ text = EXPANSION_NAME7, id = cat.FeatsOfStrengthPvPBfA },
					{ text = EXPANSION_NAME8, id = cat.FeatsOfStrengthPvPShadowlands },
					{ text = EXPANSION_NAME9, id = cat.FeatsOfStrengthPvPDragonflight },
					{ text = GetCategoryInfo(cat.PvPRatedBattleground), id = cat.FeatsOfStrengthPvPRatedBG },
					
					-- Unchained Combatant / Vicious Saddle
					{ text = select(2, GetAchievementInfo(14967)), id = cat.FeatsOfStrengthPvPUnchained },
				}},
				{ id = cat.FeatsOfStrengthReputation },
				{ id = cat.FeatsOfStrengthEvents, subMenu = {
					{ text = GetCategoryInfo(cat.WorldEventsWinterveil), id = cat.FeatsOfStrengthEventsWinterveil },
					{ text = L["Anniversary"], id = cat.FeatsOfStrengthEventsAnniversary },
				}},
				{ id = cat.FeatsOfStrengthPromotions, subMenu = {
					{ text = L["BlizzCon"], id = cat.FeatsOfStrengthPromotionsBlizzCon },
					{ text = L["Collector's Edition"], id = cat.FeatsOfStrengthPromotionsCollector },
				}},
				{ text = L["Realm First"], id = cat.FeatsOfStrengthRealmFirst },
			}},
		}
		
		-- Initialize categories (auto-fill .text & .callback)
		frame:IterateCategories(categories, function(category) 
			if not category.text and category.id then
				-- if no text has been set, get one from the id
				category.text = GetCategoryInfo(category.id)
			end
			
			-- set the onClick callback
			category.callback = categoriesList_OnClick
		end)
	
		frame:SetCategories(categories)
	end,
})

DataStore:OnAddonLoaded(addonTabName, function() 
	Altoholic_AchievementsTab_Columns = Altoholic_AchievementsTab_Columns or {}
		
	--Temporary: database migration
	if AltoholicDB and AltoholicDB.global and AltoholicDB.global.options then
		local source = AltoholicDB.global.options
		local dest = Altoholic_AchievementsTab_Columns

		for k, v in pairs(source) do
			local arg1, arg2, account, realm, column = strsplit(".", k)
			
			if arg1 == "Tabs" and arg2 == "Achievements" then
				local realmKey = format("%s.%s", account, realm)	-- ex: "Default.Dalaran"
				local columnIndex = tonumber(column:match("%d+$"))
				local _, _, characterName = strsplit(".", v)
				
				-- Create the new entries
				dest[realmKey] = dest[realmKey] or {}
				dest[realmKey][columnIndex] = characterName
				
				-- Delete the old entries
				source[k] = nil
			end
		end
	end

	local account, realm = tab.SelectRealm:GetCurrentRealm()
	tab.ClassIcons:Update(account, realm, currentPage)	
end)
