local MVC = LibStub("LibMVC-1.0")

-- ** Constants ** 
local MAX_BUTTONS = 8
local MAX_MENULEVELS = 2

local BUTTON_HEIGHT = 18
local BORDER_HEIGHT = 15

-- *** DropDownMenuButton ***
MVC:Controller("AddonFactory.DropDownMenuButton", {
	OnClick = function(frame)
		local checked = frame.checked
		
		if type(checked) == "function" then
			checked = checked(frame)
		end
		
		if frame.keepShownOnClick then
			if not frame.notCheckable then
				if checked then
					frame.Check:Hide()
					frame.UnCheck:Show()
					checked = false
				else
					frame.Check:Show()
					frame.UnCheck:Hide()
					checked = true
				end
			end
		else
			frame:GetParent():Hide()
		end

		if type(frame.checked) ~= "function" then 
			frame.checked = checked
		end

		-- saving this here because func might use a dropdown, changing this frame's attributes
		local playSound = true
		if frame.noClickSound then
			playSound = false
		end

		local func = frame.func
		if not func then return end
		
		func(frame, frame.arg1, frame.arg2, checked)
		
		if playSound then
			PlaySound(1115)
		end
	end,
	GetChecked = function(frame)
		return frame.Check:IsShown()
	end,
	GetName = function(frame)
		return frame.NormalText:GetText()
	end,
	GetButtonWidth = function(frame)
		local width
		local icon = frame.Icon
		local normalText = frame.NormalText
		
		if frame.iconOnly and icon then
			width = icon:GetWidth()
		elseif ( normalText and normalText:GetText() ) then
			width = normalText:GetWidth() + 40
			
			if frame.icon then			-- Add padding for the icon
				width = width + 10
			end
		else
			return 0
		end
		
		-- Add padding if has and expand arrow or color swatch
		if frame.hasArrow or frame.hasColorSwatch then
			width = width + 10
		end
		
		if frame.notCheckable then
			width = width - 30
		end
		
		if frame.padding then
			width = width + frame.padding
		end
		
		return width
	end,
})

-- *** DropDownList ***

-- ** Utility ** 
local info = {}
local listsPool = {}		-- to do: turn this thing into an object to automate the creation of frame a bit better..
local openMenuLevel = 1
local currentOpenMenu = nil
local currentOpenMenuLevel = 1
local currentOpenMenuValue = nil
local currentInitMenu = nil

local function CreateLists(level, buttonIndex)
	-- print(format("CreateLists(level %s, buttonIndex %s)", (level or "nil"), (buttonIndex or "nil") ))
	local maxLevels = #listsPool
	-- print(format("CreateLists() #listsPool %s", #listsPool))
	
	while #listsPool < level do
		
		-- if the current level does not exist yet .. create it !
		local list = CreateFrame("Button", nil, nil, "AddonFactory_DropDownListTemplate")
		list:SetFrameStrata("FULLSCREEN_DIALOG")
		list:SetToplevel(true)
		list:Hide()
		list:SetID(#listsPool + 1)
		list:SetWidth(180)
		list:SetHeight(10)
		list.maxWidth = 180
		
		-- now add the buttons, a new list will get at least MAX_BUTTONS
		for i = 1, MAX_BUTTONS do
			local button = CreateFrame("Button", nil, list, "AddonFactory_DropDownMenuButtonTemplate")
			button:SetID(i)
			list["Button"..i] = button
		end
		
		table.insert(listsPool, list)
	end
	
	if buttonIndex <= MAX_BUTTONS then return end
	
	-- In each list, add the extra buttons ()
	for listID = 1, #listsPool do
		local list = listsPool[listID]
		
		for i = MAX_BUTTONS+1, buttonIndex do
			if not list["Button"..i] then
				local button = CreateFrame("Button", nil, list, "AddonFactory_DropDownMenuButtonTemplate")
				button:SetID(i)
				list["Button"..i] = button
			end
		end
	end
end

local function SetIconImage(icon, texture, info)
	local iconNumber = tonumber(texture)
	icon:SetTexture(iconNumber or texture)
	
	if info.tCoordLeft then
		icon:SetTexCoord(info.tCoordLeft, info.tCoordRight, info.tCoordTop, info.tCoordBottom)
	else
		icon:SetTexCoord(0, 1, 0, 1)
	end
	
	if info.tSizeX then
		icon:SetWidth(info.tSizeX)
	else
		icon:SetWidth(16)
	end
	
	if info.tSizeY then
		icon:SetHeight(info.tSizeY)
	else
		icon:SetHeight(16)
	end
	icon:Show()
end

local function GetListButton(level, buttonIndex)
	--print(format("GetListButton(level %s, buttonIndex %s)", (level or "nil"), (buttonIndex or "nil") ))
	local list = listsPool[level]
	if list then
		return list["Button" .. buttonIndex]
	end
end

local function CloseLists(level)
	level = level or 1

	for i = level, #listsPool do
		listsPool[i]:Hide()
	end
end

MVC:Controller("AddonFactory.DropDownList", {
	StartCounting = function(frame)
		if frame.parent then
			frame.parent:StartCounting()
		else
			frame.showTimer = 1		-- Time to wait to hide the menu
			frame.isCounting = 1
		end
	end,
	StopCounting = function(frame)
		if frame.parent then
			frame.parent:StopCounting()
		else
			frame.isCounting = nil
		end
	end,
	DisableButton = function(frame, level, buttonIndex)
		local button = GetListButton(level, buttonIndex)
		if button then
			button:Disable()
		end
	end,
	EnableButton = function(frame, level, buttonIndex)
		local button = GetListButton(level, buttonIndex)
		if button then
			button:Enable()
		end
	end,
	SetButtonText = function(frame, level, buttonIndex, text, colorCode)
		local button = GetListButton(level, buttonIndex)
		
		if button then
			if colorCode then
				button:SetText(colorCode..text.."|r")
			else
				button:SetText(text)
			end
		end
	end,
	SetButtonNotClickable = function(frame, level, buttonIndex)
		local button = GetListButton(level, buttonIndex)
		if button then
			button:SetDisabledFontObject(GameFontHighlight)
		end
	end,
	SetButtonClickable = function(frame, level, buttonIndex)
		local button = GetListButton(level, buttonIndex)
		if button then
			button:SetDisabledFontObject(GameFontDisable)
		end
	end,
	HideDropDownMenu = function(frame, level)
		local listFrame = listsPool[level]
		listFrame:Hide()
	end,
	OnHide = function(frame)
		local id = frame:GetID()
		
		if frame.onHide then
			frame.onHide(id+1)
			frame.onHide = nil
		end
		
		frame:Close(id+1)
	end,
	Close = function(frame, level)
		CloseLists(level)
	end,
	GetMaxButtonWidth = function(frame)
		local maxWidth = 0
		
		for i = 1, frame.numButtons do
			local button = frame["Button"..i]
			
			if button:IsShown() then
				local width = button:GetButtonWidth()
				if width > maxWidth then
					maxWidth = width
				end
			end
		end
		return maxWidth
	end,
	OpenColorPicker = function(frame, button)
		CloseMenus()
		button = button or frame
		
		currentOpenMenuValue = button.value
		
		OpenColorPicker(button)
	end,
	RefreshDropDownSize = function(frame)
		frame.maxWidth = frame:GetMaxButtonWidth()
		frame:SetWidth(frame.maxWidth + 25)
			
		for i = 1, frame.numButtons do
			local icon = frame["Button"..i].Icon
			
			if icon.tFitDropDownSizeX then
				icon:SetWidth(frame.maxWidth - 5)
			end
		end
	end,
	GetListFromPool = function(frame, level)
		return listsPool[level]
	end,
	Toggle = function(frame, level, value, dropDownFrame, anchorName, xOffset, yOffset, menuList, button, autoHideDelay)
		level = level or 1
		
		CreateLists(level, 0)

		currentOpenMenuLevel = level
		currentOpenMenuValue = value
		
		local listFrame = listsPool[level]
		local point, relativePoint, relativeTo
		
		local tempFrame
		if not dropDownFrame then
			tempFrame = button:GetParent()
		else
			tempFrame = dropDownFrame
		end
		
		if listFrame:IsShown() and currentOpenMenu == tempFrame then
			listFrame:Hide()
			return
		end
			
		-- Set the frame scale
		local uiScale
		local uiParentScale = UIParent:GetScale()
		
		if GetCVar("useUIScale") == "1" then
			uiScale = tonumber(GetCVar("uiscale"))
			if uiParentScale < uiScale then
				uiScale = uiParentScale
			end
		else
			uiScale = uiParentScale
		end
		listFrame:SetScale(uiScale)
		
		-- Hide the listframe anyways since it is redrawn OnShow() 
		listFrame:Hide()
		
		-- Frame to anchor the dropdown menu to
		local anchorFrame

		-- Display stuff
		-- Level specific stuff
		if level == 1 then	
			currentOpenMenu = dropDownFrame
			listFrame:ClearAllPoints()
			
			-- If there's no specified anchorName then use left side of the frame
			if not anchorName then
				-- See if the anchor was set manually using setanchor
				xOffset = (dropDownFrame.xOffset) and dropDownFrame.xOffset or xOffset
				yOffset = (dropDownFrame.yOffset) and dropDownFrame.yOffset or yOffset
				point = (dropDownFrame.point) and dropDownFrame.point or point
				relativeTo = (dropDownFrame.relativeTo) and dropDownFrame.relativeTo or currentOpenMenu.Left
				relativePoint = (dropDownFrame.relativePoint) and dropDownFrame.relativePoint or relativePoint
		
			elseif type(anchorName) == "string" and anchorName == "cursor" then
				relativeTo = nil
				local cursorX, cursorY = GetCursorPosition()
				cursorX = cursorX/uiScale
				cursorY =  cursorY/uiScale

				xOffset = xOffset or 0
				yOffset = yOffset or 0
				xOffset = cursorX + xOffset
				yOffset = cursorY + yOffset
			else
				-- See if the anchor was set manually using setanchor
				xOffset = (dropDownFrame.xOffset) and dropDownFrame.xOffset or xOffset
				yOffset = (dropDownFrame.yOffset) and dropDownFrame.yOffset or yOffset
				point = (dropDownFrame.point) and dropDownFrame.point or point
				relativeTo = (dropDownFrame.relativeTo) and dropDownFrame.relativeTo or anchorName
				relativePoint = (dropDownFrame.relativePoint) and dropDownFrame.relativePoint or relativePoint
			end

			xOffset = xOffset or 8
			yOffset = yOffset or 22
			point = point or "TOPLEFT"
			relativePoint = relativePoint or "BOTTOMLEFT"
			listFrame:SetPoint(point, relativeTo, relativePoint, xOffset, yOffset)
		else
			if not dropDownFrame then
				dropDownFrame = currentOpenMenu
			end
		
			listFrame:ClearAllPoints()
			-- simply anchor to the button, it's in the XML that we tell who the button is, not in here
			anchorFrame = button
			
			point = "TOPLEFT"
			relativePoint = "TOPRIGHT"
			listFrame:SetPoint(point, anchorFrame, relativePoint, 0, 0)
		end
		
		-- Change list box appearance depending on display mode
		if dropDownFrame and dropDownFrame.displayMode == "MENU_WITH_BORDERS" then
			listFrame.Backdrop:Show()
			listFrame.MenuBackdrop:Hide()
		else
			listFrame.Backdrop:Hide()
			listFrame.MenuBackdrop:Show()
		end
		
		dropDownFrame.menuList = menuList
		dropDownFrame:Initialize(dropDownFrame.initialize, dropDownFrame.displayMode, level, menuList)
		
		-- If no items in the drop down don't show it
		if listFrame.numButtons == 0 then return end

		-- Check to see if the dropdownlist is off the screen, if it is anchor it to the top of the dropdown button
		listFrame:Show()
		
		-- Hack since GetCenter() is returning coords relative to 1024x768
		-- Hack will fix this in next revision of dropdowns
		local x, y = listFrame:GetCenter()
		if not x or not y then listFrame:Hide() return end

		listFrame.onHide = dropDownFrame.onHide
		
		--  We just move level 1 enough to keep it on the screen. We don't necessarily change the anchors.
		if level == 1 then
			local offLeft = listFrame:GetLeft() / uiScale
			local offRight = (GetScreenWidth() - listFrame:GetRight()) / uiScale
			local offTop = (GetScreenHeight() - listFrame:GetTop()) / uiScale
			local offBottom = listFrame:GetBottom() / uiScale
			
			local xAddOffset, yAddOffset = 0, 0
			if offLeft < 0 then
				xAddOffset = -offLeft
			elseif offRight < 0 then
				xAddOffset = offRight
			end
			
			if offTop < 0 then
				yAddOffset = offTop
			elseif offBottom < 0 then
				yAddOffset = -offBottom
			end
			
			listFrame:ClearAllPoints()
			if type(anchorName) == "string" and anchorName == "cursor" then
				listFrame:SetPoint(point, relativeTo, relativePoint, xOffset + xAddOffset, yOffset + yAddOffset)
			else
				listFrame:SetPoint(point, relativeTo, relativePoint, xOffset + xAddOffset, yOffset + yAddOffset)
			end
		else
			-- Determine whether the menu is off the screen or not
			local offscreenY, offscreenX
			
			if (y - listFrame:GetHeight()/2) < 0 then
				offscreenY = true
			end
			
			if listFrame:GetRight() > GetScreenWidth() then
				offscreenX = true
			end
			
			if offscreenY and offscreenX then
				point = gsub(point, "TOP(.*)", "BOTTOM%1")
				point = gsub(point, "(.*)LEFT", "%1RIGHT")
				relativePoint = gsub(relativePoint, "TOP(.*)", "BOTTOM%1")
				relativePoint = gsub(relativePoint, "(.*)RIGHT", "%1LEFT")
				xOffset = -11
				yOffset = -14
				
			elseif offscreenY then
				point = gsub(point, "TOP(.*)", "BOTTOM%1")
				relativePoint = gsub(relativePoint, "TOP(.*)", "BOTTOM%1")
				xOffset = 0
				yOffset = -14
			
			elseif offscreenX then
				point = gsub(point, "(.*)LEFT", "%1RIGHT")
				relativePoint = gsub(relativePoint, "(.*)RIGHT", "%1LEFT")
				xOffset = -11
				yOffset = 14
			else
				xOffset = 0
				yOffset = 14
			end
			
			listFrame:ClearAllPoints()
			listFrame.parentID = anchorFrame:GetID()
			listFrame:SetPoint(point, anchorFrame, relativePoint, xOffset, yOffset)
		end

		if autoHideDelay and tonumber(autoHideDelay) then
			listFrame.showTimer = autoHideDelay
			listFrame.isCounting = 1
		end
	end,
})


-- *** DropDownMenu ***

local function InitializeHelper(frame)
	-- This deals with the potentially tainted stuff!
	if frame ~= currentOpenMenu then
		currentOpenMenuLevel = 1
	end

	-- Set the frame that's being intialized
	currentInitMenu = frame
	
	-- Hide all the buttons
	local button
	
	for i, list in ipairs(listsPool) do
		if i >= currentOpenMenuLevel or frame ~= currentOpenMenu then
			for j = 1, (list.numButtons or 0) do
				button = list["Button"..j]
				button:Hide()
			end
			list.numButtons = 0
			list.maxWidth = 0
			list:Hide()
		end
	end
	frame:SetHeight(BUTTON_HEIGHT * 2)
end

MVC:Controller("AddonFactory.DropDownMenu", {
	Initialize = function(frame, initFunction, displayMode, level, menuList)
		frame.menuList = menuList

		CreateLists(1, 1)	-- create at least one list, drop down menus will always need it
		InitializeHelper(frame)
		
		-- Set the initialize function and call it.  The initFunction populates the dropdown list.
		if initFunction then
			frame.initialize = initFunction
			initFunction(frame, level, frame.menuList)
		end

		--master frame
		level = level or 1
		
		local listFrame = listsPool[level]
		listFrame.dropdown = frame
		listFrame.shouldRefresh = true

		-- Change appearance based on the displayMode
		-- possible values: 
		--  MENU_WITH_BORDERS = Drop down menu is shown, the list is shown with borders	(=default)
		--  MENU_NO_BORDERS = Drop down menu is shown, the list is shown without borders
		--  LIST = Drop down menu is not shown, the list is shown without borders
		
		displayMode = displayMode or "MENU_WITH_BORDERS"
		frame.displayMode = displayMode
		
		if displayMode == "LIST" then	-- show just the list (ex: when using a icon + mouse-over)
			frame.Left:Hide()
			frame.Middle:Hide()
			frame.Right:Hide()

			local button = frame.Button
			button.NormalTexture:SetTexture("")
			button.DisabledTexture:SetTexture("")
			button.PushedTexture:SetTexture("")
			button.HighlightTexture:SetTexture("")
			button:ClearAllPoints()
			button:SetPoint("LEFT", frame.Text, "LEFT", -9, 0)
			button:SetPoint("RIGHT", frame.Text, "RIGHT", 6, 0)
		end
	end,
	Toggle = function(frame, anchor, xOffset, yOffset)
		local listFrame = listsPool[1]
		listFrame:Toggle(1, nil, frame, anchor, xOffset, yOffset)
	end,
	Refresh = function(frame, useValue, level)
		local button, checked, checkImage, uncheckImage, width
		local maxWidth = 0
		local somethingChecked = nil; 

		level = level or currentOpenMenuLevel

		local listFrame = listsPool[level]
		listFrame.numButtons = listFrame.numButtons or 0

		-- Just redraws the existing menu
		for i = 1, listFrame.numButtons do
			button = listFrame["Button" ..i]
			checked = nil

			if i <= listFrame.numButtons then
				-- See if checked or not
				if frame:GetSelectedName() then
					if button:GetText() == frame:GetSelectedName() then
						checked = 1
					end
					
				elseif frame:GetSelectedID() then
					if button:GetID() == frame:GetSelectedID() then
						checked = 1
					end
					
				elseif frame:GetSelectedValue() then
					if button.value == frame:GetSelectedValue() then
						checked = 1
					end
				end
			end
			
			if button.checked and type(button.checked) == "function" then
				checked = button.checked(button)
			end

			if not button.notCheckable and button:IsShown() then	
				-- If checked show check image
				checkImage = button.Check
				uncheckImage = button.UnCheck
				
				if checked then
					somethingChecked = true
					
					local icon = frame.Icon
					
					if button.iconOnly and icon and button.icon then
						SetIconImage(icon, button.icon, button.iconInfo)
					elseif useValue then
						frame:SetText(button.value)
						icon:Hide()
					else
						frame:SetText(button:GetText())
						icon:Hide()
					end
					
					button:LockHighlight()
					checkImage:Show()
					uncheckImage:Hide()
				else
					button:UnlockHighlight()
					checkImage:Hide()
					uncheckImage:Show()
				end
			end

			if button:IsShown() then
				width = button:GetButtonWidth()
				if width > maxWidth then
					maxWidth = width
				end
			end
		end
		
		if not somethingChecked then
			frame:SetText(VIDEO_QUALITY_LABEL6) -- "Custom"
		end
		
		if not frame.noResize then
			for i = 1, listFrame.numButtons do
				button = listFrame["Button" ..i]
				button:SetWidth(maxWidth)
			end
			frame:RefreshDropDownSize()
		end
	end,
	ClearAll = function(frame)
		-- Previous code refreshed the menu quite often and was a performance bottleneck
		frame.selectedID = nil
		frame.selectedName = nil
		frame.selectedValue = nil
		frame:SetText("")

		-- TO REVIEW !!
		-- for i = 1, frame.numButtons do
			-- local button = frame["Button"..i]
			-- button:UnlockHighlight()
			-- button.Check:Hide()
			-- button.UnCheck:Hide()
		-- end
	end,
	
	CreateInfo = function()
		-- always work with the same table, return it after it is wiped
		return wipe(info)
	end,
	AddButtonInfo = function(frame, info, level)
		-- This function is used when info is fully created outside of the controller
		level = level or 1
		
		local listFrame = listsPool[level]
		local index = listFrame and (listFrame.numButtons + 1) or 1		-- if the list exists, it's button n+1, otherwise it's 1
		local width

		CreateLists(level, index)
		listFrame = listFrame or listsPool[level]
		listFrame.numButtons = index						-- Set the number of buttons in the listFrame
		
		local button = listFrame["Button"..index]
		local normalText = button.NormalText
		local icon = button.Icon
		
		-- This button is used to capture the mouse OnEnter/OnLeave events if the dropdown button is disabled, since a disabled button doesn't receive any events
		-- This is used specifically for drop down menu time outs
		local invisibleButton = button.InvisibleButton
		
		-- Default settings
		button:SetDisabledFontObject(GameFontDisable)
		invisibleButton:Hide()
		button:Enable()
		
		-- If not clickable then disable the button and set it white
		if info.notClickable then
			info.disabled = 1
			button:SetDisabledFontObject(GameFontHighlight)
		end

		-- Set the text color and disable it if its a title
		if info.isTitle then
			info.disabled = 1
			button:SetDisabledFontObject(GameFontNormal)
		end
		
		-- Disable the button if disabled and turn off the color code
		if info.disabled then
			button:Disable()
			invisibleButton:Show()
			info.colorCode = nil
		end
		
		-- If there is a color for a disabled line, set it
		if info.disablecolor then
			info.colorCode = info.disablecolor
		end

		-- Configure button
		if info.text then
			-- look for inline color code this is only if the button is enabled
			if info.colorCode then
				button:SetText(info.colorCode..info.text.."|r")
			else
				button:SetText(info.text)
			end
			
			-- Set icon
			if info.icon then
				icon:SetSize(16,16)
				icon:SetTexture(info.icon)
				icon:ClearAllPoints()
				icon:SetPoint("RIGHT")

				if info.tCoordLeft then
					icon:SetTexCoord(info.tCoordLeft, info.tCoordRight, info.tCoordTop, info.tCoordBottom)
				else
					icon:SetTexCoord(0, 1, 0, 1)
				end
				icon:Show()
			else
				icon:Hide()
			end

			-- Check to see if there is a replacement font
			if info.fontObject then
				button:SetNormalFontObject(info.fontObject)
				button:SetHighlightFontObject(info.fontObject)
			else
				button:SetNormalFontObject(GameFontHighlight)
				button:SetHighlightFontObject(GameFontHighlight)
			end
		else
			button:SetText("")
			icon:Hide()
		end
		
		button.iconOnly = nil;
		button.icon = nil;
		button.iconInfo = nil;
		
		if info.iconInfo then
			icon.tFitDropDownSizeX = info.iconInfo.tFitDropDownSizeX
		else
			icon.tFitDropDownSizeX = nil
		end
		
		if info.iconOnly and info.icon then
			button.iconOnly = true
			button.icon = info.icon
			button.iconInfo = info.iconInfo

			SetIconImage(icon, info.icon, info.iconInfo)
			icon:ClearAllPoints()
			icon:SetPoint("LEFT")
		end

		-- Pass through attributes
		button.func = info.func
		button.owner = info.owner
		button.hasOpacity = info.hasOpacity
		button.opacity = info.opacity
		button.opacityFunc = info.opacityFunc
		button.cancelFunc = info.cancelFunc
		button.swatchFunc = info.swatchFunc
		button.keepShownOnClick = info.keepShownOnClick
		button.tooltipTitle = info.tooltipTitle
		button.tooltipText = info.tooltipText
		button.arg1 = info.arg1
		button.arg2 = info.arg2
		button.hasArrow = info.hasArrow
		button.hasColorSwatch = info.hasColorSwatch
		button.notCheckable = info.notCheckable
		button.menuList = info.menuList
		button.tooltipWhileDisabled = info.tooltipWhileDisabled
		button.tooltipOnButton = info.tooltipOnButton
		button.noClickSound = info.noClickSound
		button.padding = info.padding

		if info.value then
			button.value = info.value
		elseif info.text then
			button.value = info.text
		else
			button.value = nil
		end
		
		-- Show the expand arrow if it has one
		if info.hasArrow then
			button.ExpandArrow:Show()
		else
			button.ExpandArrow:Hide()
		end
		button.hasArrow = info.hasArrow
		
		-- If not checkable move everything over to the left to fill in the gap where the check would be
		local xPos = 5
		local yPos = -((button:GetID() - 1) * BUTTON_HEIGHT) - BORDER_HEIGHT
		local displayInfo = normalText
		
		if info.iconOnly then
			displayInfo = icon
		end
		displayInfo:ClearAllPoints()
		
		if info.notCheckable then
			if info.justifyH and info.justifyH == "CENTER" then
				displayInfo:SetPoint("CENTER", button, "CENTER", -7, 0)
			else
				displayInfo:SetPoint("LEFT", button, "LEFT", 0, 0)
			end
			xPos = xPos + 10
			
		else
			xPos = xPos + 12
			displayInfo:SetPoint("LEFT", button, "LEFT", 20, 0)
		end

		-- Adjust offset if displayMode is menu
		local frame = currentOpenMenu
		if frame and frame.displayMode == "LIST" then
			if not info.notCheckable then
				xPos = xPos - 6
			end
		end
		
		-- If no open frame then set the frame to the currently initialized frame
		frame = frame or currentInitMenu

		if info.leftPadding then
			xPos = xPos + info.leftPadding
		end
		button:SetPoint("TOPLEFT", button:GetParent(), "TOPLEFT", xPos, yPos)

		-- See if button is selected by id or name
		if frame then
			if frame:GetSelectedName() then
				if button:GetText() == frame:GetSelectedName() then
					info.checked = 1
				end
				
			elseif frame:GetSelectedID() then
				if button:GetID() == frame:GetSelectedID() then
					info.checked = 1
				end
				
			elseif frame:GetSelectedValue() then
				if button.value == frame:GetSelectedValue() then
					info.checked = 1
				end
			end
		end

		if not info.notCheckable then 
			if info.isNotRadio then
				button.Check:SetTexCoord(0.0, 0.5, 0.0, 0.5)
				button.UnCheck:SetTexCoord(0.5, 1.0, 0.0, 0.5)
			else
				button.Check:SetTexCoord(0.0, 0.5, 0.5, 1.0)
				button.UnCheck:SetTexCoord(0.5, 1.0, 0.5, 1.0)
			end
			
			-- Checked can be a function now
			local checked = info.checked
			if type(checked) == "function" then
				checked = checked(button)
			end

			-- Show the check if checked
			if checked then
				button:LockHighlight()
				button.Check:Show()
				button.UnCheck:Hide()
			else
				button:UnlockHighlight();
				button.Check:Hide()
				button.UnCheck:Show()
			end
		else
			button.Check:Hide()
			button.UnCheck:Hide()
		end	
		button.checked = info.checked

		-- If has a colorswatch, show it and vertex color it
		local colorSwatch = button.ColorSwatch
		
		if info.hasColorSwatch then
			colorSwatch.NormalTexture:SetVertexColor(info.r, info.g, info.b)
			button.r = info.r
			button.g = info.g
			button.b = info.b
			colorSwatch:Show()
		else
			colorSwatch:Hide()
		end

		width = max(button:GetButtonWidth(), info.minWidth or 0)
		--Set maximum button width
		if width > listFrame.maxWidth then
			listFrame.maxWidth = width
		end

		-- Set the height of the listFrame
		listFrame:SetHeight((index * BUTTON_HEIGHT) + (BORDER_HEIGHT * 2))
		button:Show()
	end,
	AddButton = function(frame, text, value, func, icon, isChecked, level)
		local info = frame:CreateInfo()
		
		info.text		= text
		info.value		= value
		info.func		= func
		info.icon		= icon
		info.checked	= isChecked
		frame:AddButtonInfo(info, level or 1)
	end,
	AddButtonWithArgs = function(frame, text, value, func, arg1, arg2, isChecked, level)
		local info = frame:CreateInfo()
		
		info.text		= text
		info.value		= value
		info.func		= func
		info.arg1		= arg1
		info.arg2		= arg2
		info.checked	= isChecked
		frame:AddButtonInfo(info, level or 1)
	end,
	AddCategoryButton = function(frame, text, value, level)
		local info = frame:CreateInfo()
		
		info.text = text
		info.hasArrow = 1
		info.value = value
		frame:AddButtonInfo(info, level)
	end,
	AddCloseMenu = function(frame)
		local info = frame:CreateInfo()

		info.text = CLOSE
		info.func = function(frame) CloseLists() end
		info.icon = nil
		info.checked = nil
		info.notCheckable = 1
		frame:AddButtonInfo(info, 1)
	end,
	AddTitle = function(frame, text, icon, level)
		local info = frame:CreateInfo()

		info.isTitle = 1
		info.text = text or ""
		info.icon = icon
		info.checked = nil
		info.notCheckable = 1
		frame:AddButtonInfo(info, level or 1)
	end,
	Close = function(frame, level)
		CloseLists(level)
	end,
	DisableDropDown = function(frame)
		frame.Text:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
		frame.Button:Disable()
		frame.isDisabled = 1
	end,
	EnableDropDown = function(frame)
		frame.Text:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
		frame.Button:Enable()
		frame.isDisabled = nil
	end,
	IsEnabled = function(frame)
		return not frame.isDisabled
	end,
	SetAnchor = function(frame, xOffset, yOffset, point, relativeTo, relativePoint)
		frame.xOffset = xOffset
		frame.yOffset = yOffset
		frame.point = point
		frame.relativeTo = relativeTo
		frame.relativePoint = relativePoint
	end,
	SetMenuWidth = function(frame, width, padding)
		local defaultPadding = 25
		
		frame.Middle:SetWidth(width)
		
		if padding then
			frame:SetWidth(width + padding)
			frame.Text:SetWidth(width)
		else
			frame:SetWidth(width + defaultPadding + defaultPadding)
			frame.Text:SetWidth(width - defaultPadding)
		end
		
		frame.noResize = 1
	end,
	SetButtonWidth = function(frame, width)
		if width == "TEXT" then
			width = frame.Text:GetWidth()
		end
		
		frame.Button:SetWidth(width)
		frame.noResize = 1
	end,
	SetText = function(frame, text)
		frame.Text:SetText(text)
	end,
	GetText = function(frame)
		return frame.Text:GetText()
	end,
	JustifyText = function(frame, justification)
		local text = frame.Text
		text:ClearAllPoints()
		
		if justification == "LEFT" then
			text:SetPoint("LEFT", frame.Left, "LEFT", 27, 2)
			text:SetJustifyH("LEFT")
			
		elseif justification == "RIGHT" then
			text:SetPoint("RIGHT", frame.Right, "RIGHT", -43, 2)
			text:SetJustifyH("RIGHT")
			
		elseif justification == "CENTER" then
			text:SetPoint("CENTER", frame.Middle, "CENTER", -5, 2)
			text:SetJustifyH("CENTER")
		end
	end,
	SetSelectedName = function(frame, name, useValue)
		frame.selectedName = name
		frame.selectedID = nil
		frame.selectedValue = nil
		frame:Refresh(useValue)
	end,
	GetSelectedName = function(frame)
		return frame.selectedName
	end,
	SetSelectedValue = function(frame, value, useValue)
		-- useValue will set the value as the text, not the name
		frame.selectedName = nil
		frame.selectedID = nil
		frame.selectedValue = value
		frame:Refresh(useValue)
	end,
	GetSelectedValue = function(frame)
		return frame.selectedValue
	end,
	SetSelectedID = function(frame, id, useValue)
		frame.selectedID = id
		frame.selectedName = nil
		frame.selectedValue = nil
		frame:Refresh(useValue)
	end,
	GetSelectedID = function(frame)
		if frame.selectedID then
			return frame.selectedID
		end

		-- If no explicit selectedID then try to send the id of a selected value or name
		local i = 1
		local button = GetListButton(openMenuLevel, i)
		
		while button do
			-- See if checked or not
			if frame:GetSelectedName() then
				if button:GetText() == frame:GetSelectedName() then
					return i
				end
			elseif frame:GetSelectedValue() then
				if button.value == frame:GetSelectedValue() then
					return i
				end
			end
			i = i + 1
			button = GetListButton(openMenuLevel, i)
		end
	end,
	GetCurrentOpenMenuValue = function(frame)
		return currentOpenMenuValue
	end,
})
