local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

addon:Controller("AltoholicUI.AchievementRow", { "AltoholicUI.Options", function(Options)

	local NUM_COLUMNS = 13
	local accountWideColor = "|cFF26C6E2"

	return {
		Update = function(frame, account, realm, page, allianceID, hordeID)
			local _, achName, _, isComplete, _, _, _, _, flags = GetAchievementInfo(allianceID)
			
			-- if not achName then 
				-- DEFAULT_CHAT_FRAME:AddMessage(allianceID)
				-- achName = allianceID
			-- end
			
			local isAccountBound = ( bit.band(flags, ACHIEVEMENT_FLAGS_ACCOUNT) == ACHIEVEMENT_FLAGS_ACCOUNT ) 
			
			-- frame.Name.Text:SetText(format("%s%s", (isAccountBound and colors.cyan or colors.white), achName))
			frame.Name.Text:SetText(format("%s%s", (isAccountBound and accountWideColor or colors.white), achName))
			frame.Name.Text:SetJustifyH("LEFT")
			frame.id = allianceID
			
			local button
			local character
			local achievementID
			
			for colIndex = 1, NUM_COLUMNS do
				button = frame[format("Item%d", colIndex)]
				button.IconBorder:Hide()
				
				local optionIndex = ((page - 1) * NUM_COLUMNS) + colIndex		-- Pages = 1-12, 13-24, etc..
				
				character = Options.Get(format("Tabs.Achievements.%s.%s.Column%d", account, realm, optionIndex))
				if character then
					if hordeID and DataStore:GetCharacterFaction(character) ~= "Alliance" then
						achievementID = hordeID
					else
						achievementID = allianceID
					end
					
					button:SetImage(achievementID)
					button:SetCompletionStatus(character, achievementID, isAccountBound)
					
					-- do not remove this one, the button achievement ID could be different than that of the row
					-- row could be alliance, and button could be horde
					button:SetInfo(character, achievementID)
					button:Show()
				else
					button:SetInfo(nil, nil)
					button:Hide()
				end
			end
			frame:Show()
		end,
		Name_OnEnter = function(frame)
			local achievementID = frame.id
			local _, achName, points, _, _, _, _, description, flags, image, rewardText = GetAchievementInfo(achievementID)

			local tooltip = AddonFactory_Tooltip
			tooltip:ClearLines()
			tooltip:SetOwner(frame.Name, "ANCHOR_TOP")
			tooltip:AddLine(achName)
			tooltip:AddLine(description, 1, 1, 1, 1, 1)
			tooltip:AddLine(" ")
			tooltip:AddLine(format("%s%s: %s%s", colors.white, ACHIEVEMENT_TITLE, colors.green, points))

			-- Add the reward text, if any
			if strlen(rewardText) > 0 then		-- not nil if empty, so test the length of the string
				tooltip:AddLine(" ")
				tooltip:AddLine(format("%s%s", colors.green, rewardText))
			end
			tooltip:AddLine(" ")

			-- Add the achievement ID and whether or not it is account wide
			local isAccountBound = ( bit.band(flags, ACHIEVEMENT_FLAGS_ACCOUNT) == ACHIEVEMENT_FLAGS_ACCOUNT ) 
			local idText = format("ID: %s%d", colors.green , achievementID)
			local accountWideText = format("%s%s", colors.cyan, L["ACCOUNT_WIDE"])
			
			if isAccountBound then
				tooltip:AddDoubleLine(idText, accountWideText)
			else
				tooltip:AddLine(idText)
			end
			tooltip:Show()
		end,
	}
end})
