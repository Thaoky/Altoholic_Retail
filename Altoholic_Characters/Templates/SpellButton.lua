local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.SpellButton", {
	EnableIcon = function(frame)
		-- frame:Enable()
		frame.Icon:SetDesaturated(false)
	end,
	DisableIcon = function(frame)
		-- frame:Disable()
		frame.Icon:SetDesaturated(true)
	end,
	SetSpell = function(frame, spellID, availableAt)
		if not spellID then return end
		
		frame.spellID = spellID
		frame.SpellName:SetText(C_Spell.GetSpellName(spellID))
				
		if availableAt == 0 then	-- 0 = already known
			frame.SpellName:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
			frame.SubSpellName:SetText(C_Spell.GetSpellSubtext(spellID) or "")
			frame.SubSpellName:SetTextColor(0.50, 0.25, 0)
			frame.Icon:SetDesaturated(false)
			frame.Icon:SetVertexColor(1.0, 1.0, 1.0)
		else
			frame.SpellName:SetTextColor(0.4, 0.4, 0.4)
			frame.SubSpellName:SetFormattedText(SPELLBOOK_AVAILABLE_AT, availableAt)
			frame.SubSpellName:SetTextColor(0.4, 0.4, 0.4)
			frame.Icon:SetDesaturated(true)
			frame.Icon:SetVertexColor(0.4, 0.4, 0.4)
		end
		
		frame.Icon:SetWidth(30)
		frame.Icon:SetHeight(30)
		frame.Icon:SetAllPoints(frame)
		frame.Icon:SetTexture(C_Spell.GetSpellTexture(spellID))
		
		frame.Icon:Show()
		frame.SpellName:Show()
		frame.SubSpellName:Show()
	end,
})
