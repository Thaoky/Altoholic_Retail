local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local currentCovenantID
local currentCovenantData

-- Taken (and slightly adapted) from Blizzard_CovenantRenown.lua
addon:Controller("AltoholicUI.RenownLevel", {
	SetInfo = function(frame, info)
		frame.info = info
		frame.init = false
	end,
	GetLevel = function(frame)
		return frame.info and frame.info.level or 0
	end,
   TryInit = function(frame)
		-- not in Blizzard's implementation, reset the rewardInfo to nil, in case we switch character, they obviously do not need it.
		--frame.rewardInfo = nil
		
		if frame.init then return end

		frame.init = true
		frame.Level:SetText(frame.info.level)

		if frame.info.isCapstone then
			frame.Icon:AddMaskTexture(frame.HexMask)
			frame.HighlightTexture:SetAtlas("CovenantSanctum-Renown-Hexagon-Hover", TextureKitConstants.UseAtlasSize)
		else
			frame.Icon:RemoveMaskTexture(frame.HexMask)
			frame.HighlightTexture:SetAtlas("CovenantSanctum-Renown-Icon-Hover", TextureKitConstants.UseAtlasSize)
		end

		-- 10.0 texture is now nil ?
		-- local maskTexture = frame:GetParent().Mask
		-- for i, texture in ipairs(frame.Textures) do
			-- texture:AddMaskTexture(maskTexture)
		-- end

		local rewards = C_CovenantSanctumUI.GetRenownRewardsForLevel(currentCovenantID, frame:GetLevel())
		
		-- use first reward for icon
		frame.rewardInfo = rewards[1]
		frame:SetIcon()
	end,
	Refresh = function(frame, actualLevel, earned)
		frame:TryInit()

		local level = frame:GetLevel()
		local borderAtlas
		
		if earned then
			borderAtlas = "CovenantSanctum-Renown-Next-Border-%s"
			if frame.info.isCapstone then
				borderAtlas = "CovenantSanctum-Renown-Hexagon-Next-Border-%s"
			elseif frame.info.isMilestone then
				borderAtlas = "CovenantSanctum-Renown-Special-Next-Border-%s"
			end		
		else
			borderAtlas = "CovenantSanctum-Renown-Icon-Border-Disabled"
			if frame.info.isCapstone then
				borderAtlas = "CovenantSanctum-Renown-Hexagon-Border-Disabled"
			elseif frame.info.isMilestone then
				borderAtlas = "CovenantSanctum-Renown-Special-Disabled-Border-%s"
			end		
		end

		frame.IconBorder:SetAtlas(borderAtlas:format(currentCovenantData.textureKit), TextureKitConstants.UseAtlasSize)

		if earned then
			frame.Icon:SetDesaturated(false)
			frame.Level:SetTextColor(NORMAL_FONT_COLOR:GetRGB())
		else
			frame.Icon:SetDesaturated(true)
			frame.Level:SetTextColor(DISABLED_FONT_COLOR:GetRGB())
		end
		
		frame.Check:SetShown(level <= actualLevel)
	end,
	SetIcon = function(frame)
		if not frame.rewardInfo then return end
	
		local icon = RenownRewardUtil.GetRenownRewardInfo(frame.rewardInfo, GenerateClosure(frame.SetIcon, frame))
		frame.Icon:SetTexture(icon)
	end,
	OnEnter = function(frame)
		GameTooltip:SetOwner(frame, "ANCHOR_RIGHT", -8, -8)
		frame:RefreshTooltip()
	end,
	RefreshTooltip = function(frame)
		if not GameTooltip:GetOwner() == frame then
			return
		end

		local onItemUpdateCallback = GenerateClosure(frame.RefreshTooltip, frame)
		local rewards = C_CovenantSanctumUI.GetRenownRewardsForLevel(currentCovenantID, frame:GetLevel())
		local addRewards = true
		
		if frame.isCapstone then
			GameTooltip_SetTitle(GameTooltip, RENOWN_REWARD_CAPSTONE_TOOLTIP_TITLE)
			GameTooltip_AddNormalLine(GameTooltip, RENOWN_REWARD_CAPSTONE_TOOLTIP_DESC)
			GameTooltip_AddBlankLineToTooltip(GameTooltip)
			GameTooltip_AddHighlightLine(GameTooltip, RENOWN_REWARD_CAPSTONE_TOOLTIP_DESC2)
		else
			if #rewards == 1 then
				local icon, name, description = RenownRewardUtil.GetRenownRewardInfo(rewards[1], onItemUpdateCallback)
				GameTooltip_SetTitle(GameTooltip, name)
				GameTooltip_AddNormalLine(GameTooltip, description)
				addRewards = false
			else
				GameTooltip_SetTitle(GameTooltip, string.format(RENOWN_REWARD_MILESTONE_TOOLTIP_TITLE, frame.info.level))
			end
		end
		
		if addRewards then
			for i, rewardInfo in ipairs(rewards) do
				local icon, name, description = RenownRewardUtil.GetRenownRewardInfo(rewardInfo, onItemUpdateCallback)
				if name then
					GameTooltip_AddNormalLine(GameTooltip, string.format(RENOWN_REWARD_TOOLTIP_REWARD_LINE, name))
				end
			end
		end
		
		GameTooltip:Show()	
	end,
})

addon:Controller("AltoholicUI.TabCharacters.RenownPanel", {
	OnBind = function(frame)
		local parent = AltoholicFrame.TabCharacters
		
		frame:SetParent(parent)
		frame:SetPoint("TOPLEFT", parent.Background, "TOPLEFT", 0, 0)
		frame:SetPoint("BOTTOMRIGHT", parent.Background, "BOTTOMRIGHT", 26, 0)
		parent:RegisterPanel("Renown", frame)
		
		-- Handle resize
		frame:SetScript("OnSizeChanged", function(self, width, height)
			if not frame:IsVisible() then return end
		
			frame:Update(true)
		end)
	end,
	Update = function(frame, isResizing)
		local parent = frame:GetParent()
		local character = parent:GetCharacter()
		if not character then return end
		
		local maxDisplayedRows = math.floor(frame:GetHeight() / 75)		-- height 55 + VSpacing 20
		local covenantID, _, renownLevel =  DataStore:GetCovenantInfo(character)

		currentCovenantID = covenantID
		
		-- 0 if no covenant has been chosen yet
		if covenantID == 0 then
			if not isResizing then
				parent:SetStatus(format("%s|r / %s%s|r / %s%s", 
					DataStore:GetColoredCharacterName(character), 
					colors.white, LANDING_PAGE_RENOWN_LABEL, 
					colors.white, format(LEVEL_GAINED, renownLevel)))
			end
			
			frame:Hide()
			return
		end
		
		currentCovenantData = C_Covenants.GetCovenantData(covenantID)
		
		if not isResizing then
			parent:SetStatus(format("%s|r / %s%s|r / %s%s (%s)|r", 
				DataStore:GetColoredCharacterName(character), 
				colors.white, LANDING_PAGE_RENOWN_LABEL, 
				colors.white, format(LEVEL_GAINED, renownLevel),
				currentCovenantData.name))
		end
		
		local levels = C_CovenantSanctumUI.GetRenownLevels(covenantID)
		
		local i = 1
		for row = 1, #frame.Rows do
			local rowFrame = frame.Rows[row]
		
			if row <= maxDisplayedRows then
				if not (isResizing and rowFrame:IsVisible()) then
					for item = 1, #rowFrame.Items do
						local f = rowFrame.Items[item]
					
						f:SetInfo(levels[i])
						f:Refresh(renownLevel, (i <= renownLevel))
					
						i = i + 1
					end
				else
					i = i + 10
				end
				
				rowFrame:Show()
			else
				i = i + 10
				rowFrame:Hide()
			end
		end
		
		frame:Show()
	end,
})
