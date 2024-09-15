local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors
local icons = AddonFactory.Icons

local MVC = LibStub("LibMVC-1.0")
local Dungeons = MVC:GetService("AltoholicUI.DungeonsLists")

local L = DataStore:GetLocale(addonName)

local tab = AltoholicFrame.TabGrids

local view
local isViewValid

local OPTION_XPACK = "Dungeons.CurrentXPack"
local OPTION_RAIDS = "Dungeons.CurrentRaids"

local function BuildView()
	view = view or {}
	wipe(view)
	
	local options = Altoholic_GridsTab_Options
	local currentXPack = options[OPTION_XPACK]
	local currentRaids = options[OPTION_RAIDS]

	for index, raidList in ipairs(Dungeons.GetRaids(currentXPack, currentRaids)) do
		table.insert(view, raidList)	-- insert the table pointer
	end
	
	isViewValid = true
end

tab:RegisterGrid(6, {
	InvalidateView = function()
		isViewValid = nil
	end,
	OnUpdate = function()
			if isViewValid then return end
			
			BuildView()

			local options = Altoholic_GridsTab_Options
			local currentXPack = options[OPTION_XPACK]
			local currentRaids = options[OPTION_RAIDS]
			
			tab:SetStatus(format("%s%s|r / %s%s|r / %s%s", 
				colors.white, LOOKING_FOR_DUNGEON, 
				colors.white, Dungeons.GetExpansionName(currentXPack), 
				colors.green, Dungeons.GetDifficultyName(currentXPack, currentRaids)))
		end,
	GetSize = function() return #view end,
	RowSetup = function(self, rowFrame, dataRowID)
			local dungeonID = view[dataRowID].id

			rowFrame.Name.Text:SetText(format("%s%s", colors.white, GetLFGDungeonInfo(dungeonID)))
			rowFrame.Name.Text:SetJustifyH("LEFT")
		end,
	ColumnSetup = function(self, button, dataRowID, character)
			local rowData = view[dataRowID]
	
			local _, _, _, _, _, _, _, _, _, achImage = GetAchievementInfo(rowData.achID)
			button.Background:SetTexture(achImage)
			button.Background:SetTexCoord(0, 1, 0, 1)
			button.Background:SetDesaturated(false)
			
			local dungeonID = rowData.id
			local count = DataStore:GetLFGDungeonKillCount(character, dungeonID)
			
			if count > 0 then 
				button.Background:SetVertexColor(1.0, 1.0, 1.0)
				button.key = character
				button:SetID(dungeonID)

				button.Name:SetJustifyH("CENTER")
				button.Name:SetPoint("BOTTOMRIGHT", 3, 2)
				button.Name:SetFontObject("NumberFontNormalLarge")

				if rowData.bosses then
					button.Name:SetText(format("%s%s/%s", colors.green, count, rowData.bosses))
				else
					button.Name:SetText(format("%s%s/%s", colors.green, count, GetLFGDungeonNumEncounters(rowData.id)))
				end
			else
				button.Background:SetVertexColor(0.3, 0.3, 0.3)		-- greyed out
				button.Name:SetJustifyH("CENTER")
				button.Name:SetPoint("BOTTOMRIGHT", 5, 0)
				button.Name:SetFontObject("GameFontNormalSmall")
				button.Name:SetText(icons.notReady)
				button:SetID(0)
				button.key = nil
			end
		end,
		
	OnEnter = function(frame) 
			local character = frame.key
			if not character then return end

			local dungeonID = frame:GetID()
			local dungeonName, _, _, _, _, _, _, _, _, _, _, difficulty = GetLFGDungeonInfo(dungeonID)
			local killCount = DataStore:GetLFGDungeonKillCount(character, dungeonID)
			local numEncounters = GetLFGDungeonNumEncounters(dungeonID)
			
			local tooltip = AddonFactory_Tooltip
			
			tooltip:SetOwner(frame, "ANCHOR_LEFT")
			tooltip:ClearLines()
			
			if numEncounters then
				tooltip:AddDoubleLine(DataStore:GetColoredCharacterName(character), format("%s%s/%s", colors.green, killCount, numEncounters))
			else
				tooltip:AddLine(DataStore:GetColoredCharacterName(character),1,1,1)
			end
			tooltip:AddLine(dungeonName,1,1,1)
			tooltip:AddLine(GetDifficultyInfo(difficulty),1,1,1)
			
			tooltip:AddLine(" ",1,1,1)
			
			local color
			for i = 1, GetLFGDungeonNumEncounters(dungeonID) do
				local bossName = GetLFGDungeonEncounterInfo(dungeonID, i)

				if DataStore:IsBossAlreadyLooted(character, dungeonID, bossName) then
					tooltip:AddDoubleLine(bossName, format("%s%s", colors.red, BOSS_DEAD))
				else
					tooltip:AddDoubleLine(bossName, format("%s%s", colors.green, BOSS_ALIVE))
				end
			end
			
			tooltip:Show()
			
		end,
	OnLeave = function(self)
			AddonFactory_Tooltip:Hide() 
		end,
})
