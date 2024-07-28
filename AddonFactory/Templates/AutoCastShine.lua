local MVC = LibStub("LibMVC-1.0")

local SHINE_R = .95
local SHINE_G = .95
local SHINE_B = .32

local activeButtons = {}	-- buttons with an active auto-cast shine animation
local shineTimers = { 0, 0, 0, 0 }
local shineSpeeds = { 20, 40, 60, 80 }

MVC:Controller("AddonFactory.AutoCastShine", {
	ShineStart = function(frame, r, g, b)
		if activeButtons[frame] then return end	-- already active ? exit
		
		activeButtons[frame] = true
		
		if not r then
			r, g, b = SHINE_R, SHINE_G, SHINE_B
		end
		
		for _, sparkle in pairs(frame.Sparkles) do
			sparkle:Show()
			sparkle:SetVertexColor(r, g, b)
		end
	end,
	ShineStop = function(frame)
		activeButtons[frame] = nil
		
		for _, sparkle in pairs(frame.Sparkles) do
			sparkle:Hide()
		end
	end,
	Shine_OnUpdate = function(frame, elapsed)
		for i = 1, #shineTimers do
			shineTimers[i] = shineTimers[i] + elapsed
			if shineTimers[i] > (shineSpeeds[i]*4) then
				shineTimers[i] = 0
			end
		end

		for button, _ in pairs(activeButtons) do
			local distance = button:GetWidth()
			local sparkles = button.Sparkles
				
			for i = 1, 4 do
				local timer = shineTimers[i]
				local speed = shineSpeeds[i]
				
				if ( timer <= speed ) then
					local basePosition = timer/speed*distance
					sparkles[0+i]:SetPoint("CENTER", button, "TOPLEFT", basePosition, 0)
					sparkles[4+i]:SetPoint("CENTER", button, "BOTTOMRIGHT", -basePosition, 0)
					sparkles[8+i]:SetPoint("CENTER", button, "TOPRIGHT", 0, -basePosition)
					sparkles[12+i]:SetPoint("CENTER", button, "BOTTOMLEFT", 0, basePosition)
				elseif ( timer <= speed*2 ) then
					local basePosition = (timer-speed)/speed*distance
					sparkles[0+i]:SetPoint("CENTER", button, "TOPRIGHT", 0, -basePosition)
					sparkles[4+i]:SetPoint("CENTER", button, "BOTTOMLEFT", 0, basePosition)
					sparkles[8+i]:SetPoint("CENTER", button, "BOTTOMRIGHT", -basePosition, 0)
					sparkles[12+i]:SetPoint("CENTER", button, "TOPLEFT", basePosition, 0)	
				elseif ( timer <= speed*3 ) then
					local basePosition = (timer-speed*2)/speed*distance
					sparkles[0+i]:SetPoint("CENTER", button, "BOTTOMRIGHT", -basePosition, 0)
					sparkles[4+i]:SetPoint("CENTER", button, "TOPLEFT", basePosition, 0)
					sparkles[8+i]:SetPoint("CENTER", button, "BOTTOMLEFT", 0, basePosition)
					sparkles[12+i]:SetPoint("CENTER", button, "TOPRIGHT", 0, -basePosition)	
				else
					local basePosition = (timer-speed*3)/speed*distance
					sparkles[0+i]:SetPoint("CENTER", button, "BOTTOMLEFT", 0, basePosition)
					sparkles[4+i]:SetPoint("CENTER", button, "TOPRIGHT", 0, -basePosition)
					sparkles[8+i]:SetPoint("CENTER", button, "TOPLEFT", basePosition, 0)
					sparkles[12+i]:SetPoint("CENTER", button, "BOTTOMRIGHT", -basePosition, 0)
				end
			end	
		end
	end,
})
