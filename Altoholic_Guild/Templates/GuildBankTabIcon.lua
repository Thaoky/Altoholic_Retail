local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.GuildBankTabIcon", {
	Icon_OnEnter = function(frame)
		local parent = frame:GetParent()
		local guildKey = parent:GetCurrentGuild()
		
		local tabName = DataStore:GetGuildBankTabName(guildKey, frame:GetID())
		if not tabName then return end
		
		AddonFactory_Tooltip:ShowAtCursor(frame, function(tt)
			tt:AddLine(tabName)
		end)
	end,
	
	Icon_OnClick = function(frame, button)
		local guildBank = frame:GetParent()
		
		guildBank:SetCurrentBankTab(frame:GetID())
		guildBank:Update()
	end,
})
