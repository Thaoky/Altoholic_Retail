local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = DataStore:GetLocale(addonName)
local MVC = LibStub("LibMVC-1.0")
local MAX_BANK_TABS = 8

local rarityIcons = {
	[0] = "Interface\\Icons\\item_cutmetagemb",
	[2] = "Interface\\Icons\\inv_misc_uncutgemnormal1",
	[3] = "Interface\\Icons\\inv_misc_uncutgemnormal2",
	[4] = "Interface\\Icons\\inv_misc_uncutgemnormal4",
	[5] = "Interface\\Icons\\inv_misc_uncutgemnormal",
	[6] = "Interface\\Icons\\inv_misc_uncutgemnormal5",
}

-- ** Icon events **

local function OnHideInTooltip(frame, guildBank)
	local guildKey = frame.value
	
	-- Option for this guild will be like : "Default.Dalaran.MyGuild.HideInTooltip"
	local hiddenGuilds = Altoholic_Tooltip_Options.HiddenGuilds
	
	if hiddenGuilds[guildKey] then
		-- if the option already exists, toggle it
		hiddenGuilds[guildKey] = not hiddenGuilds[guildKey]
	else
		-- otherwise set it to true (hidden)
		hiddenGuilds[guildKey] = true
	end

	guildBank.ContextualMenu:Close()
end

local function OnGuildDelete(frame, guildBank)
	local guildKey = frame.value
	local _, realm, guildName = strsplit(".", guildKey)
	
	AltoMessageBox:Ask(format("%s\n%s%s %s(%s)", L["Delete Guild Bank?"], colors.green, guildName, colors.white, realm), function() 
		DataStore:DeleteGuildBank(guildKey)
	
		addon:Print(format( L["Guild %s successfully deleted"], guildName))
	
		AltoholicFrame.TabGuild.Panels.Bank:Update()
	end)
	
	guildBank.ContextualMenu:Close()
end

local function OnGuildBankTabChange(frame, guildBank)
	guildBank:SetCurrentBankTab(frame.value)
	guildBank:Update()
end

local function OnBankTabRemoteUpdate(frame, guildBank)
	local tabName = DataStore:GetGuildBankTabName(guildBank:GetCurrentGuild(), guildBank:GetCurrentBankTab())
	local member = frame.value
	
	addon:Print(format(L["Requesting %s information from %s"], tabName, member ))
	DataStore:RequestGuildMemberBankTab(member, tabName)
end

local function OnRarityChange(frame, guildBank)
	local rarity = frame.value

	Altoholic_GuildTab_Options.BankItemsRarity = rarity
	
	guildBank.MenuIcons.RarityIcon:SetRarity(rarity)
	guildBank:Update()
end


-- ** Menu Icons **

local function GuildIcon_Initialize(frame, level)
	local guildBank = frame:GetParent()
	local guildKey = guildBank:GetCurrentGuild()
	local guildName = select(3, strsplit(".", guildKey))
	local hideInTooltip = Altoholic_Tooltip_Options.HiddenGuilds[guildKey] or false
	
	frame:AddTitle(guildName)
	frame:AddButtonWithArgs(format("%s%s", colors.white, L["Hide this guild in the tooltip"]), guildKey, OnHideInTooltip, guildBank, nil, (hideInTooltip == true))
	frame:AddButtonWithArgs(format("%s%s", colors.white, DELETE), guildKey, OnGuildDelete, guildBank)
	frame:AddCloseMenu()
end

local function TabsIcon_Initialize(frame, level)
	local guildBank = frame:GetParent()
	local guildKey = guildBank:GetCurrentGuild()
	local bankTab = guildBank:GetCurrentBankTab()

	frame:AddTitle(L["Guild Bank Tabs"])
	
	for tabID = 1, MAX_BANK_TABS do 
		local tabName = DataStore:GetGuildBankTabName(guildKey, tabID)
		
		if tabName then
			local info = frame:CreateInfo()
			
			info.text = tabName
			info.value = tabID
			info.func = OnGuildBankTabChange
			info.icon = DataStore:GetGuildBankTabIcon(guildKey, tabID)
			info.checked = (bankTab == tabID)
			info.arg1 = guildBank
			
			frame:AddButtonInfo(info)
		end
	end
	frame:AddCloseMenu()
end

local function UpdateIcon_Initialize(frame, level)
	local guildBank = frame:GetParent()
	local guildKey = guildBank:GetCurrentGuild()
	local bankTab = guildBank:GetCurrentBankTab()

	if not guildKey or not bankTab or bankTab == 0 then return end
	
	local tabName = DataStore:GetGuildBankTabName(guildKey, bankTab)
	if not tabName then return end
	
	local player = UnitName("player")
	local myClientTime = DataStore:GetGuildMemberBankTabInfo(player, tabName)
	
	local older = {}
	local newer = {}
	
	frame:AddTitle(L["Update current tab from"])
	for member in pairs(DataStore:GetGuildBankTabSuppliers()) do
		if member ~= player then	-- skip current player
			local clientTime = DataStore:GetGuildMemberBankTabInfo(member, tabName)
				
			if clientTime then	-- if there's data, we can add this member in the view for the current bank tab
				if clientTime > myClientTime then
					table.insert(newer, { name = member, timeStamp = clientTime } )
				else
					table.insert(older, { name = member, timeStamp = clientTime } )
				end
			end
		end
	end
	
	if #newer > 0 then
		frame:AddTitle(" ")
		frame:AddTitle(format("%s%s", colors.yellow, L["Newer data"]))
		
		table.sort(newer, function(a,b) return a.timeStamp > b.timeStamp end)
		
		local info = frame:CreateInfo()
		
		for _, member in ipairs(newer) do
			local clientTime = DataStore:GetGuildMemberBankTabInfo(member.name, tabName)
		
			info.text = format("%s%s %s%s", colors.white, member.name, colors.green, date("%m/%d/%Y %H:%M", clientTime))
			info.value = member.name
			info.func = OnBankTabRemoteUpdate
			info.arg1 = guildBank
			frame:AddButtonInfo(info)
		end
	end

	if #older > 0 then
		frame:AddTitle(" ")
		frame:AddTitle(format("%s%s", colors.yellow, L["Older data"]))
		
		table.sort(older, function(a,b) return a.timeStamp > b.timeStamp end)
		
		local info = frame:CreateInfo()
		
		for _, member in ipairs(older) do
			local clientTime = DataStore:GetGuildMemberBankTabInfo(member.name, tabName)
			
			info.text = format("%s%s %s%s", colors.white, member.name, colors.green, date("%m/%d/%Y %H:%M", clientTime))
			info.value = member.name
			info.func = OnBankTabRemoteUpdate
			info.arg1 = guildBank
			frame:AddButtonInfo(info)
		end
	end

	frame:AddCloseMenu()
end

local function RarityIcon_Initialize(frame, level)
	local rarity = Altoholic_GuildTab_Options.BankItemsRarity
	
	local guildBank = frame:GetParent()
	
	frame:AddTitle(format("|r%s", RARITY))
	
	-- Add the 'Any rarity' option
	frame:AddButtonWithArgs(L["Any"], 0, OnRarityChange, guildBank, nil, (rarity == 0))

	-- Add the rarity levels higher than green (Quality: 0 = poor, 5 = legendary)
	for i = 2, 6 do
		frame:AddButtonWithArgs(format("%s%s", ITEM_QUALITY_COLORS[i].hex, _G[format("ITEM_QUALITY%d_DESC", i)]), i, OnRarityChange, guildBank, nil, (rarity == i))
	end

	frame:AddCloseMenu()
end

local menuIconCallbacks = {
	GuildIcon_Initialize,
	TabsIcon_Initialize,
	UpdateIcon_Initialize,
	RarityIcon_Initialize,
}

addon:Controller("AltoholicUI.GuildBankIcon", {
	Icon_OnEnter = function(frame)
		local currentMenuID = frame:GetID()
		
		local guildBank = frame:GetParent():GetParent()
		local menu = guildBank.ContextualMenu
		
		menu:Initialize(menuIconCallbacks[currentMenuID], "LIST")
		menu:Close()
		menu:Toggle(frame, 0, 0)
	end,
	SetRarity = function(frame, rarity)
		-- technically, this will only be applied to the rarity icon, but I'll settle for a function a this level.
		
		if rarityIcons[rarity] then
			frame.Icon:SetTexture(rarityIcons[rarity])
		end
	end,
})
