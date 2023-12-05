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
	[723] = SetReagent(0, e.Cooking), -- Goretusk Liver
	[769] = SetReagent(0, e.Cooking), -- Chunk of Boar Meat
	[1015] = SetReagent(0, e.Cooking), -- Lean Wolf Flank
	[1080] = SetReagent(0, e.Cooking), -- Tough Condor Meat
	[1468] = SetReagent(0, e.Cooking), -- Murloc Fin
	[2251] = SetReagent(0, e.Cooking), -- Gooey Spider Leg
	[2672] = SetReagent(0, e.Cooking), -- String Wolf Meat
	[2673] = SetReagent(0, e.Cooking), -- Coyote Meat
	[2675] = SetReagent(0, e.Cooking), -- Crawler Claw
	[2677] = SetReagent(0, e.Cooking), -- Boar Ribs
	[2678] = SetReagent(0, e.Cooking), -- Mild Spices
	[2886] = SetReagent(0, e.Cooking), -- Crag Boar Rib
	[2924] = SetReagent(0, e.Cooking), -- Crocolisk Meat
	[3173] = SetReagent(0, e.Cooking), -- Bear Meat
	[3404] = SetReagent(0, e.Cooking), -- Buzzard Wing
	[3667] = SetReagent(0, e.Cooking), -- Tender Crocolisk Meat
	[3685] = SetReagent(0, e.Cooking), -- Raptor Egg
	[3712] = SetReagent(0, e.Cooking), -- Turtle Meat
	[3730] = SetReagent(0, e.Cooking), -- Big Bear Meat
	[3731] = SetReagent(0, e.Cooking), -- Lion Meat
	[4402] = SetReagent(0, e.Cooking), -- Small Flame Sac
	[4655] = SetReagent(0, e.Cooking), -- Giant Clam Meat
	[5051] = SetReagent(0, e.Cooking), -- Dig Rat
	[5465] = SetReagent(0, e.Cooking), -- Small Spider Leg
	[5466] = SetReagent(0, e.Cooking), -- Scorpid Stinger
	[5467] = SetReagent(0, e.Cooking), -- Kodo Meat
	[5471] = SetReagent(0, e.Cooking), -- Stag Meat
	
	-- TO DO : check if it goes into a fishing bag ..
	[5468] = SetReagent(0, e.Cooking), -- Soft Frenzy Flesh
	
	[5469] = SetReagent(0, e.Cooking), -- Strider Meat
	[5470] = SetReagent(0, e.Cooking), -- Thunder Lizard Tail
	[5503] = SetReagent(0, e.Cooking), -- Clam Meat
	[5504] = SetReagent(0, e.Cooking), -- Tangy Clam Meat
	[6889] = SetReagent(0, e.Cooking), -- Small Egg
	[7974] = SetReagent(0, e.Cooking), -- Zesty Clam Meat
	[12037] = SetReagent(0, e.Cooking), -- Mystery Meat
	[12184] = SetReagent(0, e.Cooking), -- Raptor Flesh
	[12202] = SetReagent(0, e.Cooking), -- Tiger Meat
	[12203] = SetReagent(0, e.Cooking), -- Red Wolf Meat
	[12204] = SetReagent(0, e.Cooking), -- Heavy Kodo Meat
	[12205] = SetReagent(0, e.Cooking), -- White Spider Meat
	[12206] = SetReagent(0, e.Cooking), -- Tender Crab Meat
	[12207] = SetReagent(0, e.Cooking), -- Giant Egg
	[12208] = SetReagent(0, e.Cooking), -- Tender Wolf Meat
	[12223] = SetReagent(0, e.Cooking), -- Meaty Bat Wing
	[20424] = SetReagent(0, e.Cooking), -- Sandworm Meat
	[21024] = SetReagent(0, e.Cooking), -- Chimaerok Tenderloin
	[22644] = SetReagent(0, e.Cooking), -- Crunchy Spider Leg
	[23676] = SetReagent(0, e.Cooking), -- Moongraze Stag Tenderloin
	[27668] = SetReagent(0, e.Cooking), -- Lynx Meat
	[27669] = SetReagent(0, e.Cooking), -- Bat Flesh
	[30817] = SetReagent(0, e.Cooking), -- Simple Flour
	[35562] = SetReagent(0, e.Cooking), -- Bear Flank
	[67229] = SetReagent(0, e.Cooking), -- Stag Flank
	
	-- holiday spices = feast of winter veil
	[17194] = SetReagent(0, e.Cooking), -- Holiday Spices
	
	-- 2.0 BC
	[24477] = SetReagent(1, e.Cooking), -- Jaggal Clam Meat
	[27671] = SetReagent(1, e.Cooking), -- Buzzard Meat
	[27674] = SetReagent(1, e.Cooking), -- Ravager Flesh
	[27677] = SetReagent(1, e.Cooking), -- Chunk o' Basilisk
	[27678] = SetReagent(1, e.Cooking), -- Clefthoof Meat
	[27681] = SetReagent(1, e.Cooking), -- Warped Flesh
	[27682] = SetReagent(1, e.Cooking), -- Talbuk Venison
	[31670] = SetReagent(1, e.Cooking), -- Raptor Ribs
	[31671] = SetReagent(1, e.Cooking), -- Serpent Flesh

	-- 3.0 WotLK
	[34736] = SetReagent(2, e.Cooking), -- Chunk o' Mammoth
	[36782] = SetReagent(2, e.Cooking), -- Succulent Clam Meat
	[43007] = SetReagent(2, e.Cooking), -- Northern Spices
	[43009] = SetReagent(2, e.Cooking), -- Shoveltusk Flank
	[43010] = SetReagent(2, e.Cooking), -- Worm Meat
	[43011] = SetReagent(2, e.Cooking), -- Worg Haunch
	[43012] = SetReagent(2, e.Cooking), -- Rhino Meat
	[43013] = SetReagent(2, e.Cooking), -- Chilled Meat
	[43501] = SetReagent(2, e.Cooking), -- Northern Egg
	
	-- 4.0 Cataclysm
	[62778] = SetReagent(3, e.Cooking), -- Toughened Flesh
	[62779] = SetReagent(3, e.Cooking), -- Monstrous Claw
	[62780] = SetReagent(3, e.Cooking), -- Snake Eye
	[62781] = SetReagent(3, e.Cooking), -- Giant Turtle Tongue
	[62782] = SetReagent(3, e.Cooking), -- Dragon Flank
	[62783] = SetReagent(3, e.Cooking), -- Basilisk "Liver"
	[62784] = SetReagent(3, e.Cooking), -- Crocolisk Tail
	[62785] = SetReagent(3, e.Cooking), -- Delicate Wing
	[62786] = SetReagent(3, e.Cooking), -- Cocoa Beans
	[62791] = SetReagent(3, e.Cooking), -- Blood Shrimp
	
	-- 5.0 Mists of Pandaria
	[74659] = SetReagent(4, e.Cooking), -- Farm Chicken
	[74660] = SetReagent(4, e.Cooking), -- Pandaren Peach
	[74661] = SetReagent(4, e.Cooking), -- Black Pepper
	[74662] = SetReagent(4, e.Cooking), -- Rice Flour
	[74832] = SetReagent(4, e.Cooking), -- Barley
	[74833] = SetReagent(4, e.Cooking), -- Raw Tiger Steak
	[74834] = SetReagent(4, e.Cooking), -- Mushan Ribs
	[74837] = SetReagent(4, e.Cooking), -- Raw Turtle Meat
	[74838] = SetReagent(4, e.Cooking), -- Raw Crab Meat
	[74839] = SetReagent(4, e.Cooking), -- Wildfowl Breast
	[74840] = SetReagent(4, e.Cooking), -- Green Cabbage
	[74841] = SetReagent(4, e.Cooking), -- Juicycrunch Carrot
	[74842] = SetReagent(4, e.Cooking), -- Mogu Pumpkin
	[74843] = SetReagent(4, e.Cooking), -- Scallions
	[74844] = SetReagent(4, e.Cooking), -- Red Blossom Leek
	[74845] = SetReagent(4, e.Cooking), -- Ginseng
	[74846] = SetReagent(4, e.Cooking), -- Witchberries
	[74847] = SetReagent(4, e.Cooking), -- Jade Squash
	[74848] = SetReagent(4, e.Cooking), -- Striped Melon
	[74849] = SetReagent(4, e.Cooking), -- Pink Turnip
	[74850] = SetReagent(4, e.Cooking), -- White Turnip
	[74851] = SetReagent(4, e.Cooking), -- Rice
	[74852] = SetReagent(4, e.Cooking), -- Yak Milk
	[74853] = SetReagent(4, e.Cooking), -- 100 Year Soy Sauce
	[74854] = SetReagent(4, e.Cooking), -- Instant Noodles
	[75014] = SetReagent(4, e.Cooking), -- Raw Crocolisk Belly
	[79246] = SetReagent(4, e.Cooking), -- Delicate Blossom Petals
	[79250] = SetReagent(4, e.Cooking), -- Fresh Pomfruit
	[85506] = SetReagent(4, e.Cooking), -- Viseclaw Meat
	[85583] = SetReagent(4, e.Cooking), -- Needle Mushrooms
	[85584] = SetReagent(4, e.Cooking), -- Silkworm Pupa
	[85585] = SetReagent(4, e.Cooking), -- Red Beans
	[102536] = SetReagent(4, e.Cooking), -- Fresh Lushroom
	[102537] = SetReagent(4, e.Cooking), -- Fresh Silkfeather Hawk Eggs
	[102538] = SetReagent(4, e.Cooking), -- Fresh Shao-Tien Rice
	[102539] = SetReagent(4, e.Cooking), -- Fresh Strawberries
	[102540] = SetReagent(4, e.Cooking), -- Fresh Mangos
	[102541] = SetReagent(4, e.Cooking), -- Aged Balsamic Vinegar
	[102542] = SetReagent(4, e.Cooking), -- Ancient Pandaren Spices
	[102543] = SetReagent(4, e.Cooking), -- Aged Mogu'shan Cheese
	
	-- 6.0 Warlords of Draenor
	[109131] = SetReagent(5, e.Cooking), -- Raw Clefthoof Meat
	[109132] = SetReagent(5, e.Cooking), -- Raw Talbuk Meat
	[109133] = SetReagent(5, e.Cooking), -- Rylak Egg
	[109134] = SetReagent(5, e.Cooking), -- Raw Elekk Meat
	[109135] = SetReagent(5, e.Cooking), -- Raw Riverbeast Meat
	[109136] = SetReagent(5, e.Cooking), -- Raw Boar Meat
	[109137] = SetReagent(5, e.Cooking), -- Crescent Saberfish Flesh
	[109138] = SetReagent(5, e.Cooking), -- Jawless Skulker Flesh
	[109139] = SetReagent(5, e.Cooking), -- Fat Sleeper Flesh
	[109140] = SetReagent(5, e.Cooking), -- Blind Lake Sturgeon Flesh
	[109141] = SetReagent(5, e.Cooking), -- Fire Ammonite Tentacle
	[109142] = SetReagent(5, e.Cooking), -- Sea Scorpion Segment
	[109143] = SetReagent(5, e.Cooking), -- Abyssal Gulper Eel Flesh
	[109144] = SetReagent(5, e.Cooking), -- Blackwater Whiptail Flesh
	[128499] = SetReagent(5, e.Cooking), -- Fel Egg
	[128500] = SetReagent(5, e.Cooking), -- Fel Ham
	
	-- 7.0 Legion
	[124117] = SetReagent(6, e.Cooking), -- Lean Shank
	[124118] = SetReagent(6, e.Cooking), -- Fatty Bearsteak
	[124119] = SetReagent(6, e.Cooking), -- Big Gamy Ribs
	[124120] = SetReagent(6, e.Cooking), -- Leyblood
	[124121] = SetReagent(6, e.Cooking), -- Wildfowl Egg
	[133588] = SetReagent(6, e.Cooking), -- Flaked Sea Salt
	[133589] = SetReagent(6, e.Cooking), -- Dalapeño Pepper
	[133590] = SetReagent(6, e.Cooking), -- Muskenbutter
	[133591] = SetReagent(6, e.Cooking), -- River Onion
	[133592] = SetReagent(6, e.Cooking), -- Stonedark Snail
	[133593] = SetReagent(6, e.Cooking), -- Royal Olive
	[133680] = SetReagent(6, e.Cooking), -- Slice of Bacon
	[142336] = SetReagent(6, e.Cooking), -- Falcosaur Egg
	
	-- 8.0 Battle for Azeroth
	[152631] = SetReagent(7, e.Cooking), -- Briny Flesh
	[154897] = SetReagent(7, e.Cooking), -- Stringy Loins
	[154898] = SetReagent(7, e.Cooking), -- Meaty Haunch
	[154899] = SetReagent(7, e.Cooking), -- Thick Paleo Steak
	[160398] = SetReagent(7, e.Cooking), -- Choral Honey
	[160399] = SetReagent(7, e.Cooking), -- Wild Flour
	[160400] = SetReagent(7, e.Cooking), -- Foosaka
	[160705] = SetReagent(7, e.Cooking), -- Major's Frothy Coffee
	[160709] = SetReagent(7, e.Cooking), -- Fresh Potato
	[160710] = SetReagent(7, e.Cooking), -- Wild Berries
	[160711] = SetReagent(7, e.Cooking), -- Aromatic Fish Oil
	[160712] = SetReagent(7, e.Cooking), -- Powdered Sugar
	[163782] = SetReagent(7, e.Cooking), -- Cursed Haunch
	[168303] = SetReagent(7, e.Cooking), -- Rubbery Flank
	[168645] = SetReagent(7, e.Cooking), -- Moist Filet
	[174353] = SetReagent(7, e.Cooking), -- Questionable Meat
	
	-- 9.0 Shadowlands
	[172052] = SetReagent(8, e.Cooking), -- Aethereal Meat
	[172053] = SetReagent(8, e.Cooking), -- Tenebrous Ribs
	[172054] = SetReagent(8, e.Cooking), -- Raw Seraphic Wing
	[172055] = SetReagent(8, e.Cooking), -- Phantasmal Haunch
	[172056] = SetReagent(8, e.Cooking), -- Medley of Transplanar Spices
	[172057] = SetReagent(8, e.Cooking), -- Inconceivably Aged Vinegar
	[172058] = SetReagent(8, e.Cooking), -- Smuggled Azerothian Produce
	[172059] = SetReagent(8, e.Cooking), -- Rich Grazer Milk
	[178786] = SetReagent(8, e.Cooking), -- Lusterwheat Flour
	[179314] = SetReagent(8, e.Cooking), -- Creeping Crawler Meat
	[179315] = SetReagent(8, e.Cooking), -- Shadowy Shank
	[187704] = SetReagent(8, e.Cooking), -- Protoflesh
	[187812] = SetReagent(8, e.Cooking), -- Empty Kettle
	
	-- 10.0 Dragonflight
	[197741] = SetReagent(9, e.Cooking), -- Maybe Meat
	[197742] = SetReagent(9, e.Cooking), -- Ribbed Mollusk Meat
	[197743] = SetReagent(9, e.Cooking), -- Waterfowl Filet
	[197744] = SetReagent(9, e.Cooking), -- Hornswog Hunk
	[197745] = SetReagent(9, e.Cooking), -- Basilisk Eggs
	[197746] = SetReagent(9, e.Cooking), -- Bruffalon Flank
	[197747] = SetReagent(9, e.Cooking), -- Mighty Mammoth Ribs
	[197748] = SetReagent(9, e.Cooking), -- Burly Bear Haunch
	[197749] = SetReagent(9, e.Cooking), -- Ohn'ahran Potato
	[197750] = SetReagent(9, e.Cooking), -- Three-Cheese Blend
	[197751] = SetReagent(9, e.Cooking), -- Pastry Packets
	[197752] = SetReagent(9, e.Cooking), -- Conveniently Packaged Ingredients
	[197753] = SetReagent(9, e.Cooking), -- Thaldraszian Cocoa Powder
	[197754] = SetReagent(9, e.Cooking), -- Salt Deposit
	[197755] = SetReagent(9, e.Cooking), -- Lava Beetle
	[197756] = SetReagent(9, e.Cooking), -- Pebbled Rock Salts
	
	[197764] = SetReagent(9, e.Cooking), -- Salad on the Side
	[197765] = SetReagent(9, e.Cooking), -- Impossibly Sharp Cutting Knife
	
})