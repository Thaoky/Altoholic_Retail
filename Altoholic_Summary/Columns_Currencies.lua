local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

local L = AddonFactory:GetLocale(addonName)
local MVC = LibStub("LibMVC-1.0")
local Columns = MVC:GetService("AltoholicUI.TabSummaryColumns")
local Formatter = MVC:GetService("AltoholicUI.Formatter")

local enum = DataStore.Enum.CurrencyIDs

-- *** Utility functions ***
local function CurrencyHeader_OnEnter(frame, tooltip, column)
	tooltip:ClearLines()
	tooltip:SetOwner(frame, "ANCHOR_BOTTOM")
	tooltip:SetHyperlink(C_CurrencyInfo.GetCurrencyLink(column.currencyID, 0))
	tooltip:Show()
end

local function GetTotals(character, currencyID)
	local amount, _, _, totalMax = DataStore:GetCurrencyTotals(character, currencyID)

	-- After the DataStore_Currencies SV file was cleared, if may happen that an alt has no data, 
	-- so both values would be nil, default them to 0
	
	return amount or 0, totalMax or 0
end

local function SortByTotal(frame, character, column)
	return GetTotals(character, column.currencyID)
end

local function GetCurrencyText(character, column)
	local amount, totalMax = GetTotals(character, column.currencyID)
	local color = (amount == 0) and colors.grey or colors.white
	
	return format("%s%s", color, amount)
end

local function GetCurrencyTextWithMax(character, column)
	local amount, totalMax = GetTotals(character, column.currencyID)
	local color = (amount == 0) and colors.grey or colors.white
	
	return format("%s%s%s/%s%s", color, amount, colors.white, colors.yellow, totalMax)
end

-- ** Miscellaneous **
Columns.RegisterColumn("Cur_TimewarpedBadge", {
	currencyID = enum.TimewarpedBadge,

	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\pvecurrency-justice")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 60,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_Darkmoon", {
	currencyID = enum.DarkmoonPrize,
	
	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_misc_ticket_darkmoon_01")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 60,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_Epicurean", {
	currencyID = enum.EpicureansAward,
	
	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_misc_ribbon_01")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 60,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_Ironpaw", {
	currencyID = enum.IronpawToken,
	
	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_relics_idolofferocity")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 60,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_SpiritShard", {
	currencyID = enum.SpiritShard,
	-- Header
	headerWidth = 80,
	headerLabel = format("%s[2.0]  %s", colors.green, Formatter.Texture18("Interface\\Icons\\inv_jewelry_frostwolftrinket_04")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 80,
	GetText = GetCurrencyTextWithMax,
})

Columns.RegisterColumn("Cur_ChampionsSeal", {
	currencyID = enum.ChampionsSeal,

	-- Header
	headerWidth = 80,
	headerLabel = format("%s[3.0]  %s", colors.green, Formatter.Texture18("Interface\\Icons\\ability_paladin_artofwar")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 80,
	GetText = GetCurrencyText,
})

-- ** Cataclysm **
Columns.RegisterColumn("Cur_Deathwing", {
	currencyID = enum.EssenceOfCorruptedDeathwing,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_elemental_primal_shadow")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_MoteDarkness", {
	currencyID = enum.MoteOfDarkness,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\spell_shadow_sealofkings")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_MarkWorldTree", {
	currencyID = enum.MarkOfTheWorldTree,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_misc_markoftheworldtree")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_IllustrJC", {
	currencyID = enum.IllustriousJewelcrafter,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_misc_token_argentdawn3")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

-- ** Mists of Pandaria **
Columns.RegisterColumn("Cur_Bloody", {
	currencyID = enum.BloodyCoin,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\timelesscoin-bloody")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_ElderCharm", {
	currencyID = enum.ElderCharm,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_misc_coin_17")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyTextWithMax,
})

Columns.RegisterColumn("Cur_LesserCharm", {
	currencyID = enum.LesserCharm,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_misc_coin_18")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_MoguRune", {
	currencyID = enum.MoguRuneOfFate,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\archaeology_5_0_mogucoin")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyTextWithMax,
})

Columns.RegisterColumn("Cur_TimelessCoin", {
	currencyID = enum.TimelessCoin,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\timelesscoin")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_WarforgedSeal", {
	currencyID = enum.WarforgedSeal,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_arcane_orb")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyTextWithMax,
})

-- ** Warlords of Draenor **
Columns.RegisterColumn("Cur_Garrison", {
	currencyID = enum.GarrisonResources,

	-- Header
	headerWidth = 80,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_garrison_resource")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 80,
	GetText = function(character, column)
			local uncollected = DataStore:GetUncollectedResources(character) or 0
			local amount = GetTotals(character, column.currencyID) or 0
			local color = (amount == 0) and colors.grey or colors.white
			local colorUncollected
			
			if uncollected <= 300 then
				colorUncollected = colors.green
			elseif uncollected < 450 then
				colorUncollected = colors.yellow
			else
				colorUncollected = colors.red
			end

			return format("%s%s/%s+%s", color, amount, colorUncollected , uncollected)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Garrisons", character) then
				return
			end
			
			local amount = GetTotals(character, enum.GarrisonResources) or 0
			local uncollected = DataStore:GetUncollectedResources(character) or 0
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["Garrison resources"])
			tt:AddLine(" ")
			tt:AddLine(format("%s: %s%s", L["Garrison resources"], colors.green, amount),1,1,1)
			tt:AddLine(format("%s: %s%s", L["Uncollected resources"], colors.green, uncollected),1,1,1)
			
			local lastVisit = DataStore:GetLastResourceCollectionTime(character)
			if lastVisit then
				tt:AddLine(format("%s: %s", L["Last collected"], SecondsToTime(time() - lastVisit)),1,1,1)
			end
			
			if uncollected < 500 then
				tt:AddLine(" ")
				
				-- (resources not yet obtained * 600 seconds)
				tt:AddLine(format("%s: %s", L["Max. uncollected resources in"], SecondsToTime((500 - uncollected) * 600)),1,1,1)
			end
			tt:Show()
		end,
})

Columns.RegisterColumn("Cur_Oil", {
	currencyID = enum.Oil,

	-- Header
	headerWidth = 90,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\garrison_oil")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 90,
	GetText = function(character, column)
		local amount, totalMax = GetTotals(character, column.currencyID)
		local color = (amount == 0) and colors.grey or colors.white
		
		if totalMax > 0 then
			totalMax = format("%2.0fk", totalMax / 1000)
		end
		
		return format("%s%s%s/%s%s", color, amount, colors.white, colors.yellow, totalMax)
	end,
})

Columns.RegisterColumn("Cur_Apexis", {
	currencyID = enum.ApexisCrystal,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_apexis_draenor")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_InevitableFate", {
	currencyID = enum.SealOfInevitableFate,

	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\achievement_battleground_templeofkotmogu_02_green")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 60,
	GetText = GetCurrencyTextWithMax,
})

Columns.RegisterColumn("Cur_TemperedFate", {
	currencyID = enum.SealOfTemperedFate,

	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\ability_animusorbs")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 60,
	GetText = GetCurrencyTextWithMax,
})

Columns.RegisterColumn("Cur_ArtifactFragment", {
	currencyID = enum.ArtifactFragment,

	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_ashran_artifact")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 60,
	GetText = GetCurrencyTextWithMax,
})

-- ** Legion **
Columns.RegisterColumn("Cur_OrderHall", {
	currencyID = enum.OrderHall,

	-- Header
	headerWidth = 80,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_garrison_resource")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 80,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_WarSupplies", {
	currencyID = enum.LegionfallWarSupplies,

	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_misc_summonable_boss_token")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 60,
	GetText = GetCurrencyTextWithMax,
})

Columns.RegisterColumn("Cur_Nethershard", {
	currencyID = enum.Nethershard,

	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_datacrystal01")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 60,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_BrokenFate", {
	currencyID = enum.SealOfBrokenFate,

	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_misc_azsharacoin")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 60,
	GetText = GetCurrencyTextWithMax,
})

Columns.RegisterColumn("Cur_SightlessEye", {
	currencyID = enum.SightlessEye,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\achievement_reputation_kirintor_offensive")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyTextWithMax,
})

Columns.RegisterColumn("Cur_AncientMana", {
	currencyID = enum.AncientMana,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_misc_ancient_mana")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyTextWithMax,
})

Columns.RegisterColumn("Cur_VeiledArgunite", {
	currencyID = enum.VeiledArgunite,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\oshugun_crystalfragments")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,

	-- Content
	Width = 70,
	GetText = GetCurrencyTextWithMax,
})

-- ** Battle for Azeroth **
Columns.RegisterColumn("Cur_WarResources", {
	currencyID = enum.WarResources,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv__faction_warresources")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_WartornFate", {
	currencyID = enum.SealsOfWartornFate,

	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\timelesscoin_yellow")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 60,
	GetText = GetCurrencyTextWithMax,
})

Columns.RegisterColumn("Cur_BfADubloons", {
	currencyID = enum.SeafarersDubloon,

	-- Header
	headerWidth = 60,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_misc_azsharacoin")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 60,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_BfAWarSupplies", {
	currencyID = enum.BfAWarSupplies,

	-- Header
	headerWidth = 80,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\pvpcurrency-conquest-horde")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 80,
	GetText = GetCurrencyTextWithMax,
})

Columns.RegisterColumn("Cur_BfARichAzerite", {
	currencyID = enum.RichAzeriteFragment,

	-- Header
	headerWidth = 80,
	headerLabel = format("      %s", Formatter.Texture18("Interface\\Icons\\inv_smallazeriteshard")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 80,
	GetText = GetCurrencyTextWithMax,
})

-- ** Shadowlands / 9.0 **
Columns.RegisterColumn("Cur_Stygia", {
	currencyID = enum.Stygia,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_stygia")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_Anima", {
	currencyID = enum.ReservoirAnima,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\spell_animabastion_orb")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = function(character, column)
			local amount, totalMax = GetTotals(character, column.currencyID)
			local color = (amount == 0) and colors.grey or colors.white
			
			-- save some space by shortening the label
			if totalMax > 0 then
				totalMax = format("%sk", (totalMax / 1000))
			end
			
			return format("%s%s%s/%s%s", color, amount, colors.white, colors.yellow, totalMax)
		end,
})

Columns.RegisterColumn("Cur_RedeemedSoul", {
	currencyID = enum.RedeemedSoul,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\sha_spell_warlock_demonsoul_nightborne")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyTextWithMax,
})

Columns.RegisterColumn("Cur_Valor", {
	currencyID = enum.ValorPoints,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\pvecurrency-valor")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyTextWithMax,
})

Columns.RegisterColumn("Cur_Conquest", {
	currencyID = enum.Conquest,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\achievement_legionpvp2tier3")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_SoulAsh", {
	currencyID = enum.SoulAsh,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_soulash")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

-- ** Shadowlands / 9.1 Chains of Domination **

Columns.RegisterColumn("Cur_CatalogedResearch", {
	currencyID = enum.CatalogedResearch,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_misc_paperbundle04a")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_TowerKnowledge", {
	currencyID = enum.TowerKnowledge,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\spell_broker_orb")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyTextWithMax,
})

Columns.RegisterColumn("Cur_StygianEmber", {
	currencyID = enum.StygianEmber,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\ability_deathknight_soulreaper")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_SoulCinders", {
	currencyID = enum.SoulCinders,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_misc_supersoulash")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

-- ** Shadowlands / 9.2 Eternity's End **

Columns.RegisterColumn("Cur_Cyphers", {
	currencyID = enum.CyphersOfTheFirstOnes,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_trinket_progenitorraid_02_blue")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = function(character, column)
		local amount, totalMax = GetTotals(character, column.currencyID)
		local color = (amount == 0) and colors.grey or colors.white
		
		local text = format("%s%s", color, amount)
		
		
		-- has this character already used the "Improvised Cypher Analysis Tool" ? 
		if DataStore:IsQuestCompletedBy(character, 65282) then
			local icon = select(5, GetItemInfoInstant(188793))
			
			if icon then
				return format("%s %s", text, Formatter.Texture18(icon))
			end
		end
	
		return text
	end,
})

Columns.RegisterColumn("Cur_CosmicFlux", {
	currencyID = enum.CosmicFlux,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_currency_cosmicflux")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

-- ** Dragonflight / 10.0 **

Columns.RegisterColumn("Cur_DragonIslesSupplies", {
	currencyID = enum.DragonIslesSupplies,

	-- Header
	headerWidth = 100,
	headerLabel = format("             %s", Formatter.Texture18("Interface\\Icons\\inv_faction_warresources")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 100,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_ElementalOverflow", {
	currencyID = enum.ElementalOverflow,

	-- Header
	headerWidth = 75,
	headerLabel = format("        %s", Formatter.Texture18("Interface\\Icons\\inv_misc_powder_thorium")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 75,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_StormSigil", {
	currencyID = enum.StormSigil,

	-- Header
	headerWidth = 75,
	headerLabel = format("        %s", Formatter.Texture18("Interface\\Icons\\inv_cloudserpent_egg_yellow")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 75,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_ConquestPoints", {
	currencyID = enum.Conquest,

	-- Header
	headerWidth = 75,
	headerLabel = format("        %s", Formatter.Texture18("Interface\\Icons\\achievement_legionpvp2tier3")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 75,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_Honor", {
	currencyID = enum.Honor,

	-- Header
	headerWidth = 75,
	headerLabel = format("        %s", Formatter.Texture18("Interface\\Icons\\achievement_legionpvptier4")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 75,
	GetText = GetCurrencyText,
})

-- ** Dragonflight / 10.1 **
Columns.RegisterColumn("Cur_Flightstones", {
	currencyID = enum.Flightstones,

	-- Header
	headerWidth = 100,
	headerLabel = format("             %s", Formatter.Texture18("Interface\\Icons\\flightstone-dragonflight")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 100,
	GetText = GetCurrencyTextWithMax,
})

Columns.RegisterColumn("Cur_ParacausalFlakes", {
	currencyID = enum.ParacausalFlakes,

	-- Header
	headerWidth = 60,
	headerLabel = format("     %s", Formatter.Texture18("Interface\\Icons\\ability_essence_reapingflames")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,

	-- Content
	Width = 60,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_RidersofAzerothBadge", {
	currencyID = enum.RidersofAzerothBadge,

	-- Header
	headerWidth = 60,
	headerLabel = format("     %s", Formatter.Texture18("Interface\\Icons\\inv_10_fishing_dragonislescoins_bronze")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,

	-- Content
	Width = 60,
	GetText = GetCurrencyText,
})

-- ** Dragonflight / 10.2 **
Columns.RegisterColumn("Cur_WhelplingsDreamingCrest", {
	currencyID = enum.WhelplingsDreamingCrest,

	-- Header
	headerWidth = 60,
	headerLabel = format("     %s", Formatter.Texture18("Interface\\Icons\\inv_10_gearupgrade_whelplingsdreamingcrest")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,

	-- Content
	Width = 60,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_DrakesDreamingCrest", {
	currencyID = enum.DrakesDreamingCrest,

	-- Header
	headerWidth = 60,
	headerLabel = format("     %s", Formatter.Texture18("Interface\\Icons\\inv_10_gearupgrade_drakesdreamingcrest")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,

	-- Content
	Width = 60,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_WyrmsDreamingCrest", {
	currencyID = enum.WyrmsDreamingCrest,

	-- Header
	headerWidth = 60,
	headerLabel = format("     %s", Formatter.Texture18("Interface\\Icons\\inv_10_gearupgrade_wyrmsdreamingcrest")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,

	-- Content
	Width = 60,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_AspectsDreamingCrest", {
	currencyID = enum.AspectsDreamingCrest,

	-- Header
	headerWidth = 60,
	headerLabel = format("     %s", Formatter.Texture18("Interface\\Icons\\inv_10_gearupgrade_aspectsdreamingcrest")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,

	-- Content
	Width = 60,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_EmeraldDewdrop", {
	currencyID = enum.EmeraldDewdrop,

	-- Header
	headerWidth = 60,
	headerLabel = format("     %s", Formatter.Texture18("Interface\\Icons\\inv_misc_shadowdew")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,

	-- Content
	Width = 60,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_DreamInfusion", {
	currencyID = enum.DreamInfusion,

	-- Header
	headerWidth = 60,
	headerLabel = format("     %s", Formatter.Texture18("Interface\\Icons\\inv_legion_faction_dreamweavers")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,

	-- Content
	Width = 60,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_MysteriousFragment", {
	currencyID = enum.MysteriousFragment,

	-- Header
	headerWidth = 60,
	headerLabel = format("     %s", Formatter.Texture18("Interface\\Icons\\inv_7_0raid_trinket_05a")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,

	-- Content
	Width = 60,
	GetText = GetCurrencyText,
})

-- ** War Within / 11.0 **
Columns.RegisterColumn("Cur_ResidualMemories", {
	currencyID = enum.ResidualMemories,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\spell_azerite_essence_15")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_ResonanceCrystals", {
	currencyID = enum.ResonanceCrystals,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\spell_azerite_essence14")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_Kej", {
	currencyID = enum.Kej,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_10_tailoring_silkrare_color3")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_Valorstones", {
	currencyID = enum.Valorstones,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_valorstone_base")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_MereldarDerbyMark", {
	currencyID = enum.MereldarDerbyMark,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_11_0_misc_darkmoonfaresigil_color5")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_RestoredCofferKey", {
	currencyID = enum.RestoredCofferKey,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_10_blacksmithing_consumable_key_color1")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})



-- ** War Within / 11.0 / Season 1 **
Columns.RegisterColumn("Cur_WeatheredHarbinger", {
	currencyID = enum.WeatheredHarbingerCrest,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_crestupgrade_xalatath_weathered")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_CarvedHarbinger", {
	currencyID = enum.CarvedHarbingerCrest,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_crestupgrade_xalatath_carved")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_RunedHarbinger", {
	currencyID = enum.RunedHarbingerCrest,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_crestupgrade_xalatath_runed")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_GildedHarbinger", {
	currencyID = enum.GildedHarbingerCrest,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_crestupgrade_xalatath_gilded")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_Undercoin", {
	currencyID = enum.Undercoin,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_misc_elvencoins")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_BronzeCelebToken", {
	currencyID = enum.BronzeCelebration,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_10_dungeonjewelry_dragon_necklace_1_bronze")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})


-- ** War Within / 11.1 / Season 2 **
Columns.RegisterColumn("Cur_WeatheredUndermine", {
	currencyID = enum.WeatheredUndermineCrest,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_crestupgrade_undermine_weathered")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_CarvedUndermine", {
	currencyID = enum.CarvedUndermineCrest,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_crestupgrade_undermine_carved")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_RunedUndermine", {
	currencyID = enum.RunedUndermineCrest,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_crestupgrade_undermine_runed")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_GildedUndermine", {
	currencyID = enum.GildedUndermineCrest,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_crestupgrade_undermine_gilded")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})


-- ** War Within / 11.1 / Season 3 **
Columns.RegisterColumn("Cur_WeatheredEthereal", {
	currencyID = enum.WeatheredEtherealCrest,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_crestupgrade_ethereal_weathered")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_CarvedEthereal", {
	currencyID = enum.CarvedEtherealCrest,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_crestupgrade_ethereal_carved")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_RunedEthereal", {
	currencyID = enum.RunedEtherealCrest,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_crestupgrade_ethereal_runed")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

Columns.RegisterColumn("Cur_GildedEthereal", {
	currencyID = enum.GildedEtherealCrest,

	-- Header
	headerWidth = 70,
	headerLabel = format("   %s", Formatter.Texture18("Interface\\Icons\\inv_crestupgrade_ethereal_gilded")),
	headerOnEnter = CurrencyHeader_OnEnter,
	headerSort = SortByTotal,
	
	-- Content
	Width = 70,
	GetText = GetCurrencyText,
})

