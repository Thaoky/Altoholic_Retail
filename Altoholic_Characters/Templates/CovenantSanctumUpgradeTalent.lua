local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.TabCharacters.CovenantSanctumUpgradeTalent", {
	Update = function(frame, talentID, tier, learnedTier)
		if not talentID then return end
		
		if talentID == 0 then 
			frame:Hide()
			return
		end
		
		local info = C_Garrison.GetTalentInfo(talentID)
		local nameColor = HIGHLIGHT_FONT_COLOR
		
		if tier <= learnedTier then
			frame.Icon:SetDesaturated(false)
		else
			nameColor = DISABLED_FONT_COLOR
			frame.Icon:SetDesaturated(true)
		end
		
		frame.Name:SetTextColor(nameColor:GetRGB())
		frame.Name:SetText(info.name)
		frame.Icon:SetTexture(info.icon)
		
		-- Prepare the tooltip
		frame.name = info.name
		frame.description = info.description
		frame.costString = GetGarrisonTalentCostString(info)
				
		frame:Show()
	end,
})