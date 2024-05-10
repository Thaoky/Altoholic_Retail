local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local MVC = LibStub("LibMVC-1.0")
local L = DataStore:GetLocale(addonName)

local view
local isViewValid

local tab = AltoholicFrame.TabGrids

local function GetUsedTokens(header)
	-- get the list of tokens found under a specific header, across all alts
	
	local tokens = {}

	for _, character in pairs(DataStore:GetCharacters(tab:GetRealm())) do	-- all alts on this realm
		
		for i = 1, (DataStore:GetNumCurrencies(character) or 0) do
			local name, _, _, category = DataStore:GetCurrencyInfo(character, i)
			
			if not header or (category == header) then
				tokens[name] = true
			end
		end
	end
	
	return DataStore:HashToSortedArray(tokens)
end

local function BuildView()
	local options = Altoholic_GridsTab_Options
	
	view = GetUsedTokens(options["Currencies.CurrentTokenType"])
	isViewValid = true
end

tab:RegisterGrid(3, {
	InvalidateView = function()
		isViewValid = nil
	end,
	OnUpdate = function() 
			if isViewValid then return end
			
			BuildView()
		end,
	GetSize = function() return #view end,
	RowSetup = function(self, rowFrame, dataRowID)
			local token = view[dataRowID]

			if token then
				rowFrame.Name.Text:SetText(format("%s%s", colors.white, token))
				rowFrame.Name.Text:SetJustifyH("LEFT")
			end
		end,
	ColumnSetup = function(self, button, dataRowID, character)
			button.Name:SetFontObject("NumberFontNormalSmall")
			button.Name:SetJustifyH("CENTER")
			button.Name:SetPoint("BOTTOMRIGHT", 5, 0)
			button.Background:SetDesaturated(false)
			button.Background:SetTexCoord(0, 1, 0, 1)

			local token = view[dataRowID]
			local _, count, icon = DataStore:GetCurrencyInfoByName(character, token)
			button.count = count
		
			if count then 
				button.Background:SetTexture(icon)
				button.Background:SetVertexColor(0.5, 0.5, 0.5);	-- greyed out
				button.key = character
				
				if count >= 100000 then
					count = format("%2.1fM", count/1000000)
				elseif count >= 10000 then
					count = format("%2.0fk", count/1000)
				elseif count >= 1000 then
					count = format("%2.1fk", count/1000)
				end
				
				button.Name:SetText(format("%s%s", colors.green, count))
				button:SetID(dataRowID)
				button:Show()
			else
				button.key = nil
				button:SetID(0)
				button:Hide()
			end
		end,
	OnEnter = function(frame) 
			local character = frame.key
			if not character then return end
			
			local tooltip = AddonFactory_Tooltip
			tooltip:SetOwner(frame, "ANCHOR_LEFT")
			tooltip:ClearLines()
			tooltip:AddLine(DataStore:GetColoredCharacterName(character))
			-- tooltip:AddLine(view[frame:GetParent():GetID()], 1, 1, 1)
			tooltip:AddLine(view[frame:GetID()], 1, 1, 1)
			tooltip:AddLine(format("%s%s", colors.green, frame.count))
			tooltip:Show()
		end,
	OnClick = nil,
	OnLeave = function(frame)
			AddonFactory_Tooltip:Hide() 
		end,
})
