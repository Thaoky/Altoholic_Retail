local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.TalentRow", {
	Update = function(frame, character, class, specializationIndex)
		local tierID = frame:GetID()
		local choice = DataStore:GetSpecializationTierChoice(character, specializationIndex, tierID)
		
		for column = 1, 3 do
			local button = frame["Talent" .. column]
			
			local talentID, _, icon = DataStore:GetTalentInfo(class, specializationIndex, tierID, column)
			button.talentID = talentID
			
			-- if for some reason the correct talent information is not returned, hide the button..
			if icon then
				button:SetIcon(icon)
				
				if column == choice then
					button:EnableIcon()
					button.Border:Show()
				else
					button:DisableIcon()
					button.Border:Hide()
				end
			
				button:Show()
			else
				button:Hide()
			end
		end
		frame:Show()
	end,
})
