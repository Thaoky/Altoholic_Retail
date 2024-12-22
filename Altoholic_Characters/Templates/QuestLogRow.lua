local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

local L = AddonFactory:GetLocale(addonName)

-- Quest Tags Copied from 10.0.7 Constants.lua as they are REMOVED from the game --TechnoHunter
--QUEST_ICONS_FILE = "Interface\\QuestFrame\\QuestTypeIcons";
--QUEST_ICONS_FILE_WIDTH = 128;
--QUEST_ICONS_FILE_HEIGHT = 64;

local QUEST_TAG_TCOORDS = {
	["COMPLETED"] = { 0.140625, 0.28125, 0, 0.28125 },
	["DAILY"] = { 0.28125, 0.421875, 0, 0.28125 },
	["WEEKLY"] = { 0.28125, 0.421875, 0.5625, 0.84375 },
	["FAILED"] = { 0.84375, 0.984375, 0.28125, 0.5625 },
	["STORY"] = { 0.703125, 0.84375, 0.28125, 0.5625 },
	["ALLIANCE"] = { 0.421875, 0.5625, 0.28125, 0.5625 },
	["HORDE"] = { 0.5625, 0.703125, 0.28125, 0.5625 },
	["EXPIRING_SOON"] = { 0.84375, 0.984375, 0.5625, 0.84375 },
	["EXPIRING"] = { 0.703125, 0.84375, 0.5625, 0.84375 },
	
	[Enum.QuestTag.Dungeon] = { 0.421875, 0.5625, 0, 0.28125 },
	[Enum.QuestTag.Scenario] = { 0.5625, 0.703125, 0, 0.28125 },
	[Enum.QuestTag.Account] = { 0.84375, 0.984375, 0, 0.28125 },
	[Enum.QuestTag.Legendary] = { 0, 0.140625, 0.28125, 0.5625 },
	[Enum.QuestTag.Group] = { 0.140625, 0.28125, 0.28125, 0.5625 },
	[Enum.QuestTag.PvP] = { 0.28125, 0.421875, 0.28125, 0.5625 },
	[Enum.QuestTag.Heroic] = { 0, 0.140625, 0.5625, 0.84375 },
	
	-- same texture for all raids
	[Enum.QuestTag.Raid] = { 0.703125, 0.84375, 0, 0.28125 },
	[Enum.QuestTag.Raid10] = { 0.703125, 0.84375, 0, 0.28125 },
	[Enum.QuestTag.Raid25] = { 0.703125, 0.84375, 0, 0.28125 },
}

local WORLD_QUEST_TYPE_TCOORDS = {
	[Enum.QuestTagType.Dungeon] = { 0.421875, 0.5625, 0, 0.28125 },
	[Enum.QuestTagType.Raid] = { 0.703125, 0.84375, 0, 0.28125 },
}

addon:Controller("AltoholicUI.TabCharacters.QuestLogRow", { "AltoholicUI.Formatter", function(Formatter)
	return {
		SetName = function(frame, name, level)
			frame.Name.Text:SetText(format("%s[%s%d%s] %s%s", colors.white, colors.cyan, level, colors.white, colors.gold, name))
		end,
		SetInfo = function(frame, isComplete, isDaily, groupSize, money)
			local infos = AddonFactory:GetTable()
		
			local moneyText = ""
			if money and money > 0 then
				moneyText = Formatter.MoneyString(money or 0, colors.white)
			end
			
			if moneyText ~= "" then table.insert(infos, moneyText) end
			if isComplete then table.insert(infos, format("%s%s", colors.green, COMPLETE)) end
			if isDaily then table.insert(infos, format("%s%s", colors.cyan, DAILY)) end
			if (groupSize > 1) then table.insert(infos, format(GROUP_NUMBER, groupSize)) end
		
			frame.Info:SetText(table.concat(infos,	" / "))
			AddonFactory:ReleaseTable(infos)
		end,
		SetType = function(frame, tagID)
			local icon = frame.QuestType.Icon
			
			-- Use the known in-game icons, if proper coords exists
			--local tagCoords = QUEST_TAG_ATLAS[tagID] -- future proofing --TechnoHunter																										 
			local tagCoords = QUEST_TAG_TCOORDS[tagID]
			if tagCoords then
				icon:SetTexture("Interface\\QuestFrame\\QuestTypeIcons")
				icon:SetTexCoord(unpack(tagCoords))
			else
				icon:SetTexture("Interface\\LFGFrame\\LFGIcon-Quest")
				icon:SetTexCoord(0, 1, 0, 1)
			end
			icon:Show()
		end,
		SetRewards = function(frame, character)
			frame.Reward1:Hide()
			frame.Reward2:Hide()
			
			local id = frame:GetID()
			if id == 0 then return end

			local numRewards = DataStore:GetQuestLogNumRewards(character, id)
			
			local index = 2	-- simply to justify rewards to the right
			for rewardIndex = 1, numRewards do
				local rewardType, id, numItems = DataStore:GetQuestLogRewardInfo(character, id, rewardIndex)
				
				if rewardType == "r" then
					local button = frame["Reward" ..index]
					button:SetReward({ itemID = id, quantity = numItems })
					index = index - 1
				end
			end
		end,

		Name_OnEnter = function(frame)
			local id = frame:GetID()
			if id == 0 then return end

			local character = frame:GetParent():GetParent():GetCharacter()
			local questID = DataStore:GetQuestLogID(character, id)
			local questName = DataStore:GetQuestName(questID)
			local level = DataStore:GetQuestLevel(questID)
			local link = DataStore:GetQuestLogLink(character, id)
			if not link then return end
			
			GameTooltip:ClearLines()
			GameTooltip:SetOwner(frame.Name, "ANCHOR_LEFT")
			GameTooltip:SetHyperlink(link)
			GameTooltip:AddLine(" ",1,1,1)
			
			GameTooltip:AddDoubleLine(format("%s: %s%d", LEVEL, colors.teal, level), format("%s: %s%d", L["QuestID"], colors.teal, questID))
			
			-- local player = addon.Tabs.Characters:GetAlt()
			-- addon:ListCharsOnQuest(questName, player, GameTooltip)
			GameTooltip:Show()
		end,
		Name_OnClick = function(frame, button)
			if button ~= "LeftButton" or not IsShiftKeyDown() then return end

			local chat = ChatEdit_GetLastActiveWindow()
			if not chat:IsShown() then return end
			
			local id = frame:GetID()
			if id == 0 then return end
			
			local character = frame:GetParent():GetParent():GetCharacter()
			local link = DataStore:GetQuestLogLink(character, id)
			if link then
				chat:Insert(link)
			end
		end,
	}
end})
