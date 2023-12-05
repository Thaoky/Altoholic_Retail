local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.TabCharacters.SoulbindTreeButton", {
	EnableIcon = function(frame)
		-- frame:Enable()
		frame.Icon:SetDesaturated(false)
	end,
	DisableIcon = function(frame)
		-- frame:Disable()
		frame.Icon:SetDesaturated(true)
	end,
	Node_OnEnter = function(frame)
		if not frame.spellID then return end
		
		local tt = AddonFactory_Tooltip
		tt:SetOwner(frame, "ANCHOR_LEFT")
		tt:ClearLines()
		
		if frame.conduitID then
			-- If it's a conduit, pass its id & rank
			tt:SetConduit(frame.conduitID, frame.conduitRank)
			
		elseif frame.conduitType then
			-- If it's an empty conduit, show the proper tooltip based on its type
			local title, desc
			
			if frame.conduitType == Enum.SoulbindConduitType.Potency then
				title = CONDUIT_SLOT_POTENCY
				desc = CONDUIT_TYPE_DESC_POTENCY
			elseif frame.conduitType == Enum.SoulbindConduitType.Endurance then
				title = CONDUIT_SLOT_ENDURANCE
				desc = CONDUIT_TYPE_DESC_ENDURANCE
			elseif frame.conduitType == Enum.SoulbindConduitType.Finesse then
				title = CONDUIT_SLOT_FINESSE
				desc = CONDUIT_TYPE_DESC_FINESSE
			end
		
			tt:SetText(title, 1, 1, 1)
			tt:AddLine(desc)
			
		else
			-- It's a simple spell, pass the id
			tt:SetSpellByID(frame.spellID)
		end
		
		-- If there is any error reason, show it in red
		if frame.reason and frame.reason ~= "" then
			tt:AddLine(frame.reason, 1, 0, 0)
		end
		
		tt:Show()
	end,
	Node_OnClick = function(frame, button)
		if button ~= "LeftButton" or not IsShiftKeyDown() or not frame.spellID then return end
		
		local chat = ChatEdit_GetLastActiveWindow()
		if not chat:IsShown() then return end
		
		local link
		if frame.conduitID then
			link = C_Soulbinds.GetConduitHyperlink(frame.conduitID, frame.conduitRank)
		else
			link = GetSpellLink(frame.spellID)
		end
		
		if link then
			chat:Insert(link)
		end
	end,	
})
