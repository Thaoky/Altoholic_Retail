local addonName = "Altoholic"
local addon = _G[addonName]

addon:Controller("AltoholicUI.TabCharacters.SoulbindTreeRow", {
	Update = function(frame, character, soulbindData, row)
		-- attempt to see if the row may be moved up a little (because the whole frame only has room for 7 rows, not 8)
		local isMovable = true
		
		local parent = frame:GetParent()
		local previousRow = parent[format("Row%d", (row - 1))]	-- ex: this is Tier3, we want to check Tier2
		
		for column = 1, 3 do
			local button = frame[format("Talent%d", column)]
			
			button:Hide()	-- hide the button, unless we find data for it
			
			for _, node in pairs(soulbindData.tree.nodes) do
				-- tier - 1 because rows go from 0 to 7
				-- show the node only if it is part of the tree
				if node.row == (row - 1) and node.column == (column - 1) then
					button:Show()
					button.spellID = node.spellID
					
					local state, conduitID, conduitRank, hasConduit, conduitType, reason = DataStore:GetSoulbindInfo(character, node.ID)
					button.reason = reason
					
					-- Set the right icon
					local icon
					
					if node.spellID ~= 0 then		-- it's a spell
						icon = C_Spell.GetSpellTexture(button.spellID or 0)
					
					elseif conduitID ~= 0 then		-- it's an item
						local itemID = select(2, DataStore:GetConduitInfo(character, conduitID))
						if itemID then
							icon = GetItemIcon(itemID)
						end
						
						button.conduitID = conduitID
						button.conduitRank = conduitRank
					elseif hasConduit then		-- it's an empty socket for a conduit
						button.conduitID = nil
						button.conduitRank = nil
						button.conduitType = conduitType
					end
					
					if icon then
						button:SetIcon(icon)
					else
						button.Icon:SetTexture()	-- force an em
					end
					
					if state == Enum.SoulbindNodeState.Unavailable or 
						state == Enum.SoulbindNodeState.Unselected then
						
						button:DisableIcon()
						button.Border:Hide()
					else
						button:EnableIcon()
						button.Border:Show()
					end
				end
			end

			-- If the button we just worked on is visible, and the one just above it is also visible, then the whole row may not move
			if row ~= 1 and button:IsShown() and previousRow[format("Talent%d", column)]:IsShown() then
				isMovable = false
			end
		end
		
		-- Row 1 may never move
		if row ~= 1 then
			frame:SetPoint("TOPLEFT", previousRow, "BOTTOMLEFT", 0, (isMovable) and -2 or -12)
		end

		-- for some reason, the bottom of row 1 is nil .. set a high value to compensate
		local rowBottom = frame:GetBottom() or 9999
		local panelBottom = parent:GetParent():GetBottom()
		
		-- if the bottom of the row is lower than the bottom of the panel, it means
		-- we cannot display the row properly, so hide it
		if rowBottom < panelBottom then
			frame:Hide()
		else
			frame:Show()
		end
	end,
})
