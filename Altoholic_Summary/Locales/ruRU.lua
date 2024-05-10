-- 
-- Russian localization made by Hellbot & Interim @ EU Realms 
-- Перевод выполнен Хэлла и Интерим @ Азурегос 
--

local L = DataStore:SetLocale("Altoholic", "ruRU")
if not L then return end

L["Calendar"] = "Календарь"
L["Tooltip"] = "Подсказка"
-- L["Getting support"] = true
-- L["Memory used"] = true
L["Reset all data"] = "Сбросить все данные"
L["WIPE_DATABASE"] = "Стереть базу данных ?"
L["WIPE_WARNING"] = "Внимание: вся информация будет утеряна !"
L["DATABASE_WIPED"] = "Информация сохранённая аддоном \"DataStore\" полностью удалена !"
  
L["Account"] = "Уч.запись"
L["Default"] = "По умолчанию"
L["Characters"] = "Персонажи"
-- L["Realms"] = true
-- L["%s%d%s characters found : did you set your filters properly ?"] = true
 
-- ** Menu **
-- L["Character Information"] = true
L["Account Summary"] = "Отчет"
-- L["Experience"] = true
L["Levels"] = "уровн(я,ей)"
-- L["Location"] = true
L["Bag Usage"] = "Сумки"
L["Activity"] = "Активность"
-- L["Currencies"] = true
L["PATCH_X.0"] = "Expansion Patch"
L["PATCH_9.1"] = "Chains of Domination"
L["PATCH_9.2"] = "Eternity's End"
L["PATCH_10.1"] = "Embers of Neltharion"
L["PATCH_10.2"] = "Guardians of the Dream"

-- ** Filter Icons **
L["FILTER_CLASSES"] = "Фильтр классов"
L["FILTER_FACTIONS"] = "Фильтр фракций"
L["FILTER_LEVELS"] = "Фильтр уровней"
L["FILTER_PROFESSIONS"] = "Фильтр профессий"
L["FILTER_REALMS"] = "Фильтр миров"
-- L["FILTER_MISC"] = "Miscellaneous filters"
-- L["FILTER_BANKTYPE"] = "Bank characters filters"
L["This realm"] = "Этот мир"
L["All realms"] = "Все миры"
L["This account"] = "Этот Аккаунт"
L["All accounts"] = "Все уч.записи"
L["This faction"] = "Эта фракция"
L["Both factions"] = "Обе фракции"
L["Any"] = "Любое"
L["ACCOUNT_SHARING_BUTTON_TITLE"] = "Запрос совместного использования данных"
L["ACCOUNT_SHARING_BUTTON_INFO"] = [[Нажмите эту кнопку, чтобы спросить игрока,
не желает ли он поделиться всей своей
базой данных Altoholic'а и добавить ее в свою]]

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
L["Totals"] = "Всего"
L["Right-Click for options"] = "[Правый-щелчок] - настройки"
L["Character %s successfully deleted"] = "Персонаж %s успешно удален"
L["Realm %s successfully deleted"] = "Мир %s, успешно удален"
L["Cannot delete current character"] = "Нельзя удалить текущего персонажа"
L["Cannot delete current realm"] = "Нельзя удалить текущий мир"
L["Delete this Alt"] = "Удалить этого персонажа"
L["Delete this Realm"] = "Удалить этот мир"
-- L["Update from %s%s"] = true

L["View"] = "Просмотр"
-- L["Mark as bank"] = true
-- L["Add to group"] = true
-- L["Remove from group"] = true



-- Column Level
L["COLUMN_LEVEL_SUBTITLE"] = "Кликните на уровень, чтобы включить десятичные значения"
L["COLUMN_LEVEL_TITLE"] = "Уровень персонажа"
L["COLUMN_LEVEL_TITLE_SHORT"] = "Уровень"

-- Column Rest XP
L["COLUMN_RESTXP_DETAIL_1"] = "Требуется 8 часов, чтобы получить 5% отдыха."
L["COLUMN_RESTXP_DETAIL_2"] = "Максимальный отдых составляет 1.5 уровня."
L["COLUMN_RESTXP_DETAIL_3"] = "Это достигается в течение 10 дней."
L["COLUMN_RESTXP_DETAIL_4"] = "%d%% режим: полный отдых отображается как '%d%%'"
L["COLUMN_RESTXP_SUBTITLE"] = "Кликните, чтобы переключить между 100%/150% режимом"
L["COLUMN_RESTXP_TITLE"] = "Отдых"
L["COLUMN_RESTXP_TITLE_SHORT"] = "Отдых"
L["Fully rested"] = "Полностью отдохнувший"
L["Fully rested in"] = "Полностью отдохнёт в"
-- L["CHARACTER_NOT_IN_RESTING_AREA"] = "This character is not in a resting area !"

-- Column Money
L["COLUMN_MONEY_SUBTITLE_1"] = "Твоя прелесть"
L["COLUMN_MONEY_SUBTITLE_2"] = "Больше денег, больше проблем"
L["COLUMN_MONEY_SUBTITLE_3"] = "Жадность это хорошо"
L["COLUMN_MONEY_SUBTITLE_4"] = "Нельзя купить счастье.. но можно купить манутов!"
L["COLUMN_MONEY_SUBTITLE_5"] = "Не растут на деревьях"
L["COLUMN_MONEY_TITLE"] = "Деньги"
L["COLUMN_MONEY_TITLE_SHORT"] = "Деньги"

-- Column Played
L["COLUMN_PLAYED_SUBTITLE"] = "Кликните, чтобы показать/скрыть проведённое время в игре"
L["COLUMN_PLAYED_TITLE"] = "Общее время игры"
L["COLUMN_PLAYED_TITLE_SHORT"] = "Сыграно"

-- Column iLevel
L["COLUMN_ILEVEL_SUBTITLE"] = "Кликните на уровень, чтобы включить десятичные значения"
L["COLUMN_ILEVEL_TITLE"] = "Средний уровень предметов"
L["COLUMN_ILEVEL_TITLE_SHORT"] = "Ур. пред."

-- Column Last Online
L["COLUMN_LASTONLINE_SUBTITLE"] = "Последний раз, когда персонаж входил в игру"
L["COLUMN_LASTONLINE_TITLE"] = "Последний вход"
L["COLUMN_LASTONLINE_TITLE_SHORT"] = "Последний вход"

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
L["COLUMN_BAGS_SUBTITLE_1"] = "Основной инвентарь"
L["COLUMN_BAGS_SUBTITLE_2"] = "Чем больше, тем лучше!"
L["COLUMN_BAGS_TITLE"] = "Сумки персонажей"
L["COLUMN_BAGS_TITLE_SHORT"] = "Сумки"
L["COLUMN_FREEBAGSLOTS_SUBTITLE"] = "Свободные и занятые места"
L["COLUMN_FREEBAGSLOTS_TITLE"] = "Свободно мест в сумках"
L["COLUMN_FREEBAGSLOTS_TITLE_SHORT"] = "Свободно"
L["COLUMN_BANK_SUBTITLE_1"] = "Количество мест в вашем банке"
L["COLUMN_BANK_SUBTITLE_2"] = "Здесь хранятся старые вещи"
L["COLUMN_BANK_TITLE"] = "Банк персонажа"
L["COLUMN_BANK_TITLE_SHORT"] = "Банк"
L["COLUMN_FREEBANKLOTS_SUBTITLE"] = "Свободные и занятые места"
L["COLUMN_FREEBANKLOTS_TITLE"] = "Свободно мест в банке"
L["COLUMN_FREEBANKLOTS_TITLE_SHORT"] = "Свободно"
-- L["NUM_SLOTS_AND_FREE"] = "%s%d%s slots, %s%d%s free"

L["Bags"] = "Сумки"
L["Bank"] = "В банке"
L["Bank bag"] = "Сумки в банке"
L["Bank not visited yet"] = "Вы еще не посещали банк"
L["slots"] = "ячеек"

-- *** Skills ***
L["COLUMN_PROFESSION_1_TITLE"] = "Первая профессия"
L["COLUMN_PROFESSION_1_TITLE_SHORT"] = "Проф. 1"
L["COLUMN_PROFESSION_2_TITLE"] = "Вторая профессия"
L["COLUMN_PROFESSION_2_TITLE_SHORT"] = "Проф. 2"
-- L["COLUMN_RIDING_UPGRADEABLE_MALE"] = "This character could upgrade his riding skill"
-- L["COLUMN_RIDING_UPGRADEABLE_FEMALE"] = "This character could upgrade her riding skill"
L["COLOR_GREEN"] = "Зелёный"
L["COLOR_GREY"] = "Серый"
L["COLOR_ORANGE"] = "Оранжевый"
L["COLOR_RED"] = "Красный"
L["COLOR_YELLOW"] = "Жёлтый"

L["up to"] = "до"
L["at"] = "на"
L["and above"] = "и выше"
L["No data"] = "Нет данных"
L["Suggestion"] = "Рекомендации"
L["All cooldowns are up"] = "Все восстановления готовы"
L["Riding"] = "Верховая езда"
 
-- *** Activity ***
L["COLUMN_MAILS_DETAIL_1"] = "Помимо определенного предела, письма будут поставлены в очередь на стороне сервера."
L["COLUMN_MAILS_DETAIL_2"] = "Эти письма здесь не учитываются."
L["COLUMN_MAILS_SUBTITLE"] = "Количество писем в почтовом ящике"
L["COLUMN_MAILS_TITLE"] = "Содержимое почтового ящика"
L["COLUMN_MAILS_TITLE_SHORT"] = "Почта"
L["COLUMN_MAILBOX_VISITED_SUBTITLE"] = "Содержимое почтового ящика последний раз было проверено"
L["COLUMN_MAILBOX_VISITED_TITLE"] = "Последняя проверка почтового ящика"
L["COLUMN_MAILBOX_VISITED_TITLE_SHORT"] = "Посещение"
L["COLUMN_AUCTIONS_SUBTITLE"] = "Количество активных лотов на Аукционе"
L["COLUMN_AUCTIONS_TITLE"] = "Аукционный дом"
L["COLUMN_AUCTIONS_TITLE_SHORT"] = "Аукционы"
L["COLUMN_BIDS_SUBTITLE"] = "Количество ставок сделанных на аукционе"
L["COLUMN_BIDS_TITLE"] = "Ставки на аукционе"
L["COLUMN_BIDS_TITLE_SHORT"] = "Ставки"
L["COLUMN_AUCTIONHOUSE_VISITED_SUBTITLE"] = "Последний раз Аукцион был посещён"
L["COLUMN_AUCTIONHOUSE_VISITED_TITLE"] = "Последнее посещение Аукциона"
L["COLUMN_AUCTIONHOUSE_VISITED_TITLE_SHORT"] = "Посещение"
L["COLUMN_GARRISON_MISSIONS_DETAIL_1"] = "По крайней мере одно задание завершено"
L["COLUMN_GARRISON_MISSIONS_DETAIL_2"] = "Все задания завершены"
L["COLUMN_GARRISON_MISSIONS_DETAIL_3"] = "Нет текущих заданий"
L["COLUMN_GARRISON_MISSIONS_SUBTITLE"] = "Последний раз статус заданий был проверен"
L["COLUMN_GARRISON_MISSIONS_TITLE"] = "Задания гарнизона"
L["COLUMN_GARRISON_MISSIONS_TITLE_SHORT"] = "Задания"

L["Visited"] = "Визит"
 
 
-- *** Currencies ***
L["Last collected"] = "Последний сбор"
L["Garrison resources"] = "Ресурсы гарнизона"
L["Uncollected resources"] = "Несобранные ресурсы"
L["Max. uncollected resources in"] = "Макс. кол-во несобранных ресурсов через"
 
 
-- *** Expansion Features / Garrison Followers ***
L["COLUMN_FOLLOWERS_LV40_TITLE"] = "40 уровень соратников"
L["COLUMN_FOLLOWERS_LV40_TITLE_SHORT"] = "Ур. 40"
L["COLUMN_FOLLOWERS_LV40_SUBTITLE"] = "40 уровень и Всего соратников"
L["COLUMN_FOLLOWERS_RARITY_SUBTITLE"] = "Редкие и Эпические"
L["COLUMN_FOLLOWERS_RARITY_TITLE"] = "Уровень редкости соратников"
L["COLUMN_FOLLOWERS_RARITY_TITLE_SHORT"] = "Редкие"
L["COLUMN_FOLLOWERS_ILEVEL_SUBTITLE"] = "Уровень предметов %s"
L["COLUMN_FOLLOWERS_ILEVEL_TITLE"] = "Соратники с ур. предметов %s"
L["COLUMN_FOLLOWERS_AIL_SUBTITLE"] = "Средний уровень предметов всех активных соратников"
L["COLUMN_FOLLOWERS_AIL_TITLE"] = "Ср. уровень пред. соратников"
L["COLUMN_FOLLOWERS_AIL_TITLE_SHORT"] = "Ур. пред."

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
