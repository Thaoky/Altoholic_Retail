local L = AddonFactory:SetLocale("Altoholic", "zhCN")
if not L then return end

L["Calendar"] = "日历"
L["Tooltip"] = "提示"
L["Getting support"] = "获取支持"
L["Memory used"] = "内存占用"
L["Reset all data"] = "重置所有数据"
L["WIPE_DATABASE"] = "清空数据库?"
L["WIPE_WARNING"] = "警告：所有信息都将丢失！"
L["DATABASE_WIPED"] = "数据库中所有存储信息删除完毕！"
  
L["Account"] = "帐号"
L["Default"] = "默认"
L["Characters"] = "角色"
L["Realms"] = "服务器"
L["%s%d%s characters found : did you set your filters properly ?"] = "发现%s%d%s个角色：你有正确设置过滤吗？"
 
-- ** Menu **
L["Character Information"] = "角色信息"
L["Account Summary"] = "帐号统计"
L["Experience"] = "经验"
L["Levels"] = "等级" --实际显示的是：等级，装等，名望等级和大米评分
L["Location"] = "位置"
L["Bag Usage"] = "背包用量"
L["Activity"] = "活跃度"
L["Currencies"] = "货币"
L["PATCH_X.0"] = "版本号"
L["PATCH_9.1"] = "统御之链"
L["PATCH_9.2"] = "永恒的终结"
L["PATCH_10.1"] = "奈萨里奥的余烬"
L["PATCH_10.2"] = "梦境守护者"

-- ** Filter Icons **
L["FILTER_REALMS"] = "服务器过滤"
L["FILTER_FACTIONS"] = "阵营过滤"
L["FILTER_LEVELS"] = "等级过滤"
L["FILTER_PROFESSIONS"] = "专业过滤"
L["FILTER_CLASSES"] = "职业过滤"
L["FILTER_RACES"] = "种族过滤"
L["FILTER_MISC"] = "混合过滤"
L["FILTER_BANKTYPE"] = "角色库标签过滤"
L["This realm"] = "仅搜索该服务器"
L["All realms"] = "搜索所有服务器"
L["This account"] = "此账户"
L["All accounts"] = "所有账户"
L["This faction"] = "此阵营"
L["Both factions"] = "双方阵营"
L["Any"] = "所有"
L["Allied Races"] = "同盟种族"
L["ACCOUNT_SHARING_BUTTON_TITLE"] = "账户共享请求"
L["ACCOUNT_SHARING_BUTTON_INFO"] = [[点击此按钮来询问玩家
是否共享整个Altoholic数据库
并将其添加到自己的数据库]]

L["FILTER_ALT_GROUPS"] = "角色群组"
L["FILTER_GROUP_CREATE"] = "新建群组"
L["FILTER_GROUP_DELETE"] = "删除角色群组"
L["FILTER_GROUP_RENAME"] = "重命名角色群组"
L["ENTER_GROUP_NAME"] = "输入一个新的群组名称"
L["CHANGE_GROUP_NAME"] = "请输入替换 %s%s|r 的名称"
L["ENTER_GROUP_NAME_WARNING"] = "建议避免输入特殊符号"
-- L["DELETE_GROUP_NAME"] = "Delete this alt group ?"
L["ALT_GROUP_CREATED"] = "角色群组 %s 已成功创建"
L["ALT_GROUP_ALREADY_EXISTS"] = "角色群组 %s 已经存在."
L["ALT_GROUP_RENAMED"] = "%s 成功重命名为 %s"
L["ALT_GROUP_NOT_RENAMED"] = "%s 无法重命名为 %s"
L["ALT_GROUP_DELETED"] = "角色群组 %s 已成功删除"
L["ALT_GROUP_NOT_FOUND"] = "角色群组 %s 未找到..."

L["COLORED_SKILL_LEVELS"] = "为技能等级着色"
L["FILTER_MISC_HAVE_MAILS"] = "有邮件"
L["FILTER_MISC_HAVE_MAILS_EXPIRE_SOON"] = "有快要过期的邮件"
L["FILTER_MISC_HAVE_AUCTIONS_EXPIRE_SOON"] = "拍卖行近期未查阅"
L["FILTER_MISC_GUILD_EXALTED"] = "已加入公会的"
L["FILTER_MISC_GUILD_NOT_EXALTED"] = "尚未有公会的"
L["FILTER_MISC_UPGRADE_RIDING_SKILL"] = "可升级坐骑骑术"


-- *** Character Information / Account Summary ***
-- Column Name
L["Totals"] = "总计"
L["Right-Click for options"] = "右键点击打开选项"
L["Character %s successfully deleted"] = "人物： %s 成功删除！"
L["Realm %s successfully deleted"] = "服务器 %s 删除成功"
L["Cannot delete current character"] = "无法删除当前人物镜像"
L["Cannot delete current realm"] = "无法删除当前服务器内容"
L["Delete this Alt"] = "删除该人物镜像"
L["Delete this Realm"] = "删除此服务器内容"
-- L["Update from %s%s"] = true

L["View"] = "浏览"
L["Mark as bank"] = true
L["Mark as profession bank"] = "添加角色库标签为专业"
L["Mark as expansion bank"] = "添加角色库标签为版本名称"
L["Add to group"] = "添加进角色群组"
L["Remove from group"] = "从角色群组删除"



-- Column Level
-- L["COLUMN_LEVEL_TITLE"] = "Character Level"
L["COLUMN_LEVEL_TITLE_SHORT"] = "等级"
-- L["COLUMN_LEVEL_SUBTITLE"] = "Click level to toggle decimals"

-- Column Rest XP
L["COLUMN_RESTXP_TITLE"] = "休息经验"
L["COLUMN_RESTXP_TITLE_SHORT"] = "休息XP"
L["COLUMN_RESTXP_SUBTITLE"] = " "
L["COLUMN_RESTXP_DETAIL_1"] = "每8个小时获得当前等级的5%的奖励经验"
L["COLUMN_RESTXP_DETAIL_2"] = "最多获得当前等级的150%的奖励经验"
L["COLUMN_RESTXP_DETAIL_3"] = "休息10天可获得最大奖励经验"
L["COLUMN_RESTXP_DETAIL_4"] = "%d%% 模式 : 充分休息显示为 '%d%%'"
L["Fully rested"] = "已充分休息"
L["Fully rested in"] = "充分休息时长"
L["CHARACTER_NOT_IN_RESTING_AREA"] = "该角色没有在休息区域!"

-- Column Money
-- L["COLUMN_MONEY_TITLE"] = "Money"
L["COLUMN_MONEY_TITLE_SHORT"] = "金钱"
-- L["COLUMN_MONEY_SUBTITLE_1"] = "Your shinies"
-- L["COLUMN_MONEY_SUBTITLE_2"] = "Mo Money Mo Problems"
-- L["COLUMN_MONEY_SUBTITLE_3"] = "Greed is good"
-- L["COLUMN_MONEY_SUBTITLE_4"] = "Can't buy happiness .. but buys loads of mounts !"
-- L["COLUMN_MONEY_SUBTITLE_5"] = "Does not grow on World Trees"

-- Column Played
-- L["COLUMN_PLAYED_TITLE"] = "Total Time Played"
L["COLUMN_PLAYED_TITLE_SHORT"] = "游戏总时长"
-- L["COLUMN_PLAYED_SUBTITLE"] = "Click to show/hide real play time"

-- Column iLevel
-- L["COLUMN_ILEVEL_TITLE"] = "Average Item Level"
L["COLUMN_ILEVEL_TITLE_SHORT"] = "装等"
-- L["COLUMN_ILEVEL_SUBTITLE"] = "Click level to toggle decimals"

-- Column Last Online
-- L["COLUMN_LASTONLINE_TITLE"] = "Last Online"
L["COLUMN_LASTONLINE_TITLE_SHORT"] = "最后在线"
-- L["COLUMN_LASTONLINE_SUBTITLE"] = "Last time a character was logged in"

-- *** Character Information / Experience ***
-- L["COLUMN_MAXRESTXP_TITLE"] = "Maximum Rest XP"
L["COLUMN_MAXRESTXP_TITLE_SHORT"] = "最大休息XP"
-- L["COLUMN_MAXRESTXP_SUBTITLE"] = "Maximum rest experience that can be accumulated"
-- L["COLUMN_SAVEDRESTXP_TITLE"] = "Saved Rest XP"
L["COLUMN_SAVEDRESTXP_TITLE_SHORT"] = "已奖励经验"
-- L["COLUMN_SAVEDRESTXP_SUBTITLE"] = "Amount of unused rest experience at logout"
-- L["COLUMN_EARNEDRESTXP_TITLE"] = "XP earned while resting"
L["COLUMN_EARNEDRESTXP_TITLE_SHORT"] = "还可奖励经验"
-- L["COLUMN_EARNEDRESTXP_SUBTITLE"] = "Amount of rest experience that was earned while resting"

-- *** Character Information / Guild ***
-- L["COLUMN_GUILD_TITLE"] = "Guild name"
L["COLUMN_GUILDRANK_TITLE"] = "公会级别"
L["COLUMN_GUILDRANK_TITLE_SHORT"] = "公会内级别"
-- L["COLUMN_GUILDRANK_SUBTITLE"] = "Character rank in the guild"
L["COLUMN_GUILDREP_TITLE"] = "公会声望"
-- L["COLUMN_GUILDREP_SUBTITLE"] = "Character reputation with the guild"

-- *** Character Information / Location ***
L["COLUMN_HEARTHSTONE_TITLE"] = "炉石位置"
L["COLUMN_HEARTHSTONE_SUBTITLE"] = "炉石绑定的地方"
L["COLUMN_ZONE_TITLE"] = "下线位置"
L["COLUMN_SUBZONE_TITLE"] = "下线子区域"

-- *** Character Information / Miscellaneous ***
L["COLUMN_CLASS_SUBTITLE"] = "角色的职业和当前激活专精"
L["COLUMN_BANK_TYPE_MARKS"] = "角色库的标签"
-- L["COLUMN_BANK_TYPE_MARKS_SUBTITLE"] = "List of marks set for bank characters"

-- *** Bag Usage ***
-- L["COLUMN_BAGS_TITLE"] = "Character Bags"
L["COLUMN_BAGS_TITLE_SHORT"] = "背包"
-- L["COLUMN_BAGS_SUBTITLE_1"] = "Your main inventory slots"
-- L["COLUMN_BAGS_SUBTITLE_2"] = "Bigger is always better"
L["COLUMN_FREEBAGSLOTS_TITLE"] = "剩余背包格子"
-- L["COLUMN_FREEBAGSLOTS_TITLE_SHORT"] = "Free"
-- L["COLUMN_FREEBAGSLOTS_SUBTITLE"] = "Free vs total slots"
-- L["COLUMN_BANK_TITLE"] = "Character Bank"
L["COLUMN_BANK_TITLE_SHORT"] = "银行"
-- L["COLUMN_BANK_SUBTITLE_1"] = "Your bank inventory slots"
-- L["COLUMN_BANK_SUBTITLE_2"] = "Where old ph4t l3wts go to rest"
L["COLUMN_FREEBANKLOTS_TITLE"] = "剩余银行空格"
-- L["COLUMN_FREEBANKLOTS_TITLE_SHORT"] = "Free"
L["COLUMN_FREEBANKLOTS_SUBTITLE"] = "总格子数 和 剩余格子数"
-- L["NUM_SLOTS_AND_FREE"] = "%s%d%s slots, %s%d%s free"

L["Bags"] = "背包"
L["Bank"] = "银行"
L["Bank bag"] = "银行背包"
L["Bank not visited yet"] = "尚未访问银行"
L["slots"] = "格"

-- *** Skills ***
-- L["COLUMN_PROFESSION_1_TITLE"] = "Profession 1"
L["COLUMN_PROFESSION_1_TITLE_SHORT"] = "商业技能"
-- L["COLUMN_PROFESSION_2_TITLE"] = "Profession 2"
L["COLUMN_PROFESSION_2_TITLE_SHORT"] = "辅助技能"
-- L["COLUMN_RIDING_UPGRADEABLE_MALE"] = "This character could upgrade his riding skill"
-- L["COLUMN_RIDING_UPGRADEABLE_FEMALE"] = "This character could upgrade her riding skill"
L["COLOR_GREEN"] = "绿色"
L["COLOR_GREY"] = "灰色"
L["COLOR_ORANGE"] = "橙色"
L["COLOR_RED"] = "红色"
L["COLOR_YELLOW"] = "黄色"

L["up to"] = "升到"
L["at"] = "在"
L["and above"] = "及以上"
L["No data"] = "无数据"
L["Suggestion"] = "建议"
L["All cooldowns are up"] = "所有冷却已完成"
L["Riding"] = "骑术"
 
-- *** Activity ***
L["COLUMN_MAILS_TITLE"] = "邮箱内容"
L["COLUMN_MAILS_TITLE_SHORT"] = "邮件数"
-- L["COLUMN_MAILS_SUBTITLE"] = "Number of items in the mailbox"
-- L["COLUMN_MAILS_DETAIL_1"] = "Beyond a certain limit, mails are queued server-side."
-- L["COLUMN_MAILS_DETAIL_2"] = "These mails are not accounted for here."
L["COLUMN_MAILBOX_VISITED_TITLE"] = "最近邮箱访问时间"
L["COLUMN_MAILBOX_VISITED_TITLE_SHORT"] = "访问于"
-- L["COLUMN_MAILBOX_VISITED_SUBTITLE"] = "Last time mailbox content was checked"
L["COLUMN_MAILS_NUM_RETURNS_TITLE"] = "Number of returns"
L["COLUMN_MAILS_NUM_RETURNS_TITLE_SHORT"] = "将退回"
L["COLUMN_MAILS_NUM_RETURNS_SUBTITLE"] = "Amount of mails that will be returned to their sender upon expiry"
L["COLUMN_MAILS_CLOSEST_RETURN_TITLE"] = "Closest Return"
L["COLUMN_MAILS_CLOSEST_RETURN_TITLE_SHORT"] = "退回倒计时"
L["COLUMN_MAILS_CLOSEST_RETURN_SUBTITLE"] = "Minimum duration before a character's mail is returned to the sender"
L["COLUMN_MAILS_NUM_DELETIONS_TITLE"] = "Number of deletions"
L["COLUMN_MAILS_NUM_DELETIONS_TITLE_SHORT"] = "将删除"
L["COLUMN_MAILS_NUM_DELETIONS_SUBTITLE"] = "Amount of mails that will be deleted upon expiry"
L["COLUMN_MAILS_CLOSEST_DELETION_TITLE"] = "Closest Deletion"
L["COLUMN_MAILS_CLOSEST_DELETION_TITLE_SHORT"] = "删除倒计时"
L["COLUMN_MAILS_CLOSEST_DELETION_SUBTITLE"] = "Minimum duration before a character's mail is deleted"




-- L["COLUMN_AUCTIONS_TITLE"] = "Auction House Auctions"
L["COLUMN_AUCTIONS_TITLE_SHORT"] = "拍卖数"
-- L["COLUMN_AUCTIONS_SUBTITLE"] = "Number of active auctions at the Auction House"
L["COLUMN_AUCTIONS_LOW_BUYOUT_TITLE"] = "Lowest Buyout Price"
L["COLUMN_AUCTIONS_LOW_BUYOUT_TITLE_SHORT"] = "最低一口价"
L["COLUMN_AUCTIONS_LOW_BUYOUT_SUBTITLE"] = "Lowest buyout price set for all active auctions"
L["COLUMN_AUCTIONS_HIGH_BUYOUT_TITLE"] = "Highest Buyout Price"
L["COLUMN_AUCTIONS_HIGH_BUYOUT_TITLE_SHORT"] = "最高一口价"
L["COLUMN_AUCTIONS_HIGH_BUYOUT_SUBTITLE"] = "Highest buyout price set for all active auctions"
L["COLUMN_AUCTIONS_CLOSEST_EXPIRY_TITLE"] = "Closest Expiry"
L["COLUMN_AUCTIONS_CLOSEST_EXPIRY_TITLE_SHORT"] = "下架倒计时"
L["COLUMN_AUCTIONS_CLOSEST_EXPIRY_SUBTITLE"] = "Time before the first auction expires"

-- L["COLUMN_BIDS_TITLE"] = "Auction House Bids"
L["COLUMN_BIDS_TITLE_SHORT"] = "竞拍数"
-- L["COLUMN_BIDS_SUBTITLE"] = "Number of bids placed at the Auction House"
-- L["COLUMN_AUCTIONHOUSE_VISITED_TITLE"] = "Last Auction House Visit"
L["COLUMN_AUCTIONHOUSE_VISITED_TITLE_SHORT"] = "访问于"
-- L["COLUMN_AUCTIONHOUSE_VISITED_SUBTITLE"] = "Last time the Auction House was visited"
-- L["COLUMN_GARRISON_MISSIONS_TITLE"] = "Garrison Missions"
L["COLUMN_GARRISON_MISSIONS_TITLE_SHORT"] = "大厅任务"
-- L["COLUMN_GARRISON_MISSIONS_SUBTITLE"] = "Last time mission status was checked"
-- L["COLUMN_GARRISON_MISSIONS_DETAIL_1"] = "At least one mission is complete"
-- L["COLUMN_GARRISON_MISSIONS_DETAIL_2"] = "All missions are complete" 
-- L["COLUMN_GARRISON_MISSIONS_DETAIL_3"] = "No ongoing missions" 

L["Visited"] = "已访问"
 
 
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
L["COLUMN_COVENANT_TITLE"] = "所选盟约"
L["COLUMN_COVENANT_TITLE_SHORT"] = "盟约"
L["COLUMN_SOULBIND_SUBTITLE"] = "点击查看你的灵魂羁绊"
L["COLUMN_SOULBIND_TITLE"] = "激活的灵魂羁绊"
L["COLUMN_SOULBIND_TITLE_SHORT"] = "灵魂羁绊"
L["COLUMN_RENOWN_SUBTITLE"] = "点击查看你的盟约声望等级和奖励"
L["COLUMN_RENOWN_TITLE"] = "盟约声望等级"
-- L["COLUMN_CAMPAIGNPROGRESS_TITLE_SHORT"] = "Story"
L["COLUMN_CAMPAIGNPROGRESS_TITLE"] = "战役进度"
L["COLUMN_CAMPAIGNPROGRESS_SUBTITLE"] = "盟约战役已完成的章节数"

-- *** Expansion Features / Reservoir ***
-- L["COLUMN_TRANSPORT_NETWORK_TITLE"] = "Transport Network"
-- L["COLUMN_ANIMA_TITLE"] = "Anima Conductor"
-- L["COLUMN_COMMAND_TABLE_TITLE"] = "Command Table"
-- L["COLUMN_SANCTUM_UNIQUE_TITLE"] = "Sanctum Unique"

-- L["Overall"] = true
L["Torghast"] = "托加斯特，罪魂之塔"
-- L["Single target build"] = true
-- L["AOE build"] = true
-- L["Recommended Covenant"] = true
-- L["Equally viable"] = true


-- *** Mythic Keystone ***
L["Mythic+ Keystone"] = "大秘境钥石"
L["COLUMN_KEYNAME_TITLE"] = "当前大秘境钥石"
L["COLUMN_KEYNAME_TITLE_SHORT"] = "钥石"
-- L["COLUMN_KEYNAME_SUBTITLE"] = "Your next adventure"
L["COLUMN_KEYLEVEL_TITLE"] = "当前钥石层数"
-- L["COLUMN_KEYLEVEL_SUBTITLE"] = "You are definitely not prepared!"
L["COLUMN_WEEKLYBEST_KEYNAME_TITLE"] = "每周最佳"
-- L["COLUMN_WEEKLYBEST_KEYNAME_SUBTITLE"] = "Mouse over for weekly best for all maps"
L["COLUMN_WEEKLYBEST_KEYLEVEL_TITLE"] = "最高层数"
-- L["COLUMN_WEEKLYBEST_KEYLEVEL_SUBTITLE"] = "How deep down the rabbit hole you dared to go"
L["COLUMN_WEEKLYBEST_KEYTIME_TITLE"] = "赛季最佳"
-- L["COLUMN_WEEKLYBEST_KEYTIME_SUBTITLE"] = "Mouse over for season best for all maps"
