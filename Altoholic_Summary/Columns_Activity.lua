local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors
local icons = addon.Icons

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local MVC = LibStub("LibMVC-1.0")
local Options = MVC:GetService("AltoholicUI.Options")
local Columns = MVC:GetService("AltoholicUI.TabSummaryColumns")
local Formatter = MVC:GetService("AltoholicUI.Formatter")
local Characters = MVC:GetService("AltoholicUI.Characters")


-- *** Utility functions ***

-- ** Activity **
Columns.RegisterColumn("Mails", {
	-- Header
	headerWidth = 60,
	headerLabel = L["COLUMN_MAILS_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_MAILS_TITLE"],
	tooltipSubTitle = L["COLUMN_MAILS_SUBTITLE"],
	headerOnEnter = function(frame, tooltip)
			tooltip:AddLine(" ")
			tooltip:AddLine(L["COLUMN_MAILS_DETAIL_1"], 1,1,1)
			tooltip:AddLine(L["COLUMN_MAILS_DETAIL_2"], 1,1,1)
		end,
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("Mails") end,
	headerSort = DataStore.GetNumMails,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
			local color = colors.grey
			local num = DataStore:GetNumMails(character) or 0

			if num ~= 0 then
				color = colors.green		-- green by default, red if at least one mail is about to expire
							
				local threshold = DataStore:GetOption("DataStore_Mails", "MailWarningThreshold")
				if DataStore:GetNumExpiredMails(character, threshold) > 0 then
					color = colors.red
				end
			end
			return format("%s%s", color, num)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local num = DataStore:GetNumMails(character)
			if not num or num == 0 then return end
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), L["COLUMN_MAILS_TITLE"])
			tt:AddLine(" ")
			tt:AddLine(format("%sMails found: %s%d", colors.white, colors.green, num))
			
			local numReturned, numDeleted, numExpired = 0, 0, 0
			local closestReturn
			local closestDelete
			
			for index = 1, num do
				local _, _, _, _, _, isReturned = DataStore:GetMailInfo(character, index)
				local _, seconds = DataStore:GetMailExpiry(character, index)
				
				if seconds < 0 then		-- mail has already expired
					if isReturned then	-- .. and it was a returned mail
						numExpired = numExpired + 1
					end
				else
					if isReturned then
						numDeleted = numDeleted + 1
						
						if not closestDelete then
							closestDelete = seconds
						else
							if seconds < closestDelete then
								closestDelete = seconds
							end
						end
					else
						numReturned = numReturned + 1
						
						if not closestReturn then
							closestReturn = seconds
						else
							if seconds < closestReturn then
								closestReturn = seconds
							end
						end
					end
				end
			end

			tt:AddLine(" ")
			tt:AddLine(format("%s%d %swill be returned upon expiry", colors.green, numReturned, colors.white))
			if closestReturn then
				tt:AddLine(format("%sClosest return in %s%s", colors.white, colors.green, SecondsToTime(closestReturn)))
			end
			
			if numDeleted > 0 then
				tt:AddLine(" ")
				tt:AddLine(format("%s%d %swill be %sdeleted%s upon expiry", colors.green, numDeleted, colors.white, colors.red, colors.white))
				if closestDelete then
					tt:AddLine(format("%sClosest deletion in %s%s", colors.white, colors.green, SecondsToTime(closestDelete)))
				end
			end
			
			if numExpired > 0 then
				tt:AddLine(" ")
				tt:AddLine(format("%s%d %shave expired !", colors.red, numExpired, colors.white))
			end
			
			tt:Show()
		end,
	OnClick = function(frame, button)
			local character = frame:GetParent().character
			if not character then return end
	
			local num = DataStore:GetNumMails(character)
			if not num or num == 0 then return end

			addon:ShowCharacterPanel(character, "Mails")
		end,
})

Columns.RegisterColumn("LastMailCheck", {
	-- Header
	headerWidth = 70,
	headerLabel = L["COLUMN_MAILBOX_VISITED_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_MAILBOX_VISITED_TITLE"],
	tooltipSubTitle = L["COLUMN_MAILBOX_VISITED_SUBTITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("LastMailCheck") end,
	headerSort = DataStore.GetMailboxLastVisit,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			return format("%s%s", colors.white, Formatter.Delay(DataStore:GetMailboxLastVisit(character)))
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Mails", character) then
				return
			end
			
			local lastVisit = DataStore:GetMailboxLastVisit(character)
			if not lastVisit then return end
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), MINIMAP_TRACKING_MAILBOX)
			tt:AddLine(" ")
			tt:AddLine(format("%s: %s", L["COLUMN_MAILBOX_VISITED_TITLE_SHORT"], SecondsToTime(time() - lastVisit)),1,1,1)
			tt:Show()
		end,
})

Columns.RegisterColumn("Auctions", {
	-- Header
	headerWidth = 70,
	headerLabel = L["COLUMN_AUCTIONS_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_AUCTIONS_TITLE"],
	tooltipSubTitle = L["COLUMN_AUCTIONS_SUBTITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("Auctions") end,
	headerSort = DataStore.GetNumAuctions,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			local num = DataStore:GetNumAuctions(character) or 0
			return format("%s%s", ((num == 0) and colors.grey or colors.green), num)
		end,
	OnClick = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local num = DataStore:GetNumAuctions(character)
			if not num or num == 0 then return end

			Options.Set("UI.Tabs.Characters.ViewAuctionHouse", "Auctions")
			addon:ShowCharacterPanel(character, "Auctions")
		end,
})

Columns.RegisterColumn("Bids", {
	-- Header
	headerWidth = 60,
	headerLabel = L["COLUMN_BIDS_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_BIDS_TITLE"],
	tooltipSubTitle = L["COLUMN_BIDS_SUBTITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("Bids") end,
	headerSort = DataStore.GetNumBids,
	
	-- Content
	Width = 60,
	JustifyH = "CENTER",
	GetText = function(character)
			local num = DataStore:GetNumBids(character) or 0
			return format("%s%s", ((num == 0) and colors.grey or colors.green), num)
		end,
	OnClick = function(frame)
			local character = frame:GetParent().character
			if not character then return end
			
			local num = DataStore:GetNumBids(character)
			if not num or num == 0 then return end

			Options.Set("UI.Tabs.Characters.ViewAuctionHouse", "Bids")
			addon:ShowCharacterPanel(character, "Auctions")
		end,
})

Columns.RegisterColumn("AHLastVisit", {
	-- Header
	headerWidth = 70,
	headerLabel = L["COLUMN_AUCTIONHOUSE_VISITED_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_AUCTIONHOUSE_VISITED_TITLE"],
	tooltipSubTitle = L["COLUMN_AUCTIONHOUSE_VISITED_SUBTITLE"],
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("AHLastVisit") end,
	headerSort = DataStore.GetAuctionHouseLastVisit,
	
	-- Content
	Width = 70,
	JustifyH = "CENTER",
	GetText = function(character)
			return format("%s%s", colors.white, Formatter.Delay(DataStore:GetAuctionHouseLastVisit(character)))
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Mails", character) then
				return
			end
			
			local lastVisit = DataStore:GetAuctionHouseLastVisit(character)
			if not lastVisit then return end
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), BUTTON_LAG_AUCTIONHOUSE)
			tt:AddLine(" ")
			tt:AddLine(format("%s: %s", L["Visited"], SecondsToTime(time() - lastVisit)),1,1,1)
			tt:Show()
		end,
})

Columns.RegisterColumn("MissionTableLastVisit", {
	-- Header
	headerWidth = 80,
	headerLabel = L["COLUMN_GARRISON_MISSIONS_TITLE_SHORT"],
	tooltipTitle = L["COLUMN_GARRISON_MISSIONS_TITLE"],
	tooltipSubTitle = L["COLUMN_GARRISON_MISSIONS_SUBTITLE"],
	headerOnEnter = function(frame, tooltip)
			tooltip:AddLine(" ")
			tooltip:AddLine(format("%s* %s= %s", colors.green, colors.white, L["COLUMN_GARRISON_MISSIONS_DETAIL_1"]))
			tooltip:AddLine(format("%s* %s= %s", colors.red, colors.white, L["COLUMN_GARRISON_MISSIONS_DETAIL_2"]))
			tooltip:AddLine(format("%s! %s= %s", colors.gold, colors.white, L["COLUMN_GARRISON_MISSIONS_DETAIL_3"]))
		end,
	headerOnClick = function() AltoholicFrame.TabSummary:SortBy("MissionTableLastVisit") end,
	headerSort = DataStore.GetMissionTableLastVisit,
	
	-- Content
	Width = 65,
	JustifyH = "RIGHT",
	GetText = function(character)
			local numAvail = 	(DataStore:GetNumAvailableMissions(character, Enum.GarrisonFollowerType.FollowerType_6_0_GarrisonFollower) or 0) + 
									(DataStore:GetNumAvailableMissions(character, Enum.GarrisonFollowerType.FollowerType_7_0_GarrisonFollower) or 0) +
									(DataStore:GetNumAvailableMissions(character, Enum.GarrisonFollowerType.FollowerType_8_0_GarrisonFollower) or 0) +
									(DataStore:GetNumAvailableMissions(character, Enum.GarrisonFollowerType.FollowerType_9_0_GarrisonFollower) or 0)
			local numActive = (DataStore:GetNumActiveMissions(character, Enum.GarrisonFollowerType.FollowerType_6_0_GarrisonFollower) or 0) + 
									(DataStore:GetNumActiveMissions(character, Enum.GarrisonFollowerType.FollowerType_7_0_GarrisonFollower) or 0) +
									(DataStore:GetNumActiveMissions(character, Enum.GarrisonFollowerType.FollowerType_8_0_GarrisonFollower) or 0) +
									(DataStore:GetNumActiveMissions(character, Enum.GarrisonFollowerType.FollowerType_9_0_GarrisonFollower) or 0) 
			local numCompleted = (DataStore:GetNumCompletedMissions(character, Enum.GarrisonFollowerType.FollowerType_6_0_GarrisonFollower) or 0) + 
										(DataStore:GetNumCompletedMissions(character, Enum.GarrisonFollowerType.FollowerType_7_0_GarrisonFollower) or 0) +
										(DataStore:GetNumCompletedMissions(character, Enum.GarrisonFollowerType.FollowerType_8_0_GarrisonFollower) or 0) +
										(DataStore:GetNumCompletedMissions(character, Enum.GarrisonFollowerType.FollowerType_9_0_GarrisonFollower) or 0) 
			local text = ""
			
			if numCompleted > 0 then		-- add a '*' to show that there are some completed missions
				if numCompleted == numActive then
					text = format(" %s*", colors.red)	-- red if ALL active missions are complete
				else
					text = format(" %s*", colors.green)
				end
			elseif numActive == 0 and numAvail ~= 0 then
				text = format(" %s!", colors.gold)	-- red '!' no mission is active !
			end
	
			return format("%s%s%s", colors.white, Formatter.Delay(DataStore:GetMissionTableLastVisit(character)), text)
		end,
	OnEnter = function(frame)
			local character = frame:GetParent().character
			if not character or not DataStore:GetModuleLastUpdateByKey("DataStore_Garrisons", character) then
				return
			end
			
			local lastVisit = DataStore:GetMissionTableLastVisit(character)
			if not lastVisit then return end
			
			local tt = AddonFactory_Tooltip
			tt:ClearLines()
			tt:SetOwner(frame, "ANCHOR_RIGHT")
			tt:AddDoubleLine(DataStore:GetColoredCharacterName(character), GARRISON_MISSIONS_TITLE)
			tt:AddLine(" ")
			tt:AddLine(format("%s: %s", L["Visited"], SecondsToTime(time() - lastVisit)),1,1,1)
			tt:AddLine(" ")
			
			-- ** Garrison Missions **
			
			local numAvail = DataStore:GetNumAvailableMissions(character, Enum.GarrisonFollowerType.FollowerType_6_0_GarrisonFollower) or 0
			local numActive = DataStore:GetNumActiveMissions(character, Enum.GarrisonFollowerType.FollowerType_6_0_GarrisonFollower) or 0
			local numCompleted = DataStore:GetNumCompletedMissions(character, Enum.GarrisonFollowerType.FollowerType_6_0_GarrisonFollower) or 0
			local color = colors.green
			
			tt:AddLine(GARRISON_MISSIONS_TITLE)
			tt:AddLine(format("Available Missions: %s%d", color, numAvail),1,1,1)
			
			if numActive == 0 and numAvail ~= 0 then
				color = colors.red
			end
			tt:AddLine(format("In Progress: %s%d", color, numActive),1,1,1)
			
			color = (numCompleted > 0) and colors.cyan or colors.white
			tt:AddLine(format("%sCompleted Missions: %s%d", color, colors.green, numCompleted),1,1,1)
			tt:AddLine(" ")
			
			-- ** Order Hall Missions **
			
			numAvail = DataStore:GetNumAvailableMissions(character, Enum.GarrisonFollowerType.FollowerType_7_0_GarrisonFollower) or 0
			numActive = DataStore:GetNumActiveMissions(character, Enum.GarrisonFollowerType.FollowerType_7_0_GarrisonFollower) or 0
			numCompleted = DataStore:GetNumCompletedMissions(character, Enum.GarrisonFollowerType.FollowerType_7_0_GarrisonFollower) or 0
			color = colors.green
			
			tt:AddLine(ORDER_HALL_MISSIONS)
			tt:AddLine(format("Available Missions: %s%d", color, numAvail),1,1,1)
			
			if numActive == 0 and numAvail ~= 0 then
				color = colors.red
			end
			tt:AddLine(format("In Progress: %s%d", color, numActive),1,1,1)
			
			color = (numCompleted > 0) and colors.cyan or colors.white
			tt:AddLine(format("%sCompleted Missions: %s%d", color, colors.green, numCompleted),1,1,1)
			tt:AddLine(" ")
			
			-- ** War Campaign Missions **
            
			numAvail = DataStore:GetNumAvailableMissions(character, Enum.GarrisonFollowerType.FollowerType_8_0_GarrisonFollower) or 0
			numActive = DataStore:GetNumActiveMissions(character, Enum.GarrisonFollowerType.FollowerType_8_0_GarrisonFollower) or 0
			numCompleted = DataStore:GetNumCompletedMissions(character, Enum.GarrisonFollowerType.FollowerType_8_0_GarrisonFollower) or 0
			color = colors.green
			
			tt:AddLine(format("%s %s", WAR_CAMPAIGN, WAR_MISSIONS)) 	-- "War Campaign Missions"
			tt:AddLine(format("Available Missions: %s%d", color, numAvail),1,1,1)
			
			if numActive == 0 and numAvail ~= 0 then
				color = colors.red
			end
			tt:AddLine(format("In Progress: %s%d", color, numActive),1,1,1)
			
			color = (numCompleted > 0) and colors.cyan or colors.white
			tt:AddLine(format("%sCompleted Missions: %s%d", color, colors.green, numCompleted),1,1,1)			
			tt:AddLine(" ")
			
			-- ** Covenant Sanctum Missions **
            
			numAvail = DataStore:GetNumAvailableMissions(character, Enum.GarrisonFollowerType.FollowerType_9_0_GarrisonFollower) or 0
			numActive = DataStore:GetNumActiveMissions(character, Enum.GarrisonFollowerType.FollowerType_9_0_GarrisonFollower) or 0
			numCompleted = DataStore:GetNumCompletedMissions(character, Enum.GarrisonFollowerType.FollowerType_9_0_GarrisonFollower) or 0
			color = colors.green
			
			tt:AddLine(format("%s %s", GARRISON_TYPE_9_0_LANDING_PAGE_TITLE, GARRISON_TYPE_8_0_LANDING_PAGE_TITLE))
			tt:AddLine(format("Available Missions: %s%d", color, numAvail),1,1,1)
			
			if numActive == 0 and numAvail ~= 0 then
				color = colors.red
			end
			tt:AddLine(format("In Progress: %s%d", color, numActive),1,1,1)
			
			color = (numCompleted > 0) and colors.cyan or colors.white
			tt:AddLine(format("%sCompleted Missions: %s%d", color, colors.green, numCompleted),1,1,1)			
			
			tt:Show()
		end,
		
	OnClick = function(frame, button)
			local character = frame:GetParent().character
			if not character then return end

			addon:ShowCharacterPanel(character, "GarrisonMissions")
		end,
})
