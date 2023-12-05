local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors
local icons = addon.Icons

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local TEXTURE_HORDE = format("|T%s:%s:%s|t", icons.Horde, 18, 18)
local TEXTURE_ALLIANCE = format("|T%s:%s:%s|t", icons.Alliance, 18, 18)

addon:Controller("AltoholicUI.SummaryPaneRow", { 
	"AltoholicUI.Characters", 
	"AltoholicUI.Formatter",
	"AltoholicUI.TabSummaryColumns", 
	"AltoholicUI.AccountSharing", 
	
function(characters, formatter, columnsData, AccountSharing)

	local function GetFactionTotals(faction, line)
		local _, realm, account = characters.GetInfo(line)
		
		local level = 0
		local money = 0
		local played = 0
		
		-- to fix : this does not take filters into account !
		for _, character in pairs(DataStore:GetCharacters(realm, account)) do
			if DataStore:GetCharacterFaction(character) == faction then
				level = level + DataStore:GetCharacterLevel(character)
				money = money + DataStore:GetMoney(character)
				played = played + DataStore:GetPlayTime(character)
			end
		end
		
		return level, money, played
	end

	local function ShowTotals(frame)
		local line = frame:GetParent():GetID()
		local tt = AddonFactory_Tooltip
		
		tt:ClearLines()
		tt:SetOwner(frame, "ANCHOR_TOP")
		tt:AddLine(L["Totals"])
		
		local aLevels, aMoney, aPlayed = GetFactionTotals("Alliance", line)
		local hLevels, hMoney, hPlayed = GetFactionTotals("Horde", line)
		
		tt:AddLine(" ")
		tt:AddDoubleLine(format("%s%s", colors.white, L["Levels"]), format("%s%s", colors.white, characters.GetField(line, "level")))
		tt:AddDoubleLine(TEXTURE_ALLIANCE, format("%s%s", colors.white, aLevels))
		tt:AddDoubleLine(TEXTURE_HORDE, format("%s%s", colors.white, hLevels))
		
		tt:AddLine(" ")
		tt:AddDoubleLine(format("%s%s", colors.white, MONEY), formatter.MoneyString(characters.GetField(line, "money")))
		tt:AddDoubleLine(TEXTURE_ALLIANCE, formatter.MoneyString(aMoney, colors.white))
		tt:AddDoubleLine(TEXTURE_HORDE, formatter.MoneyString(hMoney, colors.white))
		
		tt:AddLine(" ")
		tt:AddDoubleLine(format("%s%s", colors.white, PLAYED), characters.GetField(line, "played"))
		tt:AddDoubleLine(TEXTURE_ALLIANCE, formatter.TimeString(aPlayed))
		tt:AddDoubleLine(TEXTURE_HORDE, formatter.TimeString(hPlayed))
		
		tt:Show()
	end

	return {
		HideItems = function(frame, from, to)
			for i = from, to do
				frame[format("Item%d", i)]:Hide()
			end
		end,
		DrawRealmLine = function(frame, line, realm, account, isRealmShown)
			local item = frame.Item1
			
			item:SetWidth(400)
			item:SetPoint("TOPLEFT", 25, 0)
			item.Text:SetWidth(400)
			item.Text:SetJustifyH("LEFT")

			if account == DataStore.ThisAccount then	-- saved as default, display as localized.
				item.Text:SetText(format("%s (%s%s: %s%s|r)", realm, colors.white, L["Account"], colors.green, L["Default"]))
			else
				local last = AccountSharing.GetLastAccountSharingInfo(realm, account)
				item.Text:SetText(format("%s (%s%s: %s%s %s%s|r)", realm, colors.white, L["Account"], colors.green, account, colors.yellow, last or ""))
			end

			item:SetScript("OnEnter", addon.EmptyFunc)
			item:SetScript("OnClick", columnsData.Get("Name").OnClick)

			if isRealmShown then
				frame.Collapse:SetExpanded()
			else
				frame.Collapse:SetCollapsed()
			end
			
			frame.Collapse:Show()
			frame.character = nil
			frame:HideItems(2, 10)
			frame:SetID(line)
			frame:Show()
		end,
		DrawCharacterLine = function(frame, line, profile)
			local character = DataStore:GetCharacter( characters.GetInfo(line) )
			
			frame.Collapse:Hide()
			frame.Item1:SetPoint("TOPLEFT", 10, 0)

			-- fill the visible cells for this mode
			
			for i, columnName in ipairs(profile) do
				frame[format("Item%d", i)]:SetColumnData(character, columnsData.Get(columnName))
			end
			
			frame.character = character
			frame:HideItems(#profile + 1, 10)
			frame:SetID(line)
			frame:Show()
		end,
		DrawTotalLine = function(frame, line, profile)
			frame.Collapse:Hide()

			-- fill the visible cells for this mode
			for i, columnName in ipairs(profile) do
				frame[format("Item%d", i)]:SetColumnTotal(line, columnsData.Get(columnName))
			end

			frame.Item1:SetPoint("TOPLEFT", 10, 0)
			frame.Item1:SetScript("OnEnter", ShowTotals)
			
			frame.character = nil
			frame:HideItems(#profile + 1, 10)
			frame:SetID(line)
			frame:Show()
		end,
	}
end})
