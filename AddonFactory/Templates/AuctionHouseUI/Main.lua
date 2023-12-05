local MVC = LibStub("LibMVC-1.0")

local function SafeLoadAddOn(name)
	if not IsAddOnLoaded(name) then
		LoadAddOn(name)
	end
end

MVC:Controller("AddonFactory.AuctionHouseMainFrame", {
	OnBind = function(frame)
		frame:SetPortraitToUnit("player")
	
		frame:RegisterForDrag("LeftButton")
		frame:SetScript("OnDragStart", function() frame:StartMoving() end)
		frame:SetScript("OnDragStop", function() frame:StopMovingOrSizing() end)
		
		-- Create the resize button
		local resizeButton = CreateFrame("Button", nil, frame)
		resizeButton:SetPoint("BOTTOMRIGHT", -6, 7)
		resizeButton:SetSize(16, 16)
		resizeButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
		resizeButton:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
		resizeButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
		
		resizeButton:SetScript("OnMouseDown", function() 
			local width = frame:GetWidth()
			local height = frame:GetHeight()			
			
			frame:StartSizing("BOTTOMRIGHT")
			frame.isSizing = true
			
			-- Resetting size
			frame:SetWidth(frame.lastWidth or width)
			frame:SetHeight(frame.lastHeight or height)
		end)
		
		resizeButton:SetScript("OnMouseUp", function() 
			frame:StopMovingOrSizing()
			frame.isSizing = false
		end)		
		
		frame:SetScript("OnUpdate", function(self, elapsed) 
			if frame.isSizing == true then 
				frame:LimitFrameSize()
			end
		end)
	end,
	
	LimitFrameSize = function(frame)
		local width = frame:GetWidth()
		local height = frame:GetHeight()

		-- Limit the window size
		if width < frame.minWidth then frame:SetWidth(frame.minWidth) end
		if width > frame.maxWidth then frame:SetWidth(frame.maxWidth) end
		if height < frame.minHeight then frame:SetHeight(frame.minHeight) end
		if height > frame.maxHeight then frame:SetHeight(frame.maxHeight) end
		
		frame.lastWidth = frame:GetWidth()
		frame.lastHeight = frame:GetHeight()	
	end,
	
	Initialize = function(frame, options)
		-- don't go lower than the minimum
		frame.minWidth = (options.minWidth and options.minWidth >= 200) and options.minWidth or 200
		frame.minHeight = (options.minHeight and options.minHeight >= 200) and options.minHeight or 200

		-- don't go higher than the maximum
		frame.maxWidth = (options.maxWidth and options.maxWidth <= GetScreenWidth()) and options.maxWidth or GetScreenWidth()
		frame.maxHeight = (options.maxHeight and options.maxHeight <= GetScreenHeight()) and options.maxHeight or GetScreenHeight()
		
		frame.silent = options.silent
		
		if options.closeOnESC == true then
			-- Allow ESC to close the main frame
			table.insert(UISpecialFrames, frame:GetName())
		end
	end,
	-- deprecated in 10.0
	-- SetTitle = function(frame, title)
		-- frame.Title:SetText(title)
	-- end,
	ToggleUI = function(frame)
		if frame:IsVisible() then
			frame:Hide()
		else
			frame:Show()
		end
	end,
	SetTabs = function(frame, parent, tabs)
		--[[	Usage:
				self:SetTabs("MyAddonFrame", {
					{ name = "Tab 1", onClick = function() print("tab 1 !!") end },
					{ name = "Tab 2", onClick = function() print("tab 2 !!") end },
					{ name = "Tab 3", onClick = function() print("tab 3 !!") end },
				})
		--]]
		
		-- Note 1 : frame.Tabs must exist, it is expected by Blizzard's functions
		frame.Tabs = frame.Tabs or {}
		frame.TabInfo = tabs
	
		for i, tabData in ipairs(tabs) do
			-- Create the tab button
			-- Note 2 : tab buttons must have a name, also expected.
			local tab = CreateFrame("Button", format("%sTab%d", parent, i), frame, "CharacterFrameTabTemplate")
			-- manual insert not needed anymore in 10.0
			-- table.insert(frame.Tabs, tab)
			
			-- Set ID & Name
			tab:SetID(i)
			tab:SetText(tabData.name)
			
			-- Set the OnClick
			tab:SetScript("OnClick", function(self, button) 
				frame:SwitchToTab(self:GetID(), button)
			end)		
			
			-- Anchor the button
			if i == 1 then
				tab:SetPoint("BOTTOMLEFT", 20, -28)
			else
				tab:SetPoint("TOPLEFT", frame.Tabs[i-1], "TOPRIGHT", 30, 0)
			end
		end

		-- Set the amount of tabs
		PanelTemplates_SetNumTabs(frame, #tabs)
		
		-- Activate the first tab
		PanelTemplates_SetTab(frame, 1)
	end,
	SwitchToTab = function(frame, tabID, button)
		local info
		
		-- tabID can be numeric (the actual tab ID) or the name passed in the info table
		if type(tabID) == "number" then
			info = frame.TabInfo[tabID]
		elseif type(tabID) == "string" then
			-- find the tab with the right name
			for index, tabData in pairs(frame.TabInfo) do
				if tabData.id == tabID then		-- id is not localized, but .name is.
					info = tabData
					tabID = index
					break
				end
			end
		end
	
		if not info then 
			addon:Print(format("No configuration found for tab id %d", tabID))
			return 
		end
		
		PanelTemplates_SetTab(frame, tabID)
		
		-- Load add-on
		if info.loadOnDemand then
			SafeLoadAddOn(info.loadOnDemand)
		end

		-- Hide all except current
		for _, tabFrame in pairs(frame.TabFrames) do
			if tabFrame:GetID() == tabID then
				tabFrame:Show()
			else
				tabFrame:Hide()
			end
		end

		-- call the onClick callback
		if info.onClick then
			info.onClick(self, button)
		end		
	end,
})
