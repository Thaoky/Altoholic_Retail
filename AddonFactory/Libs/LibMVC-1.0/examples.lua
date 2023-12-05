--[[	*** LibMVC ***
Written by : Thaoky, EU-Marécages de Zangar
April 30th, 2017

Examples of implementation 

--]]

-- Start by injecting LibMVC into your add-on
_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "ManyOtherLibs", "LibMVC-1.0")

-- *** Example 1 / Simple controller ***

addon:Controller("YourAddon.ToggleButton", {
	-- Reminder: controller names must be unique, do not conflict with other add-ons !

	-- The method Toggle will be usable from the outside world by calling:
	--	myButton:Toggle()
	-- no need to pass the argument 'frame' in the caller, the : notation does that for you
	Toggle = function(frame)
		if not frame.isCollapsed then
			frame.isCollapsed = true
			
			-- note that we are now addressing the frame we created in XML
			-- so standard methods like SetNormalTexture are usable
			frame:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
		else
			frame.isCollapsed = nil
			frame:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")
		end
	end,
})

-- *** Example 2 / Using OnBind ***

addon:Controller("YourAddon.Button", {
	OnBind = function(frame)
		-- LibMVC will automatically call an OnBind method if it is found
		frame:SetIconSize(frame.iconWidth, frame.iconHeight)
		frame:SetIcon(frame.iconFile)
	end,
	SetIcon = function(frame, icon)
		if icon then
			frame.Icon:SetTexture(icon)
		end
	end
})

-- *** Example 3 / Inheritance ***

addon:Controller("YourAddon.ItemIcon", {
	OnBind = function(frame)
		-- Do stuff here
		-- This code will be executed after the 'OnBind' of "YourAddon.Button"
	end,
	Item_OnEnter = function(frame, value)
		-- value is 123 when code gets here.
		-- Do stuff
	end,
})

-- *** Example 4 / Multiple Inheritance ***

addon:Controller("YourAddon.RealmPicker", {
	OnBind = function(frame)
		-- This OnBind will be called last, after the OnBind of "YourAddon.Frame" (first) and "YourAddon.DropDownMenu" (second)
	end,
})

-- *** Example 5 / Dependency Injection ***

-- Somewhere in your add-on, create a service that deals with something special, say with equipment

addon:Service("YourAddon.Equipment", function() 
	-- Service names, like controller names, must be unique, so prefix them appropriately
	return {
		DoStuff = function(self, arg1, arg2)
			return arg1 + arg2
		end,
		DoMoreStuff = function(arg1, arg2)
			return arg1 * arg2
		end
	}
end)

-- Then inject this service into your controller

addon:Controller("YourAddon.AnyButton", { "YourAddon.Equipment", "Service2", "Service3", function(equipment, serv2, serv3)
	-- Note that as in Angular, the order of the services you inject (as strings), must be the same as the parameters you define in the function.
	-- But unlike Angular, the names must not be identical.
	return {
	
		Toggle = function(frame)
			local x = equipment:DoStuff(1, 2)	-- x will be = 3
			
			local y = equipment.DoMoreStuff(3, 4)	-- y will be = 12
			
			-- Note the difference between the . and the : calls, using self or not in the service.
			-- The choice is up to you
		end,
	}
end})

-- *** Example 6 / Dependency Injection in a service ***

-- Services may also depend on other services

addon:Service("YourAddon.Weaponry", { "YourAddon.Equipment", function(equipment) 
	-- It is of course possible to do some local processing before returning the methods
	local weapon = "Sword"

	return {
		GetWeapon = function()
			return weapon
		end,
	}
end})

-- *** Example 7 / Simple use of a service oustide of any controller ***

local s = lib:GetService("YourAddon.Equipment")

local x = s:DoStuff(1, 2)