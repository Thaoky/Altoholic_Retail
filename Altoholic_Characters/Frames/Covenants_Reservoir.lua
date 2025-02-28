local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

local L = AddonFactory:GetLocale(addonName)

local currentCovenantID

addon:Controller("AltoholicUI.TabCharacters.ReservoirPanel", {
	__Parent = AltoholicFrame.TabCharacters,

	OnBind = function(frame, parent)
		frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
		frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
		parent:RegisterPanel("Reservoir", frame)
		
		-- Handle resize
		-- frame:SetScript("OnSizeChanged", function(self, width, height)
			-- if not frame:IsVisible() then return end
		
			-- frame:Update(true)
		-- end)
	end,
	
	Update = function(frame, isResizing)
		frame:Hide()
		
		local parent = frame:GetParent()
		local character = parent:GetCharacter()
		if not character then return end
		
		parent:SetStatus(format("%s|r / %s%s|r", DataStore:GetColoredCharacterName(character), colors.white, COVENANT_SANCTUM_TAB_UPGRADES))
		
		local covenantID, _, renownLevel =  DataStore:GetCovenantInfo(character)
		if covenantID == 0 then return end		-- 0 if no covenant has been chosen yet

		currentCovenantID = covenantID
		
		frame.TravelUpgrade:Update(character, covenantID, Enum.GarrTalentFeatureType.TravelPortals)
		frame.DiversionUpgrade:Update(character, covenantID, Enum.GarrTalentFeatureType.AnimaDiversion)
		frame.AdventureUpgrade:Update(character, covenantID, Enum.GarrTalentFeatureType.Adventures)
		frame.UniqueUpgrade:Update(character, covenantID, Enum.GarrTalentFeatureType.SanctumUnique)
	
		frame:Show()
	end,
})
