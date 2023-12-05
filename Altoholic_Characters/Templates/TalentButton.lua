local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.TalentButton", {
	EnableIcon = function(frame)
		-- frame:Enable()
		frame.Icon:SetDesaturated(false)
	end,
	DisableIcon = function(frame)
		-- frame:Disable()
		frame.Icon:SetDesaturated(true)
	end,
})
