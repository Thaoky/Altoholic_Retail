local MVC = LibStub("LibMVC-1.0")

MVC:Controller("AddonFactory.AuctionHouseSortButton", {
	OnBind = function(frame)
		frame.Arrow:Hide()
	end,
	OnClick = function(frame, button)
		local parent = frame:GetParent()
		
		for _, child in ipairs(parent.SortButtons) do
			child.Arrow:Hide()
		end

		-- If any callback was set, call it
		if frame.onClickCallback then
			frame.onClickCallback(frame)
		end
	end,
	
	DrawArrow = function(frame, ascending)
		local arrow = frame.Arrow
		
		if ascending then
			arrow:SetTexCoord(0, 0.5625, 1.0, 0)		-- arrow pointing up
		else
			arrow:SetTexCoord(0, 0.5625, 0, 1.0)		-- arrow pointing down
		end
		arrow:Show()
	end,
	HideArrow = function(frame)
		frame.Arrow:Hide()
	end,
	
	PreserveWidth = function(frame)
		-- Preserve requested widths
		frame.ConstantWidth = frame:GetWidth()
		
		-- Just in case : https://wowpedia.fandom.com/wiki/API_FontString_GetStringWidth
		frame.ConstantTextWidth = frame.Text:GetUnboundedStringWidth()
	end,
	
	LimitWidth = function(frame, availableWidth, testIndex)
	
		-- Use the full width if possible, or limit it to the available width
		local width = frame.ConstantWidth
		if width > availableWidth then
			width = availableWidth
		end

		frame:SetWidth(width)
		
		-- Resize the text if necessary
		local text = frame.Text
		
		text:Show()
		text:SetHeight(10)
		
		if width > frame.ConstantTextWidth + 20 then
			text:SetWidth(frame.ConstantTextWidth)
		else
			text:SetWidth(width - 20)
		end
		
		if width < 46 then text:Hide() end
		
		-- Hide arrow if necessary
		local arrow = frame.Arrow
		
		if width < frame.ConstantTextWidth + 25 then
			if arrow:IsVisible() then
				arrow.wasVisible = true
				arrow:Hide()
			end
		else
			if arrow.wasVisible == true then
				arrow.wasVisible = nil
				arrow:Show()
			end
		end
		
		-- Hide the whole frame if the new width is too small
		if width < 5 then frame:Hide() end
		
		return width
	end,
})
