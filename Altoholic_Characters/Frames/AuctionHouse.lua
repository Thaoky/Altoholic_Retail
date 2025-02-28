local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.TabCharacters.Auctions", { "AddonFactory.Classes", function(oop)

	local L = AddonFactory:GetLocale(addonName)
	local colors = AddonFactory.Colors
	local currentCharacter
	local view, viewHandler, isViewValid
	local viewSortField, viewSortOrder
	local listType		-- "Auctions" or "Bids"
	
	local function SortByName(a, b, ascending)
		local idA = select(2, DataStore:GetAuctionHouseItemInfo(currentCharacter, listType, a))
		local idB = select(2, DataStore:GetAuctionHouseItemInfo(currentCharacter, listType, b))
		
		local textA = GetItemInfo(idA) or ""
		local textB = GetItemInfo(idB) or ""
		
		if ascending then
			return textA < textB
		else
			return textA > textB
		end
	end

	local function SortByPlayer(a, b, ascending)
		local valueA = select(4, DataStore:GetAuctionHouseItemInfo(currentCharacter, listType, a)) or ""
		local valueB = select(4, DataStore:GetAuctionHouseItemInfo(currentCharacter, listType, b)) or ""
		
		if ascending then
			return valueA < valueB
		else
			return valueA > valueB
		end
	end

	local function SortByPrice(a, b, ascending)
		local valueA = select(6, DataStore:GetAuctionHouseItemInfo(currentCharacter, listType, a))
		local valueB = select(6, DataStore:GetAuctionHouseItemInfo(currentCharacter, listType, b))
	
		if ascending then
			return valueA < valueB
		else
			return valueA > valueB
		end
	end

	local function BuildView(field, ascending)
		field = field or "expiry"

		view = view or {}
		wipe(view)
		
		listType = Altoholic_CharactersTab_Options["ViewAuctionHouse"]
		
		local num
		if listType == "Auctions" then
			num = DataStore:GetNumAuctions(currentCharacter) or 0
		else
			num = DataStore:GetNumBids(currentCharacter) or 0
		end
		
		for i = 1, num do
			table.insert(view, i)
		end
		
		if field == "name" then
			table.sort(view, function(a, b) return SortByName(a, b, ascending) end)
		elseif field == "owner" then
			table.sort(view, function(a, b) return SortByPlayer(a, b, ascending) end)
		elseif field == "highBidder" then
			table.sort(view, function(a, b) return SortByPlayer(a, b, ascending) end)
		elseif field == "buyoutPrice" then
			table.sort(view, function(a, b) return SortByPrice(a, b, ascending) end)
		end
		
		isViewValid = true
	end

	return {
		__Parent = AltoholicFrame.TabCharacters,
	
		OnBind = function(frame, parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel("Auctions", frame)
			
			DataStore:ListenTo("DATASTORE_AUCTIONS_UPDATED", function() 

				frame:InvalidateView()
				if frame:IsVisible() then
					frame:Update()
				end
			end)
			
			viewHandler = oop:New("ScrollFrameViewHandler", frame.ScrollFrame)
			
			-- Handle resize
			frame:SetScript("OnSizeChanged", function(self, width, height)
				if not frame:IsVisible() then return end
			
				frame:PreUpdate()
				frame:Update(true)
			end)
		end,
		
		PreUpdate = function(frame)

			-- There is no Update(), it points to UpdateAuctions or UpdateBids
			if Altoholic_UI_Options.ViewAuctionHouse == "Auctions" then
				frame.Update = frame.UpdateAuctions
			else
				frame.Update = frame.UpdateBids
			end
		end,
		Sort = function(frame, field, sortOrder)
			viewSortField = field
			viewSortOrder = sortOrder
			
			frame:InvalidateView()
		end,
		InvalidateView = function()
			isViewValid = nil
		end,
		
		UpdateAuctions = function(frame, isResizing)
			local parent = frame:GetParent()
			local character = parent:GetCharacter()
			if not character then return end
			
			currentCharacter = character
			
			if not isViewValid then
				BuildView(viewSortField, viewSortOrder)
			end
			
			local numAuctions = DataStore:GetNumAuctions(character) or 0
		
			-- Set the tab status
			parent:SetStatus(format("%s|r / %s%s", DataStore:GetColoredCharacterName(character), 
				colors.white, format("%s %s(%d)", AUCTIONS, colors.green, numAuctions)))
			
			-- Update the scrollframe
			viewHandler:Update(#view, isResizing, function(rowFrame, line) 
			
				local index = view[line]
				
				local isGoblin, itemID, count, highBidder, startPrice, buyoutPrice, timeLeft = DataStore:GetAuctionHouseItemInfo(character, "Auctions", index)

				if itemID then
					local itemName, _, itemRarity = GetItemInfo(itemID)
					rowFrame:SetName(itemName or L["N/A"], itemRarity or 1)
					rowFrame.Item:SetID(index)
				end
				
				rowFrame:SetTimeLeft(timeLeft)
				rowFrame:SetHighBidder(isGoblin, highBidder)
				rowFrame:SetPrice(startPrice, buyoutPrice)
				
				rowFrame.Item:SetIcon(GetItemIcon(itemID))
				rowFrame.Item:SetCount(count)
				rowFrame.Item.listType = listType
			end)
			
			frame:Show()
		end,
		UpdateBids = function(frame, isResizing)
			local parent = frame:GetParent()
			local character = parent:GetCharacter()
			if not character then return end
			
			currentCharacter = character
			
			if not isViewValid then
				BuildView(viewSortField, viewSortOrder)
			end
			
			local numBids = DataStore:GetNumBids(character) or 0
		
			-- Set the tab status
			parent:SetStatus(format("%s|r / %s%s", DataStore:GetColoredCharacterName(character), 
				colors.white, format("%s %s(%d)", BIDS, colors.green, numBids)))
			
			-- Update the scrollframe
			viewHandler:Update(#view, isResizing, function(rowFrame, line)
				local index = view[line]
				
				local isGoblin, itemID, count, ownerName, bidPrice, buyoutPrice, timeLeft = DataStore:GetAuctionHouseItemInfo(character, "Bids", index)
				
				if itemID then
					local itemName, _, itemRarity = GetItemInfo(itemID)
					rowFrame:SetName(itemName or L["N/A"], itemRarity or 1)
					rowFrame.Item:SetID(index)
				end
				
				rowFrame:SetTimeLeftForBid(timeLeft)
				rowFrame:SetOwnBid(isGoblin, ownerName)
				rowFrame:SetBidPrice(bidPrice, buyoutPrice)
				rowFrame.Item:SetIcon(GetItemIcon(itemID))
				rowFrame.Item:SetCount(count)
				rowFrame.Item.listType = listType
			end)
		
			frame:Show()
		end,
	}
end})
