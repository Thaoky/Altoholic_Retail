local addonName = ...
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local function OnRealmChange(frame, dropDownFrame)
	local oldAccount, oldRealm = dropDownFrame:GetCurrentRealm()
	local newAccount, newRealm = strsplit("|", frame.value)
	
	dropDownFrame:SetCurrentRealm(newRealm, newAccount)

	if oldRealm and oldAccount then	-- clear the "select char" drop down if realm or account has changed
		if oldRealm ~= newRealm or oldAccount ~= newAccount then
			dropDownFrame:TriggerClassEvent("RealmChanged", newAccount, newRealm)
		end
	end
end

addon:Controller("AltoholicUI.RealmPicker", {
	OnBind = function(frame)
		frame:SetMenuWidth(frame.menuWidth) 
		frame:SetButtonWidth(20)
		frame:Initialize(frame.DropDownRealm_Initialize)
		frame:SetCurrentRealm(GetRealmName())
	end,
	DropDownRealm_Initialize = function(frame)
		if not frame.currentAccount or not frame.currentRealm then return end

		-- this account first ..
		frame:AddTitle(format("%s%s", colors.gold, L["This account"]))
		for realm in pairs(DataStore:GetRealms()) do
			local info = frame:CreateInfo()

			info.text = format("%s%s", colors.white, realm)
			info.value = format("%s|%s", DataStore.ThisAccount, realm) 
			info.checked = nil
			info.func = OnRealmChange
			info.arg1 = frame
			frame:AddButtonInfo(info, 1)
		end

		-- .. then all other accounts
		local accounts = DataStore:GetAccounts()
		local count = 0
		for account in pairs(accounts) do
			if account ~= DataStore.ThisAccount then
				count = count + 1
			end
		end
		
		if count > 0 then
			frame:AddTitle()
			frame:AddTitle(format("%s%s", colors.gold, OTHER))
			
			for account in pairs(accounts) do
				if account ~= DataStore.ThisAccount then
					for realm in pairs(DataStore:GetRealms(account)) do
						local info = frame:CreateInfo()
						info.text = format("%s%s: %s%s", colors.green, account, colors.white, realm)
						info.value = format("%s|%s", account, realm)
						info.checked = nil
						info.func = OnRealmChange
						info.arg1 = frame
						frame:AddButtonInfo(info, 1)
					end
				end
			end
		end
		
		frame:TriggerClassEvent("DropDownInitialized")
	end,
	SetCurrentRealm = function(frame, realm, account)
		account = account or DataStore.ThisAccount

		frame.currentAccount = account
		frame.currentRealm = realm
		frame:SetSelectedValue(format("%s|%s", account, realm))
		frame:SetText(format("%s%s: %s%s", colors.green, account, colors.white, realm))
	end,
	GetCurrentRealm = function(frame)
		return frame.currentAccount, frame.currentRealm
	end,
})
