local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors
local icons = addon.Icons

local MVC = LibStub("LibMVC-1.0")
local Options = MVC:GetService("AltoholicUI.Options")
local TransmogSets = MVC:GetService("AltoholicUI.TransmogSetsLists")

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local tab = AltoholicFrame.TabGrids

local view
local isViewValid
local currentTier

local OPTION_PVE = "UI.Tabs.Grids.Sets.IncludePVE"
local OPTION_PVP = "UI.Tabs.Grids.Sets.PVP.All"
local OPTION_XPACK = "UI.Tabs.Grids.Sets.CurrentXPack"
local OPTION_PVPDESC_PREFIX = "UI.Tabs.Grids.Sets.PVP."

local TEXTURE_FONT = "|T%s:%s:%s|t"

local function FormatSetDescription(setInfo)
	local line1 = format("%s%s", colors.white, setInfo.label)
	local line2 = ""
	local description = (setInfo.description) and format("%s - %s", colors.cyan, setInfo.description) or ""

	if setInfo.requiredFaction then
		local icon = icons[setInfo.requiredFaction]
		line1 = format("%s %s", line1, format(TEXTURE_FONT, icon, 18, 18))
	end

	if setInfo.tier then
		line2 = format("%s%s %s%s%s", colors.gold, GARRISON_TIER, colors.green, setInfo.tier, description)
	end

	return format("%s\n%s", line1, line2)
end

local function IsPVPDescriptionChecked(description)
	local optionName = format("%s%s", OPTION_PVPDESC_PREFIX, description)
	local option = Options.Get(optionName)
	
	if type(option) == "nil" then		-- if the option does not exist (first use), then initialize it to true
		Options.Set(optionName, true)
		option = true
	end

	return option
end

local function BuildView()
	view = view or {}
	wipe(view)

	local includePVE = Options.Get(OPTION_PVE)
	local includePVP = Options.Get(OPTION_PVP)
	local includeAlliance = Options.Get(format("%s%s", OPTION_PVPDESC_PREFIX, "Alliance"))
	local includeHorde = Options.Get(format("%s%s", OPTION_PVPDESC_PREFIX, "Horde"))
	local currentXPack = Options.Get(OPTION_XPACK)
	
	local activePVPTypes = {}
	
	for _, pvpDescription in ipairs(TransmogSets.GetPvPDescriptions()) do
		if IsPVPDescriptionChecked(pvpDescription) then
			activePVPTypes[pvpDescription] = true
		end
	end

	-- Parse set data
	for xpackIndex, xpack in ipairs(TransmogSets.Get()) do
		for _, setInfo in ipairs(xpack) do
			local isPVP = setInfo.isPVP
			local factionOK = true	-- will remain true if no "requiredFaction" is set
			local descOK = false

			-- For PVP sets only: check is the description is one we want to show (ex: hide all "Elite" sets)
			if isPVP and setInfo.description then
				descOK = activePVPTypes[setInfo.description]
			end
			
			local faction = setInfo.requiredFaction
			if faction then
				if ((faction == "Alliance") and not includeAlliance) or
					((faction == "Horde") and not includeHorde) then
					factionOK = false
				end
			end

			if (not isPVP and includePVE and factionOK) or		-- it is a PVE set, and we want it
				(isPVP and includePVP and descOK and factionOK) then		-- it is a PVP set, and we want it, and it's description is OK

				if currentXPack == xpackIndex then
					table.insert(view, setInfo)	-- insert the table pointer
				end
			end
		end
	end
	
	isViewValid = true
end

tab:RegisterGrid(13, {
	InvalidateView = function()
		isViewValid = nil
	end,
	OnUpdate = function() 
			if isViewValid then return end
			
			BuildView()
		end,
	GetSize = function() return #view end,
	RowSetup = function(self, rowFrame, dataRowID)
			currentTier = view[dataRowID]
			rowFrame.Name.Text:SetText(FormatSetDescription(currentTier))
			rowFrame.Name.Text:SetJustifyH("LEFT")
		end,
	ColumnSetup = function(self, button, dataRowID, character)
			local _, englishClass = DataStore:GetCharacterClass(character)
			local setID = currentTier[englishClass]

			button.Name:SetFontObject("GameFontNormalSmall")
			button.Name:SetJustifyH("CENTER")
			button.Name:SetPoint("BOTTOMRIGHT", 5, 0)
			button.Background:SetDesaturated(false)

			if setID then
				button.Background:SetTexture(DataStore:GetSetIcon(setID))
				button.Background:SetTexCoord(0, 1, 0, 1)

				if DataStore:IsSetCollected(setID) then
					button.Background:SetVertexColor(1, 1, 1)
					button.Name:SetText(icons.ready)
				else
					button.Name:SetFontObject("NumberFontNormalSmall")
					button.Name:SetJustifyH("RIGHT")
					button.Name:SetPoint("BOTTOMRIGHT", 0, 0)

					local numCollected, numTotal = DataStore:GetCollectedSetInfo(setID)
					local text = icons.notReady
					if numCollected ~= 0 then
						text = format("%s%s/%s", colors.green, numCollected, numTotal)
					end

					button.Background:SetVertexColor(0.3, 0.3, 0.3)	-- greyed out
					button.Name:SetText(text)
				end
				
				button.key = character		
				button:SetID(setID)
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
			
			local setID = frame:GetID()
			if not setID then return end

			local class, englishClass = DataStore:GetCharacterClass(character)
			local classColor = DataStore:GetClassColor(englishClass)
			local numCollected, numTotal = DataStore:GetCollectedSetInfo(setID)


			local info = C_TransmogSets.GetSetInfo(setID)
			local setName = info.name or format("Set %s", setID)
			local setTier = info.label or format("Set %s", setID)

			local tt = AddonFactory_Tooltip
			tt:SetOwner(frame, "ANCHOR_LEFT")
			tt:ClearLines()
			tt:AddDoubleLine(setName, format("%s%s", classColor, class))
			tt:AddDoubleLine(
				format("%s%s", colors.white, setTier), 
				format("%s%s/%s", colors.green, numCollected, numTotal))
			tt:AddLine(" ",1,1,1)

			local apppearances = C_TransmogSets.GetSetPrimaryAppearances(setID)
			local isComplete = DataStore:IsSetCollected(setID)

			local itemsMissing = false

			for _, appearance in pairs(apppearances) do
				local icon = icons.notReady
				
				if isComplete or DataStore:IsSetItemCollected(setID, appearance.appearanceID) then
					icon = icons.ready
				end

				local info = C_TransmogCollection.GetSourceInfo(appearance.appearanceID)

				-- GetItemInfo may not be able to return all info immediately
				-- so alleviate the impact on the UI by warning the user
				local itemName, _, itemRarity = GetItemInfo(info.itemID)
				if itemName and itemRarity then
					local _, _, _, hex = GetItemQualityColor(itemRarity)
					tt:AddLine(format("%s %s |c%s%s|r", icon, format(TEXTURE_FONT, GetItemIcon(info.itemID), 18, 18), hex, itemName)) 
				else
					itemsMissing = true
				end
			end
			
			if itemsMissing then
				tt:AddLine(L["Fetching item information .."], 1,0,0)	
			end

			tt:Show()
		end,
	OnLeave = function(self)
			AddonFactory_Tooltip:Hide() 
		end,
})
