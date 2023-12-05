local MVC = LibStub("LibMVC-1.0")

MVC:Controller("AddonFactory.AuctionHouseCategoryButton", {
	OnBind = function(frame)
		frame:SetPushedTextOffset(0, 0)
		
		frame:SetScript("OnEnter", function(self) 
			TruncatedTooltipScript_OnEnter(self)
			self.HighlightTexture:Show()
		end)
		
		frame:SetScript("OnLeave", function(self) 
			TruncatedTooltipScript_OnLeave(self)
			self.HighlightTexture:Hide()
		end)
		
		frame:SetScript("OnMouseDown", function(self) 
			self.Text:AdjustPointsOffset(1, -1)
		end)
		
		frame:SetScript("OnMouseUp", function(self) 
			self.Text:AdjustPointsOffset(-1, 1)
		end)
	end,
	
	SetData = function(frame, data)
		-- let the frame know to which data it is pointing
		frame.data = data
		
		-- let the data point back to a parent button
		if data then data._parentButton = frame end
	end,
	SetSelected = function(frame, data)
		if data.isSelected then
			frame.SelectedTexture:SetShown(true)
		else
			frame.SelectedTexture:SetShown(false)
		end
	end,
	
	Button_OnClick = function(frame, button)
		local data = frame.data
		if button ~= "LeftButton" or not data then return end

		if data.subMenu then
			-- toggle the subMenu
			if data.isExpanded then
				data.isExpanded = nil
			else
				data.isExpanded = true
			end
		end
		
		if data.callback then
			-- if a callback exists for this menu item, call it
			-- and pass a reference to both the data and the button itself 
			-- (could be useful to update the text of the button that has just been clicked)
			data.callback(data, frame)
		end
		
		-- Hide the selection on all buttons
		for _, menuButton in pairs(frame:GetParent().Buttons) do
			menuButton.SelectedTexture:SetShown(false)
		end
		
		local parent = frame:GetParent()

		-- Select only the category we just clicked
		if not data.subMenu then
			parent:UnselectAll()			-- only unselect all if we are actually 
			data.isSelected = true		-- going to select another item
		end
		
		parent:UpdateCategories()
	end,

	SetCategory = function(frame, text)
		frame:SetText(text)
		frame.Text:SetPoint("LEFT", frame, "LEFT", 8, 0)
		frame.Lines:Hide()
		frame:SetNormalFontObject(GameFontNormalSmall)
		
		local texture = frame.NormalTexture
		texture:SetAtlas("auctionhouse-nav-button", false)
		texture:SetSize(156,32)
		texture:ClearAllPoints()
		texture:SetPoint("TOPLEFT", -2, 0)
		texture:SetAlpha(1.0)
		
		texture = frame.SelectedTexture
		texture:SetAtlas("auctionhouse-nav-button-select", false)
		texture:SetSize(152,21)
		texture:ClearAllPoints()
		texture:SetPoint("CENTER")
	
		texture = frame.HighlightTexture
		texture:SetAtlas("auctionhouse-nav-button-highlight", false)
		texture:SetSize(152,21)
		texture:ClearAllPoints()
		texture:SetPoint("CENTER")
		texture:SetBlendMode("BLEND")
		
		frame:Show()
	end,
	SetSubCategory = function(frame, text)
		frame:SetText(text)
		frame.Text:SetPoint("LEFT", frame, "LEFT", 18, 0)
		frame.Lines:Hide()
		frame:SetNormalFontObject(GameFontHighlightSmall)	

		local texture = frame.NormalTexture
		texture:SetAtlas("auctionhouse-nav-button-secondary", false)
		texture:SetSize(153,32)
		texture:ClearAllPoints()
		texture:SetPoint("TOPLEFT", 1, 0)
		texture:SetAlpha(1.0)
		
		texture = frame.SelectedTexture
		texture:SetAtlas("auctionhouse-nav-button-secondary-select", false)
		texture:SetSize(142,21)
		texture:ClearAllPoints()
		texture:SetPoint("TOPLEFT", 10, 0)
		
		texture = frame.HighlightTexture
		texture:SetAtlas("auctionhouse-nav-button-secondary-highlight", false)
		texture:SetSize(142,21)
		texture:ClearAllPoints()
		texture:SetPoint("TOPLEFT", 10, 0)
		texture:SetBlendMode("BLEND")
		
		frame:Show()
	end,
	SetSubSubCategory = function(frame, text)
		frame:SetText(text)
		frame.Text:SetPoint("LEFT", frame, "LEFT", 26, 0)
		frame.Lines:Show()
		frame:SetNormalFontObject(GameFontHighlightSmall)		
	
		local texture = frame.NormalTexture
		texture:ClearAllPoints()
		texture:SetPoint("TOPLEFT", 10, 0)
		texture:SetAlpha(0.0)
		
		texture = frame.SelectedTexture
		texture:SetAtlas("auctionhouse-ui-row-select", false)
		texture:SetSize(136,18)
		texture:ClearAllPoints()
		texture:SetPoint("TOPRIGHT",0,-2)
		
		texture = frame.HighlightTexture
		texture:SetAtlas("auctionhouse-ui-row-highlight", false)
		texture:SetSize(136,18)
		texture:ClearAllPoints()
		texture:SetPoint("TOPRIGHT",0,-2)
		texture:SetBlendMode("ADD")
		
		frame:Show()
	end,
})

MVC:Controller("AddonFactory.AuctionHouseCategoriesList", {
	
	ClickCategory = function(frame, field, value)
		-- parse all categories, find the one that matches the field with the right value
		local soughtCategory
		
		frame:IterateCategories(frame.categories, function(category, parent, grandParent) 
			if soughtCategory then return end	-- already found ? stop searching
			
			if category[field] and category[field] == value then
				soughtCategory = category	-- if the sought item exists, save it
				
				-- be sure it is visible by expanding both its parent and grand-parent
				if parent then parent.isExpanded = true end
				if grandParent then grandParent.isExpanded = true end
			end
		end)
		
		-- Update, to apply the expansion of categories
		if soughtCategory then 
			frame:UpdateCategories() 
			if soughtCategory._parentButton then
				soughtCategory._parentButton:Button_OnClick("LeftButton")
			end
		end
		
	end,
	
	UnselectAll = function(frame)
		-- unselect all categories
		frame:IterateCategories(frame.categories, function(category) 
			category.isSelected = nil
		end)
	end,
	
	IterateCategories = function(frame, categories, callback)
	
		-- Loop on all 3 levels
		for _, category in pairs(categories) do
			callback(category)
			
			if category.subMenu then
				for _, subCategory in pairs(category.subMenu) do
					callback(subCategory, category)
					
					if subCategory.subMenu then
						for _, subSubCategory in pairs(subCategory.subMenu) do
							callback(subSubCategory, subCategory, category)
						end
					end
				end
			end
		end
	end,
	
	SetCategories = function(frame, categories)
		--[[	Categories format : 
				{
					{ text = "Menu 1" },
					{ text = "Menu 2", subMenu = {
						{ text = "Sub 2.1" },
						{ text = "Sub 2.2", subMenu = {
							{ text = "SubSub 2.2.1" },
							{ text = "SubSub 2.2.2" },
							{ text = "SubSub 2.2.3" },
							}},
						{ text = "Sub 2.3" },
						}},
					{ text = "Menu 3" },
					{ text = "Menu 4" },
				}	
		--]]
	
		frame.categories = categories
		frame:UpdateCategories()
	end,
	
	GetNumVisibleCategories = function(frame)
		local numCategories = #frame.categories
		local count = numCategories	-- we already know that level 1 is always visible
		
		for i = 1, numCategories do
			local category = frame.categories[i]
		
			-- is there a level 2 and is it expanded ?
			if category.subMenu and category.isExpanded then
				count = count + #category.subMenu		-- add level 2 size
				
				for j = 1, #category.subMenu do
					local subCategory = category.subMenu[j]
					
					-- is there a level 3 and is it expanded ?
					if subCategory.subMenu and subCategory.isExpanded then
						count = count + #subCategory.subMenu		-- add level 3 size
					end
				end
			end
		end
		
		return count
	end,
	
	UpdateCategories = function(frame)
		local currentButton = 0
		
		local scrollFrame = frame.ScrollFrame
		local numRows = scrollFrame.numRows
		local offset = scrollFrame:GetOffset()
		
		local function IterateVisibleCategories(list, callback)
			for i = 1, #list do
				-- the offset will also represent the amount of lines to skip, so decrease it until it reaches 0
				if offset == 0 then
					currentButton = currentButton + 1
					if currentButton > numRows then return end
					
					callback(list[i], true)
				else
					offset = offset - 1
					callback(list[i])
				end
			end
		end

		-- Level 1
		IterateVisibleCategories(frame.categories, function(item, addItem)
			if addItem then 
				frame.Buttons[currentButton]:SetCategory(item.text)
				frame.Buttons[currentButton]:SetData(item)
				frame.Buttons[currentButton]:SetSelected(item)
			end
			
			if item.subMenu and item.isExpanded then
				-- Level 2
				IterateVisibleCategories(item.subMenu, function(subItem, addSubItem) 
					if addSubItem then 
						frame.Buttons[currentButton]:SetSubCategory(subItem.text)
						frame.Buttons[currentButton]:SetData(subItem)
						frame.Buttons[currentButton]:SetSelected(subItem)
					end
				
					if subItem.subMenu and subItem.isExpanded then
						-- Level 3
						IterateVisibleCategories(subItem.subMenu, function(subsubItem, addSubSubItem) 
							if addSubSubItem then 
								frame.Buttons[currentButton]:SetSubSubCategory(subsubItem.text)
								frame.Buttons[currentButton]:SetData(subsubItem)
								frame.Buttons[currentButton]:SetSelected(subsubItem)
							end
						end)
					end
				end)
			end
		end)

		-- Hide unused buttons
		currentButton = currentButton + 1
		while currentButton <= numRows do
			local button = frame.Buttons[currentButton]
			
			button:Hide()
			button:SetData(nil)
			currentButton = currentButton + 1
		end

		scrollFrame:Update(frame:GetNumVisibleCategories())
	end,
})
