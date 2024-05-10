local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors
local icons = addon.Icons

local MVC = LibStub("LibMVC-1.0")
local L = DataStore:GetLocale(addonName)

local tab = AltoholicFrame.TabGrids

local spellList
local currentSpellID
local currentPetTexture

local function SortPets(a, b)
	local textA = GetSpellInfo(a) or ""
	local textB = GetSpellInfo(b) or ""
	return textA < textB
end

if DataStore_Pets then
	table.sort(DataStore:GetCompanionList(), SortPets)
end

local function CompanionOnClick(frame, button)
	if frame.id and ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
		local chat = ChatEdit_GetLastActiveWindow()
		if chat:IsShown() then
			local link = DataStore:GetCompanionLink(frame.id)
			if link then
				chat:Insert(link)
			end
		end
	end
end

-- *** PETS ***

local petList = {
	{	-- "Classic"
		4055, 10673, 10674, 10675, 10676, 10677, 10678, 10679, 10680, 10682,
		10683, 10684, 10685, 10688, 10695, 10696, 10697, 10698, 10703, 10704, 
		10706, 10707, 10709, 10711, 10714, 10716, 10717, 12243, 13548, 15048, 
		15049, 15067, 15999, 17707, 17708, 17709, 19772, 23811, 24696, 24988, 
		25162, 26010, 26045, 26529, 26533, 26541, 27241, 27570, 28505, 28738, 
		28739, 28740, 28871, 35239, 
	},
	{	-- "The Burning Crusade"
		40990, 33050, 43697, 43698, 46425, 46426, 42609, 45890, 54187, 40613, 
		40614, 40634, 44369, 36034, 43918, 46599, 39181, 39709, 45082, 51716, 
		35156, 35909, 36031, 36027, 36028, 36029, 35907, 35910, 35911, 48406, 
		48408, 51851, 32298, 40405, 53082, 40549, 45125, 45127, 30156, 49964, 
	},
	{	-- "Wrath of the Lich King"
		69452, 69539, 66520, 67527, 23530, 23531, 45174, 61773, 61472, 61991, 
		70613, 59250, 62561, 61725, 71840, 74932, 65382, 65381, 67413, 67414, 
		67415, 67416, 67418, 67419, 67420, 62491, 62508, 62510, 62513, 62516, 
		62542, 62562, 62564, 62674, 63712, 61348, 61349, 61350, 61351, 61357, 
		53316, 67417, 75134, 65358, 10713, 61855, 63318, 69002, 55068, 52615, 
		78381, 66030, 94070, 65682, 68767, 68810, 69677, 69541, 69535, 69536, 
		75906, 95787, 66096, 62609, 95786, 66096, 62746, 95909, 
	},
	{	-- "Cataclysm"
		16450, 65046, 75613, 78683, 78685, 81937, 82173, 84263, 84492, 84752, 
		87344, 89039, 89472, 89670, 90523, 90637, 91343, 92395, 92396, 92397, 
		92398, 93624, 93739, 93813, 93817, 93823, 93836, 93837, 93838, 96571, 
		96817, 96819, 97638, 97779, 98079, 98571, 98587, 98736, 99578, 99663, 
		99668, 100330,100576,100684,100970,101424,101493,101606,101733,101986,
		101989,102317,103074,103076,103125,103544,103549,103588,104047,104049,
		105122,
	},
	{	-- "Mists of Pandaria"
		114090,118414,120501,120507,122748,123212,123214,123778,123784,124000,
		124152,124660,126247,126249,126251,126885,127006,127008,127813,127815,
		127816,130726,130759,131590,131650,132574,132580,132759,132762,132785,
		132789,134538,134892,134894,134895,135156,135254,135255,135256,135257,
		135258,135259,135261,135263,135264,135265,135266,135267,135268,136484,
		137568,137977,138082,138087,138161,138285,138380,138381,138382,138913,
		139148,139361,139362,139363,139365,139932,139933,139934
	},
}

for _, list in pairs(petList) do
	table.sort(list, SortPets)
end

local xPacks = {
	EXPANSION_NAME0,	-- "Classic"
	EXPANSION_NAME1,	-- "The Burning Crusade"
	EXPANSION_NAME2,	-- "Wrath of the Lich King"
	EXPANSION_NAME3,	-- "Cataclysm"
	EXPANSION_NAME4,	-- "Mists of Pandaria"
	L["All-in-one"],
}

local CAT_ALLINONE = #xPacks

tab:RegisterGrid(5, {
	OnUpdate = function() 
			local options = Altoholic_GridsTab_Options
			local currentXPack = options["Companions.CurrentXPack"]
			
			spellList = (currentXPack <= CAT_ALLINONE) and petList[currentXPack] or DataStore:GetCompanionList()
		end,
	GetSize = function() return #spellList end,
	RowSetup = function(self, rowFrame, dataRowID)
			currentSpellID = spellList[dataRowID]
			local petName, _
			petName, _, currentPetTexture = GetSpellInfo(currentSpellID)
			
			if petName then
				rowFrame.Name.Text:SetText(format("%s%s", colors.white, petName))
				rowFrame.Name.Text:SetJustifyH("LEFT")
			end
		end,
	ColumnSetup = function(self, button, dataRowID, character)
			button.Name:SetFontObject("GameFontNormalSmall")
			button.Name:SetJustifyH("CENTER")
			button.Name:SetPoint("BOTTOMRIGHT", 5, 0)
			button.Background:SetDesaturated(false)
			button.Background:SetTexCoord(0, 1, 0, 1)
			button.Background:SetTexture(currentPetTexture)
			
			if DataStore:IsPetKnown(currentSpellID) then
				button.Background:SetVertexColor(1.0, 1.0, 1.0)
				button.Name:SetText(icons.ready)
			else
				button.Background:SetVertexColor(0.4, 0.4, 0.4)
				button.Name:SetText(icons.notReady)
			end
			button.id = currentSpellID
		end,
	OnEnter = function(frame) 
			local id = frame.id
			if id then
				local tooltip = AddonFactory_Tooltip
				
				tooltip:SetOwner(frame, "ANCHOR_LEFT")
				tooltip:ClearLines()
				tooltip:SetHyperlink(format("spell:%d", id))
				tooltip:Show()
			end
			
		end,
	OnClick = CompanionOnClick,
	OnLeave = function(self)
			AddonFactory_Tooltip:Hide() 
		end,
})
