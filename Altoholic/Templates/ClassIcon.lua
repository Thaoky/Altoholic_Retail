local addonName, addon = ...
local colors = addon.Colors

local L = DataStore:GetLocale(addonName)
local MVC = LibStub("LibMVC-1.0")
local Options = MVC:GetService("AltoholicUI.ColumnOptions")

local ICON_PARTIAL = "Interface\\RaidFrame\\ReadyCheck-Waiting"

local function OnCharacterChange(frame, owner)
	local id = owner.menuID
	local parent = owner:GetParent()
	local classIcons = parent.ClassIcons
	local account, realm = parent.SelectRealm:GetCurrentRealm()

	Options.SetColumnKey(_G[owner.storage], account, realm, id, frame.value)
	
	if classIcons.OnCharacterChanged then
		classIcons:OnCharacterChanged()		-- callback method in the container
	end
end

local function ClassIcon_Initialize(frame, level)
	local id = frame.menuID
	local parent = frame:GetParent()
	local account, realm = parent.SelectRealm:GetCurrentRealm()
		
	frame:AddTitle(L["Characters"])
	local nameList = {}		-- we want to list characters alphabetically
	for _, character in pairs(DataStore:GetCharacters(realm, account)) do
		table.insert(nameList, character)	-- we can add the key instead of just the name, since they will all be like account.realm.name, where account & realm are identical
	end
	table.sort(nameList)
	
	-- get the key associated with this button
	local key = Options.GetColumnKey(_G[frame.storage], account, realm, id)
	
	for _, character in ipairs(nameList) do
		local _, _, characterName = strsplit(".", character)
	
		local info = frame:CreateInfo()
		info.text		= DataStore:GetColoredCharacterName(character)
		info.value		= characterName
		info.func		= OnCharacterChange
		info.checked	= (key == character)
		info.arg1		= frame
		frame:AddButtonInfo(info, 1)
	end
	
	frame:AddTitle()
	
	local info = frame:CreateInfo()
	info.text		= (id == 1) and RESET or NONE
	info.value		= nil
	info.func		= OnCharacterChange
	info.checked	= (key == "")
	info.arg1		= frame
	frame:AddButtonInfo(info, 1)

	frame:AddCloseMenu()
end

addon:Controller("AltoholicUI.ClassIcon", {
	Icon_OnEnter = function(frame)
		local parent = frame:GetParent():GetParent()
		local currentMenuID = frame:GetID()
		local menu = parent.ContextualMenu

		menu.menuID = currentMenuID
		menu.storage = frame.storage
		menu:Initialize(ClassIcon_Initialize, "MENU")
		menu:Close()
		menu:Toggle(frame, 0, 0)

		-- get the key associated with this button
		local account, realm = parent.SelectRealm:GetCurrentRealm()
		local key = Options.GetColumnKey(_G[frame.storage], account, realm, currentMenuID)
		
		if key then
			frame:DrawTooltip(key)
		end
	end,
	SetClass = function(frame, class, faction)
		local icon = frame.Icon
		local border = frame.IconBorder
		
		if class and faction then
			local tc = CLASS_ICON_TCOORDS[class]
		
			icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
			icon:SetTexCoord(tc[1], tc[2], tc[3], tc[4])

			if faction == "Alliance" then
				border:SetVertexColor(0.1, 0.25, 1, 0.5)
			else
				border:SetVertexColor(1, 0, 0, 0.5)
			end
		else	-- no key ? display a question mark icon
			icon:SetTexture(ICON_PARTIAL)
			icon:SetTexCoord(0, 1, 0, 1)
			
			border:SetVertexColor(0, 1, 0, 0.5)
		end
		
		-- icon:SetWidth(33)
		-- icon:SetHeight(33)
		icon:SetWidth(30)
		icon:SetHeight(30)
		icon:SetAllPoints(frame)
		
		border:Show()
		-- frame:SetWidth(34)
		-- frame:SetHeight(34)
		frame:SetWidth(31)
		frame:SetHeight(31)
		frame:Show()
	end,
	DrawTooltip = function(frame, character)
		local name = DataStore:GetColoredCharacterName(character)
		if not name then return end

		local tt = AddonFactory_Tooltip
		tt:SetOwner(frame, "ANCHOR_LEFT")
		tt:ClearLines()
		tt:AddDoubleLine(name, DataStore:GetColoredCharacterFaction(character))

		tt:AddLine(format("%s %s%s |r%s %s", 
			LEVEL, 
			colors.green,
			DataStore:GetCharacterLevel(character), 
			DataStore:GetCharacterRace(character),
			DataStore:GetCharacterClass(character)
		),1,1,1)

		local zone, subZone = DataStore:GetLocation(character)
		tt:AddLine(format("%s: %s%s |r(%s%s|r)", L["Zone"], colors.gold, zone, colors.gold, subZone),1,1,1)
		
		local restXP = DataStore:GetRestXP(character)
		if restXP and restXP > 0 then
			tt:AddLine(format("%s: %s%s", L["Rest XP"], colors.green, restXP),1,1,1)
		end
		
		local AiL = DataStore:GetAverageItemLevel(character)
		tt:AddLine(format("Average iLevel: %s%.1f", colors.green, AiL or 0),1,1,1)

		if C_AddOns.IsAddOnLoaded("DataStore_Achievements") then
			local numAchievements = DataStore:GetNumCompletedAchievements(character) or 0
			if numAchievements > 0 then
				tt:AddLine(format("%s: %s%s/%s", 
					ACHIEVEMENTS_COMPLETED, 
					colors.green, 
					DataStore:GetNumCompletedAchievements(character), 
					DataStore:GetNumAchievements(character)
				))
				tt:AddLine(format("%s: %s%s", ACHIEVEMENT_TITLE, colors.green, DataStore:GetNumAchievementPoints(character)))
			end
		end
		
		tt:Show()
	end,
})
