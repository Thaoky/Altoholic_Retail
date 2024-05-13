local addonName, addon = ...

addon:Service("AltoholicUI.ColumnOptions", function() 
	return {
		SetColumnKey = function(storage, account, realm, id, value)
			-- Set the character key associated with one column
			
			local realmKey = format("%s.%s", account, realm)
			
			storage[realmKey] = storage[realmKey] or {}
			-- value could be nil, when removing an alt from a column
			storage[realmKey][id] = value
		end,
		
		GetColumnKey = function(storage, account, realm, id)
			-- Get the character key associated with one column
			
			local realmKey = format("%s.%s", account, realm)
			local character
			
			if storage[realmKey] then
				character = storage[realmKey][id]
			end
			
			if character then
				return format("%s.%s", realmKey, character)
			end
		end,
		
		ClearRealm = function(storage, account, realm)
			storage[format("%s.%s", account, realm)] = nil
		end,
}end)
