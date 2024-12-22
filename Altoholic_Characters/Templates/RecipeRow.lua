local addonName = "Altoholic"
local addon = _G[addonName]
local L = AddonFactory:GetLocale(addonName)

addon:Controller("AltoholicUI.TabCharacters.RecipeRow", {
	Update = function(frame, profession, recipeID, color, isLearned, recipeRank, totalRanks)
		
		-- ** set the crafted item **
		local craftedItemID, maxMade = DataStore:GetCraftResultItem(recipeID)
		local itemName, itemLink, itemRarity
		
		if craftedItemID then
			frame.CraftedItem:SetIcon(GetItemIcon(craftedItemID))
			frame.CraftedItem.itemID = craftedItemID
			
			itemName, itemLink, itemRarity = GetItemInfo(craftedItemID)
			
			local vc = (isLearned) and 1 or 0.3
			frame.CraftedItem.Icon:SetVertexColor(vc, vc, vc)
			if itemRarity then
				frame.CraftedItem:SetRarity(itemRarity)
			end
			
			if maxMade > 1 then
				frame.CraftedItem.Count:SetText(maxMade)
				frame.CraftedItem.Count:Show()
			else
				frame.CraftedItem.Count:Hide()
			end
			frame.CraftedItem:Show()
		else
			frame.CraftedItem:Hide()
		end
		
		-- ** set the stars **
		if totalRanks > 1 then
			frame.IsLearned:SetPoint("TOPLEFT", frame, "TOPLEFT", 100, -15)
			
			for i, starFrame in ipairs(frame.StarsFrame.Stars) do
				starFrame.EarnedStar:SetShown(i <= recipeRank)
			end
			frame.StarsFrame:Show()
		else
			frame.IsLearned:SetPoint("TOPLEFT", frame, "TOPLEFT", 42, -15)
			frame.StarsFrame:Hide()
		end
		
		-- ** set the UNLEARNED text, if needed **
		frame.IsLearned:SetText(isLearned and "" or TRADE_SKILLS_UNLEARNED_TAB)
		
		-- ** set the recipe link **
		if recipeID then
			-- local link = addon:GetRecipeLink(recipeID, profession, color)
			local link = addon:GetRecipeLink(recipeID, profession, nil)
			local recipeText
			
			if itemName then
				local _, _, _, hexColor = GetItemQualityColor(itemRarity)
				recipeText = format("|c%s%s", hexColor, itemName)
			else
				recipeText = link
			end
		
			frame.RecipeLink.Text:SetText(recipeText)
			frame.RecipeLink.link = link
		else
			-- this should NEVER happen, like NEVER-EVER-ER !!
			frame.RecipeLink.Text:SetText(L["N/A"])
			frame.RecipeLink.link = nil
		end
		
		-- ** set the reagents **
		local schematic = C_TradeSkillUI.GetRecipeSchematic(recipeID, false)
		local index = 1
		
		for reagentIndex = 1, #schematic.reagentSlotSchematics do
			local reagent = schematic.reagentSlotSchematics[reagentIndex]
			local reagentID = reagent.reagents[1].itemID
			local reagentIcon = frame[format("Reagent%d", index)]
			
			if not reagentIcon then
				print(reagentIndex)
			end
			
			if reagentID then
				local reagentCount = reagent.quantityRequired
									
				reagentIcon.itemID = reagentID
				reagentIcon:SetIcon(GetItemIcon(reagentID))
				reagentIcon.Count:SetText(reagentCount)
				reagentIcon.Count:Show()
			
				reagentIcon:Show()
				index = index + 1
			else
				reagentIcon:Hide()
			end
		end
		
		-- hide unused reagent icons
		while index <= 12 do
			frame[format("Reagent%d", index)]:Hide()
			index = index + 1
		end

		frame:Show()
	end,
	RecipeLink_OnEnter = function(frame)
		local link = frame.RecipeLink.link
		if not link then return end
		
		GameTooltip:ClearLines()
		GameTooltip:SetOwner(frame.RecipeLink, "ANCHOR_RIGHT")
		GameTooltip:SetHyperlink(link)
		GameTooltip:AddLine(" ", 1, 1, 1)
		GameTooltip:Show()
	end,
	RecipeLink_OnClick = function(frame, button)
		if button ~= "LeftButton" or not IsShiftKeyDown() then return end

		local link = frame.RecipeLink.link
		if not link then return end
		
		local chat = ChatEdit_GetLastActiveWindow()
		if chat:IsShown() then 
			chat:Insert(link)
		end
	end,
})
