--[[
This file contains a list of tools that help interact with Blizzard's add-on features.
Ex: Key bindings, add-on compartment, slash commands, etc..
--]]

local addonName, addon = ...
_G[addonName] = addon

-- One empty function to rule them all
addon.EmptyFunc = function() end

-- Add support for an addon's binding to a key
function addon:AddKeyBinding(prefix, name, description)
	-- Reminder: binding is done in bindings.xml !!
	
	_G[format("BINDING_HEADER_%s", prefix)] = name
	_G[format("BINDING_NAME_%s_TOGGLE", prefix)] = description
end

-- Add support for an addon's shortcut in Blizzard's Add-on Compartment
function addon:AddToAddonCompartment(prefix, data)
	--[[
			https://wowpedia.fandom.com/wiki/Addon_compartment
			
			Do not forget to match this with the names in the .toc :
			
## AddonCompartmentFunc: <prefix>_OnAddonCompartmentClick
## AddonCompartmentFuncOnEnter: <prefix>_OnAddonCompartmentEnter
## AddonCompartmentFuncOnLeave: <prefix>_OnAddonCompartmentLeave
	--]]
	
	
	if prefix and data then 
		if data.Click then
			_G[format("%s_OnAddonCompartmentClick", prefix)] = data.Click
		end
		
		if data.Enter then
			_G[format("%s_OnAddonCompartmentEnter", prefix)] = data.Enter
		end
		
		if data.Leave then
			_G[format("%s_OnAddonCompartmentLeave", prefix)] = data.Leave
		end
	end
end

-- Create a new options table if it does not exist, with default values (if any)
function addon:SetOptionsTable(tableName, defaultValues)
	-- Create the table if it does not exist yet
	_G[tableName] = _G[tableName] or {}

	local t = _G[tableName]
	
	-- if we have default values, apply them.
	if defaultValues then
		for k, value in pairs(defaultValues) do
			if type(t[k]) == "nil" then		-- if this option does not exist yet in the table ..
				t[k] = value						-- .. then assign the default value
			end
		end
	end
	
	return t
end

-- Register a slash command
function addon:RegisterChatCommand(command, callback)
	_G[ format("SLASH_%s1", command)] = format("/%s", command:lower())
	SlashCmdList[command] = callback
end

-- Hook a simple method
function addon:InstallMethodHook(widget, method, preHook, postHook)
	local orig = widget[method]
	
	local stub = function(...)
		if preHook then preHook(...) end
		
		local a,b,c,d,e,f,g,h,i,j,k = orig(...)
		if postHook then postHook(...) end
		
		return a,b,c,d,e,f,g,h,i,j,k
	end
	
	widget[method] = stub
end

