local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors
local L = AddonFactory:GetLocale(addonName)

addon:Controller("AltoholicUI.GuildMemberRow", {
	SetMember = function(frame, playerName, color, isHeader)
		if isHeader then
			frame.Collapse:Show()
			frame.Name:SetPoint("TOPLEFT", 20, 0)
		else
			frame.Collapse:Hide()
			frame.Name:SetPoint("TOPLEFT", 10, 0)
		end

		frame.Name.Text:SetText(format("%s%s", color, playerName))
		frame.CharName = playerName
	end,
	SetMemberInfo = function(frame, level, averageItemLvl, version, class)
		frame.Level:SetText(format("%s%s", colors.green, level))
		if averageItemLvl then
			frame.AvgILevel.Text:SetText(format("%s%.1f", colors.yellow, averageItemLvl))
		else
			frame.AvgILevel.Text:SetText("")
		end
		frame.Version:SetText(format("%s%s", colors.white, version))
		frame.Class:SetText(class)
	end,
	Collapse_OnClick = function(frame)
		local rowID = frame:GetID()
		frame:GetParent():TogglePlayerAlts(rowID)
	end,
	Name_OnEnter = function(frame)
		local member = frame.CharName
		if not member then return end

		local name, rank, rankIndex, _, _, zone, note, officerNote, _, _, englishClass = DataStore:GetGuildMemberInfo(member)
		if name ~= member then return end
	  
		local tooltip = AddonFactory_Tooltip
		
		tooltip:ClearLines()
		tooltip:SetOwner(frame.Name, "ANCHOR_RIGHT")
		tooltip:AddLine(format("%s%s", DataStore:GetClassColor(englishClass), member),1,1,1)
		tooltip:AddLine(format("%s%s|r %d%s (%d)", colors.white, RANK_COLON, rank, colors.green, rankIndex))
		
		if zone then
			tooltip:AddLine(format("%s%s|r %s", colors.white, ZONE_COLON, zone))
		end
		
		if note then
			tooltip:AddLine(" ",1,1,1)
			tooltip:AddLine(format("%s%s:", colors.white, NOTE))
			tooltip:AddLine(note)
		end
		
		if officerNote then
			tooltip:AddLine(" ",1,1,1)
			tooltip:AddLine(format("%s%s:", colors.white, GUILD_OFFICER_NOTE))
			tooltip:AddLine(officerNote)
		end

		tooltip:Show()
	end,
	Level_OnEnter = function(frame)
		local member = frame.CharName
		if member == L["OFFLINE_MEMBERS"] then return end
		
		local _, _, _, _, _, _, _, _, _, _, englishClass = DataStore:GetGuildMemberInfo(member)
		local guild = DataStore:GetGuild()
		local averageItemLvl = DataStore:GetGuildMemberAverageItemLevel(guild, member) or 0
		
		local tooltip = AddonFactory_Tooltip
		
		tooltip:ClearLines()
		tooltip:SetOwner(frame, "ANCHOR_RIGHT")
		tooltip:AddLine(format("%s%s", DataStore:GetClassColor(englishClass), member), 1, 1, 1)
		tooltip:AddLine(format("%s%s: %s%s", colors.white, L["COLUMN_ILEVEL_TITLE"], colors.green, format("%.1f", averageItemLvl)), 1, 1, 1)

		-- addon:AiLTooltip()
		tooltip:AddLine(" ", 1, 1, 1)
		tooltip:AddLine(format("%s%s", colors.green, L["LEFT_CLICK_SEE_PLAYER_EQUIPMENT"]), 1, 1, 1)
		tooltip:Show()
	end,
	Level_OnClick = function(frame, button)
		if button ~= "LeftButton" then return end

		local rowID = frame:GetID()
		frame:GetParent():ShowPlayerEquipment(rowID, frame.CharName)
	end,
})
