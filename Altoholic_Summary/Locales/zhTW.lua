local L = AddonFactory:SetLocale("Altoholic", "zhTW")
if not L then return end

L["Calendar"] = "日曆"
L["Tooltip"] = "提示"
-- L["Getting support"] = true
-- L["Memory used"] = true
L["Reset all data"] = "重置所有數據"
L["WIPE_DATABASE"] = "清除數據庫?"
L["WIPE_WARNING"] = "警告：所有數據將會全部刪除!"
L["DATABASE_WIPED"] = "保存在數據庫存儲的資料已被完全刪除！"
  
L["Account"] = "帳戶"
L["Default"] = "預設值"
L["Characters"] = "角色"
-- L["Realms"] = true
-- L["%s%d%s characters found : did you set your filters properly ?"] = true
 
-- ** Menu **
-- L["Character Information"] = true
L["Account Summary"] = "帳戶摘要"
-- L["Experience"] = true
L["Levels"] = "等級"
-- L["Location"] = true
L["Bag Usage"] = "背包使用度"
L["Activity"] = "活動"
-- L["Currencies"] = true
-- L["PATCH_X.0"] = "Expansion Patch"
-- L["PATCH_9.1"] = "Chains of Domination"
-- L["PATCH_9.2"] = "Eternity's End"
-- L["PATCH_10.1"] = "Embers of Neltharion"
-- L["PATCH_10.2"] = "Guardians of the Dream"

-- ** Filter Icons **
L["FILTER_CLASSES"] = "職業過濾"
L["FILTER_FACTIONS"] = "陣營過濾"
L["FILTER_LEVELS"] = "等級過濾"
L["FILTER_PROFESSIONS"] = "專業技能過濾"
L["FILTER_REALMS"] = "伺服器過濾"
-- L["FILTER_RACES"] = "Race filter"
-- L["FILTER_MISC"] = "Miscellaneous filters"
-- L["FILTER_BANKTYPE"] = "Bank characters filters"
L["This realm"] = "搜索這伺服器"
L["All realms"] = "所有伺服器"
L["This account"] = "這個帳號"
L["All accounts"] = "所有帳戶"
L["This faction"] = "這陣營聲望"
L["Both factions"] = "這兩個陣營聲望"
L["Any"] = "任何"
-- L["Allied Races"] = true
L["ACCOUNT_SHARING_BUTTON_TITLE"] = "要求帳戶共享資料"
L["ACCOUNT_SHARING_BUTTON_INFO"] = [[按一下這個按鈕來詢問玩家
要求分享Altoholic的數據庫
並將其添加到您自己數據庫內]]

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
L["Totals"] = "總數"
L["Right-Click for options"] = "右鍵點擊選單"
L["Character %s successfully deleted"] = "角色 %s 刪除成功"
L["Realm %s successfully deleted"] = "伺服器 %s 成功刪除"
L["Cannot delete current character"] = "不能刪除現有角色"
L["Cannot delete current realm"] = "不能刪除當前的伺服器"
L["Delete this Alt"] = "刪除這角色"
L["Delete this Realm"] = "刪除此伺服器"
-- L["Update from %s%s"] = true

L["View"] = "顯示"
-- L["Mark as bank"] = true
-- L["Add to group"] = true
-- L["Remove from group"] = true



-- Column Level
L["COLUMN_LEVEL_SUBTITLE"] = "點選等級來顯示小數點"
L["COLUMN_LEVEL_TITLE"] = "角色等級"
L["COLUMN_LEVEL_TITLE_SHORT"] = "等級"

-- Column Rest XP
L["COLUMN_RESTXP_DETAIL_1"] = "每8小時會增加一格經驗加倍 (5%)."
L["COLUMN_RESTXP_DETAIL_2"] = "經驗加倍的最大值是30格,也就是1.5級"
L["COLUMN_RESTXP_DETAIL_3"] = "這需要經過10天"
L["COLUMN_RESTXP_DETAIL_4"] = "%d%% 模式: 加倍經驗將被顯示為 '%d%%'"
L["COLUMN_RESTXP_SUBTITLE"] = "點選來切換 100%/150% 顯示模式"
L["COLUMN_RESTXP_TITLE"] = "雙倍經驗"
L["COLUMN_RESTXP_TITLE_SHORT"] = "雙倍經驗"
-- L["Fully rested"] = true
-- L["Fully rested in"] = true
-- L["CHARACTER_NOT_IN_RESTING_AREA"] = "This character is not in a resting area !"

-- Column Money
L["COLUMN_MONEY_TITLE"] = "金錢"
L["COLUMN_MONEY_TITLE_SHORT"] = "金錢"
-- L["COLUMN_MONEY_SUBTITLE_1"] = "Your shinies"
-- L["COLUMN_MONEY_SUBTITLE_2"] = "Mo Money Mo Problems"
L["COLUMN_MONEY_SUBTITLE_3"] = "貪婪是好的"
L["COLUMN_MONEY_SUBTITLE_4"] = "不能買到快樂... 但可以買一堆坐騎!"
-- L["COLUMN_MONEY_SUBTITLE_5"] = "Does not grow on World Trees"

-- Column Played
L["COLUMN_PLAYED_SUBTITLE"] = "點選 顯示/隱藏 實際遊玩時間"
L["COLUMN_PLAYED_TITLE"] = "總計遊戲時間"
L["COLUMN_PLAYED_TITLE_SHORT"] = "遊戲時間"

-- Column iLevel
L["COLUMN_ILEVEL_SUBTITLE"] = "點選等級顯示小數點"
L["COLUMN_ILEVEL_TITLE"] = "平均物品等級"
L["COLUMN_ILEVEL_TITLE_SHORT"] = "裝等"

-- Column Last Online
L["COLUMN_LASTONLINE_SUBTITLE"] = "最後此角色的登入時間"
L["COLUMN_LASTONLINE_TITLE"] = "最後在線"
L["COLUMN_LASTONLINE_TITLE_SHORT"] = "最後在線"

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
L["COLUMN_BAGS_SUBTITLE_1"] = "你主要的物品格數"
L["COLUMN_BAGS_SUBTITLE_2"] = "越大越好"
L["COLUMN_BAGS_TITLE"] = "角色背包"
L["COLUMN_BAGS_TITLE_SHORT"] = "背包"
L["COLUMN_FREEBAGSLOTS_SUBTITLE"] = "未使用/總計 格數"
L["COLUMN_FREEBAGSLOTS_TITLE"] = "空的背包格數"
L["COLUMN_FREEBAGSLOTS_TITLE_SHORT"] = "未使用"
L["COLUMN_BANK_TITLE"] = "角色銀行"
L["COLUMN_BANK_TITLE_SHORT"] = "銀行"
L["COLUMN_BANK_SUBTITLE_1"] = "你的銀行物品格數"
-- L["COLUMN_BANK_SUBTITLE_2"] = "Where old ph4t l3wts go to rest"
L["COLUMN_FREEBANKLOTS_SUBTITLE"] = "未使用/總計 格數"
L["COLUMN_FREEBANKLOTS_TITLE"] = "未使用銀行格數"
L["COLUMN_FREEBANKLOTS_TITLE_SHORT"] = "未使用"
L["NUM_SLOTS_AND_FREE"] = "%s%d%s 格, %s%d%s 未使用"

L["Bags"] = "背包"
L["Bank"] = "銀行"
L["Bank bag"] = "銀行包"
L["Bank not visited yet"] = "銀行沒有訪問過"
L["slots"] = "空格"

-- *** Skills ***
L["COLUMN_PROFESSION_1_TITLE"] = "專業1"
L["COLUMN_PROFESSION_1_TITLE_SHORT"] = "專業1"
L["COLUMN_PROFESSION_2_TITLE"] = "專業2"
L["COLUMN_PROFESSION_2_TITLE_SHORT"] = "專業2"
-- L["COLUMN_RIDING_UPGRADEABLE_MALE"] = "This character could upgrade his riding skill"
-- L["COLUMN_RIDING_UPGRADEABLE_FEMALE"] = "This character could upgrade her riding skill"
L["COLOR_GREEN"] = "綠色"
L["COLOR_GREY"] = "灰色"
L["COLOR_ORANGE"] = "橘色"
L["COLOR_RED"] = "紅色"
L["COLOR_YELLOW"] = "黃色"

L["up to"] = "最高至"
L["at"] = "在"
L["and above"] = "及以上"
L["No data"] = "無資料"
L["Suggestion"] = "建議"
L["All cooldowns are up"] = "所有冷卻已完成"
L["Riding"] = "騎術"
 
-- *** Activity ***
L["COLUMN_MAILS_DETAIL_1"] = "超過一個數量限制後,郵件會佇列在伺服器端"
L["COLUMN_MAILS_DETAIL_2"] = "這些郵件不會被計算在這"
L["COLUMN_MAILS_SUBTITLE"] = "在郵箱中的物品數量"
L["COLUMN_MAILS_TITLE"] = "郵箱內容"
L["COLUMN_MAILS_TITLE_SHORT"] = "信件"
L["COLUMN_MAILBOX_VISITED_SUBTITLE"] = "最後檢查郵箱內容的時間"
L["COLUMN_MAILBOX_VISITED_TITLE"] = "最後檢查郵箱時間"
L["COLUMN_MAILBOX_VISITED_TITLE_SHORT"] = "已到訪"
L["COLUMN_AUCTIONS_SUBTITLE"] = "正在拍賣場中拍賣的物品數量"
L["COLUMN_AUCTIONS_TITLE"] = "拍賣場拍賣"
L["COLUMN_AUCTIONS_TITLE_SHORT"] = "拍賣"
L["COLUMN_BIDS_SUBTITLE"] = "在拍賣場中投標的數量"
L["COLUMN_BIDS_TITLE"] = "拍賣場投標"
L["COLUMN_BIDS_TITLE_SHORT"] = "投標"
L["COLUMN_AUCTIONHOUSE_VISITED_SUBTITLE"] = "最後到訪拍賣場的時間"
L["COLUMN_AUCTIONHOUSE_VISITED_TITLE"] = "最後到訪拍賣場時間"
L["COLUMN_AUCTIONHOUSE_VISITED_TITLE_SHORT"] = "已到訪"
L["COLUMN_GARRISON_MISSIONS_DETAIL_1"] = "至少有一個任務已完成"
L["COLUMN_GARRISON_MISSIONS_DETAIL_2"] = "所有任務皆完成"
L["COLUMN_GARRISON_MISSIONS_DETAIL_3"] = "沒有正在執行的任務"
L["COLUMN_GARRISON_MISSIONS_SUBTITLE"] = "最後檢查任務的時間"
L["COLUMN_GARRISON_MISSIONS_TITLE"] = "要塞任務"
L["COLUMN_GARRISON_MISSIONS_TITLE_SHORT"] = "任務"

L["Visited"] = "已到訪"
 
 
-- *** Currencies ***
L["Last collected"] = "最後收集"
L["Garrison resources"] = "要塞資源"
L["Uncollected resources"] = "未收集的資源"
L["Max. uncollected resources in"] = "最大值。未收集的資源"
 
 
-- *** Expansion Features / Garrison Followers ***
L["COLUMN_FOLLOWERS_LV40_TITLE"] = "等級40的追隨者"
L["COLUMN_FOLLOWERS_LV40_TITLE_SHORT"] = "Lv 40"
L["COLUMN_FOLLOWERS_LV40_SUBTITLE"] = "Lv 40/總計 追隨者"
L["COLUMN_FOLLOWERS_RARITY_SUBTITLE"] = "精良/史詩 稀有度"
L["COLUMN_FOLLOWERS_RARITY_TITLE"] = "追隨者稀有度"
L["COLUMN_FOLLOWERS_RARITY_TITLE_SHORT"] = "稀有"
L["COLUMN_FOLLOWERS_ILEVEL_SUBTITLE"] = "裝等 %s"
L["COLUMN_FOLLOWERS_ILEVEL_TITLE"] = "追隨者裝等 %s"
L["COLUMN_FOLLOWERS_AIL_SUBTITLE"] = "所有啟用的追隨者的平均裝等"
L["COLUMN_FOLLOWERS_AIL_TITLE"] = "啟用追隨者裝等"
L["COLUMN_FOLLOWERS_AIL_TITLE_SHORT"] = "裝等"

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
