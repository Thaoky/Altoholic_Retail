local addonName = "Altoholic"
local addon = _G[addonName]

local L = AddonFactory:GetLocale(addonName)

addon:Controller("AltoholicUI.TabOptions.AuthorizedClientsRow", { "AltoholicUI.Authorization", function(Authorization)
	return {
		OnBind = function(frame)
		
			frame.Ask.tooltipText = L["Ask"]
			frame.Ask.tooltipRequirement = L["ACCOUNT_SHARING_AUTH_ASK"]
			frame.Auto.tooltipText = L["Auto"]
			frame.Auto.tooltipRequirement = L["ACCOUNT_SHARING_AUTH_AUTO"]
			frame.Never.tooltipText = NEVER
			frame.Never.tooltipRequirement = L["ACCOUNT_SHARING_AUTH_NEVER"]
		
		end,
		CheckButton_OnClick = function(frame, auth)
			local line = frame:GetID() 
			local name = Authorization.GetClientInfo(line)
			
			Authorization.UpdateClient(name, auth)

			frame:GetParent():GetParent():GetParent():Update()
		end,
	}
end})