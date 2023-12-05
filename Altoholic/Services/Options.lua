local addonName = ...
local addon = _G[addonName]

addon:Service("AltoholicUI.Options", { "AddonFactory.Options", function(Options) 
	return {
		Initialize = function() Options.Initialize(addon, addon.db.global.options) end,
		Get = function(name) return Options.Get(addon, name) end,
		Set = function(name, value) return Options.Set(addon, name, value) end,
		Toggle = function(frame, option) return Options.Toggle(addon, frame, option) end,
		
		Clear = function(startsWith)
			-- Clear all options starting with a given prefix
			local options = addon.db.global.options
	
			for option, _ in pairs(options) do
				-- does the option name start with the string passed as argument ?
				if option:sub(1, #startsWith) == startsWith then
					options[option] = nil
				end
			end
		end,
	}
end})
