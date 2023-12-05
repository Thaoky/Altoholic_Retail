local addonName = "Altoholic"
local addon = _G[addonName]

local BORDER_TEXTURE = "CovenantSanctum-Icon-Border-%s"

-- Source : Blizzard_CovenantSanctum/Blizzard_CovenantSanctumUpgrades.lua
local covenantSanctumFeatureDescription = {
	[Enum.GarrTalentFeatureType.AnimaDiversion] = {
		[Enum.CovenantType.Venthyr] = COVENANT_SANCTUM_FEATURE_ANIMACONDUCTOR_VENTHYR,
		[Enum.CovenantType.Kyrian] = COVENANT_SANCTUM_FEATURE_ANIMACONDUCTOR_KYRIAN,
		[Enum.CovenantType.NightFae] = COVENANT_SANCTUM_FEATURE_ANIMACONDUCTOR_NIGHTFAE,
		[Enum.CovenantType.Necrolord] = COVENANT_SANCTUM_FEATURE_ANIMACONDUCTOR_NECROLORD,
	},
	[Enum.GarrTalentFeatureType.TravelPortals] = {
		[Enum.CovenantType.Venthyr] = COVENANT_SANCTUM_FEATURE_TRAVELNETWORK_VENTHYR,
		[Enum.CovenantType.Kyrian] = COVENANT_SANCTUM_FEATURE_TRAVELNETWORK_KYRIAN,
		[Enum.CovenantType.NightFae] = COVENANT_SANCTUM_FEATURE_TRAVELNETWORK_NIGHTFAE,
		[Enum.CovenantType.Necrolord] = COVENANT_SANCTUM_FEATURE_TRAVELNETWORK_NECROLORD,
	},
	[Enum.GarrTalentFeatureType.Adventures] = {
		[Enum.CovenantType.Venthyr] = COVENANT_SANCTUM_FEATURE_ADVENTURES_VENTHYR,
		[Enum.CovenantType.Kyrian] = COVENANT_SANCTUM_FEATURE_ADVENTURES_KYRIAN,
		[Enum.CovenantType.NightFae] = COVENANT_SANCTUM_FEATURE_ADVENTURES_NIGHTFAE,
		[Enum.CovenantType.Necrolord] = COVENANT_SANCTUM_FEATURE_ADVENTURES_NECROLORD,
	},
	[Enum.GarrTalentFeatureType.SanctumUnique] = {
		[Enum.CovenantType.Venthyr] = COVENANT_SANCTUM_UNIQUE_VENTHYR,
		[Enum.CovenantType.Kyrian] = COVENANT_SANCTUM_UNIQUE_KYRIAN,
		[Enum.CovenantType.NightFae] = COVENANT_SANCTUM_UNIQUE_NIGHTFAE,
		[Enum.CovenantType.Necrolord] = COVENANT_SANCTUM_UNIQUE_NECROLORD,
	},
}

local talentCache = { 0, 0, 0, 0, 0 }	-- make room for 5 talents

addon:Controller("AltoholicUI.TabCharacters.CovenantSanctumUpgradeTree", {
	Update = function(frame, character, covenantID, treeType)
		
		-- Get a valid tree ID
		local treeInfo = DataStore:GetReservoirTalentTreeInfo(character, treeType)
		if not treeInfo or not treeInfo.treeID then return end
		
		local info = C_Garrison.GetTalentTreeInfo(treeInfo.treeID)
		local textureKit = C_Covenants.GetCovenantData(covenantID).textureKit
		
		-- Set the upgrade type icon & border
		local button = frame.IconButton
		
		button.Icon:SetTexture(info.talents[1].icon)
		button.Border:SetAtlas(format(BORDER_TEXTURE, textureKit, true))
		button.Tier:SetText(treeInfo.tier)
		
		-- Prepare the tooltip
		button.title = info.title
		button.description = covenantSanctumFeatureDescription[treeType][covenantID]
		button:Show()

		-- Loop through the list of talents (unordered !)
		local numTalents = 0
		for _, talent in pairs(info.talents) do
			talentCache[talent.tier + 1] = talent.id		-- tier goes from 0 to n, so + 1
			numTalents = numTalents + 1
		end
		
		while numTalents < 5 do
			numTalents = numTalents + 1
			talentCache[numTalents] = 0
		end
		
		-- Update the talent icon
		for i = 1, 5 do
			frame[format("Item%d", i)]:Update(talentCache[i], i, treeInfo.tier)
		end
		
		frame:Show()
	end,
})
