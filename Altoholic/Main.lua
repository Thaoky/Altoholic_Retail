local addonName, addon = ...
local colors = AddonFactory.Colors

local L = DataStore:GetLocale(addonName)
local LCI = LibStub("LibCraftInfo-1.0")
local MVC = LibStub("LibMVC-1.0")

-- *** Hooks ***
local Orig_ChatEdit_InsertLink = ChatEdit_InsertLink

function ChatEdit_InsertLink(text, ...)
	local editBox = AltoholicFrame.SearchBox

	if text and editBox:IsVisible() and not DataStore:IsTradeSkillWindowOpen() then
		local info = GetItemInfo(text)
		if info then
			editBox:Insert(info)
			return true
		end
	end
	
	return Orig_ChatEdit_InsertLink(text, ...)
end

local Orig_SendMailNameEditBox_OnChar = SendMailNameEditBox:GetScript("OnChar")

SendMailNameEditBox:SetScript("OnChar", function(self, ...)
	if Altoholic_UI_Options.Mail.AutoCompleteRecipient then
		local text = self:GetText()
		
		local textLength = strlen(text)
		local currentFaction = UnitFactionGroup("player")
		
		local matches = {}
		
		for characterName, character in pairs(DataStore:GetCharacters()) do
			if DataStore:GetCharacterFaction(character) == currentFaction then
				if ( strfind(strupper(characterName), strupper(text), 1, 1) == 1 ) and characterName ~= DataStore.ThisChar then
					-- We have a match starting with the user input ..
	
					table.insert(matches, { 
						name = characterName, 										-- Alphabetical sort
						played = DataStore:GetRealPlayTime(character),		-- Most played first
						lastLogout = DataStore:GetLastLogout(character)		-- Last played first
					})
				end
			end
		end
		
		if #matches > 0 then					-- if we have at least a match..
			local currentPriority = Altoholic_UI_Options.Mail.AutoCompletePriority

			if currentPriority == 3 then
				table.sort(matches, function(a, b) return a.lastLogout > b.lastLogout end)
			elseif currentPriority == 2 then
				table.sort(matches, function(a, b) return a.played > b.played end)
			else
				table.sort(matches, function(a, b) return a.name < b.name end)
			end

			local characterName = matches[1].name
			
			SendMailNameEditBox:SetText(characterName)
			SendMailNameEditBox:HighlightText(textLength, strlen(characterName))
			SendMailNameEditBox:SetCursorPosition(textLength)
		end
	end
	
	if Orig_SendMailNameEditBox_OnChar then
		return Orig_SendMailNameEditBox_OnChar(self, ...)
	end
end)

local function IsBOPItemKnown(itemID)
	-- Check if a given item is BOP and known by the current player
	local _, link = GetItemInfo(itemID)
	if not link then return end

	-- ITEM_BIND_ON_EQUIP = "Binds when equipped";
	-- ITEM_BIND_ON_PICKUP = "Binds when picked up";
	-- ITEM_BIND_ON_USE = "Binds when used";
	-- ITEM_SPELL_KNOWN = "Already known";
	
	local tooltip = AddonFactory_Tooltip
	
	tooltip:SetOwner(AltoholicFrame, "ANCHOR_LEFT")
	tooltip:SetHyperlink(link)
	
	local tooltipLine
	local isBOP
	local isKnown	-- by the current character only
	
	for i = 1, tooltip:NumLines() do
		tooltipLine = _G[format("AddonFactory_TooltipTextLeft%d", i)]:GetText()
		
		if tooltipLine then
			if tooltipLine == ITEM_BIND_ON_PICKUP and i <= 4 then	
				-- some items will have "Binds when picked up" twice.. only care about the occurence in the first 4 lines
				isBOP = true
			elseif tooltipLine == ITEM_SPELL_KNOWN then
				isKnown = true
			end
		end
	end

	return (isBOP and isKnown) -- only return true if both are true
end

-- local Orig_MerchantFrame_UpdateMerchantInfo

local function MerchantFrame_UpdateMerchantInfoHook()
	
	-- Orig_MerchantFrame_UpdateMerchantInfo()		-- Let default stuff happen first ..
	
	if Altoholic_UI_Options.VendorColorCoding == false then return end
	
   local numItems = GetMerchantNumItems()
	local index, link

	for i = 1, MERCHANT_ITEMS_PER_PAGE do
		index = ((MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE) + i
		
		if index <= numItems then
			link = GetMerchantItemLink(index)
	
			if link then		-- if there's a valid item link in this slot ..
				local itemID = addon:GetIDFromLink(link)
				if itemID and itemID ~= 0 then		-- if there's a valid item link 
					
					-- local _, _, _, _, _, itemType, itemSubType = GetItemInfo(itemID)
					local itemSubType = select(7, GetItemInfo(itemID))
					local classID, subclassID = select(12, GetItemInfo(itemID))
					
					local r, g, b = 1, 1, 1
					
					-- also applies to garrison blueprints
					if IsBOPItemKnown(itemID) then		-- recipe is bop and already known, useless to alts : red.
						r, g, b = 1, 0, 0
						
					elseif classID == Enum.ItemClass.Recipe and subclassID ~= Enum.ItemRecipeSubclass.Book then -- is it a recipe ?
						local _, couldLearn, willLearn = addon:GetRecipeOwners(itemSubType, link, addon:GetRecipeLevel(link))
						
						if #couldLearn == 0 and #willLearn == 0 then		-- nobody could learn the recipe, neither now nor later : red
							r, g, b = 1, 0, 0
						elseif #couldLearn > 0 then							-- at least 1 could learn it : green (priority over "will learn")
							r, g, b = 0, 1, 0
						elseif #willLearn > 0 then								-- nobody could learn it now, but some could later : yellow
							r, g, b = 1, 1, 0
						end
					end
					
					local button = _G[format("MerchantItem%dItemButton", i)]
					if button then
						SetItemButtonTextureVertexColor(button, r, g, b)
						SetItemButtonNormalTextureVertexColor(button, r, g, b)
					end
				end
			end
		end
	end
	
	AddonFactory_Tooltip:Hide()
end


DataStore:OnPlayerLogin(function() 
	MVC:GetService("AltoholicUI.Authorization"):Initialize()
	MVC:GetService("AltoholicUI.SharedContent"):Initialize()
	MVC:GetService("AltoholicUI.AccountSharing"):Initialize()
	MVC:GetService("AltoholicUI.Events"):Initialize()
	
	local Tooltip = MVC:GetService("AltoholicUI.Tooltip")
	Tooltip:Initialize()

	AltoholicFrame:SetClampedToScreen(Altoholic_UI_Options.ClampWindowToScreen)
	AltoholicFrame:SetScale(Altoholic_UI_Options.Scale)
	AltoholicFrame:LimitFrameSize()
	
	local minimap = AltoholicMinimapButton
	
	if Altoholic_UI_Options.Minimap.ShowIcon then
		minimap:Move()
		minimap:Show()
	else
		minimap:Hide()
	end
	
	-- any loot message should cause a refresh
	addon:ListenTo("CHAT_MSG_LOOT", Tooltip.RefreshTooltip)
	
	-- hook the Merchant update function
	-- Orig_MerchantFrame_UpdateMerchantInfo = MerchantFrame_UpdateMerchantInfo
	-- MerchantFrame_UpdateMerchantInfo = MerchantFrame_UpdateMerchantInfoHook
	
	-- 2023-11-15: From Belazor
	-- There was an issue where sorting the bags while the merchant frame is opened would trigger a slow down
	-- This fixes the problem.
	hooksecurefunc("MerchantFrame_UpdateMerchantInfo", function()
		C_Timer.NewTimer(0.1, function()
			MerchantFrame_UpdateMerchantInfoHook();
		end)
	end)	
end)

addon:Controller("AltoholicUI.MainFrame", { 
	OnBind = function(frame)
		frame:SetTitle(format("Altoholic %s%s by %sThaoky", colors.white, addon.Version, colors.classMage))
	end,
})

-- ** Global methods **
function addon:Item_OnEnter(frame)
	if not frame.id then return end
	
	GameTooltip:SetOwner(frame, "ANCHOR_LEFT")
	frame.link = frame.link or select(2, GetItemInfo(frame.id) )
	
	if frame.link then
		GameTooltip:SetHyperlink(frame.link)
	else
		-- this line queries the server for an unknown id
		GameTooltip:SetHyperlink(format("item:%d:0:0:0:0:0:0:0", frame.id))

		-- don't leave residual info in the tooltip after the server query
		GameTooltip:ClearLines()
	end
	GameTooltip:Show()
end

function addon:Item_OnClick(frame, button)
	if button ~= "LeftButton" or not frame.id then return end
	
	local link = frame.link
	
	if not link then
		link = select(2, GetItemInfo(frame.id) )
	end
	if not link then return end		-- still not valid ? exit
	
	if IsControlKeyDown() then
		DressUpItemLink(link)
	elseif IsShiftKeyDown() then
		local chat = ChatEdit_GetLastActiveWindow()
	
		if chat:IsShown() then
			chat:Insert(link)
		else
			AltoholicFrame.SearchBox:SetText(GetItemInfo(link))
		end
	end
end

function addon:DrawFollowerTooltip(frame)
	local character = frame.key
	if not character then return end

	-- get the follower link
	local link = DataStore:GetFollowerLink(character, frame.followerID)
	if not link then return end
	
	-- toggle the tooltip, use blizzard's own function for that
	local _, garrisonFollowerID, quality, level, itemLevel, ability1, ability2, ability3, ability4, trait1, trait2, trait3, trait4 = strsplit(":", link);
	FloatingGarrisonFollowerTooltip:ClearAllPoints()
	FloatingGarrisonFollowerTooltip:SetPoint("TOPLEFT", frame, "TOPRIGHT", 1, 1)
	FloatingGarrisonFollower_Toggle(tonumber(garrisonFollowerID), tonumber(quality), tonumber(level), tonumber(itemLevel), tonumber(ability1), tonumber(ability2), tonumber(ability3), tonumber(ability4), tonumber(trait1), tonumber(trait2), tonumber(trait3), tonumber(trait4))
end

function addon:GetIDFromLink(link)
	if link then
		local linktype, id = string.match(link, "|H([^:]+):(%d+)")
		if id then
			return tonumber(id)
		end
	end
end

function addon:GetSpellIDFromRecipeLink(link)
	-- returns nil if recipe id is not in the DB, returns the spellID otherwise
	local recipeID = addon:GetIDFromLink(link)
	return LCI:GetRecipeLearnedSpell(recipeID)
end

function addon:GetRecipeLink(spellID, profession, color)
	color = color or "|cffffd000"
	local name = C_Spell.GetSpellName(spellID) or ""
	
	return format("%s|Henchant:%s|h[%s: %s]|h|r", color, spellID, profession, name)
end

function addon:GetRecipeLevel(link, tooltip)
	-- if not tooltip then	-- if no tooltip is provided for scanning, let's make one
		-- tooltip = AddonFactory_Tooltip
		
		-- tooltip:ClearLines();	
		-- tooltip:SetOwner(AltoholicFrame, "ANCHOR_LEFT");
		-- tooltip:SetHyperlink(link)
	-- end

	local tooltip = AltoScanningTooltip
	
	tooltip:ClearLines()
	tooltip:SetHyperlink(link)
	
	local tooltipName = tooltip:GetName()
	
	for i = tooltip:NumLines(), 2, -1 do			-- parse all tooltip lines, from last to second
		local tooltipText = _G[format("%sTextLeft%d", tooltipName, i)]:GetText()
		
		if tooltipText then
			local _, _, recipeLevel = string.find(tooltipText, "%((%d+)%)") -- find number enclosed in brackets
			
			if recipeLevel then
				return tonumber(recipeLevel)
			end
		end
	end
end

function addon:ListCharsOnQuest(questName, player, tooltip)
	if not questName then return nil end

	local charsOnQuest = DataStore:GetCharactersOnQuest(questName, player)
	
	if charsOnQuest and #charsOnQuest > 0 then
		tooltip:AddLine(" ",1,1,1)
		tooltip:AddLine(format("%s%s", colors.green, L["Are also on this quest:"]))
		
		for _, character in pairs(charsOnQuest) do
			tooltip:AddLine(DataStore:GetColoredCharacterName(character))
		end
	end
end

function addon:ShowCharacterPanel(character, panel)
	-- Shortcut to show a given panel on the characters tab
	AltoholicFrame:SwitchToTab("Characters")
	
	local tab = AltoholicFrame.TabCharacters
	tab:SetCharacter(character)
	tab.CategoriesList:ClickCategory("key", character)
	tab:ShowPanel(panel)
end

function addon:CanUpgradeRidingSkill(character, speed)
	speed = speed or DataStore:GetRidingSkill(character)
	local characterLevel = DataStore:GetCharacterLevel(character)
	local couldUpgrade = false
		
	-- Could the player upgrade ?
	DataStore:IterateRidingSkills(function(skill) 
		if characterLevel >= skill.minLevel and speed < skill.speed then
			couldUpgrade = true
		end
	end)
	
	return couldUpgrade
end

function addon.ShowOptionsPanel(self, helpID)
	local panel = self.value
	
	AltoholicFrame:SwitchToTab("Options")
	
	local tab = AltoholicFrame.TabOptions
	if helpID then
		tab.CategoriesList:ClickCategory("helpID", helpID)
		tab:SetHelp(helpID)
	else
		tab.CategoriesList:ClickCategory("panel", panel)
	end
	tab:ShowPanel(panel)	
end

function addon:GetItemQualityLabel(qLevel)
	return format("|c%s%s", select(4, GetItemQualityColor(qLevel)), _G[format("ITEM_QUALITY%d_DESC", qLevel)])
end

-- ** Calendar stuff **
local calendarFirstWeekday = 1
-- 1 = Sunday, recreated locally to avoid the problem caused by the calendar addon not being loaded at startup.
-- On an EU client, CALENDAR_FIRST_WEEKDAY = 1 when the game is loaded, but becomes 2 as soon as the calendar is launched.
-- So default it to 1, and add an option to select Monday as 1st day of the week instead. If need be, use a slider.
-- Although the calendar is LoD, avoid it.

function addon:SetFirstDayOfWeek(day)
	calendarFirstWeekday = day
end

function addon:GetFirstDayOfWeek()
	return calendarFirstWeekday
end
