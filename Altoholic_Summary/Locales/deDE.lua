local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "deDE" )

if not L then return end

L["Calendar"] = "Kalender"
L["Tooltip"] = true
-- L["Getting support"] = true
-- L["Memory used"] = true
L["Reset all data"] = "Alle Daten zurücksetzen"
L["WIPE_DATABASE"] = "Datenbank leeren ?"
L["WIPE_WARNING"] = "Warnung: Alle Informationen gehen verloren !"
L["DATABASE_WIPED"] = "Alle in DataStore gespeicherten Informationen wurden komplett gelöscht !"
  
L["Account"] = true
L["Default"] = "Standardmäßig"
L["Characters"] = "Charaktere"
-- L["Realms"] = true
-- L["%s%d%s characters found : did you set your filters properly ?"] = true
 
-- ** Menu **
-- L["Character Information"] = true
L["Account Summary"] = "Account-Überblick"
-- L["Experience"] = true
L["Levels"] = "Stufen"
L["Location"] = "Ort"
L["Bag Usage"] = "Taschennutzung"
L["Activity"] = "Aktivitäten"
L["Currencies"] = "Währungen"
L["PATCH_X.0"] = "Expansion Patch"
L["PATCH_9.1"] = "Chains of Domination"
L["PATCH_9.2"] = "Eternity's End"
L["PATCH_10.1"] = "Embers of Neltharion"
L["PATCH_10.2"] = "Guardians of the Dream"

-- ** Filter Icons **
L["FILTER_REALMS"] = "Realmfilter"
L["FILTER_FACTIONS"] = "Fraktionsfilter"
L["FILTER_LEVELS"] = "Stufenfilter"
L["FILTER_PROFESSIONS"] = "Berufsfilter"
L["FILTER_CLASSES"] = "Klassenfilter"
-- L["FILTER_MISC"] = "Miscellaneous filters"
-- L["FILTER_BANKTYPE"] = "Bank characters filters"
L["This realm"] = "Dieser Realm"
L["All realms"] = "Alle Realms"
L["This account"] = "Dieser Account"
L["All accounts"] = "Alle Accounts"
L["Both factions"] = "Beide Fraktionen"
L["This faction"] = "Diese Fraktion"
L["Any"] = "Beliebige"
L["ACCOUNT_SHARING_BUTTON_TITLE"] = "Anfrage zum Austausch zwischen Accounts"
L["ACCOUNT_SHARING_BUTTON_INFO"] = [[Diese Schaltfläche anklicken, um einen Spieler zu bitten,
seine komplette Altoholic-Datenbank zur Übermittlung
freizugeben und deiner Datenbank hinzuzufügen.]]

-- L["FILTER_ALT_GROUPS"] = "Alt groups"
-- L["FILTER_GROUP_CREATE"] = "Create new group"
-- L["FILTER_GROUP_DELETE"] = "Delete alt group"
-- L["FILTER_GROUP_RENAME"] = "Rename alt group"
-- L["ENTER_GROUP_NAME"] = "Enter a new group name"
-- L["CHANGE_GROUP_NAME"] = "Select a new name for %s%s|r"
-- L["ENTER_GROUP_NAME_WARNING"] = "It is recommended to avoid special characters"
-- L["DELETE_GROUP_NAME"] = "Delete this alt group ?"
-- L["ALT_GROUP_CREATED"] = "Alt group %s successfully created."
-- L["ALT_GROUP_ALREADY_EXISTS"] = "Alt group %s already exists."
-- L["ALT_GROUP_RENAMED"] = "%s successfully renamed to %s"
-- L["ALT_GROUP_NOT_RENAMED"] = "%s could not be renamed to %s"
-- L["ALT_GROUP_DELETED"] = "Alt group %s successfully deleted."
-- L["ALT_GROUP_NOT_FOUND"] = "Alt group %s was not found."

-- L["COLORED_SKILL_LEVELS"] = "Use color for skill levels"
-- L["FILTER_MISC_HAVE_MAILS"] = "With mails"
-- L["FILTER_MISC_HAVE_MAILS_EXPIRE_SOON"] = "With mails about to expire"
-- L["FILTER_MISC_HAVE_AUCTIONS_EXPIRE_SOON"] = "Auction house not recently checked"
-- L["FILTER_MISC_GUILD_EXALTED"] = "Exalted with guild"
-- L["FILTER_MISC_GUILD_NOT_EXALTED"] = "Not exalted with guild"
-- L["FILTER_MISC_UPGRADE_RIDING_SKILL"] = "Could upgrade their riding skill"


-- *** Character Information / Account Summary ***
-- Column Name
L["Totals"] = "Summen"
L["Right-Click for options"] = "Optionen mittels Rechts-Klick"
L["Character %s successfully deleted"] = "Charakter %s erfolgreich gelöscht"
L["Realm %s successfully deleted"] = "Realm %s wurde erfolgreich gelöscht"
L["Cannot delete current character"] = "Aktueller Charakter kann nicht gelöscht werden"
L["Cannot delete current realm"] = "Aktueller Realm kann nicht gelöscht werden"
L["Delete this Alt"] = "Lösche diesen Twink"
L["Delete this Realm"] = "Lösche diesen Realm"
L["Update from %s%s"] = "Aktualisieren von %s%s"

L["View"] = "Ansehen"
-- L["Mark as bank"] = true
-- L["Add to group"] = true
-- L["Remove from group"] = true



-- Column Level
L["COLUMN_LEVEL_TITLE"] = "Charakterstufe"
L["COLUMN_LEVEL_TITLE_SHORT"] = "Stufe"
L["COLUMN_LEVEL_SUBTITLE"] = "Auf die Stufe klicken, um zw. der Dezimal- und der normalen Anzeige zu wechseln"

-- Column Rest XP
L["COLUMN_RESTXP_TITLE"] = "Erholt-EP"
L["COLUMN_RESTXP_TITLE_SHORT"] = "Erholt-EP"
L["COLUMN_RESTXP_SUBTITLE"] = "Klicken um zwischen dem 100%/150% Modus umzuschalten"
L["COLUMN_RESTXP_DETAIL_1"] = "Es braucht 8 Stunden um ein EP-Kästchen (5%) mit Erholung zu füllen."
L["COLUMN_RESTXP_DETAIL_2"] = "Die maximale Menge an Erholt-EP sind 30 EP-Kästchen oder 1.5 Level."
L["COLUMN_RESTXP_DETAIL_3"] = "Das dauert insgesamt 10 Tage"
L["COLUMN_RESTXP_DETAIL_4"] = "%d%% Modus: Maximale Erholt-EP wird als '%d%%' angezeigt"
L["Fully rested"] = "Komplett Erholt"
L["Fully rested in"] = "Komplett erholt in"
-- L["CHARACTER_NOT_IN_RESTING_AREA"] = "This character is not in a resting area !"

-- Column Money
L["COLUMN_MONEY_TITLE"] = "Geld"
L["COLUMN_MONEY_TITLE_SHORT"] = "Geld"
L["COLUMN_MONEY_SUBTITLE_1"] = "Deine Glanzstücke"
L["COLUMN_MONEY_SUBTITLE_2"] = "Mehr Geld - Mehr Probleme"
L["COLUMN_MONEY_SUBTITLE_3"] = "Gier ist gut"
L["COLUMN_MONEY_SUBTITLE_4"] = "Man kann kein Glück kaufen.. aber haufenweise Reittiere!"
L["COLUMN_MONEY_SUBTITLE_5"] = "Wächst nicht auf Bäumen"

-- Column Played
L["COLUMN_PLAYED_TITLE"] = "Gesamt Spielzeit"
L["COLUMN_PLAYED_TITLE_SHORT"] = "Spielzeit"
L["COLUMN_PLAYED_SUBTITLE"] = "Klicken um echte Spielzeit anzuzeigen/zu verstecken"

-- Column iLevel
L["COLUMN_ILEVEL_TITLE"] = "Durchschnitt Item Level"
L["COLUMN_ILEVEL_TITLE_SHORT"] = "iLvl"
L["COLUMN_ILEVEL_SUBTITLE"] = "Klicke auf das Level um die Dezimalanzeige umzuschalten"

-- Column Last Online
L["COLUMN_LASTONLINE_TITLE"] = "Zuletzt Online"
L["COLUMN_LASTONLINE_TITLE_SHORT"] = "Zul. online"
L["COLUMN_LASTONLINE_SUBTITLE"] = "Letztes Mal als ein Charakter eingeloggt wurde"

-- *** Character Information / Experience ***
-- L["COLUMN_MAXRESTXP_TITLE"] = "Maximum Rest XP"
-- L["COLUMN_MAXRESTXP_TITLE_SHORT"] = "Max XP"
-- L["COLUMN_MAXRESTXP_SUBTITLE"] = "Maximum rest experience that can be accumulated"
-- L["COLUMN_SAVEDRESTXP_TITLE"] = "Saved Rest XP"
-- L["COLUMN_SAVEDRESTXP_TITLE_SHORT"] = "Saved XP"
-- L["COLUMN_SAVEDRESTXP_SUBTITLE"] = "Amount of unused rest experience at logout"
-- L["COLUMN_EARNEDRESTXP_TITLE"] = "XP earned while resting"
-- L["COLUMN_EARNEDRESTXP_TITLE_SHORT"] = "Earned XP"
-- L["COLUMN_EARNEDRESTXP_SUBTITLE"] = "Amount of rest experience that was earned while resting"

-- *** Character Information / Guild ***
-- L["COLUMN_GUILD_TITLE"] = "Guild name"
-- L["COLUMN_GUILDRANK_TITLE"] = "Guild rank"
-- L["COLUMN_GUILDRANK_TITLE_SHORT"] = "Guild rank"
-- L["COLUMN_GUILDRANK_SUBTITLE"] = "Character rank in the guild"
-- L["COLUMN_GUILDREP_TITLE"] = "Guild reputation"
-- L["COLUMN_GUILDREP_SUBTITLE"] = "Character reputation with the guild"

-- *** Character Information / Location ***
-- L["COLUMN_HEARTHSTONE_TITLE"] = "Hearthstone"
-- L["COLUMN_HEARTHSTONE_SUBTITLE"] = "That special place you call home"
-- L["COLUMN_SUBZONE_TITLE"] = "Sub-zone"

-- *** Character Information / Miscellaneous ***
-- L["COLUMN_CLASS_SUBTITLE"] = "Character class and active specialization"
-- L["COLUMN_BANK_TYPE_MARKS"] = "Bank type marks"
-- L["COLUMN_BANK_TYPE_MARKS_SUBTITLE"] = "List of marks set for bank characters"

-- *** Bag Usage ***
L["COLUMN_BAGS_TITLE"] = "Charakter Taschen"
L["COLUMN_BAGS_TITLE_SHORT"] = "Taschen"
L["COLUMN_BAGS_SUBTITLE_1"] = "Deine Rucksackplätze"
L["COLUMN_BAGS_SUBTITLE_2"] = "Größer ist immer besser"
L["COLUMN_FREEBAGSLOTS_TITLE"] = "freie Taschenplätze"
L["COLUMN_FREEBAGSLOTS_TITLE_SHORT"] = "Frei"
L["COLUMN_FREEBAGSLOTS_SUBTITLE"] = "Freie vs Gesamte Plätze"
L["COLUMN_BANK_TITLE"] = "Charakter Bank"
L["COLUMN_BANK_TITLE_SHORT"] = "Bank"
L["COLUMN_BANK_SUBTITLE_1"] = "Deine Bankinventarplätze"
L["COLUMN_BANK_SUBTITLE_2"] = "Wo die fette Beute Ruhe findet! "
L["COLUMN_FREEBANKLOTS_TITLE"] = "Freie Bankplätze"
L["COLUMN_FREEBANKLOTS_TITLE_SHORT"] = "Frei"
L["COLUMN_FREEBANKLOTS_SUBTITLE"] = "Freie vs Gesamte Plätze"
L["NUM_SLOTS_AND_FREE"] = "%s%d%s Plätze, %s%d%s Frei"

L["Bags"] = "Taschen"
L["Bank"] = true
L["Bank bag"] = "Banktasche"
L["Bank not visited yet"] = "Bank noch nicht besucht"
L["slots"] = "Plätze"

-- *** Skills ***
L["COLUMN_PROFESSION_1_TITLE"] = "Erster Beruf"
L["COLUMN_PROFESSION_1_TITLE_SHORT"] = "Beruf 1"
L["COLUMN_PROFESSION_2_TITLE"] = "Zweiter Beruf"
L["COLUMN_PROFESSION_2_TITLE_SHORT"] = "Beruf 2"
-- L["COLUMN_RIDING_UPGRADEABLE_MALE"] = "This character could upgrade his riding skill"
-- L["COLUMN_RIDING_UPGRADEABLE_FEMALE"] = "This character could upgrade her riding skill"
L["COLOR_GREEN"] = "Grün"
L["COLOR_GREY"] = "Grau"
L["COLOR_ORANGE"] = "Orange"
L["COLOR_RED"] = "Rot"
L["COLOR_YELLOW"] = "Gelb"

L["up to"] = "bis zu"
L["at"] = "auf"
L["and above"] = "und höher"
L["No data"] = "Keine Daten"
L["Suggestion"] = "Vorschlag"
L["All cooldowns are up"] = "Alle Abklingzeiten abgelaufen"
L["Riding"] = "Reiten"
 
-- *** Activity ***
L["COLUMN_MAILS_TITLE"] = "Briefkasten-Inhalt"
L["COLUMN_MAILS_TITLE_SHORT"] = "Post"
L["COLUMN_MAILS_SUBTITLE"] = "Anzahl der Gegenstände im Briefkasten"
L["COLUMN_MAILS_DETAIL_1"] = "Ab einer bestimmten Anzahl wird die Post Serverseitig zurückgehalten."
L["COLUMN_MAILS_DETAIL_2"] = "Diese Post wird hier nicht aufgeführt."
L["COLUMN_MAILBOX_VISITED_TITLE"] = "Letzte Postfach Überprüfung"
L["COLUMN_MAILBOX_VISITED_TITLE_SHORT"] = "Besucht"
L["COLUMN_MAILBOX_VISITED_SUBTITLE"] = "Letztes Mal wurde der Postfachinhalt überprüft"
L["COLUMN_AUCTIONS_TITLE"] = "Auktionshaus Auktionen"
L["COLUMN_AUCTIONS_TITLE_SHORT"] = "Auktion"
L["COLUMN_AUCTIONS_SUBTITLE"] = "Anzahl der aktiven Auktionen im Auktionshaus"
L["COLUMN_BIDS_TITLE"] = "Auktionshaus Gebote"
L["COLUMN_BIDS_TITLE_SHORT"] = "Gebote"
L["COLUMN_BIDS_SUBTITLE"] = "Anzahl an abgegebenen Geboten im Auktionshaus"
L["COLUMN_AUCTIONHOUSE_VISITED_TITLE"] = "Letzter Auktionshaus Besuch"
L["COLUMN_AUCTIONHOUSE_VISITED_TITLE_SHORT"] = "Besucht"
L["COLUMN_AUCTIONHOUSE_VISITED_SUBTITLE"] = "Letztes Mal wurde das Auktionshaus besucht"
L["COLUMN_GARRISON_MISSIONS_TITLE"] = "Garnisonsmissionen"
L["COLUMN_GARRISON_MISSIONS_TITLE_SHORT"] = "Missionen"
L["COLUMN_GARRISON_MISSIONS_SUBTITLE"] = "Letztes Mal wurde der Status der Mission überprüft"
L["COLUMN_GARRISON_MISSIONS_DETAIL_1"] = "Mindestens eine Mission ist abgeschlossen"
L["COLUMN_GARRISON_MISSIONS_DETAIL_2"] = "Alle Missionen sind abgeschlossen"
L["COLUMN_GARRISON_MISSIONS_DETAIL_3"] = "Keine laufenden Missionen"

L["Visited"] = "Besucht"
 
 
-- *** Currencies ***
L["Last collected"] = "Zuletzt gesammelt"
L["Garrison resources"] = "Garnisonsressourcen"
L["Uncollected resources"] = "Nicht gesammelte Ressourcen"
L["Max. uncollected resources in"] = "Max. nicht gesammelte Ressourcen in"
 
 
-- *** Expansion Features / Garrison Followers ***
L["COLUMN_FOLLOWERS_LV40_TITLE"] = "Level 40 Anhänger"
L["COLUMN_FOLLOWERS_LV40_TITLE_SHORT"] = "Lv 40"
L["COLUMN_FOLLOWERS_LV40_SUBTITLE"] = "Level 40 Anhänger gesamt"
L["COLUMN_FOLLOWERS_RARITY_TITLE"] = "Anhänger Seltenheitswert"
L["COLUMN_FOLLOWERS_RARITY_TITLE_SHORT"] = "Seltenheit"
L["COLUMN_FOLLOWERS_RARITY_SUBTITLE"] = "Seltene gegen epische Qualität"
L["COLUMN_FOLLOWERS_ILEVEL_TITLE"] = "Anhänger mit %s iLevel"
L["COLUMN_FOLLOWERS_ILEVEL_SUBTITLE"] = "iLevel %s"
L["COLUMN_FOLLOWERS_AIL_TITLE"] = "Anhänger AiL"
L["COLUMN_FOLLOWERS_AIL_TITLE_SHORT"] = "iLvl"
L["COLUMN_FOLLOWERS_AIL_SUBTITLE"] = "Durchschnittlicher Itemlevel deiner aktiven Anhänger"

-- *** Expansion Features / Artifacts ***
 
-- *** Expansion Features / Covenant ***
-- L["COLUMN_COVENANT_SUBTITLE"] = "Click to view your soulbinds"
-- L["COLUMN_COVENANT_TITLE"] = "Chosen Covenant"
-- L["COLUMN_COVENANT_TITLE_SHORT"] = "Covenant"
-- L["COLUMN_SOULBIND_SUBTITLE"] = "Click to view your soulbinds"
-- L["COLUMN_SOULBIND_TITLE"] = "Active Soulbind"
-- L["COLUMN_SOULBIND_TITLE_SHORT"] = "Soulbind"
-- L["COLUMN_RENOWN_SUBTITLE"] = "Click to view your renown level and rewards"
-- L["COLUMN_RENOWN_TITLE"] = "Renown Level"
-- L["COLUMN_CAMPAIGNPROGRESS_TITLE_SHORT"] = "Story"
-- L["COLUMN_CAMPAIGNPROGRESS_TITLE"] = "Campaign Progress"
-- L["COLUMN_CAMPAIGNPROGRESS_SUBTITLE"] = "Number of completed chapters in the covenant campaign"

-- *** Expansion Features / Reservoir ***
-- L["COLUMN_TRANSPORT_NETWORK_TITLE"] = "Transport Network"
-- L["COLUMN_ANIMA_TITLE"] = "Anima Conductor"
-- L["COLUMN_COMMAND_TABLE_TITLE"] = "Command Table"
-- L["COLUMN_SANCTUM_UNIQUE_TITLE"] = "Sanctum Unique"

-- L["Overall"] = true
-- L["Torghast"] = true
-- L["Single target build"] = true
-- L["AOE build"] = true
-- L["Recommended Covenant"] = true
-- L["Equally viable"] = true


-- *** Mythic Keystone ***
-- L["Mythic+ Keystone"] = true
-- L["COLUMN_KEYNAME_TITLE"] = "Current Mythic+ Keystone"
-- L["COLUMN_KEYNAME_TITLE_SHORT"] = "Keystone"
-- L["COLUMN_KEYNAME_SUBTITLE"] = "Your next adventure"
-- L["COLUMN_KEYLEVEL_TITLE"] = "Current Mythic+ Keystone Level"
-- L["COLUMN_KEYLEVEL_SUBTITLE"] = "You are definitely not prepared!"
-- L["COLUMN_WEEKLYBEST_KEYNAME_TITLE"] = "Weekly Best Mythic+ Keystone"
-- L["COLUMN_WEEKLYBEST_KEYNAME_SUBTITLE"] = "Mouse over for weekly best for all maps"
-- L["COLUMN_WEEKLYBEST_KEYLEVEL_TITLE"] = "Weekly Best Mythic+ Level"
-- L["COLUMN_WEEKLYBEST_KEYLEVEL_SUBTITLE"] = "How deep down the rabbit hole you dared to go"
-- L["COLUMN_WEEKLYBEST_KEYTIME_TITLE"] = "Weekly Best Mythic+ Time"
-- L["COLUMN_WEEKLYBEST_KEYTIME_SUBTITLE"] = "Mouse over for season best for all maps"

