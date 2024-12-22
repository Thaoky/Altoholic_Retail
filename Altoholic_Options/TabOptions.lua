local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

local L = AddonFactory:GetLocale(addonName)

local tab		-- small shortcut to easily address the frame (set in OnBind)

addon:Controller("AltoholicUI.TabOptions", { "AddonFactory.Classes", function(oop)
	return oop:New("AuctionHouseUI.Tab", {
		OnBind = function(frame)
			tab = frame
			
			frame.URLInfo:SetText(L["CTRL_C_TO_COPY"])
		end,
		SetHelp = function(frame, helpID)
		
			local panel = frame.Panels[30]	-- SetHelp is only for this panel
			panel:SetHelp(helpID)
		end,
	})
end})

local function Settings_OnClick(categoryData)
	tab:SetCurrentPanel(categoryData.panel)
	tab:Update()
end

local function Help_OnClick(categoryData)
	tab:SetCurrentPanel(categoryData.panel)
	tab:SetHelp(categoryData.helpID)
	tab:Update()
end

addon:Controller("AltoholicUI.TabOptionsCategoriesList", {
	OnBind = function(frame)
		local helpPanelID = 30
	
		local categories = {
			{ text = L["Settings"], isExpanded = true, subMenu = {
				{ text = addonName, isExpanded = true, subMenu = {
					{ text = GENERAL, panel = 1, callback = Settings_OnClick },
					{ text = MAIL_LABEL, panel = 2, callback = Settings_OnClick },
					{ text = L["Tooltip"], panel = 3, callback = Settings_OnClick },
					{ text = L["Calendar"], panel = 4, callback = Settings_OnClick },
					{ text = MISCELLANEOUS, panel = 5, callback = Settings_OnClick },
				}},
				{ text = "DataStore", subMenu = {
					{ text = "Auctions", panel = 10, callback = Settings_OnClick },
					{ text = "Characters", panel = 11, callback = Settings_OnClick },
					{ text = "Garrisons", panel = 12, callback = Settings_OnClick },
					{ text = "Inventory", panel = 13, callback = Settings_OnClick },
					{ text = "Mails", panel = 14, callback = Settings_OnClick },
					{ text = "Quests", panel = 15, callback = Settings_OnClick },
				}},
			}},
			{ text = L["Account Sharing"], subMenu = {
				{ text = format("%s1|r. %s", colors.cyan, L["How to"]), panel = helpPanelID, helpID = 1, callback = Help_OnClick },
				{ text = format("%s2|r. %s", colors.cyan, L["Authorizations"]), panel = 20, callback = Settings_OnClick },
				{ text = format("%s3|r. %s", colors.cyan, L["Shared Content"]), panel = 21, callback = Settings_OnClick },
				{ text = format("%s4|r. %s%s|r !", colors.cyan, colors.green, L["Share"]), panel = 22, callback = Settings_OnClick },
			}},
			{ text = L["Memory used"], subMenu = {
				{ text = addonName, panel = helpPanelID, helpID = 9, callback = Help_OnClick },
				{ text = "DataStore", panel = helpPanelID, helpID = 10, callback = Help_OnClick },
			}},
			{ text = HELP_LABEL, subMenu = {
				{ text = addonName, subMenu = { 
					{ text = GENERAL, panel = helpPanelID, helpID = 2, callback = Help_OnClick },
					{ text = L["Characters"], panel = helpPanelID, helpID = 3, callback = Help_OnClick },
					{ text = L["Bank characters"], panel = helpPanelID, helpID = 11, callback = Help_OnClick },
					{ text = L["Alt groups"], panel = helpPanelID, helpID = 12, callback = Help_OnClick },
					{ text = SEARCH, panel = helpPanelID, helpID = 13, callback = Help_OnClick },
				}},
				{ text = "DataStore", subMenu = { 
					{ text = GENERAL, panel = helpPanelID, helpID = 4, callback = Help_OnClick },
					{ text = L["Saved Variables"], panel = helpPanelID, helpID = 5, callback = Help_OnClick },
				}},
				{ text = L["Getting support"], panel = helpPanelID, helpID = 6, callback = Help_OnClick },
			}},
			{ text = L["About"], subMenu = {
				{ text = addonName, panel = helpPanelID, helpID = 7, callback = Help_OnClick },
				{ text = "DataStore", panel = helpPanelID, helpID = 8, callback = Help_OnClick },
			}},
		}
	
		frame:SetCategories(categories)
	end,
})