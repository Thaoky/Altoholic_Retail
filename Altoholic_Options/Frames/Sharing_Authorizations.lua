local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors
local icons = AddonFactory.Icons

local L = AddonFactory:GetLocale(addonName)

addon:Controller("AltoholicUI.TabOptions.SharingAuthorizations", { "AltoholicUI.Authorization", function(Authorization)
	
	local AUTH_AUTO	= 1
	local AUTH_ASK		= 2
	local AUTH_NEVER	= 3
	
	return {
		OnBind = function(frame)
			-- Attach to the parent
			local parent = AltoholicFrame.TabOptions
			
			frame:SetParent(parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel(20, frame)

			-- Setup localization & clear localized value after use (no longer needed)
			frame.Title:SetText(format("%s%s", colors.white, L["Authorizations"]))
			frame.Info:SetText(L["ACCOUNT_SHARING_AUTH_INFO"])
			frame.CharacterLabel:SetText(format("%s%s", colors.white, L["Character"]))
			
			frame.AddButton:SetText(ADD)
			frame.RemoveButton:SetText(REMOVE)
			frame.IconNever:SetText(icons.notReady)
			frame.IconAsk:SetText(icons.waiting)
			frame.IconAuto:SetText(icons.ready)
		end,
		
		AddCharacter = function(frame, name)
			Authorization.AddClient(name)
			frame:Update()
		end,
		
		RemoveCharacter = function(frame, name)
			Authorization.RemoveClient(name)
			frame:Update()
		end,
		
		Update = function(frame, isResizing)
			frame.IsEnabled:SetChecked(Altoholic_Sharing_Options.IsEnabled)

			local scrollFrame = frame.CharactersContainer.ScrollFrame
			local numRows = scrollFrame.numRows
			local numClients = Authorization.GetNumClients() 
			local offset = scrollFrame:GetOffset()
			
			for rowIndex = 1, numRows do
				local rowFrame = scrollFrame:GetRow(rowIndex)
				local line = rowIndex + offset
				
				if line <= numClients then
					local name, auth = Authorization.GetClientInfo(line)
					
					-- Add the name as a raw attribute, because a GetText() would also return the color
					rowFrame.Name.Text.name = name
					
					if auth == AUTH_NEVER then
						name = format("%s%s", colors.red, name)
					elseif auth == AUTH_AUTO then
						name = format("%s%s", colors.green, name)
					end
					
					rowFrame.Name.Text:SetText(name)
					rowFrame.Never:SetChecked((auth == AUTH_NEVER) and 1 or nil)
					rowFrame.Ask:SetChecked((auth == AUTH_ASK) and 1 or nil)
					rowFrame.Auto:SetChecked((auth == AUTH_AUTO) and 1 or nil)
				
					rowFrame:SetID(line)
					rowFrame:Show()
				else
					rowFrame.Name.Text:SetText("")
					rowFrame.Name.Text.name = nil
					rowFrame:SetID(0)
					
					rowFrame.Never:SetChecked(nil)
					rowFrame.Ask:SetChecked(nil)
					rowFrame.Auto:SetChecked(nil)
					rowFrame:Hide()
				end
			end

			scrollFrame:Update((numClients < numRows) and numRows or numClients)
			
			frame:Show()
		end,
	}
end})
