local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors
local icons = addon.Icons

local MVC = LibStub("LibMVC-1.0")

local tab = AltoholicFrame.TabGrids

local currentRace
local currentItemID

-- Just in case
-- https://wowpedia.fandom.com/wiki/Archaeology#Race_descriptions

tab:RegisterGrid(8, {
	OnUpdate = function()
			local options = Altoholic_GridsTab_Options
			currentRace = options["Archaeology.CurrentRace"] 
		end,
	GetSize = function() return DataStore:GetRaceNumArtifacts(currentRace) end,
	RowSetup = function(self, rowFrame, dataRowID)
			local artifact = DataStore:GetArtifactInfo(currentRace, dataRowID)
			currentItemID = artifact.itemID
			
			if currentItemID then
				local _, _, _, hexColor = GetItemQualityColor(artifact.rarity)
				local itemName = C_Spell.GetSpellName(artifact.spellID)
				
				rowFrame.Name.Text:SetText(format("|c%s%s", hexColor, itemName))
				rowFrame.Name.Text:SetJustifyH("LEFT")
			end
		end,
	ColumnSetup = function(self, button, dataRowID, character)
			button.Name:SetFontObject("GameFontNormalSmall")
			button.Name:SetJustifyH("CENTER")
			button.Name:SetPoint("BOTTOMRIGHT", 5, 0)
			button.Background:SetDesaturated(false)
			button.Background:SetTexCoord(0, 1, 0, 1)
			button.Background:SetTexture(GetItemIcon(currentItemID))
			
			local artifact = DataStore:GetArtifactInfo(currentRace, dataRowID)
			if DataStore:IsArtifactKnown(character, artifact.spellID) then
				button.Background:SetVertexColor(1.0, 1.0, 1.0)
				button.Name:SetText(icons.ready)
				
				local _, _, itemRarity, itemLevel = GetItemInfo(currentItemID)
				if itemRarity and itemRarity >= 2 then
					local r, g, b = GetItemQualityColor(itemRarity)
					button.IconBorder:SetVertexColor(r, g, b, 0.5)
					button.IconBorder:Show()
				end
			else
				button.Background:SetVertexColor(0.4, 0.4, 0.4)
				button.Name:SetText(icons.notReady)
			end
			button.id = currentItemID
		end,
	OnEnter = function(self) 
			self.link = nil
			addon:Item_OnEnter(self) 
		end,
	OnClick = function(self, button)
			self.link = nil
			addon:Item_OnClick(self, button)
		end,
	OnLeave = function(self)
			GameTooltip:Hide() 
		end,
})
