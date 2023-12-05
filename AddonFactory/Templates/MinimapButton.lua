local MVC = LibStub("LibMVC-1.0")

MVC:Controller("AddonFactory.MinimapButton", { "AddonFactory.Options", function(Options)

	local function GetIconAngle()
		local xPos, yPos = GetCursorPosition()

		xPos = Minimap:GetLeft() - xPos/UIParent:GetScale() + 70 
		yPos = yPos/UIParent:GetScale() - Minimap:GetBottom() - 70 

		local iconAngle = math.deg(math.atan2(yPos, xPos))
		if iconAngle < 0 then
			iconAngle = iconAngle + 360
		end
		
		return iconAngle
	end

	local buttons = {}

	return {
		OnBind = function(frame)
		end,
		Initialize = function(frame, info)
			--[[	self:Initialize({
						addonName = "addon table name",
						icon = "Interface\\Icons\\INV_Drink_13",
						iconAngleOption = "UI.Minimap.IconAngle",
						iconRadiusOption = "UI.Minimap.IconRadius",
						onUpdate = function() 
							-- do stuff
						end,
					})
			--]]
		
			buttons[frame] = info
			
			frame.Icon:SetTexture(info.icon)
			frame:RegisterForClicks("LeftButtonDown", "RightButtonDown")
			frame:RegisterForDrag("RightButton")
		end,
		Move = function(frame)
			local info = buttons[frame]
			local addon = _G[info.addonName]
			
			local angle = Options.Get(addon, info.iconAngleOption)
			local radius = Options.Get(addon, info.iconRadiusOption)
			
			frame:SetPoint( "TOPLEFT", "Minimap", "TOPLEFT", 79 - (radius * cos(angle)), (radius * sin(angle)) - 83)
		end,
		Update = function(frame)
			
			if frame.isMoving then
				local info = buttons[frame]
				local addon = _G[info.addonName]
			
				local iconAngle = GetIconAngle()
				Options.Set(addon, info.iconAngleOption, iconAngle)
				frame:Move()

				if info.onUpdate then
					info.onUpdate(iconAngle)
				end
			end
		end,
	}
end})
