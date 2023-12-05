local addonName = ...
local addon = _G[addonName]

addon:Controller("AltoholicUI.ItemIcon", {
	OnBind = function(frame)
		frame:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	end,
	Item_OnEnter = function(frame)
		local itemID = frame.itemID
		if not itemID then return end
		
		local itemLink = frame.itemLink or select(2, GetItemInfo(itemID))
		if not itemLink then return end		-- still not valid ? exit
		
		GameTooltip:SetOwner(frame, "ANCHOR_LEFT")
		
		if itemLink then
			local speciesID, level, breedQuality, maxHealth, power, speed, name = DataStore:GetBattlePetInfoFromLink(itemLink)
			if speciesID then
				BattlePetToolTip_Show(speciesID, level, breedQuality, maxHealth, power, speed, name)
			else
				GameTooltip:SetHyperlink(itemLink)
			end
		else
			-- this line queries the server for an unknown id
			GameTooltip:SetHyperlink(format("item:%d:0:0:0:0:0:0:0", itemID))
			
			-- don't leave residual info in the tooltip after the server query
			GameTooltip:ClearLines()	
		end
		GameTooltip:Show()
	end,
	Item_OnClick = function(frame, button)
		local itemID = frame.itemID
		if button ~= "LeftButton" or not itemID then return end
		
		local itemLink = frame.itemLink or select(2, GetItemInfo(itemID))
		if not itemLink then return end		-- still not valid ? exit
		
		if IsControlKeyDown() then
			DressUpItemLink(itemLink)
		elseif IsShiftKeyDown() then
			local chat = ChatEdit_GetLastActiveWindow()
		
			if chat:IsShown() then
				chat:Insert(itemLink)
			else
				AltoholicFrame.SearchBox:SetText(GetItemInfo(itemLink))
			end
		end
	end,
	SetInfo = function(frame, itemID, itemLink, startTime, duration)
		frame.itemID = itemID
		frame.itemLink = itemLink
		frame.startTime = startTime
		frame.duration = duration
	end,
	SetItem = function(frame, itemID, itemLink, rarityToMatch)
		frame:SetInfo(itemID, itemLink)
		frame.IconBorder:Hide()
		frame.Icon:SetDesaturated(false)
		
		if itemID then
			frame:SetIcon(GetItemIcon(itemID))
			frame:SetRarityMatch(rarityToMatch)
		else
			frame:SetIcon("Interface\\PaperDoll\\UI-Backpack-EmptySlot")
		end
	end,
	SetRarity = function(frame, rarity)
		-- Set the right border colour depending on the item's rarity
		local r, g, b = GetItemQualityColor(rarity)
		
		frame.IconBorder:SetVertexColor(r, g, b, 0.5)
		frame.IconBorder:Show()
	end,
	SetRarityMatch = function(frame, rarityToMatch)
		-- the item is set to the right rarity if it matches the one passed as parameter, otherwise it is greyed out
		if not rarityToMatch or rarityToMatch == 0 then	return end

		local _, _, itemRarity = GetItemInfo(frame.itemID)
		if itemRarity and itemRarity == rarityToMatch then
			frame:SetRarity(itemRarity)
		else
			frame.Icon:SetDesaturated(true)
		end
	end,
	SetCount = function(frame, count)
		if not count or (count < 2) then
			frame.Count:Hide()
		else
			frame.Count:SetText(count)
			frame.Count:Show()
		end
	end,
	SetCooldown = function(frame, startTime, duration, isEnabled)
		frame.startTime = startTime
		frame.duration = duration

		CooldownFrame_Set(frame.Cooldown, startTime or 0, duration or 0, isEnabled)
	end,
})
