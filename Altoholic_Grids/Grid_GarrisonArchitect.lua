local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

local MVC = LibStub("LibMVC-1.0")
local enum = DataStore.Enum.BuildingTypes

local Buildings = {
	{	-- [1]  Other
		{ 
			buildingType = enum.TownHall, 
			name = format("%s / %s", GARRISON_TOWN_HALL_ALLIANCE, GARRISON_TOWN_HALL_HORDE), 
			tex = "Interface\\Icons\\inv_garrison_resource",
			id = 0, 
		},
		{ buildingType = enum.LunarfallExcavation, id = 61 },
		{ buildingType = enum.HerbGarden, id = 29 },
		{ buildingType = enum.FishingShack, id = 64 },
		{ buildingType = enum.Menagerie, id = 42 },
	},
	{	-- [2] "Small"
		{ buildingType = enum.AlchemyLab, id = 76 },
		{ buildingType = enum.EnchantersStudy, id = 93 },
		{ buildingType = enum.EngineeringWorks, id = 91 },
		{ buildingType = enum.GemBoutique, id = 96 },
		{ buildingType = enum.SalvageYard, id = 52 },
		{ buildingType = enum.ScribesQuarters, id = 95 },
		{ buildingType = enum.Storehouse, id = 51 },
		{ buildingType = enum.TailoringEmporium, id = 94 },
		{ buildingType = enum.TheForge, id = 60 },
		{ buildingType = enum.TheTannery, id = 90 },
	},
	{	-- [3] "Medium"
		{ buildingType = enum.Barn, id = 24 },
		{ buildingType = enum.GladiatorsSanctum, id = 159 },
		{ buildingType = enum.LumberMill, id = 40 },
		{ buildingType = enum.LunarfallInn, id = 34 },
		{ buildingType = enum.TradingPost, id = 111 },
	},
	{	-- [4] "Large"
		{ buildingType = enum.Barracks, id = 26 },
		{ buildingType = enum.DwarvenBunker, id = 8 },
		{ buildingType = enum.GnomishGearworks, id = 162 },
		{ buildingType = enum.MageTower, id = 37 },
		{ buildingType = enum.Stables, id = 65 },
	},
}

local view
local isViewValid

local tab = AltoholicFrame.TabGrids

local function BuildView()
	view = view or {}
	wipe(view)
	
	local options = Altoholic_GridsTab_Options
	local currentBuildings = options["Garrisons.CurrentBuildings"]
	
	for i, building in ipairs(Buildings[currentBuildings]) do
		table.insert(view, building)	-- insert the table pointer
	end
	
	isViewValid = true
end


tab:RegisterGrid(9, {
	InvalidateView = function()
		isViewValid = nil
	end,
	OnUpdate = function()
			if isViewValid then return end
			
			BuildView()
		end,
	GetSize = function() return #view end,
	RowSetup = function(self, rowFrame, dataRowID)
			local v = view[dataRowID]
			local name = v.name or select(2, C_Garrison.GetBuildingInfo(v.id))
			
			if name then
				rowFrame.Name.Text:SetText(format("%s%s", colors.white, name))
				rowFrame.Name.Text:SetJustifyH("LEFT")
			end
		end,
	ColumnSetup = function(self, button, dataRowID, character)
			button.Name:SetFontObject("NumberFontNormal")
			button.Name:SetJustifyH("RIGHT")
			button.Name:SetPoint("BOTTOMRIGHT", -3, 0)
			
			button.Background:SetDesaturated(false)
			button.Background:SetTexCoord(0, 1, 0, 1)
			
			local v = view[dataRowID]
			local buildingType = v.buildingType
			local id, level = DataStore:GetBuildingInfo(character, buildingType)

			-- Set basic building information
			local tex = v.tex or select(4, C_Garrison.GetBuildingInfo(v.id))
			button.Background:SetTexture(tex)
			button.buildingID = v.id
			
			if id and level then	-- if the id from DataStore exists, this character owns this building type
				button.Background:SetVertexColor(1.0, 1.0, 1.0)
				button.Name:SetText(format("%s%s", colors.green, level))
			else
				button.Background:SetVertexColor(0.4, 0.4, 0.4)
				button.Name:SetText("")
			end
			
			button:Show()
		end,
	OnEnter = function(frame) 
			local buildingID = frame.buildingID
			local _, buildingName, _, _, _, rank, currencyID, currencyQty, goldQty, buildTime, needsPlan, _, _, upgrades, canUpgrade = C_Garrison.GetBuildingInfo(buildingID)
			
			-- from Blizzard_GarrisonBuildingUI.lua / GarrisonBuilding_ShowLevelTooltip()
			
			local tooltip = tab.BuildingLevelTooltip
			
			tooltip.Name:SetText(buildingName)
			local height = tooltip.Name:GetHeight() + 30		--15 pixels of padding on top and bottom
			
			tooltip.FollowerText:SetText(nil)
			tooltip.Rank1:SetPoint("TOPLEFT", tooltip.Name, "BOTTOMLEFT", 0, -10)
	
			for i = 1, 3 do
				tooltip[format("Rank%d", i)]:SetFormattedText(GARRISON_CURRENT_LEVEL, i)
			end
			
			-- The town/great hall will not have any tooltip														
			if (not upgrades or #upgrades == 0) then
				return
			end
			
			tooltip.Rank1Tooltip:SetVertexColor(0.5, 0.5, 0.5, 1)
			tooltip.Rank2Tooltip:SetVertexColor(0.5, 0.5, 0.5, 1)
			tooltip.Rank3Tooltip:SetVertexColor(0.5, 0.5, 0.5, 1)
			
			for i = 1, 3 do
				tooltip[format("Rank%dTooltip", i)]:SetVertexColor(1, 1, 1, 1)
			end
			
			local nextAnchor = nil
			for i = 1, #upgrades do
				local rank = tooltip[format("Rank%d", i)]
				local rankTooltip = tooltip[format("Rank%dTooltip", i)]
			
			
				local tooltip = C_Garrison.GetBuildingTooltip(upgrades[i])
				if (tooltip == "") then 
					tooltip = nil 
				end
				
				if (nextAnchor) then
					rank:SetPoint("TOPLEFT", nextAnchor, "BOTTOMLEFT", -10, -10)
				end
				local tooltipText = tooltip
				
				rankTooltip:SetText(tooltipText)
				rank:Show()
				rankTooltip:Show()
				
				--10 pixels padding above rank title, 5 pixels above rank tooltip
				height = height + rankTooltip:GetHeight() + rank:GetHeight() + 15
			end
		
			tooltip.UnlockText:SetText(nil)
			
			tooltip:SetHeight(height)
			-- tooltip:SetPoint("LEFT", frame, "RIGHT", -3, -5)
			tooltip:SetPoint("TOPLEFT", frame, "TOPRIGHT", 1, 1)
			tooltip:Show()
		end,
	OnLeave = function(self)
			tab.BuildingLevelTooltip:Hide()
		end,
})
