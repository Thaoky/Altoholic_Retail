local addonName, addon = ...

addon.Enum = {
	ArmorTypes = {
		[1] = C_Item.GetItemSubClassInfo(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Cloth), -- "Cloth"
		[2] = C_Item.GetItemSubClassInfo(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Leather), -- "Leather"
		[3] = C_Item.GetItemSubClassInfo(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Mail), -- "Mail"
		[4] = C_Item.GetItemSubClassInfo(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Plate) -- "Plate"
	},
}

addon.Colors = {
	white	= "|cFFFFFFFF",
	red = "|cFFFF0000",
	darkred = "|cFFF00000",
	green = "|cFF00FF00",
	orange = "|cFFFF7F00",
	yellow = "|cFFFFFF00",
	gold = "|cFFFFD700",
	teal = "|cFF00FF9A",
	cyan = "|cFF1CFAFE",
	lightBlue = "|cFFB0B0FF",
	battleNetBlue = "|cff82c5ff",
	grey = "|cFF909090",
	
	-- classes
	classMage = "|cFF69CCF0",
	classHunter = "|cFFABD473",
	
	-- recipes
	recipeGrey = "|cFF808080",
	recipeGreen = "|cFF40C040",
	recipeOrange = "|cFFFF8040",
	
	-- rarity : http://wow.gamepedia.com/Quality
	common = "|cFFFFFFFF",
	uncommon = "|cFF1EFF00",
	rare = "|cFF0070DD",
	epic = "|cFFA335EE",
	legendary = "|cFFFF8000",
	heirloom = "|cFFE6CC80",

	Alliance = "|cFF2459FF",
	Horde = "|cFFFF0000"
}

addon.Icons = {
	ready = "\124TInterface\\RaidFrame\\ReadyCheck-Ready:14\124t",
	waiting = "\124TInterface\\RaidFrame\\ReadyCheck-Waiting:14\124t",
	notReady = "\124TInterface\\RaidFrame\\ReadyCheck-NotReady:14\124t",
	questionMark = "Interface\\RaidFrame\\ReadyCheck-Waiting",

	Alliance = "Interface\\Icons\\INV_BannerPVP_02",
	Horde = "Interface\\Icons\\INV_BannerPVP_01",
	Neutral = "Interface\\Icons\\Achievement_character_pandaren_female",
}
