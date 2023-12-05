local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

addon:Controller("AltoholicUI.TabGrids.Grids", function()
	return {
		OnBind = function(frame)
			local parent = AltoholicFrame.TabGrids
			
			frame:SetParent(parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel("Grids", frame)
			
			-- Handle resize
			frame:SetScript("OnSizeChanged", function(self, width, height)
				if not frame:IsVisible() then return end
			
				frame:Update(true)
			end)
		end,
		
		PreUpdate = function(frame)
			local parent = frame:GetParent()
			
			local obj = parent:GetCurrentGridObject()	-- point to the callbacks of the current object (equipment, tabards, ..)
			
			if obj and obj.InvalidateView then
				obj:InvalidateView()
			end
		end,
		
		Update = function(frame, isResizing)
			local parent = frame:GetParent()
			local obj = parent:GetCurrentGridObject()	-- point to the callbacks of the current object (equipment, tabards, ..)
			if not obj then return end			-- this may happen when a character is changed via the class icons, and no panel is displayed.
			
			local scrollFrame = frame.ScrollFrame
			local numRows = scrollFrame.numRows
			local offset = scrollFrame:GetOffset()

			local maxDisplayedRows = math.floor(scrollFrame:GetHeight() / 38)
			-- print(format("frame height: %d, width: %d", frame:GetHeight(), frame:GetWidth()))
			
			if obj.OnUpdate then
				obj:OnUpdate()
			end

			local categorySize = obj:GetSize()
			local realm, account = parent:GetRealm()
			local page = parent:GetPage()
			
			-- Set status is done in each grid
			-- parent:SetStatus("")
			
			for rowIndex = 1, numRows do
				local rowFrame = scrollFrame:GetRow(rowIndex)
				local line = rowIndex + offset
				
				if line <= categorySize and (rowIndex <= maxDisplayedRows) then	-- if the line is visible
					if not (isResizing and rowFrame:IsVisible()) then
						obj:RowSetup(rowFrame, line)
					
						-- Set the row label
						local itemButton = rowFrame.Name
						itemButton:SetScript("OnEnter", obj.RowOnEnter or addon.EmptyFunc)
						itemButton:SetScript("OnLeave", obj.RowOnLeave or addon.EmptyFunc)

						rowFrame:Update(account, realm, page, obj, line)
						rowFrame:Show()
					end
				else
					rowFrame:Hide()
				end
			end
			
			-- categorySize = number of items in the list
			-- maxDisplayedRows = number of items that will actually be displayed
			scrollFrame:Update(categorySize, maxDisplayedRows)
			frame:Show()
			
			frame.lastMaxDisplayedRows = maxDisplayedRows
		end,
	
		CheckForResize = function(frame)
			-- Check if a resize happened while viewing another tab
			
			if not frame.lastMaxDisplayedRows then return end
			
			local maxDisplayedRows = math.floor(frame.ScrollFrame:GetHeight() / 38)
			
			-- it the last number of rows we displayed is not identical to the current frame size.. we need to refresh
			if (maxDisplayedRows ~= frame.lastMaxDisplayedRows) then
				frame:Update()
			end
		end,
	}
end)
