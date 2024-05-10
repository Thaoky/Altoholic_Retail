local addonName = "Altoholic"
local addon = _G[addonName]
local L = DataStore:GetLocale(addonName)

local STAT_PRIO = 1
local STAT_UNKNOWN = 2

addon:Controller("AltoholicUI.TalentSpecialization", {
	Update = function(frame, character, class, specializationIndex)
		local _, specName = DataStore:GetSpecializationInfo(class, specializationIndex)
		
		if specName then
			DataStore:IterateTalentTiers(function(tierIndex, level) 
				frame["Tier"..tierIndex]:Update(character, class, specializationIndex)
			end)

			frame.tooltip = STAT_PRIO
			frame.class = class
			frame.spec = specializationIndex
		else
			DataStore:IterateTalentTiers(function(tierIndex, level) 
				frame["Tier"..tierIndex]:Hide()
			end)
			
			frame.tooltip = STAT_UNKNOWN
		end
		
		frame.SpecInfo.Name:SetText(specName or "?")
		frame:Show()
	end,
	SpecInfo_OnEnter = function(frame, button)
		local tt = AddonFactory_Tooltip
	
		if frame.tooltip == STAT_PRIO then
			tt:ClearLines()
			tt:SetOwner(button, "ANCHOR_TOP")
			tt:AddLine(L["TALENT_SPECIALIZATION_STAT_PRIORITY"], 0, 1, 0)
			tt:AddLine(" ", 1, 1, 1)
			for i, priority in pairs(DataStore:GetStatPriority(frame.class, frame.spec)) do
				tt:AddLine(format("%s%d. %s%s", addon.Colors.cyan, i, addon.Colors.white, priority), 1, 1, 1)
			end

			tt:AddLine(" ", 1, 1, 1)
			tt:AddLine(format("%s: %s", L["Source"], "Icy Veins (9.0)"), 1, 1, 0)
			tt:Show()
			
		elseif frame.tooltip == STAT_UNKNOWN then
			tt:ClearLines()
			tt:SetOwner(button, "ANCHOR_TOP")
			tt:AddLine(INFO)
			tt:AddLine(" ", 1, 1, 1)
			tt:AddLine(L["TALENT_SPECIALIZATION_UNKOWN"],  1, 1, 1)
			tt:Show()
		end
	end,
})
