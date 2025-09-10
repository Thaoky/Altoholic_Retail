local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.TabOptions.SettingsAltoholicTooltip", function()

	return {
		__Parent = AltoholicFrame.TabOptions,
	
		OnBind = function(frame, parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel(3, frame)

			-- Setup localization & clear localized value after use (no longer needed)
			local L = AddonFactory:GetLocale(addonName)
			local colors = AddonFactory.Colors
			
			frame.Title:SetText(format("%s%s", colors.white, L["Tooltip Options"]))
			L["Tooltip Options"] = nil

		end,
		Update = function(frame, isResizing)
			local options = Altoholic_Tooltip_Options
			
			frame.ShowItemSource:SetChecked(options.ShowItemSource)
			frame.ShowItemCount:SetChecked(options.ShowItemCount)
			frame.ShowSimpleCount:SetChecked(options.ShowSimpleCount)
			frame.ShowTotalItemCount:SetChecked(options.ShowTotalItemCount)
			frame.ShowKnownRecipes:SetChecked(options.ShowKnownRecipes)
			
			frame.ShowItemID:SetChecked(options.ShowItemID)
			frame.ShowGatheringNodesCount:SetChecked(options.ShowGatheringNodesCount)
			frame.ShowCrossFactionCount:SetChecked(options.ShowCrossFactionCount)
			frame.ShowMergedRealmsCount:SetChecked(options.ShowMergedRealmsCount)
			frame.ShowAllRealmsCount:SetChecked(options.ShowAllRealmsCount)
			frame.ShowAllAccountsCount:SetChecked(options.ShowAllAccountsCount)
			
			frame.ShowAccountBankCount:SetChecked(options.ShowAccountBankCount)
			frame.ShowGuildBankCount:SetChecked(options.ShowGuildBankCount)
			frame.ShowGuildBankRealm:SetChecked(options.ShowGuildBankRealm)
			frame.IncludeGuildBankInTotal:SetChecked(options.IncludeGuildBankInTotal)
			frame.ShowGuildBankCountPerTab:SetChecked(options.ShowGuildBankCountPerTab)
			frame.ShowHearthstoneCount:SetChecked(options.ShowHearthstoneCount)
			frame.ShowItemXPack:SetChecked(options.ShowItemXPack)
			frame.ShowCouldBeStoredOn:SetChecked(options.ShowCouldBeStoredOn)
			frame.ShowCurrenciesCount:SetChecked(options.ShowCurrenciesCount)
			
			frame:Show()
		end,
}end)
