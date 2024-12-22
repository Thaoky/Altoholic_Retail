local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

local L = AddonFactory:GetLocale(addonName)

addon:Controller("AltoholicUI.TabOptions.SharedContentRow", { "AltoholicUI.SharedContent", "AltoholicUI.SharedContentView", function(SharedContent, View)
	return {
		OnBind = function(frame)
		end,
		
		-- ** Collapse Button **
		Collapse_OnClick = function(frame)
			local index = View.GetLineDataKey(frame:GetID())
			
			SharedContent.ToggleHeader(index)
			View:Invalidate()
			
			frame:GetParent():GetParent():Update()
		end,
		DrawCollapseButton = function(frame, line)
			local button = frame.Collapse

			if not View.IsHeaderLine(line) then
				button:Hide()
				return
			end
		
			-- only work with guild or character headers.
			local index = View.GetLineDataKey(line)
			
			if not SharedContent.IsHeaderCollapsed(index) then
				button:SetExpanded()
			else
				button:SetCollapsed()
			end
			button:Show()
		end,
		
		-- ** Check box **
		CheckButton_OnClick = function(frame, checkButton)
			local index = View.GetLineDataKey(frame:GetID())

			SharedContent.Share(index, checkButton:GetChecked())
			View:Invalidate()
			
			frame:GetParent():GetParent():Update()
		end,
		DrawCheckBox = function(frame, line)
			-- Set the checkbox
			frame.Check:SetChecked(SharedContent.IsContentShared(line))
			frame.Check:SetPoint("TOPLEFT", View.GetLine(line).offset, 0)
			
			-- Set the text
			frame.Check.Text:SetWidth(400)
			frame.Check.Text:SetText(View.GetText(line))
		end,
	}
end})