local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

addon:Controller("AltoholicUI.TabCharacters.GarrisonMissionRow", {
	SetName = function(frame, missionID, duration)
		frame.Name:SetText(format("%s%s |r(%s)", colors.white, C_Garrison.GetMissionName(missionID), SecondsToTime(duration)))
	end,
	SetType = function(frame, missionType)
		local icon = frame.MissionType.Icon

		if missionType then
			icon:Show()
			icon:SetAtlas(missionType)
		else
			icon:Hide()
		end
	end,
	SetLevel = function(frame, level, iLevel)
		local color = colors.white
		
		if iLevel ~= 0 then
			level = iLevel
			
			if iLevel >= 700 then
				color = colors.yellow
			elseif iLevel >= 645 then
				color = colors.epic
			elseif iLevel >= 630 then
				color = colors.rare
			elseif iLevel >= 615 then
				color = colors.green
			end
		end
		
		local count = frame.MissionType.Count
		
		count:SetText(format("%s%s", color, level))
		count:Show()
	end,
	SetCost = function(frame, cost)
		if cost and cost > 0 then
			frame.CostIcon:Show()
			frame.Cost:SetText(cost)
			frame.Cost:Show()
		else
			frame.CostIcon:Hide()
			frame.Cost:SetText("")
			frame.Cost:Hide()
		end
	end,
	SetSuccessChance = function(frame, successChance)
		if not successChance then
			frame.Success:Hide()
			return
		end
		
		local color
		if successChance >= 75 then
			color = colors.green
		elseif successChance >= 50 then
			color = colors.yellow
		else
			color = colors.red
		end
		frame.Success:SetText(format("%s%s%%", color, successChance))
		frame.Success:Show()
	end,
	SetRemainingTime = function(frame, remainingTime)
		if not remainingTime then
			frame.Remaining:Hide()
			return
		end
		
		if remainingTime == 0 then
			frame.Remaining:SetText(format("%s%s", colors.green, GARRISON_MISSION_COMPLETE))
		else
			frame.Remaining:SetText(SecondsToTime(remainingTime, true))
		end
		frame.Remaining:Show()
	end,
	SetFollowers = function(frame, followers, missionID, character)
		-- hide all icons
		for i = 1, 5 do
			frame[format("Follower%d", i)]:Hide()
		end

		-- 'followers' could be nil for the list of available missions
		-- nevertheless, we want to show empty portraits
		local numFollowers = C_Garrison.GetMissionMaxFollowers(missionID)
		
		for i = 1, numFollowers do
			local followerFrame = frame[format("Follower%d", i)]
			
			if followers then
				local followerID = followers[i]
			
				followerFrame:SetPortrait(followerID)
				followerFrame:SetInfo(character, followerID)
			else
				followerFrame:SetPortrait()
				followerFrame:SetInfo()
			end
			followerFrame:Show()
		end
	end,
	SetRewards = function(frame, rewards)
		frame.Reward1:Hide()
		frame.Reward2:Hide()
		
		local index = 2
		for id, reward in pairs(rewards) do
			local button = frame[format("Reward%d", index)]
			button:SetReward(reward)
			index = index - 1
		end
	end,
})
