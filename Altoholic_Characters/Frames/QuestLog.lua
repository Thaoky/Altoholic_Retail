local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.TabCharacters.QuestLog", function()
	
	local colors = AddonFactory.Colors

	local function GetStatus(character, category, numQuests)
		local allCategories = (category == 0)
		
		local text = ""
		
		if allCategories then
			text = format("%s%s|r / %s%s", colors.white, QUEST_LOG, colors.white, ALL)
		else
			local headers = DataStore:GetQuestHeaders(character)
			text = format("%s%s|r / %s%s", colors.white, QUEST_LOG, colors.white, headers[category])
		end

		return format("%s|r / %s (%s%d|r)|r", 
			DataStore:GetColoredCharacterName(character), 
			text, 
			colors.green, numQuests)
	end

	return {
		OnBind = function(frame)
			local parent = AltoholicFrame.TabCharacters
			
			frame:SetParent(parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel("QuestLog", frame)
			
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
		
			local currentCategoryID = Altoholic_CharactersTab_Options["ViewQuestLogCategory"]
			
			-- Get the quest list
			local questList = {}
			
			DataStore:IterateQuests(character, currentCategoryID, function(questIndex) 
				table.insert(questList, questIndex)
			end)
		
			-- Set the tab status
			parent:SetStatus(GetStatus(character, currentCategoryID, #questList))
			
			-- Update the scrollframe
			local scrollFrame = frame.ScrollFrame
			local numRows = scrollFrame.numRows
			local offset = scrollFrame:GetOffset()
			
			local maxDisplayedRows = math.floor(scrollFrame:GetHeight() / scrollFrame.rowHeight)
			
			for rowIndex = 1, numRows do
				local rowFrame = scrollFrame:GetRow(rowIndex)
				local line = rowIndex + offset
				
				if line <= #questList and (rowIndex <= maxDisplayedRows)then	-- if the line is visible
					if not (isResizing and rowFrame:IsVisible()) then
						local lineID = questList[line]
						rowFrame:SetID(lineID)

						local questID = DataStore:GetQuestLogID(character, lineID)
						
						rowFrame:SetName(DataStore:GetQuestName(questID), DataStore:GetQuestLevel(questID))
						rowFrame:SetType(DataStore:GetQuestLogTag(character, lineID))
						rowFrame:SetRewards(character)
						rowFrame:SetInfo(
							DataStore:IsQuestCompleted(character, lineID), 
							DataStore:IsQuestDaily(questID), 
							DataStore:GetQuestGroupSize(questID), 
							DataStore:GetQuestLogMoney(character, lineID))
					end
					rowFrame:Show()
				else
					rowFrame:Hide()
				end
			end

			scrollFrame:Update(#questList, maxDisplayedRows)
			frame:Show()
		end,
}end)
