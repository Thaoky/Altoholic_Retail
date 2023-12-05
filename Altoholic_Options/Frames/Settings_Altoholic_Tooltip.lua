local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.TabOptions.SettingsAltoholicTooltip", { "AltoholicUI.Options", function(Options)

	return {
		OnBind = function(frame)
			-- Attach to the parent
			local parent = AltoholicFrame.TabOptions
			
			frame:SetParent(parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel(3, frame)

			-- Setup localization & clear localized value after use (no longer needed)
			local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
			local colors = addon.Colors
			
			frame.Title:SetText(format("%s%s", colors.white, L["Tooltip Options"]))
			L["Tooltip Options"] = nil

		end,
		Update = function(frame, isResizing)
			frame.ShowItemSource:SetChecked(Options.Get("UI.Tooltip.ShowItemSource"))
			frame.ShowItemCount:SetChecked(Options.Get("UI.Tooltip.ShowItemCount"))
			frame.ShowSimpleCount:SetChecked(Options.Get("UI.Tooltip.ShowSimpleCount"))
			frame.ShowTotalItemCount:SetChecked(Options.Get("UI.Tooltip.ShowTotalItemCount"))
			frame.ShowKnownRecipes:SetChecked(Options.Get("UI.Tooltip.ShowKnownRecipes"))
			
			frame.ShowItemID:SetChecked(Options.Get("UI.Tooltip.ShowItemID"))
			frame.ShowGatheringNodesCount:SetChecked(Options.Get("UI.Tooltip.ShowGatheringNodesCount"))
			frame.ShowCrossFactionCount:SetChecked(Options.Get("UI.Tooltip.ShowCrossFactionCount"))
			frame.ShowMergedRealmsCount:SetChecked(Options.Get("UI.Tooltip.ShowMergedRealmsCount"))
			frame.ShowAllRealmsCount:SetChecked(Options.Get("UI.Tooltip.ShowAllRealmsCount"))
			frame.ShowAllAccountsCount:SetChecked(Options.Get("UI.Tooltip.ShowAllAccountsCount"))
			
			frame.ShowGuildBankCount:SetChecked(Options.Get("UI.Tooltip.ShowGuildBankCount"))
			frame.ShowGuildBankRealm:SetChecked(Options.Get("UI.Tooltip.ShowGuildBankRealm"))
			frame.IncludeGuildBankInTotal:SetChecked(Options.Get("UI.Tooltip.IncludeGuildBankInTotal"))
			frame.ShowGuildBankCountPerTab:SetChecked(Options.Get("UI.Tooltip.ShowGuildBankCountPerTab"))
			frame.ShowHearthstoneCount:SetChecked(Options.Get("UI.Tooltip.ShowHearthstoneCount"))
			frame.ShowItemXPack:SetChecked(Options.Get("UI.Tooltip.ShowItemXPack"))
			frame.ShowCouldBeStoredOn:SetChecked(Options.Get("UI.Tooltip.ShowCouldBeStoredOn"))
			
			frame:Show()
		end,
	}
end})
