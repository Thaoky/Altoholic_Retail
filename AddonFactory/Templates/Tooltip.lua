local MVC = LibStub("LibMVC-1.0")

MVC:Controller("AddonFactory.Tooltip", {
	OnBind = function(frame)
	end,
	
	ShowInfo = function(frame, owner, info, anchor)
		if not owner or not info then return end
	
		frame:SetOwner(owner, anchor or "ANCHOR_LEFT")
		frame:ClearLines()
		frame:AddLine(info)
		frame:Show()
	end,
	
	ShowLink = function(frame, owner, link, anchor)
		if not owner or not link then return end
		
		frame:SetOwner(owner, anchor or "ANCHOR_LEFT")
		frame:ClearLines()
		frame:SetHyperlink(link)
		frame:Show()
	end,
	
	ShowSpellInfo = function(frame, owner, spellID, anchor)
		frame:ShowLink(owner, format("spell:%d", spellID), anchor)
	end,
})
