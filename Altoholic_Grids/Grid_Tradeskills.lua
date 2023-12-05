local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors
local icons = addon.Icons

local MVC = LibStub("LibMVC-1.0")
local Options = MVC:GetService("AltoholicUI.Options")

local LCI = LibStub("LibCraftInfo-1.0")
local LCL = LibStub("LibCraftLevels-1.0")

local tab = AltoholicFrame.TabGrids

local xPacks = {
	EXPANSION_NAME0,	-- "Classic"
	EXPANSION_NAME1,	-- "The Burning Crusade"
	EXPANSION_NAME2,	-- "Wrath of the Lich King"
	EXPANSION_NAME3,	-- "Cataclysm"
	EXPANSION_NAME4,	-- "Mists of Pandaria"
	EXPANSION_NAME5,	-- "Warlords of Draenor"
	EXPANSION_NAME6,  -- "Legion"
	EXPANSION_NAME7,  -- "Battle for Azeroth"
	EXPANSION_NAME8,  -- "Shadowlands"
	EXPANSION_NAME9,  -- "Dragonflight"
}

local OPTION_XPACK = "UI.Tabs.Grids.Tradeskills.CurrentXPack"
local OPTION_TRADESKILL = "UI.Tabs.Grids.Tradeskills.CurrentTradeSkill"

local currentItemID
local currentList
local currentProfession
local currentTexture
local view
local isViewValid

local function SortByCraftLevel(a, b)
	
	local o1, y1, g1, gr1 = LCL:GetCraftLevels(a)	-- get color level : orange, yellow, green, grey
	local o2, y2, g2, gr2 = LCL:GetCraftLevels(b)
	
	-- try the most common cases = by orange, then by yellow, then by green
	if o1 and o2 and o1 ~= o2 then
		return o1 < o2
	elseif y1 and y2 and y1 ~= y2 then
		return y1 < y2
	elseif g1 and g2 and g1 ~= g2 then
		return g1 < g2
	end	
	
	-- if none has worked, we have a craft with no value for one or multiple colors, so basically skip the missing ones
	-- ex: if no orange value, sort on yellow .. to be able to do so, start from the grey, then green, then yellow
	gr1 = gr1 or 0
	gr2 = gr2 or 0
	
	if gr1 ~= gr2 then
		return gr1 < gr2
	end
	
	g1 = g1 or gr1
	g2 = g2 or gr2
	
	if g1 ~= g2 then
		return g1 < g2
	end
	
	y1 = y1 or g1
	y2 = y2 or g2
	
	if y1 ~= y2 then
		return y1 < y2
	end
	
	-- if nothing worked, sort on spell id
	return a < b
end

local function BuildView()
	local tradeskills = addon.TradeSkills.spellIDs
	local currentXPack = Options.Get(OPTION_XPACK)
	local currentTradeSkill = Options.Get(OPTION_TRADESKILL)
			
	view = LCI:GetProfessionCraftList(tradeskills[currentTradeSkill], currentXPack)
	if not view.isSorted then
		table.sort(view, SortByCraftLevel)
		view.isSorted = true
	end
	
	currentProfession = GetSpellInfo(tradeskills[currentTradeSkill])
	isViewValid = true
end

tab:RegisterGrid(7, {
	InvalidateView = function()
		isViewValid = nil
	end,
	OnUpdate = function() 
			if isViewValid then return end
			
			BuildView()			
	
			local currentXPack = Options.Get(OPTION_XPACK)
			tab:SetStatus(format("%s%s|r / %s%s|r / %s%s", 
				colors.white, TRADESKILLS, 
				colors.white, xPacks[currentXPack], 
				colors.green, currentProfession))
		end,
	GetSize = function() return #view end,
	RowSetup = function(self, rowFrame, dataRowID)
			local spellID = view[dataRowID]
			local itemName = GetSpellInfo(spellID)
			local text
			
			if not itemName then
				-- DEFAULT_CHAT_FRAME:AddMessage("spell : " .. spellID)
				return
			end
			
			currentItemID = DataStore:GetCraftResultItem(spellID)
			-- local orange, yellow, green, grey = LCL:GetCraftLevels(spellID)
			
			currentTexture = GetItemIcon(currentItemID) or icons.questionMark
			
			if orange then
				text = format("%s%s\n%s%s %s%s %s%s %s%s",
					colors.white, itemName, 
					-- colors.white, spellID, 
					colors.recipeOrange, orange, 
					colors.yellow, yellow, 
					colors.recipeGreen, green, 
					colors.recipeGrey, grey )
			end
			
			text = text or format("%s%s", colors.white, itemName)

			rowFrame.Name.Text:SetText(text)
			rowFrame.Name.Text:SetJustifyH("LEFT")
		end,
	ColumnSetup = function(self, button, dataRowID, character)
			button.Name:SetFontObject("GameFontNormalSmall")
			button.Name:SetJustifyH("CENTER")
			button.Name:SetPoint("BOTTOMRIGHT", 5, 0)
			button.Background:SetDesaturated(false)
			button.Background:SetTexCoord(0, 1, 0, 1)
			
			button.Background:SetTexture(currentTexture)

			local text = icons.notReady
			local vc = 0.25	-- vertex color
			
			if DataStore:IsProfessionKnown(character, currentProfession) then
				local profession = DataStore:GetProfession(character, currentProfession)			
				
				-- do not enable this yet .. working fine, but better if more filtering allowed. ==> filtering on rarity
				
				-- local _, _, itemRarity, itemLevel = GetItemInfo(currentItemID)
				-- if itemRarity and itemRarity >= 2 then
					-- local r, g, b = GetItemQualityColor(itemRarity)
					-- button.IconBorder:SetVertexColor(r, g, b, 0.5)
					-- button.IconBorder:Show()
				-- end
				
				if DataStore:IsCraftKnown(profession, view[dataRowID]) then
					vc = 1.0
					text = icons.ready
				else
					vc = 0.4
				end
			end
			
			button.Background:SetVertexColor(vc, vc, vc)
			button.Name:SetText(text)
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
