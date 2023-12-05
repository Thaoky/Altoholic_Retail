local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.TabCharacters.GarrisonMissionFollower", {
	SetPortrait = function(frame, id)
		local icon = frame.Portrait
		local texture
		
		if id then 
			local iconFileID = C_Garrison.GetFollowerPortraitIconIDByID(id)

			if iconFileID and iconFileID ~= 0 then
				texture = iconFileID
			end
		end
		
		if texture then						-- if a valid texture could be found ..
			icon:SetTexture(texture)		-- .. set it and show the portrait
			icon:Show()
		else
			icon:Hide()							-- .. otherwise hide it
		end
	end,
	SetInfo = function(frame, character, followerID)
		frame.key = character
		frame.followerID = followerID
	end,
})
