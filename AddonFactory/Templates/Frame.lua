local MVC = LibStub("LibMVC-1.0")

MVC:Controller("AddonFactory.Frame", {
	ShowChildFrames = function(frame)
		for _, child in ipairs( {frame} ) do
			child:Show()
		end
	end,
	HideChildFrames = function(frame)
		for _, child in ipairs( {frame} ) do
			child:Hide()
		end
	end,
	RegisterClassEvent = function(frame, event, func)
		-- this one can obviously not be called RegisterEvent, it would conflict with Blizzard's own
		frame.customCallbacks = frame.customCallbacks or {}
		frame.customCallbacks[event] = func
	end,	
	TriggerClassEvent = function(frame, event, arg1, arg2)
		if frame.customCallbacks[event] then
			frame.customCallbacks[event](frame, arg1, arg2)
		end
	end,
})
