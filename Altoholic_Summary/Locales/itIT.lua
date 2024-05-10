local L = DataStore:SetLocale("Altoholic", "itIT")
if not L then return end

L["Calendar"] = "Calendario"
L["Tooltip"] = true
-- L["Getting support"] = true
-- L["Memory used"] = true
-- L["Reset all data"] = true
-- L["WIPE_DATABASE"] = "Wipe database ?"
-- L["WIPE_WARNING"] = "Warning: all information will be lost !"
-- L["DATABASE_WIPED"] = "Information saved in DataStore has been completely deleted !"
  
L["Account"] = true
L["Default"] = true
L["Characters"] = "Personaggi"
-- L["Realms"] = true
-- L["%s%d%s characters found : did you set your filters properly ?"] = true
 
-- ** Menu **
-- L["Character Information"] = true
L["Account Summary"] = "Sommario account"
-- L["Experience"] = true
L["Levels"] = "Livelli"
-- L["Location"] = true
L["Bag Usage"] = "Utilizzo delle borse"
L["Activity"] = "Attività"
L["Currencies"] = "Valute"
L["PATCH_X.0"] = "Expansion Patch"
L["PATCH_9.1"] = "Chains of Domination"
L["PATCH_9.2"] = "Eternity's End"
L["PATCH_10.1"] = "Embers of Neltharion"
L["PATCH_10.2"] = "Guardians of the Dream"

-- ** Filter Icons **
-- L["FILTER_REALMS"] = "Realms filter"
-- L["FILTER_FACTIONS"] = "Faction filter"
-- L["FILTER_LEVELS"] = "Level filter"
-- L["FILTER_PROFESSIONS"] = "Profession filter"
-- L["FILTER_CLASSES"] = "Class filter"
-- L["FILTER_MISC"] = "Miscellaneous filters"
-- L["FILTER_BANKTYPE"] = "Bank characters filters"
L["This realm"] = "Questo reame"
L["All realms"] = "Tutti i reami"
L["This account"] = "Questo Account"
L["All accounts"] = "Tutti gli Account"
L["This faction"] = "Questa fazione"
L["Both factions"] = "Entrambe le fazioni"
L["Any"] = "Qualsiasi"
L["ACCOUNT_SHARING_BUTTON_TITLE"] = "Richiesta di condivisione account"
L["ACCOUNT_SHARING_BUTTON_INFO"] = "Cliccare questo pulsante per chiedere ad un giocatore di condividere tutto il suo database di Altoholic ed aggiungerlo al vostro"

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
L["Totals"] = "Totali"
L["Right-Click for options"] = "Clic destro per le opzioni"
L["Character %s successfully deleted"] = "Personaggio %s eliminato con successo"
L["Realm %s successfully deleted"] = "Reame %s eliminato con successo"
L["Cannot delete current character"] = "Impossibile eliminare il personaggio corrente"
L["Cannot delete current realm"] = "Impossibile eliminare il reame corrente"
L["Delete this Alt"] = "Elimina questo Alt"
L["Delete this Realm"] = "Elimina questo Reame"
L["Update from %s%s"] = "Aggiorna da %s%s"

L["View"] = "Visualizza"
-- L["Mark as bank"] = true
-- L["Add to group"] = true
-- L["Remove from group"] = true



-- Column Level
-- L["COLUMN_LEVEL_TITLE"] = "Character Level"
-- L["COLUMN_LEVEL_TITLE_SHORT"] = "Level"
-- L["COLUMN_LEVEL_SUBTITLE"] = "Click level to toggle decimals"

-- Column Rest XP
-- L["COLUMN_RESTXP_TITLE"] = "Rest XP"
-- L["COLUMN_RESTXP_TITLE_SHORT"] = "Rest XP"
-- L["COLUMN_RESTXP_SUBTITLE"] = "Click to toggle 100%/150% mode"
-- L["COLUMN_RESTXP_DETAIL_1"] = "It takes 8 hours to gain 1 XP bubble (5%)."
-- L["COLUMN_RESTXP_DETAIL_2"] = "The maximum rested XP is 30 XP bubbles, or 1.5 level."
-- L["COLUMN_RESTXP_DETAIL_3"] = "It is achieved in 10 days."
-- L["COLUMN_RESTXP_DETAIL_4"] = "%d%% mode : fully rested is displayed as '%d%%'"
-- L["Fully rested"] = true
-- L["Fully rested in"] = true
-- L["CHARACTER_NOT_IN_RESTING_AREA"] = "This character is not in a resting area !"

-- Column Money
-- L["COLUMN_MONEY_TITLE"] = "Money"
-- L["COLUMN_MONEY_TITLE_SHORT"] = "Money"
-- L["COLUMN_MONEY_SUBTITLE_1"] = "Your shinies"
-- L["COLUMN_MONEY_SUBTITLE_2"] = "Mo Money Mo Problems"
-- L["COLUMN_MONEY_SUBTITLE_3"] = "Greed is good"
-- L["COLUMN_MONEY_SUBTITLE_4"] = "Can't buy happiness .. but buys loads of mounts !"
-- L["COLUMN_MONEY_SUBTITLE_5"] = "Does not grow on World Trees"

-- Column Played
-- L["COLUMN_PLAYED_TITLE"] = "Total Time Played"
-- L["COLUMN_PLAYED_TITLE_SHORT"] = "Played"
-- L["COLUMN_PLAYED_SUBTITLE"] = "Click to show/hide real play time"

-- Column iLevel
-- L["COLUMN_ILEVEL_TITLE"] = "Average Item Level"
-- L["COLUMN_ILEVEL_TITLE_SHORT"] = "iLvl"
-- L["COLUMN_ILEVEL_SUBTITLE"] = "Click level to toggle decimals"

-- Column Last Online
-- L["COLUMN_LASTONLINE_TITLE"] = "Last Online"
-- L["COLUMN_LASTONLINE_TITLE_SHORT"] = "Last Online"
-- L["COLUMN_LASTONLINE_SUBTITLE"] = "Last time a character was logged in"

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
-- L["COLUMN_BAGS_TITLE"] = "Character Bags"
-- L["COLUMN_BAGS_TITLE_SHORT"] = "Bags"
-- L["COLUMN_BAGS_SUBTITLE_1"] = "Your main inventory slots"
-- L["COLUMN_BAGS_SUBTITLE_2"] = "Bigger is always better"
-- L["COLUMN_FREEBAGSLOTS_TITLE"] = "Free Bag Slots"
-- L["COLUMN_FREEBAGSLOTS_TITLE_SHORT"] = "Free"
-- L["COLUMN_FREEBAGSLOTS_SUBTITLE"] = "Free vs total slots"
-- L["COLUMN_BANK_TITLE"] = "Character Bank"
-- L["COLUMN_BANK_TITLE_SHORT"] = "Bank"
-- L["COLUMN_BANK_SUBTITLE_1"] = "Your bank inventory slots"
-- L["COLUMN_BANK_SUBTITLE_2"] = "Where old ph4t l3wts go to rest"
-- L["COLUMN_FREEBANKLOTS_TITLE"] = "Free Bank Slots"
-- L["COLUMN_FREEBANKLOTS_TITLE_SHORT"] = "Free"
-- L["COLUMN_FREEBANKLOTS_SUBTITLE"] = "Free vs total slots"
-- L["NUM_SLOTS_AND_FREE"] = "%s%d%s slots, %s%d%s free"

L["Bags"] = "Sacche"
L["Bank"] = "Banca"
L["Bank bag"] = "Sacca della banca"
L["Bank not visited yet"] = "Banca non ancora visitata"
-- L["slots"] = true

-- *** Skills ***
-- L["COLUMN_PROFESSION_1_TITLE"] = "Profession 1"
-- L["COLUMN_PROFESSION_1_TITLE_SHORT"] = "Prof. 1"
-- L["COLUMN_PROFESSION_2_TITLE"] = "Profession 2"
-- L["COLUMN_PROFESSION_2_TITLE_SHORT"] = "Prof. 2"
-- L["COLUMN_RIDING_UPGRADEABLE_MALE"] = "This character could upgrade his riding skill"
-- L["COLUMN_RIDING_UPGRADEABLE_FEMALE"] = "This character could upgrade her riding skill"
L["COLOR_GREEN"] = "Verde"
L["COLOR_GREY"] = "Grigio"
L["COLOR_ORANGE"] = "Arancione"
L["COLOR_RED"] = "Rosso"
L["COLOR_YELLOW"] = "Giallo"

L["up to"] = "fino a"
L["at"] = "a"
L["and above"] = "e oltre"
L["No data"] = "Nessun dato"
L["Suggestion"] = "Suggerimento"
L["All cooldowns are up"] = "Tutti i periodi di recupero sono terminati"
L["Riding"] = "Equitazione"
 
-- *** Activity ***
-- L["COLUMN_MAILS_TITLE"] = "Mailbox Content"
-- L["COLUMN_MAILS_TITLE_SHORT"] = "Mails"
-- L["COLUMN_MAILS_SUBTITLE"] = "Number of items in the mailbox"
-- L["COLUMN_MAILS_DETAIL_1"] = "Beyond a certain limit, mails are queued server-side."
-- L["COLUMN_MAILS_DETAIL_2"] = "These mails are not accounted for here."
-- L["COLUMN_MAILBOX_VISITED_TITLE"] = "Last Mailbox Check"
-- L["COLUMN_MAILBOX_VISITED_TITLE_SHORT"] = "Visited"
-- L["COLUMN_MAILBOX_VISITED_SUBTITLE"] = "Last time mailbox content was checked"
-- L["COLUMN_AUCTIONS_TITLE"] = "Auction House Auctions"
-- L["COLUMN_AUCTIONS_TITLE_SHORT"] = "Auctions"
-- L["COLUMN_AUCTIONS_SUBTITLE"] = "Number of active auctions at the Auction House"
-- L["COLUMN_BIDS_TITLE"] = "Auction House Bids"
-- L["COLUMN_BIDS_TITLE_SHORT"] = "Bids"
-- L["COLUMN_BIDS_SUBTITLE"] = "Number of bids placed at the Auction House"
-- L["COLUMN_AUCTIONHOUSE_VISITED_TITLE"] = "Last Auction House Visit"
-- L["COLUMN_AUCTIONHOUSE_VISITED_TITLE_SHORT"] = "Visited"
-- L["COLUMN_AUCTIONHOUSE_VISITED_SUBTITLE"] = "Last time the Auction House was visited"
-- L["COLUMN_GARRISON_MISSIONS_TITLE"] = "Garrison Missions"
-- L["COLUMN_GARRISON_MISSIONS_TITLE_SHORT"] = "Missions"
-- L["COLUMN_GARRISON_MISSIONS_SUBTITLE"] = "Last time mission status was checked"
-- L["COLUMN_GARRISON_MISSIONS_DETAIL_1"] = "At least one mission is complete"
-- L["COLUMN_GARRISON_MISSIONS_DETAIL_2"] = "All missions are complete" 
-- L["COLUMN_GARRISON_MISSIONS_DETAIL_3"] = "No ongoing missions" 

L["Visited"] = "Visitato"
 
 
-- *** Currencies ***
-- L["Last collected"] = true
-- L["Garrison resources"] = true
-- L["Uncollected resources"] = true
-- L["Max. uncollected resources in"] = true
 
 
-- *** Expansion Features / Garrison Followers ***
-- L["COLUMN_FOLLOWERS_LV40_TITLE"] = "Level 40 Followers"
-- L["COLUMN_FOLLOWERS_LV40_TITLE_SHORT"] = "Lv 40"
-- L["COLUMN_FOLLOWERS_LV40_SUBTITLE"] = "Level 40 vs Total Followers"
-- L["COLUMN_FOLLOWERS_RARITY_TITLE"] = "Followers' Rarity Level"
-- L["COLUMN_FOLLOWERS_RARITY_TITLE_SHORT"] = "Rarity"
-- L["COLUMN_FOLLOWERS_RARITY_SUBTITLE"] = "Rare vs Epic Rarity" 
-- L["COLUMN_FOLLOWERS_ILEVEL_TITLE"] = "Followers with %s iLevel"
-- L["COLUMN_FOLLOWERS_ILEVEL_SUBTITLE"] = "iLevel %s" 
-- L["COLUMN_FOLLOWERS_AIL_TITLE"] = "Followers' AiL"
-- L["COLUMN_FOLLOWERS_AIL_TITLE_SHORT"] = "iLvl"
-- L["COLUMN_FOLLOWERS_AIL_SUBTITLE"] = "Average item level of all active followers" 

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

