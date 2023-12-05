local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local currentCovenantID

addon:Controller("AltoholicUI.TabCharacters.SoulbindsPanel", {
	OnBind = function(frame)
		local parent = AltoholicFrame.TabCharacters
		
		frame:SetParent(parent)
		frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
		frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
		parent:RegisterPanel("Soulbinds", frame)
		
		-- Handle resize
		frame:SetScript("OnSizeChanged", function(self, width, height)
			if not frame:IsVisible() then return end
		
			frame:Update(true)
		end)
	end,
	Update = function(frame, isResizing)
		frame:Hide()
		
		local parent = frame:GetParent()
		local character = parent:GetCharacter()
		if not character then return end
		
		if not isResizing then
			parent:SetStatus(format("%s|r / %s%s|r", DataStore:GetColoredCharacterName(character), colors.white, COVENANT_PREVIEW_SOULBINDS))
		end
		
		local covenantID, _, renownLevel =  DataStore:GetCovenantInfo(character)
		if covenantID == 0 then return end		-- 0 if no covenant has been chosen yet

		currentCovenantID = covenantID
		
		local activeSoulbindID = DataStore:GetActiveSoulbindID(character)
		local covenantData = C_Covenants.GetCovenantData(covenantID)
		
		-- Loop on the soulbinds of this covenant
		local i = 1
		for _, soulbindID in pairs(covenantData.soulbindIDs) do
			frame[format("Spec%d", i)]:Update(character, C_Soulbinds.GetSoulbindData(soulbindID), (activeSoulbindID == soulbindID))
			i = i + 1
		end		
		
		frame:Show()
	end,
})
