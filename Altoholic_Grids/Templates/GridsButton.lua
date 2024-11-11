local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors
local icons = AddonFactory.Icons

local L = DataStore:GetLocale(addonName)

addon:Controller("AltoholicUI.GridsButton", { "AltoholicUI.Formatter", function(formatter)
	return {
		Button_OnEnter = function(frame)
			local character = frame.key
			if not character then return end
			
			-- local achievementID = frame.id
			-- local _, achName, points, _, _, _, _, description, flags, image, rewardText = GetAchievementInfo(achievementID)

		-- debug
			-- DEFAULT_CHAT_FRAME:AddMessage("id: " .. achievementID .. " name: " .. achName .. " icon: " .. image)
			
	
		end,
		-- SetImage = function(frame, achievementID)
			-- local _, _, _, _, _, _, _, _, _, achImage = GetAchievementInfo(achievementID)
			-- frame.Background:SetTexture(achImage)
		-- end,

		-- SetInfo = function(frame, character, achievementID)
			-- frame.key = character
			-- frame.id = achievementID
		-- end,
	}
end})
