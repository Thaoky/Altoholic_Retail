local addonName = "Altoholic"
local addon = _G[addonName]

local BORDER_TEXTURE = "CovenantSanctum-Icon-Border-%s"

-- Source : Blizzard_CovenantSanctum/Blizzard_CovenantSanctumUpgrades.lua
local features = Enum.GarrTalentFeatureType
local covenants = Enum.CovenantType

local covenantSanctumFeatureDescription = {
	[features.AnimaDiversion] = {
		[covenants.Venthyr] = COVENANT_SANCTUM_FEATURE_ANIMACONDUCTOR_VENTHYR,
		[covenants.Kyrian] = COVENANT_SANCTUM_FEATURE_ANIMACONDUCTOR_KYRIAN,
		[covenants.NightFae] = COVENANT_SANCTUM_FEATURE_ANIMACONDUCTOR_NIGHTFAE,
		[covenants.Necrolord] = COVENANT_SANCTUM_FEATURE_ANIMACONDUCTOR_NECROLORD,
	},
	[features.TravelPortals] = {
		[covenants.Venthyr] = COVENANT_SANCTUM_FEATURE_TRAVELNETWORK_VENTHYR,
		[covenants.Kyrian] = COVENANT_SANCTUM_FEATURE_TRAVELNETWORK_KYRIAN,
		[covenants.NightFae] = COVENANT_SANCTUM_FEATURE_TRAVELNETWORK_NIGHTFAE,
		[covenants.Necrolord] = COVENANT_SANCTUM_FEATURE_TRAVELNETWORK_NECROLORD,
	},
	[features.Adventures] = {
		[covenants.Venthyr] = COVENANT_SANCTUM_FEATURE_ADVENTURES_VENTHYR,
		[covenants.Kyrian] = COVENANT_SANCTUM_FEATURE_ADVENTURES_KYRIAN,
		[covenants.NightFae] = COVENANT_SANCTUM_FEATURE_ADVENTURES_NIGHTFAE,
		[covenants.Necrolord] = COVENANT_SANCTUM_FEATURE_ADVENTURES_NECROLORD,
	},
	[features.SanctumUnique] = {
		[covenants.Venthyr] = COVENANT_SANCTUM_UNIQUE_VENTHYR,
		[covenants.Kyrian] = COVENANT_SANCTUM_UNIQUE_KYRIAN,
		[covenants.NightFae] = COVENANT_SANCTUM_UNIQUE_NIGHTFAE,
		[covenants.Necrolord] = COVENANT_SANCTUM_UNIQUE_NECROLORD,
	},
}

local talentCache = { 0, 0, 0, 0, 0 }	-- make room for 5 talents

addon:Controller("AltoholicUI.TabCharacters.CovenantSanctumUpgradeTree", {
	Update = function(frame, character, covenantID, treeType)
		
		-- Get a valid tree ID
		local tier, treeID = DataStore:GetReservoirTalentTreeInfo(character, treeType)
		
		-- Exit if there is nothing to show
		if treeID == 0 then 
			frame:Hide()
			return 
		end

		local info = C_Garrison.GetTalentTreeInfo(treeID)
		local textureKit = C_Covenants.GetCovenantData(covenantID).textureKit
		
		-- Set the upgrade type icon & border
		local button = frame.IconButton
		
		button.Icon:SetTexture(info.talents[1].icon)
		button.Border:SetAtlas(format(BORDER_TEXTURE, textureKit, true))
		button.Tier:SetText(tier)
		
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
			frame[format("Item%d", i)]:Update(talentCache[i], i, tier)
		end
		
		frame:Show()
	end,
})
