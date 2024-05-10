local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.TabCharacters.Recipes", function()
	local L = DataStore:GetLocale(addonName)
	local colors = addon.Colors

	local recipeColors = { [0] = colors.recipeOrange, [1] = colors.yellow, [2] = colors.recipeGreen, [3] = colors.recipeGrey }
	local recipeColorNames = { [0] = L["COLOR_ORANGE"], [1] = L["COLOR_YELLOW"], [2] = L["COLOR_GREEN"], [3] = L["COLOR_GREY"] }
	
	local SKILL_ANY = 4
	
	local currentProfession
	local mainCategory
	local subCategory
	local currentColor = SKILL_ANY
	local currentSlots = ALL_INVENTORY_SLOTS
	local currentSearch = ""

	local function GetStatus(character, professionName, numRecipes)
		local profession = DataStore:GetProfession(character, professionName)
		local allCategories = (mainCategory == 0)
		local allSubCategories = (subCategory == 0)
		
		local text = ""
		
		if not allCategories then
			local categoryName = select(2, DataStore:GetRecipeCategoryInfo(profession, mainCategory))
		
			if not allSubCategories then
				local subCategoryName = select(2, DataStore:GetRecipeSubCategoryInfo(profession, mainCategory, subCategory))
				text = format("%s%s|r / %s%s|r / %s%s|r", 
							colors.white, professionName, 
							colors.white, categoryName, 
							colors.white, subCategoryName)
			else
				text = format("%s%s|r / %s%s|r", 
							colors.white, professionName, 
							colors.white, categoryName)
			end
		elseif allSubCategories then
			text = format("%s%s|r", colors.white, professionName)		-- full list, just display "Tailoring"
		else
			-- should never get here
			text = "Recipes.lua : error in SetStatus()"
		end

		return format("%s|r / %s (%s%d|r %s)", DataStore:GetColoredCharacterName(character), text, 
					colors.green, numRecipes, TRADESKILL_SERVICE_LEARN)
	end

	local function RecipePassesColorFilter(color)
		-- the recipe is accounter for if we want any color, or if it matches a specific one
		return ((currentColor == SKILL_ANY) or (currentColor == color))
	end

	local function RecipePassesSlotFilter(recipeID)
		if currentSlots == ALL_INVENTORY_SLOTS then return true end
		
		if recipeID then	-- on a data line, recipeID is numeric
			local itemID = DataStore:GetCraftResultItem(recipeID)
			if itemID then
				local _, _, _, _, _, itemType, _, _, itemEquipLoc = GetItemInfo(itemID)
				
				if itemType == GetItemClassInfo(Enum.ItemClass.Armor) or itemType == GetItemClassInfo(Enum.ItemClass.Weapon) then
					if itemEquipLoc and strlen(itemEquipLoc) > 0 then
						if currentSlots == itemEquipLoc then
							return true
						end
					end
				else	-- not a weapon or armor ? then test if it's a generic "Created item"
					if currentSlots == NONEQUIPSLOT then
						return true
					end
				end
			else		-- enchants, like socket bracer, might not have an item id, so hide the line
				return false
			end
		else
			if currentSlots ~= NONEQUIPSLOT then
				return false
			end
		end
	end

	local function RecipePassesSearchFilter(recipeID)
		-- no search filter ? ok
		if currentSearch == "" then return true end
		
		local name = GetSpellInfo(recipeID)
		if name and string.find(strlower(name), currentSearch, 1, true) then
			return true
		end
	end

	local function GetRecipeList(character, professionName)
		local list = {}
		
		local options = Altoholic_CharactersTab_Options
		local viewLearned = options["ViewLearnedRecipes"]
		local viewUnlearned = options["ViewUnlearnedRecipes"]
		local profession = DataStore:GetProfession(character, professionName)
		
		DataStore:IterateRecipes(profession, mainCategory, subCategory, function(recipeData) 
			local color, recipeID, isLearned = DataStore:GetRecipeInfo(recipeData)
			
			-- filter by learned / unlearned ..
			if (isLearned and viewLearned) or (not isLearned and viewUnlearned) then
				if RecipePassesColorFilter(color) and RecipePassesSlotFilter(recipeID) and RecipePassesSearchFilter(recipeID) then
					table.insert(list, recipeData)
				end
			end
		end)
		
		return list
	end

	return {

		SetCurrentProfession = function(frame, prof) currentProfession = prof end,
		GetCurrentProfession = function(frame) return currentProfession end,
		SetMainCategory = function(frame, cat) mainCategory = cat end,
		GetMainCategory = function(frame) return mainCategory end,
		SetSubCategory = function(frame, cat) subCategory = cat end,
		GetSubCategory = function(frame) return subCategory end,
		SetCurrentSlots = function(frame, slot) currentSlots = slot end,
		GetCurrentSlots = function(frame) return currentSlots end,
		SetCurrentColor = function(frame, color) currentColor = color end,
		GetCurrentColor = function(frame) return currentColor end,
		GetRecipeColorName = function(frame, index) return format("%s%s", recipeColors[index], recipeColorNames[index]) end,
		ResetFilters = function(frame)
			mainCategory = 0
			subCategory = 0
			currentColor = SKILL_ANY
			currentSlots = ALL_INVENTORY_SLOTS
		end,
		
		OnBind = function(frame)
			local parent = AltoholicFrame.TabCharacters
			
			frame:SetParent(parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel("Recipes", frame)
			
			-- Handle resize
			frame:SetScript("OnSizeChanged", function(self, width, height)
				if not frame:IsVisible() then return end
			
				frame:Update(true)
			end)
		end,
		
		Update = function(frame, isResizing)
			local parent = frame:GetParent()
			local character = parent:GetCharacter()
			if not character then return end
			
			local recipeList = GetRecipeList(character, currentProfession)
			
			-- Set the tab status
			parent:SetStatus(GetStatus(character, currentProfession, #recipeList))
			
		
			local scrollFrame = frame.ScrollFrame
			local numRows = scrollFrame.numRows
			local offset = scrollFrame:GetOffset()
			
			local maxDisplayedRows = math.floor(scrollFrame:GetHeight() / scrollFrame.rowHeight)

			for rowIndex = 1, numRows do
				local rowFrame = scrollFrame:GetRow(rowIndex)
				local line = rowIndex + offset
				
				if line <= #recipeList and (rowIndex <= maxDisplayedRows)then	-- if the line is visible
					if not (isResizing and rowFrame:IsVisible()) then
						local color, recipeID, isLearned, recipeRank, totalRanks = DataStore:GetRecipeInfo(recipeList[line])
						
						rowFrame:Update(currentProfession, recipeID, recipeColors[color], isLearned, recipeRank, totalRanks)
					end
					rowFrame:Show()
				else
					rowFrame:Hide()
				end
			end

			scrollFrame:Update(#recipeList, maxDisplayedRows)
			frame:Show()
		end,
		Link_OnClick = function(frame, button)
			if button ~= "LeftButton" then return end
			
			local parent = frame:GetParent()
			local character = parent:GetCharacter()
			if not character then return end
			
			local realm, altName = select(2, strsplit(".", character))
			
			if realm ~= DataStore.ThisRealm then
				addon:Print(L["Cannot link another realm's tradeskill"])
				return
			end

			local profession = DataStore:GetProfession(character, currentProfession)
			local link = profession.FullLink

			if not link then
				addon:Print(L["Invalid tradeskill link"])
				return
			end
			
			local chat = ChatEdit_GetLastActiveWindow()
			if chat:IsShown() then
				chat:Insert(format("%s: %s", altName, link))
			end
		end,
		OnSearchTextChanged = function(frame, self)
			currentSearch = self:GetText()
			frame:Update()
		end,
}end)
