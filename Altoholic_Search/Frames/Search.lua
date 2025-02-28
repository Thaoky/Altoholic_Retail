local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

addon:Controller("AltoholicUI.TabSearch.Search", { "AddonFactory.Classes", "AltoholicUI.SearchResults", "AltoholicUI.ItemFilters", 
function(oop, Results, ItemFilters)

	local L = AddonFactory:GetLocale(addonName)
	local viewHandler

	return {
		__Parent = AltoholicFrame.TabSearch,
	
		OnBind = function(frame, parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel("Search", frame)
			
			viewHandler = oop:New("ScrollFrameViewHandler", frame.ScrollFrame)
			
			-- Handle resize
			frame:SetScript("OnSizeChanged", function(self, width, height)
				if not frame:IsVisible() then return end
			
				frame:Update(true)
			end)
		end,

		Update = function(frame, isResizing)
			local parent = frame:GetParent()
			local numResults = Results.GetSize()
			
			if not isResizing then
				local status = ""
			
				if numResults == 0 then
					if not parent.searchedValue or parent.searchedValue == "" then 
						status = format("%s%s", colors.white, L["NO_MATCH_FOUND_BLANK"])
					else
						status = format(L["ITEM_NOT_FOUND"], colors.white, parent.searchedValue)
					end
				else
					status = format(L["SEARCH_RESULTS_FOUND"], colors.green, numResults, colors.white )
				end
				
				status = format("%s (%s)", status, ItemFilters.GetFiltersString())
				parent:SetStatus(status)
			end
			
			local options = Altoholic_SearchTab_Options
			local useClassColor = options["UseColorsForAlts"]
			local useFactionColor = options["UseColorsForRealms"]
		
			viewHandler:Update(numResults, isResizing, function(rowFrame, line)
				local result = Results.GetResult(line)
				local itemID = result.itemID
				local itemLink = result.itemLink
				
				local hex = rowFrame:DrawItemBorder(itemID, itemLink)
				local isCraft = Results.IsPlayerCraft(line)
				
				if isCraft then
					rowFrame:DrawCraftItem(itemID)
					rowFrame:DrawCraftInfo(result.spellID, result.professionName, line, hex)
				else
					rowFrame:DrawItem(itemID, itemLink, result.isBattlePet)
					rowFrame:DrawItemInfo(itemID, itemLink, result.location, result.isBattlePet, hex)
				end
				
				-- crafts will work below this point
				if Results.IsPlayerItem(line) or isCraft then
					rowFrame:DrawOwner(result.sourceKey, useClassColor)
					rowFrame:DrawRealm(result.sourceKey, useFactionColor)
					
				elseif Results.IsGuildItem(line) then
					rowFrame:DrawOwner(result.sourceKey, useClassColor, true)
					rowFrame:DrawRealm(result.sourceKey, useFactionColor, true)
				end

				rowFrame:DrawItemCount(result.count)
				rowFrame:DrawItemLevel(itemID)
			end)

			frame:Show()
		end,
		
		CheckForResize = function(frame)
			-- Check if a resize happened while viewing another tab
			local lastMaxRows = viewHandler:GetLastMaxRows()
			if not lastMaxRows then return end
			
			local maxDisplayedRows = math.floor(frame.ScrollFrame:GetHeight() / 41)
			
			-- it the last number of rows we displayed is not identical to the current frame size.. we need to refresh
			if (maxDisplayedRows ~= frame.lastMaxRows) then
				frame:Update()
			end
		end,
	}
end})
