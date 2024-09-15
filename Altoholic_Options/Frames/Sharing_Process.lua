local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

local L = DataStore:GetLocale(addonName)

addon:Controller("AltoholicUI.TabOptions.SharingProcess", { "AltoholicUI.AvailableContent", "AltoholicUI.AvailableContentView", "AltoholicUI.AccountSharing", 
	function(Content, View, AccountSharing)
	
	return {
		OnBind = function(frame)
			-- Attach to the parent
			local parent = AltoholicFrame.TabOptions
			parent.SharingProcess = frame
			
			frame:SetParent(parent)
			frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
			frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
			parent:RegisterPanel(22, frame)

			-- Setup localization & clear localized value after use (no longer needed)
			frame.Title:SetText(format("%s%s", colors.white, L["Account Sharing"]))
			frame.AccountNameLabel:SetText(format("%s%s", colors.white, L["Account Name"]))
			frame.AccountNameInfo:SetText(L["ACCOUNT_NAME_INFO"])
			frame.SendRequestLabel:SetText(format("%s%s", colors.white, L["Send account sharing request to:"]))
			-- frame.Info:SetText(L["SHARED_CONTENT_INFO"])
			
			frame.UseTarget.text:SetText(TARGET)
			frame.UseName.text:SetText(L["Character"])
			frame.SendRequest:SetText(L["Send Request"])
			
			-- Handle resize
			frame:SetScript("OnSizeChanged", function(self, width, height)
				if not frame:IsVisible() then return end
			
				frame:Update(true)
			end)
			
			AccountSharing.SetModeUpdateInfo({ button = frame.SendRequest, callback = frame.SetMode })
			AccountSharing.SetStatusUpdateInfo({ fontstring = frame.TransferStatus, callback = frame.SetStatus })
		end,
		
		SetMode = function(button, mode)
			
			-- send request, expect toc in return
			if mode == 1 then			
				button:SetText(L["Send Request"])
				button:Enable()
				button.requestMode = nil	
				
			-- request content, get data in return
			elseif mode == 2 then	
				button:SetText(L["Request Content"])
				button:Enable()
				button.requestMode = true	
				
			-- transfer ongoing, button is grey
			elseif mode == 3 then
				button:Disable()
			end
		end,
		
		SetStatus = function(fontstring, text)
			fontstring:SetText(text)
		end,
		
		GetRequestee = function(frame)
			local player	-- name of the player to whom the account sharing request will be sent
			
			if frame.UseTarget:GetChecked() then
				player = UnitName("target")
			elseif frame.UseName:GetChecked() then
				player = frame.SharingTarget:GetText()
			end

			if player and strlen(player) > 0 then
				return player
			end
		end,
		
		SendRequest_OnClick = function(frame, button)
		
			if button.requestMode then
				button:Disable()
				AccountSharing.GetContent(frame:GetRequestee())
			else
				local account = frame.AccountName:GetText()
				
				-- account name cannot be empty
				if not account or strlen(account) == 0 then 
					addon:Print(L["EMPTY_ACCOUNT_WARNING"])
					return 
				end
			
				AccountSharing.Request(frame:GetRequestee(), account)
			end
		end,

		Cancel_OnClick = function(frame, button)
			AccountSharing.CancelTransfer()
		end,
		
		ToggleAll = function(frame, button)
			Content.ToggleAll(button.isCollapsed)
			Content.BuildView()
			frame:Update()
		end,
		
		CheckAll = function(frame, checkBox)
			if not checkBox.isChecked then			-- are all entries collapsed or not ?
				checkBox.isChecked = true
			else
				checkBox.isChecked = nil
			end
			checkBox:SetChecked(checkBox.isChecked)
			
			Content.CheckAll(checkBox.isChecked)
			Content.BuildView()
			frame:Update()
		end,
		
		Update = function(frame, isResizing)
			if not View.IsValid() then
				Content.BuildView()
			end
		
			local scrollFrame = frame.ContentContainer.ScrollFrame
			local numRows = scrollFrame.numRows
			local viewSize = View.GetSize() 
			local offset = scrollFrame:GetOffset()
			
			-- This handles the resize
			local maxDisplayedRows = math.floor(scrollFrame:GetHeight() / 23)
			
			for rowIndex = 1, numRows do
				local rowFrame = scrollFrame:GetRow(rowIndex)
				local line = rowIndex + offset
				
				if line <= viewSize and (rowIndex <= maxDisplayedRows) then	-- if the line is visible
				
					if not (isResizing and rowFrame:IsVisible()) then
						local lineData = View.GetLine(line)
						local index
						
						if View.IsGuildHeaderLine(line) then
							index = format("%s.%s.%s", Content.GetAccount(), lineData.realm, lineData.name)
						
						elseif View.IsCharacterHeaderLine(line) then
							index = lineData.key
						end
					
						rowFrame:DrawCollapseButton(line, index)
						rowFrame:DrawCheckBox(line)
						
						rowFrame:DrawSize(lineData.size)
						rowFrame:DrawDate(lineData.lastUpdate, lineData.key, lineData.module or "DataStore_Characters")
					end				
					
					rowFrame:SetID(line)
					rowFrame:Show()
				else
					rowFrame:SetID(0)
					rowFrame:Hide()
				end
			end

			scrollFrame:Update((viewSize < numRows) and numRows or viewSize, maxDisplayedRows)
			
			frame:Show()
		end,
	}
end})
