local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "deDE" )

if not L then return end

-- L["Account"] = true
-- L["Select a character on the left"] = true

-- ** Filter Icons **
L["Containers"] = "Behälter"
L["All-in-one"] = "Alle zusammen"
L["Any"] = "Beliebige"
L["Clear all entries"] = "Alle Einträge löschen"
L["Clear goblin AH entries"] = "Einträge aus dem Goblin-AH löschen"
L["Clear your faction's entries"] = "Einträge der eigenen Fraktion löschen"
L["Mail"] = "Post"

-- ** Containers **
-- L["Bank"] = true
L["Bank bag"] = "Banktasche"
L["slots"] = "Plätze"

-- ** Quest Log **
-- L["QuestID"] = true

-- ** Auctions/Bids **
L["Goblin AH"] = "Goblin-AH"
L["N/A"] = true

-- ** Mails **
L["Expiry:"] = "Verfall:"
L["Mails %s(%d)"] = "Post %s(%d)"
-- L["Attached Money"] = true
L["Will be %sreturned|r in"] = "Wird %szurückgesendet|r in"
L["Will be %sdeleted|r in"] = "%sVerfällt|r in"

-- ** Recipes **
L["COLOR_GREEN"] = "Grün"
L["COLOR_GREY"] = "Grau"
L["COLOR_ORANGE"] = "Orange"
L["COLOR_RED"] = "Rot"
L["COLOR_YELLOW"] = "Gelb"
L["Invalid tradeskill link"] = "Ungültige Fertigkeiten-Verknüpfung"
L["Cannot link another account's tradeskill"] = "Fertigkeiten eines anderen Accounts können nicht verlinkt werden"
L["Cannot link another realm's tradeskill"] = "Fertigkeiten eines anderen Realms können nicht verlinkt werden"


-- ** Talents **
L["Source"] = "Quelle"
L["TALENT_SPECIALIZATION_STAT_PRIORITY"] = "Wertepriorität "
L["TALENT_SPECIALIZATION_UNKOWN"] = "Diese Talentspezialisierung ist unbekannt.\\nAktiviere sie um sie vom Addon erfassen zu lassen."
