local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.TabCharacters.GarrisonMissionsPanel", function()

	local colors = addon.Colors
	local L = DataStore:GetLocale(addonName)
	
	local view = {}

	local modes = {
		[1] = {	-- available missions
			GetName = function() return GARRISON_LANDING_AVAILABLE end,
			GetMissions = function(c) return DataStore:GetAvailableMissions(c, Enum.GarrisonFollowerType.FollowerType_6_0_GarrisonFollower) end,
			GetNumMissions = function(c) return DataStore:GetNumAvailableMissions(c, Enum.GarrisonFollowerType.FollowerType_6_0_GarrisonFollower) end,
		},
		[2] = {	-- active missions
			GetName = function() return GARRISON_LANDING_IN_PROGRESS end,
			GetMissions = function(c) return DataStore:GetActiveMissions(c, Enum.GarrisonFollowerType.FollowerType_6_0_GarrisonFollower) end,
			GetNumMissions = function(c) return DataStore:GetNumActiveMissions(c, Enum.GarrisonFollowerType.FollowerType_6_0_GarrisonFollower) end,
		},
		[3] = {	-- available missions
			GetName = function() return GARRISON_LANDING_AVAILABLE end,
			GetMissions = function(c) return DataStore:GetAvailableMissions(c, Enum.GarrisonFollowerType.FollowerType_7_0_GarrisonFollower) end,
			GetNumMissions = function(c) return DataStore:GetNumAvailableMissions(c, Enum.GarrisonFollowerType.FollowerType_7_0_GarrisonFollower) end,
		},
		[4] = {	-- active missions
			GetName = function() return GARRISON_LANDING_IN_PROGRESS end,
			GetMissions = function(c) return DataStore:GetActiveMissions(c, Enum.GarrisonFollowerType.FollowerType_7_0_GarrisonFollower) end,
			GetNumMissions = function(c) return DataStore:GetNumActiveMissions(c, Enum.GarrisonFollowerType.FollowerType_7_0_GarrisonFollower) end,
		},
		[5] = {	-- available missions
			GetName = function() return GARRISON_LANDING_AVAILABLE end,
			GetMissions = function(c) return DataStore:GetAvailableMissions(c, Enum.GarrisonFollowerType.FollowerType_8_0_GarrisonFollower) end,
			GetNumMissions = function(c) return DataStore:GetNumAvailableMissions(c, Enum.GarrisonFollowerType.FollowerType_8_0_GarrisonFollower) end,
		},
		[6] = {	-- active missions
			GetName = function() return GARRISON_LANDING_IN_PROGRESS end,
			GetMissions = function(c) return DataStore:GetActiveMissions(c, Enum.GarrisonFollowerType.FollowerType_8_0_GarrisonFollower) end,
			GetNumMissions = function(c) return DataStore:GetNumActiveMissions(c, Enum.GarrisonFollowerType.FollowerType_8_0_GarrisonFollower) end,
		},
		[7] = {	-- available missions
			GetName = function() return GARRISON_LANDING_AVAILABLE end,
			GetMissions = function(c) return DataStore:GetAvailableMissions(c, Enum.GarrisonFollowerType.FollowerType_9_0_GarrisonFollower) end,
			GetNumMissions = function(c) return DataStore:GetNumAvailableMissions(c, Enum.GarrisonFollowerType.FollowerType_9_0_GarrisonFollower) end,
		},
		[8] = {	-- active missions
			GetName = function() return GARRISON_LANDING_IN_PROGRESS end,
			GetMissions = function(c) return DataStore:GetActiveMissions(c, Enum.GarrisonFollowerType.FollowerType_9_0_GarrisonFollower) end,
			GetNumMissions = function(c) return DataStore:GetNumActiveMissions(c, Enum.GarrisonFollowerType.FollowerType_9_0_GarrisonFollower) end,
		},
	}

	local function BuildView(character)
		wipe(view)

		local mode = Altoholic_CharactersTab_Options["GarrisonMissions"]

		local api = modes[mode]
		local missions = api.GetMissions(character)
		if not missions then return end
		
		for _, id in pairs(missions) do
			table.insert(view, id)
		end
		
		-- for active missions only
		if mode %2 == 0 then
			table.sort(view, function(a,b) 
					local remainingA = select(2, DataStore:GetActiveMissionInfo(character, a)) or 0
					local remainingB = select(2, DataStore:GetActiveMissionInfo(character, b)) or 0
					
					return remainingA < remainingB
				end)
		end
	end

	return {
		OnBind = function(frame)
			local parent = AltoholicFrame.TabCharacters
			
			frame:SetParent(parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel("GarrisonMissions", frame)		
		
			local function OnGarrisonMissionListUpdate()
				if frame:IsVisible() then
					frame:Update()
				end
			end
		
			addon:ListenTo("GARRISON_MISSION_LIST_UPDATE", OnGarrisonMissionListUpdate)
			
			-- Handle resize
			frame:SetScript("OnSizeChanged", function(self, width, height)
				if not frame:IsVisible() then return end
			
				frame:Update(true)
			end)
		end,
		Update = function(frame, isResizing)
			local parent = frame:GetParent()
			local character = parent:GetCharacter()
			if not character then return end
			
			if not isResizing then
				local mode = Altoholic_CharactersTab_Options["GarrisonMissions"]
				local api = modes[mode]
			
				-- Set the tab status
				parent:SetStatus(format("%s|r / %s%s|r", DataStore:GetColoredCharacterName(character),
					colors.white, format(api.GetName(), api.GetNumMissions(character))))

				BuildView(character)
			end

			local scrollFrame = frame.ScrollFrame
			local numRows = scrollFrame.numRows
			local offset = scrollFrame:GetOffset()
			
			local maxDisplayedRows = math.floor(scrollFrame:GetHeight() / scrollFrame.rowHeight)
			
			for rowIndex = 1, numRows do
				local rowFrame = scrollFrame:GetRow(rowIndex)
				local line = rowIndex + offset
			
				if line <= #view and (rowIndex <= maxDisplayedRows) then	-- if the line is visible
					if not (isResizing and rowFrame:IsVisible()) then
						local missionID = view[line]
						local followers, remainingTime, successChance = DataStore:GetActiveMissionInfo(character, missionID)
						
						rowFrame:SetName(missionID, DataStore:GetMissionDuration(missionID))
						rowFrame:SetType(DataStore:GetMissionAtlas(missionID))
						rowFrame:SetLevel(DataStore:GetMissionLevel(missionID))
						rowFrame:SetRemainingTime(remainingTime)
						rowFrame:SetSuccessChance(successChance)
						rowFrame:SetCost(DataStore:GetMissionCost(missionID))
						rowFrame:SetFollowers(followers, missionID, character)
						rowFrame:SetRewards(DataStore:GetMissionRewards(missionID))
					end
					rowFrame:Show()
				else
					rowFrame:Hide()
				end
			end
			
			scrollFrame:Update(#view, maxDisplayedRows)
			frame:Show()
		end,
}end)
