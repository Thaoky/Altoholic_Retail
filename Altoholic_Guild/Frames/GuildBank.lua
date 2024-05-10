local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.TabGuild.Bank", { "AltoholicUI.Formatter", function(Formatter)

	local colors = addon.Colors
	local L = DataStore:GetLocale(addonName)
	local MAX_BANK_TABS = 8

	local currentGuildKey
	local currentGuildBankTab = 0

	local function HideRows(frame)
		for _, row in pairs(frame.ItemRows) do
			row:Hide()
		end
	end

	return {
		OnBind = function(frame)
			local parent = AltoholicFrame.TabGuild
			
			frame:SetParent(parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel("Bank", frame)	
			parent:Update()		
		
			local menuIcons = frame.MenuIcons
			-- menuIcons.RarityIcon:SetRarity(Altoholic_GuildTab_Options["BankItemsRarity"])
			menuIcons.RarityIcon:SetRarity(0)
				
			-- load the drop down with a guild
			local currentGuild = GetGuildInfo("player")
			
			-- if the player is not in a guild, set the drop down to the first available guild on this realm, if any.
			if not currentGuild then
				-- if the guild that will be displayed is not the one the current player is in, then disable the button
				menuIcons.UpdateIcon:Disable()
				menuIcons.UpdateIcon.Icon:SetDesaturated(true)
			
				-- Get this realms/this account's guilds
				for guildName, guild in pairs(DataStore:GetGuilds()) do
					local money = DataStore:GetGuildBankMoney(guild)
					if money then		-- if money is not nil, the guild bank has been populated
						currentGuild = guildName
						break	-- if there's at least one guild, let's set the right value and break immediately
					end
				end
			end
			
			-- if the current guild or at least a guild on this realm was found, then set the right values
			if currentGuild then
				currentGuildKey = DataStore:GetThisGuildKey()

				-- pick the first available tab
				for i = 1, MAX_BANK_TABS do 
					local tabName = DataStore:GetGuildBankTabName(currentGuildKey, i)
					if tabName then
						currentGuildBankTab = i
						break
					end
				end
			end
			
			frame:UpdateBankTabButtons()
		end,
		Update = function(frame)
			if not currentGuildKey or not currentGuildBankTab then		-- no tab found ? exit
				HideRows(frame)
				return 
			end
			
			local tab = DataStore:GetGuildBankTab(currentGuildKey, currentGuildBankTab)
			if not tab or not tab.name then			-- tab not yet scanned ? exit
				HideRows(frame)
				return 
			end		
			
			local _, _, guildName = strsplit(".", currentGuildKey)
			local parent = frame:GetParent()
			parent:SetStatus(format("%s%s|r / %s%s|r / %s%s", colors.white, L["GUILD_BANKS"], colors.green, guildName, colors.gold, tab.name ))
			
			frame.Info1:SetText(format(L["GUILD_BANK_LAST_VISIT_BY"], colors.gold, colors.green, tab.ClientDate, colors.green, tab.visitedBy))

			local localTime = format("%s%02d%s:%s%02d", colors.green, tab.ClientHour, colors.white, colors.green, tab.ClientMinute )
			local realmTime = format("%s%02d%s:%s%02d", colors.green, tab.ServerHour, colors.white, colors.green, tab.ServerMinute )
			frame.Info2:SetText(format("%s%s   %s%s", 
				colors.gold, format(L["GUILD_BANK_LOCAL_TIME"], colors.green, localTime),
				colors.gold, format(L["GUILD_BANK_REALM_TIME"], colors.green, realmTime)))
			
			local money = DataStore:GetGuildBankMoney(currentGuildKey)
			frame.Info3:SetText(format("%s%s: %s", colors.gold, MONEY, Formatter.MoneyString(money or 0, colors.white)))
			
			local rarity = Altoholic_GuildTab_Options["BankItemsRarity"]
			
			local numGuildBankRows = #frame.ItemRows
			
			for _, row in pairs(frame.ItemRows) do
				local from = mod(row:GetID(), numGuildBankRows)
				if from == 0 then from = numGuildBankRows end
			
				for _, itemButton in pairs(row.Items) do
					local itemIndex = from + ((itemButton:GetID() - 1) * numGuildBankRows)
					local itemID, itemLink, itemCount, isBattlePet = DataStore:GetSlotInfo(tab, itemIndex)
					
					itemButton:SetItem(itemID, itemLink, rarity)
					itemButton:SetCount(itemCount)
					-- if isBattlePet then
						-- itemButton:SetIcon(itemID)	-- override the icon if one is returned by datastore
					-- end
					itemButton:Show()
				end
				row:Show()
			end
			
			frame:Show()
		end,
		UpdateBankTabButtons = function(frame)
			if not currentGuildKey then return end
			
			for _, button in pairs(frame.TabButtons) do
				local id = button:GetID()
				local tabName = DataStore:GetGuildBankTabName(currentGuildKey, id)
			
				if tabName then
					local icon = DataStore:GetGuildBankTabIcon(currentGuildKey, id)
					local iconNumber = tonumber(icon)
					
					button.Icon:SetTexture(iconNumber or icon)
					button:Show()
				else
					button:Hide()
				end
			end
		end,
		
		GetCurrentGuild = function(frame)
			return currentGuildKey
		end,
		SetCurrentGuild = function(frame, newGuild)
			currentGuildKey = newGuild
		end,
		GetCurrentBankTab = function(frame)
			return currentGuildBankTab
		end,
		SetCurrentBankTab = function(frame, newBankTab)
			currentGuildBankTab = newBankTab
		end,
}end})
