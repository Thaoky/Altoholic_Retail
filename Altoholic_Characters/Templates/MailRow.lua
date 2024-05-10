local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.TabCharacters.MailRow", { "AltoholicUI.Formatter", function(Formatter)

	local colors = addon.Colors
	local L = DataStore:GetLocale(addonName)
	
	return {
		Item_OnEnter = function(frame, button)
			local id = button:GetID()
			if id == 0 then return end

			local character = frame:GetParent():GetParent():GetCharacter()
			local _, _, link, money, text = DataStore:GetMailInfo(character, id)

			GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
			GameTooltip:ClearLines()
			
			if link then
				GameTooltip:SetHyperlink(link)
			else
				local subject = DataStore:GetMailSubject(character, id)
				
				if subject then 
					GameTooltip:AddLine(format("%s%s|r", colors.white, subject))
				end
					
				if text then 
					GameTooltip:AddLine(format("%s%s|r", colors.gold, text), 1, 1, 1, 1, 1)
				end
				
				if money > 0 then
					GameTooltip:AddLine("%s%s: ", colors.white, L["Attached Money"], Formatter.MoneyString(money, colors.white))
				end
			end
			
			GameTooltip:Show()
		end,
		Item_OnClick = function(frame, button, mouseButton)
			local id = button:GetID()
			if id == 0 then return end

			local character = frame:GetParent():GetParent():GetCharacter()
			local link = select(3, DataStore:GetMailInfo(character, id))

			if link and button == "LeftButton" and IsShiftKeyDown() then
				local chat = ChatEdit_GetLastActiveWindow()
				if chat:IsShown() then
					chat:Insert(link)
				end
			end
		end,
	}
end})
