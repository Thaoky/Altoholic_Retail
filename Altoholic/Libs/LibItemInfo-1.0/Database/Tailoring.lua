--	*** LibItemInfo ***
-- Written by : Thaoky, EU-Marécages de Zangar
-- March 2021
-- This list was manually curated (source: mostly Wowhead + in-game).
-- Non-commercial use is permitted as long as credits are preserved, and that Blizzard's terms of services are respected.

local lib = LibStub("LibItemInfo-1.0")

local e = lib.Enum.ReagentTypes
local SetReagent = lib.SetReagent

lib:RegisterItems({
	-- 1.0 Classic
	[2320] = SetReagent(0, e.Tailoring), -- Coarse Thread
	[2321] = SetReagent(0, e.Tailoring), -- Fine Thread
	[2589] = SetReagent(0, e.Tailoring), -- Linen Cloth
	[2592] = SetReagent(0, e.Tailoring), -- Wool Cloth
	[2996] = SetReagent(0, e.Tailoring), -- Bolt of Linen Cloth
	[2997] = SetReagent(0, e.Tailoring), -- Bolt of Woolen Cloth
	[3182] = SetReagent(0, e.Tailoring), -- Spider's Silk
	[4305] = SetReagent(0, e.Tailoring), -- Bolt of Silk Cloth
	[4306] = SetReagent(0, e.Tailoring), -- Silk Cloth
	[4291] = SetReagent(0, e.Tailoring), -- Silken Thread
	[4337] = SetReagent(0, e.Tailoring), -- Thick Spider's Silk
	[4338] = SetReagent(0, e.Tailoring), -- Mageweave Cloth
	[4339] = SetReagent(0, e.Tailoring), -- Bolt of Mageweave
	[8343] = SetReagent(0, e.Tailoring), -- Heavy Silken Thread
	[10285] = SetReagent(0, e.Tailoring), -- Shadow Silk
	[14047] = SetReagent(0, e.Tailoring), -- Runecloth
	[14048] = SetReagent(0, e.Tailoring), -- Bolt of Runecloth
	[14227] = SetReagent(0, e.Tailoring), -- Ironweb Spider Silk
	[14256] = SetReagent(0, e.Tailoring), -- Felcloth
	[14341] = SetReagent(0, e.Tailoring), -- Rune Thread
	[14342] = SetReagent(0, e.Tailoring), -- Mooncloth
	
	-- 2.0 BC
	[21840] = SetReagent(1, e.Tailoring), -- Bolt of Netherweave
	[21842] = SetReagent(1, e.Tailoring), -- Bolt of Imbued Netherweave
	[21844] = SetReagent(1, e.Tailoring), -- Bolt of Soulcloth
	[21845] = SetReagent(1, e.Tailoring), -- Primal Mooncloth
	[21877] = SetReagent(1, e.Tailoring), -- Netherweave Cloth
	[21881] = SetReagent(1, e.Tailoring), -- Netherweb Spider Silk
	[24271] = SetReagent(1, e.Tailoring), -- Spellcloth
	[24272] = SetReagent(1, e.Tailoring), -- Shadowcloth
	
	-- 3.0 WotLK
	[33470] = SetReagent(2, e.Tailoring), -- Frostweave Cloth
	[41510] = SetReagent(2, e.Tailoring), -- Bolt of Frostweave
	[41511] = SetReagent(2, e.Tailoring), -- Bolt of Imbued Frostweave
	[41593] = SetReagent(2, e.Tailoring), -- Ebonweave
	[41594] = SetReagent(2, e.Tailoring), -- Moonshroud
	[41595] = SetReagent(2, e.Tailoring), -- Spellweave
	[42253] = SetReagent(2, e.Tailoring), -- Iceweb Spider Silk
	
	-- 4.0 Cataclysm
	[53010] = SetReagent(3, e.Tailoring), -- Embersilk Cloth
	[53643] = SetReagent(3, e.Tailoring), -- Bolt of Embersilk Cloth
	[54440] = SetReagent(3, e.Tailoring), -- Dreamcloth
	
	-- 5.0 Mists of Pandaria
	[38426] = SetReagent(4, e.Tailoring), -- Eternium Thread
	[72988] = SetReagent(4, e.Tailoring), -- Windwool Cloth
	[82441] = SetReagent(4, e.Tailoring), -- Bolt of Windwool Cloth
	[82447] = SetReagent(4, e.Tailoring), -- Imperial Silk
	[98619] = SetReagent(4, e.Tailoring), -- Celestial Cloth
	
	-- 6.0 Warlords of Draenor
	[111556] = SetReagent(5, e.Tailoring), -- Hexweave Cloth
	[111557] = SetReagent(5, e.Tailoring), -- Sumptuous Fur
	
	-- 7.0 Legion
	[124437] = SetReagent(6, e.Tailoring), -- Shal'dorei Silk
	[127004] = SetReagent(6, e.Tailoring), -- Imbued Silkweave
	[127037] = SetReagent(6, e.Tailoring), -- Runic Catgut
	[127681] = SetReagent(6, e.Tailoring), -- Sharp Spritethorn
	[151567] = SetReagent(6, e.Tailoring), -- Lightweave Cloth
	
	-- 8.0 Battle for Azeroth
	[152576] = SetReagent(7, e.Tailoring), -- Tidespray Linen
	[152577] = SetReagent(7, e.Tailoring), -- Deep Sea Satin
	[158378] = SetReagent(7, e.Tailoring), -- Embroidered Deep Sea Satin
	[159959] = SetReagent(7, e.Tailoring), -- Nylon Thread
	[167738] = SetReagent(7, e.Tailoring), -- Gilded Seaweave
	
	-- 9.0 Shadowlands
	[172439] = SetReagent(8, e.Tailoring), -- Enchanted Lightless Silk
	[173202] = SetReagent(8, e.Tailoring), -- Shrouded Cloth
	[173204] = SetReagent(8, e.Tailoring), -- Lightless Silk
	[177062] = SetReagent(8, e.Tailoring), -- Penumbra Thread
	[187703] = SetReagent(8, e.Tailoring), -- Silken Protofiber
	
	-- 10.0 Dragonflight
	[192095] = SetReagent(9, e.Tailoring), -- Spool of Wilderthread 1
	[192096] = SetReagent(9, e.Tailoring), -- Spool of Wilderthread 2
	[192097] = SetReagent(9, e.Tailoring), -- Spool of Wilderthread 3
	[193050] = SetReagent(9, e.Tailoring), -- Tattered Wildercloth
	[193053] = SetReagent(9, e.Tailoring), -- Contoured Fowlfeather
	[193922] = SetReagent(9, e.Tailoring), -- Wildercloth
	[193923] = SetReagent(9, e.Tailoring), -- Decayed Wildercloth
	[193924] = SetReagent(9, e.Tailoring), -- Frostbitten Wildercloth
	[193925] = SetReagent(9, e.Tailoring), -- Singed Wildercloth
	[193926] = SetReagent(9, e.Tailoring), -- Wildercloth Bolt 1
	[193927] = SetReagent(9, e.Tailoring), -- Wildercloth Bolt 2
	[193928] = SetReagent(9, e.Tailoring), -- Wildercloth Bolt 3
	[193929] = SetReagent(9, e.Tailoring), -- Vibrant Wildercloth Bolt 1
	[193930] = SetReagent(9, e.Tailoring), -- Vibrant Wildercloth Bolt 2
	[193931] = SetReagent(9, e.Tailoring), -- Vibrant Wildercloth Bolt 3
	[193932] = SetReagent(9, e.Tailoring), -- Infurious Wildercloth Bolt 1
	[193933] = SetReagent(9, e.Tailoring), -- Infurious Wildercloth Bolt 2
	[193934] = SetReagent(9, e.Tailoring), -- Infurious Wildercloth Bolt 3
	[193935] = SetReagent(9, e.Tailoring), -- Chronocloth Bolt 1
	[193936] = SetReagent(9, e.Tailoring), -- Chronocloth Bolt 2
	[193937] = SetReagent(9, e.Tailoring), -- Chronocloth Bolt 3
	[193938] = SetReagent(9, e.Tailoring), -- Azureweave Bolt 1
	[193939] = SetReagent(9, e.Tailoring), -- Azureweave Bolt 2
	[193940] = SetReagent(9, e.Tailoring), -- Azureweave Bolt 3

	[193956] = SetReagent(9, e.Tailoring), -- Blazing Embroidery Thread 1
	[193957] = SetReagent(9, e.Tailoring), -- Blazing Embroidery Thread 2
	[193958] = SetReagent(9, e.Tailoring), -- Blazing Embroidery Thread 3
	[193959] = SetReagent(9, e.Tailoring), -- Chromatic Embroidery Thread 1
	[193960] = SetReagent(9, e.Tailoring), -- Chromatic Embroidery Thread 2
	[193961] = SetReagent(9, e.Tailoring), -- Chromatic Embroidery Thread 3
	[193962] = SetReagent(9, e.Tailoring), -- Shimmering Embroidery Thread 1
	[193963] = SetReagent(9, e.Tailoring), -- Shimmering Embroidery Thread 2
	[193964] = SetReagent(9, e.Tailoring), -- Shimmering Embroidery Thread 3
	
	-- 11.0 The War Within
	[224826] = SetReagent(10, e.Tailoring), -- Dawnweave 1
	[228235] = SetReagent(10, e.Tailoring), -- Dawnweave 2
	[228236] = SetReagent(10, e.Tailoring), -- Dawnweave 3
	[222801] = SetReagent(10, e.Tailoring), -- Dawnweave Bolt 1
	[222802] = SetReagent(10, e.Tailoring), -- Dawnweave Bolt 2
	[222803] = SetReagent(10, e.Tailoring), -- Dawnweave Bolt 3
	[224824] = SetReagent(10, e.Tailoring), -- Duskweave 1
	[228233] = SetReagent(10, e.Tailoring), -- Duskweave 2
	[228234] = SetReagent(10, e.Tailoring), -- Duskweave 3
	[222798] = SetReagent(10, e.Tailoring), -- Duskweave Bolt 1
	[222799] = SetReagent(10, e.Tailoring), -- Duskweave Bolt 2
	[222800] = SetReagent(10, e.Tailoring), -- Duskweave Bolt 3
	[224832] = SetReagent(10, e.Tailoring), -- Exquisite Weavercloth Bolt 1
	[224833] = SetReagent(10, e.Tailoring), -- Exquisite Weavercloth Bolt 2
	[224834] = SetReagent(10, e.Tailoring), -- Exquisite Weavercloth Bolt 3
	[222792] = SetReagent(10, e.Tailoring), -- Spool of Dawnthread 1
	[222793] = SetReagent(10, e.Tailoring), -- Spool of Dawnthread 2
	[222794] = SetReagent(10, e.Tailoring), -- Spool of Dawnthread 3
	[222789] = SetReagent(10, e.Tailoring), -- Spool of Duskthread 1
	[222790] = SetReagent(10, e.Tailoring), -- Spool of Duskthread 2
	[222791] = SetReagent(10, e.Tailoring), -- Spool of Duskthread 3
	[222795] = SetReagent(10, e.Tailoring), -- Spool of Weaverthread 1
	[222796] = SetReagent(10, e.Tailoring), -- Spool of Weaverthread 2
	[222797] = SetReagent(10, e.Tailoring), -- Spool of Weaverthread 3
	[224828] = SetReagent(10, e.Tailoring), -- Weavercloth 1
	[228231] = SetReagent(10, e.Tailoring), -- Weavercloth 2
	[228232] = SetReagent(10, e.Tailoring), -- Weavercloth 3
	[222804] = SetReagent(10, e.Tailoring), -- Weavercloth Bolt 1
	[222805] = SetReagent(10, e.Tailoring), -- Weavercloth Bolt 2
	[222806] = SetReagent(10, e.Tailoring), -- Weavercloth Bolt 3
	
})