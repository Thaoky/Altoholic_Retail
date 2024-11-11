local MVC = LibStub("LibMVC-1.0")
local TableInsert = table.insert

MVC:Service("AddonFactory.SimpleHTML", function()

	-- infos : https://wowpedia.fandom.com/wiki/UIOBJECT_SimpleHTML

	local content = {}
	
	local function ToHTML(code)
		return format("<html><body>%s</body></html>", code)
	end

	return {
		Initialize = function()
			wipe(content)
		end,
		GetContent = function()
			return ToHTML(table.concat(content))
		end,
		OpenTag = function(tag)
			TableInsert(content, format("<%s>", tag))
		end,
		CloseTag = function(tag)
			TableInsert(content, format("</%s>", tag))
		end,
		AddTag = function(tag, value)
			if value then
				TableInsert(content, format("<%s>%s</%s>", tag, value, tag))
			end
		end,
		AddContent = function(value)
			TableInsert(content, value)
		end,

		GetItemLink = function(itemID)
			local link = select(2, GetItemInfo(itemID))
			return link or format("item:%d", itemID)
		end,
		
		GetItemIconLink = function(itemID)
			local _, link, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)

			if link and icon then
				local _, endPos = string.find(link, "|h")
				
				if endPos then
					-- get the payload before the first |h, and use it as-is to build the icon link
					local payload = string.sub(link, 1, endPos - 2)
					return format("%s|h|T%s:20:20|t|h|r", payload, icon)
				end
			end

			-- Question mark icon
			return "|TInterface\\Icons\\inv_misc_questionmark:20:20|t"
		end,
		
		GetItemIconAndLink = function(itemID, count)
			local name, link, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)

			if link and icon then
				local _, endPos = string.find(link, "|h")
				
				if endPos then
					-- get the payload before the first |h, and use it as-is to build the icon link
					local payload = string.sub(link, 1, endPos - 2)
					-- print(payload)
					count = (count and count ~= "") and format("%dx ", count) or ""
					
					return format("%s%s|h|T%s:16:16|t [%s]|h|r", count, payload, icon, name)
				end
			end

			-- Question mark icon
			return "|TInterface\\Icons\\inv_misc_questionmark:16:16|t |cFF808080[querying..]|r"
		end,
		
		GetSpellIconAndLink = function(spellID)
			local link = C_Spell.GetSpellLink(spellID)
			local info = C_Spell.GetSpellInfo(spellID)

			local name = info.name 
			local icon = info.iconID

			if link and icon then
				local _, endPos = string.find(link, "|h")
				
				if endPos then
					-- get the payload before the first |h, and use it as-is to build the icon link
					local payload = string.sub(link, 1, endPos - 2)
					-- print(payload)
					
					return format("%s|h|T%s:16:16|t [%s]|h|r", payload, icon, info.name)
				end
			end

			-- Question mark icon
			return "|TInterface\\Icons\\inv_misc_questionmark:16:16|t |cFF808080[querying..]|r"
		end,
		
		AddItemLink = function(itemID)
			local link = select(2, GetItemInfo(itemID))
			link = link or format("item:%d", itemID)
			
			TableInsert(content, format("<p>%s</p>", link))
		end,
		
		AddSpellLink = function(spellID)
			local link = select(2, GetSpellLink(spellID))
			link = link or format("spell:%d", spellID)
			
			TableInsert(content, format("<p>%s</p>", link))
		end,
		
		GetQuestLink = function(questID, questTitle)
			-- Note : the quest title may be wrong, it will be displayed as is in the link, but properly in the tooltip. (Tested!)
			return (questID and questTitle)
				and format("|cffffff00|Hquest:%d:0|h[%s]|h|r", questID, questTitle)
				or "|cFFFF0000invalid quest link|r"
		end,
		AddQuestLink = function(questID, questTitle)
			-- ex: "|cffffff00|Hquest:74381:0|h[Hidden Legacies]|h|r"
			-- note: the id & the title must be determined and validated by the caller.
			-- Only C_TaskQuest.GetQuestInfoByQuestID would return the questTitle based on the id, but it only works for emissaries.
			if questID and questTitle then
				TableInsert(content, format("<p>|cffffff00|Hquest:%d:0|h[%s]|h|r</p>", questID, questTitle))
			end
		end,
		
		AddImage = function(source, width, height, align)
			-- <img src="IMAGE_SOURCE" [align="(left|center|right)"] [width="NUM"] [height="NUM"] />
			-- ex: <img src="Interface\Icons\Ability_Ambush" width="32" height="32" align="right"/>
			TableInsert(content, format('<img src="%s" width="%d" height="%d" align="%s"/>', source, width, height, align))
		end,
		
		GetGold = function(amount)
			return format(GOLD_AMOUNT_TEXTURE_STRING, amount)
		end,
		
		GetNPCLink = function(faction, npcName, uiMapID, locX, locY, npcID)
			-- ex: $npc:A:Jaluu the Generous:630:222
			-- faction is A, H or B for both
			
			-- Create an enhanced worldmap link (we're adding the faction and the npc name between |H and |h, because that's all we get in OnHyperlinkEnter
			-- return format("|cff71d5ff|Hworldmap:%d:%d0:%d0:%s:%s|h[|A:Waypoint-MapPin-ChatIcon:13:13:0:0|a %s]|h|r", uiMapID, locX, locY, faction, npcName, npcName)
			return format("|cff71d5ff|Hworldmap:%d:%d0:%d0:%d:%s:%s|h[%s]|h|r", uiMapID, locX, locY, npcID, faction, npcName, npcName)
		end,
		
		GetNPCLink_GOOD = function(faction, npcName, uiMapID, locX, locY)
			-- ex: $npc:A:Jaluu the Generous:630:222
			-- faction is A, H or B for both
			
			-- Create an enhanced worldmap link (we're adding the faction and the npc name between |H and |h, because that's all we get in OnHyperlinkEnter
			-- return format("|cff71d5ff|Hworldmap:%d:%d0:%d0:%s:%s|h[|A:Waypoint-MapPin-ChatIcon:13:13:0:0|a %s]|h|r", uiMapID, locX, locY, faction, npcName, npcName)
			return format("|cff71d5ff|Hworldmap:%d:%d0:%d0:%s:%s|h[%s]|h|r", uiMapID, locX, locY, faction, npcName, npcName)
		end,
		
		GetMapLink = function(mapName, uiMapID, locX, locY)
			-- expected: $map:Timeless Isle:554:346:536
			-- but if the map name is the same as the map ID, then passing 0 suffices
			-- ex: $map:0:554:346:536
			-- the mapName also contain the id used for the link label 
			-- 	ex: I want to show Hellfire Ramparts (the dungeon = 347) on the Hellfire Peninsula (100) zone map, id's can return both names
			--		=> $map:347:100:xxx:yyy
			
			local mapID = tonumber(mapName)

			if mapID then
				-- 0 means use the uiMapID for the name
				if mapID == 0 then mapID = uiMapID end
				
				local info = C_Map.GetMapInfo(mapID)
				if info and info.name then
					mapName = info.name
				else
					mapName = "Missing map name!"
				end
			end
			
			-- if mapName == "0" then
				-- local info = C_Map.GetMapInfo(uiMapID)
				-- if info and info.name then
					-- mapName = info.name
				-- else
					-- mapName = "Missing map name!"
				-- end
			-- end
		
			return format("|cff71d5ff|Hworldmap:%d:%d0:%d0|h[%s]|h|r", uiMapID, locX, locY, mapName)
		end,
		
		
		
		-- Does not work
		-- AddLink = function(link, text)
			-- TableInsert(content, format('<a href="%s">%s</a>', link, text))
		-- end,
		
		-- Add n lines of spacing
		AddSpacing = function(num)
			num = num or 1
			for i = 1, num do
				TableInsert(content, "<br/>")
			end
		end,

		-- Create a new paragraph, with a variable list of parameters
		NewParagraph = function(...)
			local para = "<p>"
			
			for i = 1, select("#", ...) do
				para = format("%s%s", para, tostring(select(i, ...)))
			end

			return format("%s<br/></p>", para)
		end,

		-- Functions to insert a line with one or two <br/> tags (Li stands for Line, obviously)
		NewLine1BR = function(line) return format("%s<br/>", line) end,
		NewLine2BR = function(line) return format("%s<br/><br/>", line) end,
		
	}
end)
