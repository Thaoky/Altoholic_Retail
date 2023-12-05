local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.TabCharacters.AuctionsRow", { "AltoholicUI.Formatter", function(Formatter)

	local colors = addon.Colors
	local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
	
	return {
		SetName = function(frame, itemName, itemRarity)
			frame.Name:SetText(format("|c%s%s", select(4, GetItemQualityColor(itemRarity)), itemName))
		end,
		SetTimeLeft = function(frame, timeLeft)
			frame.TimeLeft:SetText(Formatter.TimeString(timeLeft))
		end,
		SetTimeLeftForBid = function(frame, timeLeft)
			frame.TimeLeft:SetText(format("%s%s (%s)", colors.teal, _G[format("AUCTION_TIME_LEFT%d", timeLeft)],
				_G[format("AUCTION_TIME_LEFT%d_DETAIL", timeLeft)]))
		end,
		SetHighBidder = function(frame, isGoblin, highBidder)
			local bidder = (isGoblin) and format("%s\n", L["Goblin AH"]) or ""
			bidder = (highBidder) and format("%s%s", colors.white, highBidder) or format("%s%s", colors.red, NO_BIDS)
			
			frame.HighBidder:SetText(bidder)
		end,
		SetOwnBid = function(frame, isGoblin, ownerName)
			if isGoblin then
				frame.HighBidder:SetText(format("%s\n%s%s", L["Goblin AH"], colors.white, ownerName))
			else
				frame.HighBidder:SetText(format("%s%s", colors.white, ownerName))
			end			
		end,
		SetPrice = function(frame, startPrice, buyoutPrice)
			frame.Price:SetText(format("%s\n%s%s: %s", Formatter.MoneyString(startPrice), 
					colors.green, BUYOUT, Formatter.MoneyString(buyoutPrice)))
					
		end,
		SetBidPrice = function(frame, bidPrice, buyoutPrice)
			frame.Price:SetText(format("%s%s: %s\n%s%s: %s", colors.orange, CURRENT_BID, Formatter.MoneyString(bidPrice), 
					colors.green, BUYOUT, Formatter.MoneyString(buyoutPrice)))
		end,
	
		Item_OnEnter = function(frame, button)
			local id = button:GetID()
			if id == 0 then return end

			local character = frame:GetParent():GetParent():GetCharacter()
			local itemID = select(2, DataStore:GetAuctionHouseItemInfo(character, button.listType, id))
			if not itemID then return end
	
			local link = select(2, GetItemInfo(itemID))
			if link then 
				GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
				GameTooltip:ClearLines()
				GameTooltip:SetHyperlink(link)
				GameTooltip:Show()
			end
		end,
		Item_OnClick = function(frame, button, mouseButton)
			local id = button:GetID()
			if id == 0 or mouseButton ~= "LeftButton" then return end

			local character = frame:GetParent():GetParent():GetCharacter()
			local itemID = select(2, DataStore:GetAuctionHouseItemInfo(character, button.listType, id))
			if not itemID then return end
	
			local link = select(2, GetItemInfo(itemID))
			if link then 
				if IsControlKeyDown() then
					DressUpItemLink(link)
					
				elseif IsShiftKeyDown() then
					local chat = ChatEdit_GetLastActiveWindow()
					if chat:IsShown() then
						chat:Insert(link)
					else
						AltoholicFrame.SearchBox:SetText(GetItemInfo(link))
					end
				end
			end
		end,
	}
end})