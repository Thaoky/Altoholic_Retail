local addonName, addon = ...
local colors = addon.Colors

local L = DataStore:GetLocale(addonName)
local LibDeflate = LibStub:GetLibrary("LibDeflate")
local LibSerialize = LibStub:GetLibrary("LibSerialize")

local COMM_PREFIX = "AltoShare"

local AUTH_AUTO	= 1
local AUTH_ASK		= 2
local AUTH_NEVER	= 3

local MSG_REQUEST				= 1
local MSG_REFUSED				= 2
local MSG_REFUSEDINCOMBAT	= 3
local MSG_REFUSEDDISABLED	= 4
local MSG_ACCEPTED			= 5
local MSG_SENDITEM			= 6
local MSG_COMPLETED			= 7
local MSG_ACK					= 8	-- a simple ACK message, confirms message has been received, but no data is sent back

local CMD_DATASTORE_XFER			= 20
local CMD_DATASTORE_CHAR_XFER		= 21
local CMD_DATASTORE_STAT_XFER		= 22
local CMD_BANKTAB_XFER				= 23
local CMD_REFDATA_XFER				= 24


--[[	*** Protocol ***

Client						Server

		==> MSG_REQUEST 
		<== MSG_REFUSED (stop)   
		or 
		<== MSG_ACCEPTED (receives the TOC)

		while toc not empty
		==> MSG_SENDNEXT (pass the type, based on the TOC)
		<== CMD_??? (transfer & save data)
		wend

		==> MSG_COMPLETED
--]]

addon:Service("AltoholicUI.AccountSharing", { 
	"AltoholicUI.Authorization", 
	"AltoholicUI.SharedContent", 
	"AltoholicUI.AvailableContent", 
	"AltoholicUI.SharedTableOfContent",
	function(Authorization, SharedContent, AvailableContent, TableOfContent)

	local sharingDomains				-- reference to the domains in the DB
	local messageHandler
	local isSharingEnabled, isSharingInProgress
	local destinationCurrentItem
	local authorizedRecipient
	local clientAccountName
	local clientRealmName, clientGuildName, clientCharName
	local serverRealmName, serverGuildName, serverCharacterName
	local importedChars
	local modeUpdateInfo, statusUpdateInfo

	local function SetMode(mode)
		-- Ex: modeUpdateInfo = { button = frame.SendRequest, callback = frame.SetMode }
		
		modeUpdateInfo.callback(modeUpdateInfo.button, mode)
	end
	
	local function SetStatus(text)
		-- statusUpdateInfo = { fontstring = frame.TransferStatus, callback = frame.SetStatus }
		
		statusUpdateInfo.callback(statusUpdateInfo.fontstring, text)
	end
	
	local function Whisper(player, messageType, ...)
		local serializedData = LibSerialize:Serialize(messageType, ...)
		local compressedData = LibDeflate:CompressDeflate(serializedData, {level = 8})
		local encodedData = LibDeflate:EncodeForWoWAddonChannel(compressedData)
		
		addon:SendCommMessage(COMM_PREFIX, encodedData, "WHISPER", player)
	end
	
	local function ImportCharacters()
		-- once data has been transfered, finalize the import by acknowledging that these alts can be seen by client addons
		-- will be changed when account sharing goes into datastore.
		for k, v in pairs(importedChars) do
			DataStore:ImportCharacter(k, v.faction, v.guild)
		end
		importedChars = nil
	end
	
	local function SendSourceTOC(otherPlayer)
		isSharingEnabled = true
		local toc = SharedContent.GetSourceTableOfContent()
		
		authorizedRecipient = otherPlayer
		addon:Print(format(L["Sending table of content to %s (%d items)"], otherPlayer, #toc))
		Whisper(otherPlayer, MSG_ACCEPTED, toc)
	end
	
	local function Reset()
		isSharingInProgress = nil
		isSharingEnabled = nil
		destinationCurrentItem = nil
		clientRealmName = nil
		clientGuildName = nil
		clientCharName = nil
		
		SetMode(1)
	end
		
	local function RequestNext(player)
		if not isSharingInProgress then
			SetStatus(format("%s%s", colors.white, L["SHARING_TRANSFER_CANCELLED"]))
			Reset()
			return
		end
	
		destinationCurrentItem = destinationCurrentItem + 1
		local index = destinationCurrentItem
		local tocSize = TableOfContent.GetSize()

		-- find the next checked item
		local isChecked = AvailableContent.IsItemChecked(index)
		while not isChecked and index <= tocSize do
			index = index + 1
			isChecked = AvailableContent.IsItemChecked(index)
		end
		

		if isChecked and index <= tocSize then
			SetStatus(format(L["%sTransferring item %s%d|r/%s%d|r"], colors.white, colors.green, index, colors.green, tocSize))

			local _, arg1 = TableOfContent.GetLine(index)

			if TableOfContent.IsLineRealm(index) then
				clientRealmName = arg1
				
			elseif TableOfContent.IsLineGuild(index) then
				clientGuildName = arg1
				
			-- elseif TableOfContent.IsLineGuildBankTab(index) then
			elseif TableOfContent.IsLineCharacter(index) then
				clientCharName = arg1
				
			-- elseif TableOfContent.IsLineDataStoreModule(index) then
			-- elseif TableOfContent.IsLineClassReference(index) then
			end
			
			Whisper(player, MSG_SENDITEM, index)
			destinationCurrentItem = index
			return
		end

		ImportCharacters()
		SetStatus(format("%s%s", colors.white, L["SHARING_TRANSFER_OK"]))
		Whisper(player, MSG_COMPLETED)

		Reset()
		
		AvailableContent.Clear()
		AvailableContent.BuildView()
		AltoholicFrame.TabOptions.SharingProcess:Update()

		-- Set last account sharing info
		local sharing = sharingDomains[format("%s.%s", clientAccountName, DataStore.ThisRealm)]
		sharing.lastSharingTimestamp = time()
		sharing.lastUpdatedWith = player
		
		-- Update the characters view & account summary
		LibStub("LibMVC-1.0"):GetService("AltoholicUI.Characters").InvalidateView()
		AltoholicFrame.TabSummary:Update()
	end
	
	local function ImportCharacters()
		-- once data has been transfered, finalize the import by acknowledging that these alts can be seen by client addons
		-- will be changed when account sharing goes into datastore.
		for k, v in pairs(importedChars) do
			DataStore:ImportCharacter(k, v.faction, v.guild)
		end
		importedChars = nil
	end
	
	local callbacks = {
		-- Comm setup
		[MSG_REQUEST] = function(sender, data)
			isSharingEnabled = nil
			
			if InCombatLockdown() then
				-- automatically reject if requestee is in combat
				Whisper(sender, MSG_REFUSEDINCOMBAT)
				return
			end
			
			local auth = Authorization.GetClientRights(sender)
			
			if not auth then		-- if the sender is not a known client, add him with defaults rights (=ask)
				Authorization.AddClient(sender)
				auth = AUTH_ASK
			end
			
			if auth == AUTH_AUTO then
				SendSourceTOC(sender)
			elseif auth == AUTH_ASK then
				addon:Print(format(L["Account sharing request received from %s"], sender))
				addon:Print(format(L["%sWarning:|r if you accept, %sALL|r information known\nby Altoholic will be sent to %s%s|r (bags, money, etc..)"],
							colors.white, colors.green, colors.white,sender))

				AltoMessageBox:Ask(format(L["You have received an account sharing request\nfrom %s%s|r, accept it?"], colors.white, sender),
					function() SendSourceTOC(sender) end,					-- On Yes => Send the TOC
					function() Whisper(sender, MSG_REFUSED) end)			-- On No => Refuse request 
				
			elseif auth == AUTH_NEVER then
				Whisper(sender, MSG_REFUSED)
			end
		end,
		[MSG_REFUSED] = function(sender, data)
			addon:Print(format(L["Request rejected by %s"], sender))
			isSharingInProgress = nil
		end,
		[MSG_REFUSEDINCOMBAT] = function(sender, data)
			addon:Print(format(L["%s is in combat, request cancelled"], sender))
			isSharingInProgress = nil
		end,
		[MSG_REFUSEDDISABLED] = function(sender, data)
			addon:Print(format(L["%s has disabled account sharing"], sender))
			isSharingInProgress = nil
		end,
		[MSG_ACCEPTED] = function(sender, data)
		
			-- Setting the destination ToC, retrieved by the AvailableContent controller
			TableOfContent.Initialize(data)
			destinationCurrentItem = 0

			SetStatus(format(L["SHARING_TOC_RECEIVED"], TableOfContent.GetSize()))
			
			-- build & refresh the scroll frame
			AvailableContent.SetAccount(clientAccountName)
			AvailableContent.BuildView()
			AltoholicFrame.TabOptions.SharingProcess:Update()

			-- change the text on the 'send' button 
			SetMode(2)
		end,
		
		-- Send content
		[MSG_SENDITEM] = function(sender, data)
			-- Server side, a request to send a given item is processed here
			if not isSharingEnabled or not authorizedRecipient then
				return
			end
			
			local index = tonumber(data)		-- get the index of the item in the toc
			local _, arg1, arg2 = TableOfContent.GetLine(index)		-- Source ToC
				
			if TableOfContent.IsLineRealm(index) then
				serverRealmName = arg1
				Whisper(authorizedRecipient, MSG_ACK)
				
			elseif TableOfContent.IsLineGuild(index) then
				serverGuildName = arg1
				Whisper(authorizedRecipient, MSG_ACK)
				
			elseif TableOfContent.IsLineGuildBankTab(index) then
				-- Send the requested bank tab
				local tabID = tonumber(arg2)
				local guild = DataStore:GetGuild(serverGuildName, serverRealmName)
				
				Whisper(authorizedRecipient, CMD_BANKTAB_XFER, DataStore:GetGuildBankTab(guild, tabID))
				
			elseif TableOfContent.IsLineCharacter(index) then
				-- Send character => send mandatory modules (char definition = DS_Char + DS_Stats)
				serverCharacterName = arg1
				
				Whisper(authorizedRecipient, CMD_DATASTORE_CHAR_XFER, DataStore:GetCharacterTable("DataStore_Characters", serverCharacterName, serverRealmName))
				Whisper(authorizedRecipient, CMD_DATASTORE_STAT_XFER, DataStore:GetCharacterTable("DataStore_Stats", serverCharacterName, serverRealmName))
			
			elseif TableOfContent.IsLineDataStoreModule(index) then
				-- Send the appropriate DS module (from arg1)
				Whisper(authorizedRecipient, CMD_DATASTORE_XFER, DataStore:GetCharacterTable(arg1, serverCharacterName, serverRealmName))
				
			elseif TableOfContent.IsLineClassReference(index) then
				-- Send the class reference data (from arg1)
				Whisper(authorizedRecipient, CMD_REFDATA_XFER, DataStore:GetClassReference(arg1))
			end
		end,
		[MSG_COMPLETED] = function(sender, data)
			isSharingEnabled = nil
			authorizedRecipient = nil
			serverRealmName = nil
			serverGuildName = nil
			serverCharacterName = nil
			
			addon:Print(L["SHARING_TRANSFER_OK"])
		end,
		[MSG_ACK] = function(sender, data)
			RequestNext(sender) 
		end,

		-- Receive content
		[CMD_DATASTORE_XFER] = function(sender, data)
			local _, moduleName = TableOfContent.GetLine(destinationCurrentItem)

			DataStore:ImportData(moduleName, data, clientCharName, clientRealmName, clientAccountName)
			RequestNext(sender)
		end,
		[CMD_DATASTORE_CHAR_XFER] = function(sender, data)
			DataStore:ImportData("DataStore_Characters", data, clientCharName, clientRealmName, clientAccountName)

			local key = format("%s.%s.%s", clientAccountName, clientRealmName, clientCharName)
			
			importedChars[key] = {}
			importedChars[key].faction = data.faction
			importedChars[key].guild = data.guildName
			
			-- NO REQUEST NEXT HERE !!
		end,
		[CMD_DATASTORE_STAT_XFER] = function(sender, data)
			DataStore:ImportData("DataStore_Stats", data, clientCharName, clientRealmName, clientAccountName)
			-- Request next, to resume transfer after processing mandatory data
			RequestNext(sender)
		end,
		[CMD_BANKTAB_XFER] = function(sender, data)
			local _, _, tabID = TableOfContent.GetLine(destinationCurrentItem)
			tabID = tonumber(tabID)
			
			local guild	= DataStore:GetGuild(clientGuildName, clientRealmName)
			
			DataStore:ImportGuildBankTab(guild, tabID, data)
			RequestNext(sender)
		end,
		[CMD_REFDATA_XFER] = function(sender, data)
			local _, class = TableOfContent.GetLine(destinationCurrentItem)
			
			DataStore:ImportClassReference(class, data)
		--	addon:Print(format(L["Reference data received (%s) !"], class))
			RequestNext(sender)
		end,
	}
	
	local function EmptyHandler(prefix, message, distribution, sender)
		local decodedData = LibDeflate:DecodeForWoWAddonChannel(message)
		local decompressedData = LibDeflate:DecompressDeflate(decodedData)
		local success, msgType, msgData = LibSerialize:Deserialize(decompressedData)
		
		if success and msgType and msgType == MSG_REQUEST then
			-- Automatically reply that the option is disabled
			Whisper(sender, MSG_REFUSEDDISABLED)
		end
	end
	
	local function ActiveHandler(prefix, message, distribution, sender)
		local decodedData = LibDeflate:DecodeForWoWAddonChannel(message)
		local decompressedData = LibDeflate:DecompressDeflate(decodedData)
		local success, msgType, msgData = LibSerialize:Deserialize(decompressedData)
		
		if not success then
			isSharingEnabled = nil
			-- self:Print(msgType)
			-- self:Print(string.sub(decompData, 1, 15))
			return
		end
		
		if success and msgType then
			if callbacks[msgType] then
				callbacks[msgType](sender, msgData)		-- process the message
			end
		end
	end	
		
	local function SetMessageHandler()
		-- Set the appropriate communication handler according to user settings.
		messageHandler = Altoholic_Sharing_Options.IsEnabled and ActiveHandler or EmptyHandler
	end
	
	local function SharingHandler(prefix, message, distribution, sender)
		-- 	since Ace 3 communication handlers cannot be enabled/disabled on the fly, 
		--	let's use a function pointer to either an empty function, or the normal one
		messageHandler(prefix, message, distribution, sender)
	end
	
	return {
		Initialize = function()
			sharingDomains = Altoholic_Sharing_Options.Domains
			
			SetMessageHandler()
			-- addon:RegisterComm(COMM_PREFIX, SharingHandler)	temporarily disabled
		end,
		
		GetLastAccountSharingInfo = function(realm, account)
			local sharing = sharingDomains[format("%s.%s", account, realm)]
			
			if sharing and sharing.lastSharingTimestamp then
				return date("%m/%d/%Y %H:%M", sharing.lastSharingTimestamp), sharing.lastUpdatedWith
			end
		end,
		
		HasBeenUsedBefore = function()
			-- loop through all the domains
			for _, v in pairs(sharingDomains) do
				-- if any has a timestamp, the account sharing feature was used, so return true
				if v.lastSharingTimestamp then
					return true
				end
			end
		end,
		
		GetContent = function(player)
			if player then
				-- Setup the transfer, clear the temporary import tables.
				-- This is necessary to avoid having datastore tables in a partial state.
				-- Transfer to local temporary tables, then make a local import
				importedChars = importedChars or {}
				wipe(importedChars)
				
				SetMode(3)
				RequestNext(player)
			end
		end,
		
		Request = function(player, account)
			if not Altoholic_Sharing_Options.IsEnabled then
				addon:Print(L["SHARING_OPTION_DISABLED"])
				return
			end
		
			clientAccountName = account

			if player then
				isSharingInProgress = true

				addon:Print(format(L["Sending account sharing request to %s"], player))
				-- SetStatus(format(L["Getting table of content from %s"], player))
				Whisper(player, MSG_REQUEST)
			else
				addon:Print(format(L["SHARING_INVALID_TARGET"], player))
			end
		end,
		
		CancelTransfer = function()
			-- change the "in progress" state, will be trapped by the "RequestNext" method
			isSharingInProgress = nil
		end,
		
		UpdateMessageHandler = SetMessageHandler,
		SetModeUpdateInfo = function(info) modeUpdateInfo = info	end,
		SetStatusUpdateInfo = function(info) statusUpdateInfo = info end,
		IsSharingInProgress = function() return isSharingInProgress end,
		GetClientAccountName = function() return clientAccountName end,
	}
end})
