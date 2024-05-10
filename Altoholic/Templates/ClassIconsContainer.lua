local addonName, addon = ...

addon:Controller("AltoholicUI.ClassIconsContainer", { "AltoholicUI.ColumnOptions", function(Options)
	
	local NUM_COLUMNS = 13

	return {
		OnBind = function(frame)
			local prefix = frame.iconPrefix
				
			-- auto create the sort buttons, with the quantity passed as key
			for i = 1, frame.numIcons do
				local button = CreateFrame("Button", nil, frame, frame.iconTemplate)
				
				if i == 1 then
					button:SetPoint("TOPLEFT")
				else
					-- attach to previous frame
					button:SetPoint("TOPLEFT", frame[format("%s%d", prefix, i - 1)], "TOPRIGHT", 5, 0)
				end
				
				button:SetID(i)
				frame[format("%s%d", prefix, i)] = button
			end	
		end,
		SetIDs = function(frame, page)
			for i = 1, frame.numIcons do
				local index = ((page - 1) * NUM_COLUMNS) + i		-- Pages = 1-12, 13-24, etc..
				
				frame[format("%s%d", frame.iconPrefix, i)]:SetID(index)
			end		
		end,
		
		Update = function(frame, account, realm, page)
			frame:SetIDs(page)
		
			local numIcons = frame.numIcons
			local storage = _G[frame.storage]
			local key = Options.GetColumnKey(storage, account, realm, 1)
			
			if not key then	-- first time this realm is displayed, or reset by player
				local index = 1

				-- Clear all options for this tab, for all pages
				Options.ClearRealm(storage, account, realm)
				
				-- add the first 11 keys found on this realm
				for characterName, characterKey in pairs(DataStore:GetCharacters(realm, account)) do	
					Options.SetColumnKey(storage, account, realm, index, characterName)
					
					index = index + 1
					if index > numIcons then
						break
					end
				end
			end

			-- Set each class/icon
			for i = 1, numIcons do
				local class, faction, _
				
				local index = ((page - 1) * NUM_COLUMNS) + i		-- Pages = 1-12, 13-24, etc..
				key = Options.GetColumnKey(storage, account, realm, index)
				
				if key then
					_, class = DataStore:GetCharacterClass(key)
					faction = DataStore:GetCharacterFaction(key)
				end
				
				frame[format("%s%d", frame.iconPrefix, i)]:SetClass(class, faction)
			end
		end,
	}
end})
