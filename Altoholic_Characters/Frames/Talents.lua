local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

addon:Controller("AltoholicUI.TabCharacters.Talents", {
	OnBind = function(frame)
		local parent = AltoholicFrame.TabCharacters
		
		frame:SetParent(parent)
		frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
		frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
		parent:RegisterPanel("Talents", frame)
	
		local function OnPlayerTalentUpdate()
			if frame:IsVisible() then
				frame:Update()
			end
		end	

		addon:ListenTo("PLAYER_TALENT_UPDATE", OnPlayerTalentUpdate)
		addon:ListenTo("PLAYER_SPECIALIZATION_CHANGED", OnPlayerTalentUpdate)
	end,
	Update = function(frame)
		frame:Hide()
		
		local parent = frame:GetParent()
		local character = parent:GetCharacter()
		if not character then return end
		
		parent:SetStatus(format("%s|r / %s%s|r", DataStore:GetColoredCharacterName(character), colors.white, TALENTS))
		
		local _, currentClass = DataStore:GetCharacterClass(character)
		if not DataStore:IsClassKnown(currentClass) then return end
		
		local level = DataStore:GetCharacterLevel(character)
		if not level or level < 10 then return end

		if currentClass == "DRUID" then
			for i = 1, 4 do
				frame.Specs[i]:SetWidth(150)
				frame.Specs[i]:Update(character, currentClass, i)
			end
		elseif currentClass == "DEMONHUNTER" then
			for i = 1, 2 do
				frame.Specs[i]:SetWidth(300)
				frame.Specs[i]:Update(character, currentClass, i)
			end
			frame.Spec3:Hide()
			frame.Spec4:Hide()
		else
			for i = 1, 3 do
				frame.Specs[i]:SetWidth(210)
				frame.Specs[i]:Update(character, currentClass, i)
			end
			frame.Spec4:Hide()
		end
		
		frame:Show()
	end,
})
