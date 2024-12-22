local addonName = "Altoholic"
local addon = _G[addonName]
local colors = AddonFactory.Colors

local L = AddonFactory:GetLocale(addonName)

addon:Controller("AltoholicUI.TabOptions.AvailableContentRow", { "AltoholicUI.AvailableContent", "AltoholicUI.AvailableContentView", function(Content, View)
	return {
		OnBind = function(frame)
		end,
		
		-- ** Collapse Button **
		Collapse_OnClick = function(frame)
			local id = frame:GetID()

			if not View.IsHeaderLine(id) then return end

			local line = View.GetLine(id)
			local index

			if View.IsGuildHeaderLine(id) then
				index = format("%s.%s.%s", Content.GetAccount(), line.realm, line.name)
				
			elseif View.IsCharacterHeaderLine(id) then
				index = line.key
			end

			Content.ToggleHeader(index)
			View:Invalidate()
			frame:GetParent():GetParent():Update()
		end,
		DrawCollapseButton = function(frame, line, index)
			local button = frame.Collapse

			if not View.IsHeaderLine(line) or not index then
				button:Hide()
				return
			end
		
			-- only work with guild or character headers.
			if not Content.IsHeaderCollapsed(index) then
				button:SetExpanded()
			else
				button:SetCollapsed()
			end
			button:Show()
		end,
		
		-- ** Check box **
		CheckButton_OnClick = function(frame, checkButton)
			Content.ToggleCheck(frame:GetID())
		end,
		DrawCheckBox = function(frame, line)
			local lineData = View.GetLine(line)
		
			-- Set the checkbox
			frame.Check:SetID(lineData.parentID)
			frame.Check:SetChecked(Content.IsItemChecked(lineData.parentID))
			frame.Check:SetPoint("TOPLEFT", lineData.offset, 0)
			
			-- Set the text
			frame.Check.Text:SetWidth(400)
			frame.Check.Text:SetText(View.GetText(line))
		end,
		
		DrawSize = function(frame, size)
			if size then
				frame.Size:SetText(format("%s%2.1f KB", colors.lightBlue, size / 1024))
				frame.Size:Show()
			else
				frame.Size:Hide()
			end
		end,
		DrawDate = function(frame, lastUpdate, character, module)
		
			if not lastUpdate then
				frame.Date:Hide()
				return
			end

			local text
			
			if lastUpdate == 0 then
				-- never updated before
				text = format("%s%s", colors.red, NEVER)
			
			else
				-- if we have a key, it is a datastore module or character line
				if character then
					
					-- local account, realm, name = strsplit(".", key)
					-- local last = DataStore:GetModuleLastUpdate(module, name, realm, account)
					
					local last = DataStore:GetModuleLastUpdateByKey(module, character)
					
					if last == lastUpdate then
						text = format("%s%s", colors.green, L["Up-to-date"])
					end
				end
			end
			
			text = text or format("%s%s", colors.lightBlue, date("%m/%d/%Y %H:%M", lastUpdate))
			
			frame.Date:SetText(text)
			frame.Date:Show()
		end,
	}
end})