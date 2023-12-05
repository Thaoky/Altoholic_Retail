local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.SummaryPaneButton", {
	SetColumnData = function(frame, character, column)
		-- Set basic properties
		frame:SetWidth(column.Width)
		frame.Text:SetWidth(column.Width)
		frame.Text:SetJustifyH(column.JustifyH)
		frame.Text:SetText(column.GetText(character))
		frame:Show()

		-- Set Scripts
		frame:SetScript("OnEnter", column.OnEnter or addon.EmptyFunc)
		frame:SetScript("OnClick", column.OnClick or addon.EmptyFunc)
	end,
	SetColumnTotal = function(frame, line, column)
		-- Set basic properties
		frame:SetWidth(column.Width)
		frame.Text:SetWidth(column.Width)
		
		if column.TotalJustifyH then
			frame.Text:SetJustifyH(column.TotalJustifyH)
		else
			frame.Text:SetJustifyH(column.JustifyH)
		end

		-- if column.GetTotal ~= EmptyFunc then
		if type(column.GetTotal) == "function" then
			frame.Text:SetText(column.GetTotal(line))
			frame:Show()
		else
			frame:Hide()
		end

		-- Set Scripts
		frame:SetScript("OnEnter", addon.EmptyFunc)
		frame:SetScript("OnClick", addon.EmptyFunc)
	end,
})
