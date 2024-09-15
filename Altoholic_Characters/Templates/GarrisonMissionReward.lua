local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

addon:Controller("AltoholicUI.TabCharacters.GarrisonMissionReward", {
	SetQuantity = function(frame, quantity)
		frame.Quantity:SetText(quantity)
		frame.Quantity:Show()
	end,
	SetItemLevel = function(frame, itemID)
		local text = ""
		local iLvl = select(4, GetItemInfo(itemID))
		
		-- if the reward has an iLevel .. show it
		if iLvl and iLvl > 1 then	
			local color = colors.white
			
			if iLvl >= 645 then
				color = colors.epic
			elseif iLvl >= 630 then
				color = colors.rare
			elseif iLvl >= 615 then
				color = colors.uncommon
			end

			text = format("%s%s", color, iLvl)
		end
			
		frame:SetQuantity(text)
	end,
	SetFollowerXP = function(frame, xp)
		if xp >= 10000 then
			xp = format("%2.0fk", xp/1000)
		elseif xp >= 1000 then
			xp = format("%2.1fk", xp/1000)
		end

		frame:SetQuantity(xp)
	end,
	SetMoney = function(frame, money)
		if money >= 1000000 then
			frame:SetQuantity(format("%2.1fk", money/10000000))
		else
			frame:SetQuantity(money / 10000)
		end

		frame.tooltip = GetMoneyString(money)
	end,
	SetReward = function(frame, reward)
		frame.Quantity:Hide()
		frame.itemID = nil
		frame.title = nil
		frame.tooltip = nil
		
		if reward.itemID then
			frame.itemID = reward.itemID
			frame.Icon:SetTexture(GetItemIcon(reward.itemID))
			frame:SetItemLevel(reward.itemID)
			
		else
			frame.Icon:SetTexture(reward.icon)
			frame.title = reward.title
			frame.tooltip = reward.tooltip
			
			if reward.followerXP then
				frame:SetFollowerXP(reward.followerXP)
			elseif reward.currencyID then
				if reward.currencyID == 0 then	-- this is money
					frame:SetMoney(reward.quantity)
				else
					frame.title = C_CurrencyInfo.GetCurrencyInfo(reward.currencyID)
					frame.tooltip = reward.quantity
					frame:SetQuantity(reward.quantity)
				end
			end
		end
		frame:Show()
	end,
})
