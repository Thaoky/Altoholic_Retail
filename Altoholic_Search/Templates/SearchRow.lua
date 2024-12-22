local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors
local L = AddonFactory:GetLocale(addonName)

addon:Controller("AltoholicUI.SearchRow", { "AltoholicUI.SearchResults", function(Results)

	local function GetIcon(itemID)
		-- return the enchanting icon if no item id.
		return (itemID) and GetItemIcon(itemID) or "Interface\\Icons\\Trade_Engraving"
	end

	return {
		DrawItem = function(frame, itemID, itemLink, isBattlePet)
			frame.Item:SetInfo(itemID, itemLink)
			frame.Item:SetIcon((isBattlePet) and itemID or GetIcon(itemID))
		end,
		DrawCraftItem = function(frame, itemID)
			frame.Item:SetInfo(itemID)
			frame.Item:SetIcon(GetIcon(itemID))
		end,
		
		DrawItemInfo = function(frame, itemID, itemLink, location, isBattlePet, hex)	
			-- Item name & source
			local name = (isBattlePet) and select(7, DataStore:GetBattlePetInfoFromLink(itemLink)) or GetItemInfo(itemID)
			
			if name then
				frame.Name:SetText(format("%s%s", hex, name))
				frame.Source.Text:SetText(format("%s%s", colors.teal, location))
				frame.Source:SetID(0)
			end
		end,
		DrawCraftInfo = function(frame, spellID, professionName, line, hex)	
			local name = C_Spell.GetSpellName(spellID)
		
			if name then
				frame.Name:SetText(format("%s%s", hex, name))
				frame.Source.Text:SetText(addon:GetRecipeLink(spellID, professionName))
				frame.Source:SetID(line)
			end
		end,

		DrawItemCount = function(frame, count)
			frame.Item:SetCount(count)
		end,
		DrawItemLevel = function(frame, itemID)
			local text = (itemID) and select(4, GetItemInfo(itemID)) or ""
			frame.ILevel:SetText(text or "")
		end,
		DrawItemBorder = function(frame, itemID, itemLink)
			-- Item Button Border
			local hex = colors.white
			local border = frame.Item.IconBorder
			border:Hide()
			
			local item = itemLink or itemID
			
			if item then
				local itemRarity = select(3, GetItemInfo(item))
				
				if itemRarity then
					local r, g, b
					r, g, b, hex = GetItemQualityColor(itemRarity)
					
					if itemRarity >= 2 then
						border:SetVertexColor(r, g, b, 0.5)
						border:Show()
					end
					hex = format("|c%s", hex)
				end
			end
			
			return hex
		end,
		DrawOwner = function(frame, sourceKey, useClassColor, isGuild)
			local owner
			
			if isGuild then
				local guild = select(3, strsplit(".", sourceKey))
				owner = (useClassColor) 
					and format("%s%s", colors.green, guild)
					or format("%s%s", colors.white, guild)
			else
				-- Player owning the item
				owner = (useClassColor) 
					and DataStore:GetColoredCharacterName(sourceKey)
					or format("%s%s", colors.white, DataStore:GetCharacterName(sourceKey))
			end
			
			frame.Owner:SetText(owner)
		end,
		DrawRealm = function(frame, sourceKey, useFactionColor, isGuild)
		
			-- Realm
			local account, realm = strsplit(".", sourceKey)
			local faction = (isGuild) and DataStore:GetGuildBankFaction(sourceKey) or DataStore:GetCharacterFaction(sourceKey)
			local location = format("%s%s", (useFactionColor) and colors[faction] or colors.white, realm)

			if account ~= DataStore.ThisAccount then
				location = format("%s\n%s%s: %s%s", location, colors.white, L["Account"], colors.green, account)
			end
			frame.Realm:SetText(location)
		end,

		Source_OnClick = function(frame, button, mouseButton)
			-- wrong input ? exiit
			if mouseButton ~= "LeftButton" or not IsShiftKeyDown() then return end 
			
			-- chat hidden ? exit
			local chat = ChatEdit_GetLastActiveWindow()
			if not chat:IsShown() then return end
		
			-- bad line ? exit
			local line = button:GetID()
			if line == 0 or not Results.IsPlayerCraft(line) then return end
		
			local result = Results.GetResult(line)
			local link = addon:GetRecipeLink(result.spellID, result.professionName)
		
			if link then
				chat:Insert(link)
			end
		end,
		Source_OnEnter = function(frame, button)
			local line = button:GetID()
			if line == 0 or not Results.IsPlayerCraft(line) then return end
			
			local result = Results.GetResult(line)
			local link = addon:GetRecipeLink(result.spellID, result.professionName)

			if link then
				GameTooltip:ClearLines()
				GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
				GameTooltip:SetHyperlink(link)
				GameTooltip:AddLine(" ",1,1,1)
				GameTooltip:Show()
			end
		end,
	}
end})
