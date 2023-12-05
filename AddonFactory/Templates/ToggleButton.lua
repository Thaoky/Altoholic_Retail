local MVC = LibStub("LibMVC-1.0")

MVC:Controller("AddonFactory.ToggleButton", function() 

	local function SetCollapsed(frame)
		frame.isCollapsed = true
		frame:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
	end

	local function SetExpanded(frame)
		frame.isCollapsed = nil
		frame:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")
	end

	local function Toggle(frame)
		if not frame.isCollapsed then
			SetCollapsed(frame)
		else
			SetExpanded(frame)
		end
	end
	
	return {
		SetCollapsed = SetCollapsed,
		SetExpanded = SetExpanded,
		Toggle = Toggle,
	}
end)
