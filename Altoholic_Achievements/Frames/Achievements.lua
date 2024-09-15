local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

addon:Controller("AltoholicUI.TabAchievements.Achievements", { "AltoholicUI.AchievementsLists", function(Lists)

	local currentCategoryID

	return {
		OnBind = function(frame)
			local parent = AltoholicFrame.TabAchievements
			
			frame:SetParent(parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel("Achievements", frame)
			
			-- Handle resize
			frame:SetScript("OnSizeChanged", function(self, width, height)
				if not frame:IsVisible() then return end
			
				frame:Update(true)
			end)
			
			Lists.Initialize()
		end,
	
		SetCategory = function(frame, categoryID)
			-- for debug only
			-- print(categoryID)
			currentCategoryID = categoryID
		end,
		Update = function(frame, isResizing)

			local scrollFrame = frame.ScrollFrame
			local numRows = scrollFrame.numRows
			local offset = scrollFrame:GetOffset()
			
			local maxDisplayedRows = math.floor(scrollFrame:GetHeight() / 38)
			-- print(format("frame height: %d, width: %d", frame:GetHeight(), frame:GetWidth()))
			
			local parent = frame:GetParent()
			local categorySize = Lists.GetCategorySize(currentCategoryID)
			local realm, account = parent:GetRealm()
			local page = parent:GetPage()
			
			if not isResizing then
				parent:SetStatus(format("%s%s: %s%s", colors.white, ACHIEVEMENTS, colors.green, categorySize ))
			end
			
			for rowIndex = 1, numRows do
				local rowFrame = scrollFrame:GetRow(rowIndex)
				local line = rowIndex + offset
				
				if line <= categorySize and (rowIndex <= maxDisplayedRows) then	-- if the line is visible
					if not isResizing then
						local allianceID, hordeID = Lists.GetAchievementFactionInfo(currentCategoryID, line)
						
						-- allianceID may not be nil, if it is, it means the achievement is no longer in-game
						-- print(allianceID)
						rowFrame:Update(account, realm, page, allianceID, hordeID)
					end
					rowFrame:Show()
				else
					rowFrame:Hide()
				end
			end

			-- categorySize = number of items in the list
			-- maxDisplayedRows = number of items that will actually be displayed
			scrollFrame:Update(categorySize, maxDisplayedRows)
			frame:Show()
			
			frame.lastMaxDisplayedRows = maxDisplayedRows
		end,
		
		CheckForResize = function(frame)
			-- Check if a resize happened while viewing another tab
			
			if not frame.lastMaxDisplayedRows then return end
			
			local maxDisplayedRows = math.floor(frame.ScrollFrame:GetHeight() / 38)
			
			-- it the last number of rows we displayed is not identical to the current frame size.. we need to refresh
			if (maxDisplayedRows ~= frame.lastMaxDisplayedRows) then
				frame:Update()
			end
		end,
	}
end})
