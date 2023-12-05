local MVC = LibStub("LibMVC-1.0")

MVC:Controller("AddonFactory.AuctionHouseHeaderContainer", {
	OnBind = function(frame)
		frame.SortButtons = {}
		
		-- auto create the sort buttons, with the quantity passed as key
		for i = 1, frame.numButtons do
			local button = CreateFrame("Button", nil, frame, "AddonFactory_AuctionHouseSortButtonTemplate")
			
			if i == 1 then
				button:SetPoint("TOPLEFT")
			else
				-- attach to previous frame
				button:SetPoint("LEFT", frame.SortButtons[i - 1], "RIGHT", 0, 0)
			end
			
			table.insert(frame.SortButtons, button)
		end
	end,
	SetButton = function(frame, id, title, width, onClickCallback)
		local button = frame.SortButtons[id]

		if not title then		-- no title ? hide the button
			button:Hide()
			return
		end
		
		button:SetText(title)
		button:SetWidth(width)
		button.Text:SetJustifyH("LEFT")
		button.Text:SetNonSpaceWrap(false)
		button.onClickCallback = onClickCallback
		button:Show()
		
		button:PreserveWidth()
	end,
	LimitWidth = function(frame, maxWidth)
		-- if there is not enough room to show the whole container, only show the leftmost ones..
		local buttonIndex = 1
		
		while maxWidth > 0 and buttonIndex <= frame.numButtons do
			local button = frame.SortButtons[buttonIndex]
			if not button then return end
			
			local title = button:GetText()
			if not title or title == "" then 
				button:Hide()
			else
				button:Show()
				
				local newWidth = button:LimitWidth(maxWidth, buttonIndex)
				maxWidth = maxWidth - newWidth
				-- print("maxw = " .. maxWidth .. ", newW = " .. newWidth)
			end
			
			buttonIndex = buttonIndex + 1
		end
		
		-- hide unused buttons
		for i = buttonIndex, frame.numButtons do
			local button = frame.SortButtons[i]
			button:Hide()
		end
	end,
})
