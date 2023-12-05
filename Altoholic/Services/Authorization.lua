local addonName = ...
local addon = _G[addonName]

addon:Service("AltoholicUI.Authorization", function() 

	-- This service manages the list of clients who are authorized to send account sharing requests.

	local clients			-- dereference database table
	
	return {
		Initialize = function()
			clients = Altoholic.db.global.Sharing.Clients
		end,
		
		GetNumClients = function()
			return #clients
		end,
		
		GetClientInfo = function(index)
			local info = clients[index]
			if info then
				local name, auth = strsplit("|", info)
				return name, tonumber(auth)
			end
		end,
		
		AddClient = function(name)
			if name == "" then return end
		
			-- Loop through existing clients
			for _, clientInfo in pairs(clients) do
				local clientName = strsplit("|", clientInfo)
				if clientName == name then return end				-- if it already exists, stop
			end
			
			-- if this character does not exist, add it
			table.insert(clients, format("%s|%s", name, 2))		-- 2 = AUTH_ASK
		end,
		
		RemoveClient = function(name)
			if name == "" then return end
			
			-- Loop through existing clients
			for index, clientInfo in pairs(clients) do
				local clientName = strsplit("|", clientInfo)
				if clientName == name then			-- clear the name if found in the table
					table.remove(clients, index)
					return
				end
			end
		end,
		
		UpdateClient = function(name, auth)
			if name == "" then return end
			
			-- Loop through existing clients
			for index, clientInfo in pairs(clients) do
				local clientName = strsplit("|", clientInfo)
				if clientName == name then 

					-- Ex: Update with "Player|2"
					clients[index] = format("%s|%s", name, auth)
					return
				end
			end
		end,
		
		-- return the rights of a given player
		GetClientRights = function(name)
			if name == "" then return end
			
			-- Loop through existing clients
			for _, clientInfo in pairs(clients) do
				local clientName, auth = strsplit("|", clientInfo)
				if clientName == name then 
					return tonumber(auth)
				end
			end
		end,
				
	}
end)
