local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors
local icons = AddonFactory.Icons

local L = AddonFactory:GetLocale(addonName)

addon:Controller("AltoholicUI.TabOptions.SharingContent", { "AltoholicUI.SharedContent", "AltoholicUI.SharedContentView", function(SharedContent, View)
	
	return {
		__Parent = AltoholicFrame.TabOptions,
	
		OnBind = function(frame, parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel(21, frame)

			-- Setup localization & clear localized value after use (no longer needed)
			frame.Title:SetText(format("%s%s", colors.white, L["Shared Content"]))
			frame.Info:SetText(L["SHARED_CONTENT_INFO"])
		end,
		
		ToggleAll = function(frame, isCollapsed)
			SharedContent.ToggleAll(isCollapsed)
			frame:Update()
		end,
		
		CheckAll = function(frame, button)
			-- are all entries checked or not ?
			if not button.isChecked then
				button.isChecked = true
			else
				button.isChecked = nil
			end
			button:SetChecked(button.isChecked)
			
			SharedContent.CheckAll(button.isChecked)
			frame:Update()
		end,
		
		Update = function(frame, isResizing)
			if not View.IsValid() then
				SharedContent.BuildView()
			end
		
			local scrollFrame = frame.ContentContainer.ScrollFrame
			local numRows = scrollFrame.numRows
			local viewSize = View.GetSize() 
			local offset = scrollFrame:GetOffset()
			
			for rowIndex = 1, numRows do
				local rowFrame = scrollFrame:GetRow(rowIndex)
				local line = rowIndex + offset
				
				if line <= viewSize then
					rowFrame:DrawCollapseButton(line)
					rowFrame:DrawCheckBox(line)
					
					rowFrame:SetID(line)
					rowFrame:Show()
				else
					rowFrame:SetID(0)
					rowFrame:Hide()
				end
			end

			scrollFrame:Update((viewSize < numRows) and numRows or viewSize)
			
			frame:Show()
		end,
	}
end})
