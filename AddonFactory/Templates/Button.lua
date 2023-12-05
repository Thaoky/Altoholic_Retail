local MVC = LibStub("LibMVC-1.0")

MVC:Controller("AddonFactory.Button", {
	OnBind = function(frame)
		frame:SetIconSize(frame.iconWidth, frame.iconHeight)
		frame:SetIcon(frame.iconFile)
	end,
	SetIcon = function(frame, icon)
		if icon then
			frame.Icon:SetTexture(icon)
		end
	end,
	SetIconSize = function(frame, width, height)
		-- resize the frame, the icon will be resized along with it due to setAllPoints="true"
		if width then
			frame:SetWidth(width)
		end
		
		if height then
			frame:SetHeight(height)
		end
	end,
})
