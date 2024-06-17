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
			TableInsert(content, format("<%s>%s</%s>", tag, value, tag))
		end,
		AddContent = function(value)
			TableInsert(content, value)
		end,

		GetItemLink = function(itemID)
			local link = select(2, GetItemInfo(itemID))
			return link or format("item:%d", itemID)
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
	}
end)
