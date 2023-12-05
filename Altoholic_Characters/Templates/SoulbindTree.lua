local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local NUM_TALENT_TIERS = 12

addon:Controller("AltoholicUI.TabCharacters.SoulbindTree", {
	Update = function(frame, character, soulbindData, isActive)

		-- Set the soulbind name
		frame.SpecInfo.Name:SetText(format("%s%s", isActive and colors.cyan or colors.gold, soulbindData.name or "?"))

		-- Loop on each tier/row
		for tier = 1, NUM_TALENT_TIERS do
			local rowFrame = frame[format("Row%d", tier)]
			rowFrame:Update(character, soulbindData, tier)
		end
		
		frame:Show()
	end,
})