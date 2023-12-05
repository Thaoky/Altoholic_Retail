local MVC = LibStub("LibMVC-1.0")

MVC:Service("AddonFactory.Options", function() 

	-- Manage options separately for each client add-on, keep a reference to their options' table
	local addons = {}

	local function SetOption(addon, name, value)
		if addons[addon] then 
			addons[addon][name] = value
		end
	end
	
	local function GetOption(addon, name)
		if addons[addon] then 
			return addons[addon][name]
		end
	end
	
	local function ToggleOption(addon, optionFrame, option)
		local value
		
		if optionFrame then
			value = optionFrame:GetChecked() and true or false
		else
			value = not GetOption(addon, option)
		end
		
		SetOption(addon, option, value)
	end

	return {
		-- Tell the service where the options' table is for this addon
		Initialize = function(addon, optionsTable)
			addons[addon] = optionsTable
		end,
		Get = GetOption,
		Set = SetOption,
		Toggle = ToggleOption,
	}
end)
