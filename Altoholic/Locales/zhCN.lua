local addonName = ...
local L = AddonFactory:SetLocale(addonName, "zhCN")
if not L then return end

L["TAB_SUMMARY"] = "概要"
L["TAB_CHARACTERS"] = "人物"
L["TAB_AGENDA"] = "行事历"
L["TAB_GRIDS"] = "网格清单"
 
L["Shows the UI"] = "显示图形界面"
L["Hides the UI"] = "隐藏图形界面"
L["Toggles the UI"] = "切换图形界面的显示/隐藏"
L["Search in bags"] = "在背包中搜索"

L["Left-click to %sopen"] = "左键点击%s打开"
L["Right-click to %sdrag"] = "右键点击%s拖拽"

-- L["NEW_VERSION_AVAILABLE"] = "A new version of Altoholic is available, consider upgrading to get the latest features."
-- L["OFFICIAL_SOURCES"] = "Official sources : Curseforge & WoW Interface"

L["%s%s|r has requested the bank tab %s%s|r\nSend this information ?"] = [[%s%s|r 要求公会仓库分页 %s%s|r
要传送这项资料吗 ?]]
L["%sWarning:|r make sure this user may view this information before accepting"] = "%s警告:|r 请确定此用户可以查看分页的资料才接受"
L["%s|r has received a mail from %s"] = "%s|r 已收到%s的邮件"
-- L["AUCTION_HOUSE_NOT_VISITED_WARNING"] = "Auctions have not been checked on %s|r since %d days, check the auction house and your mailbox !"

L["Mail is about to expire on at least one character."] = "至少一个角色的邮件即将到期."
L["Refer to the activity pane for more details."] = "更多信息请查看现用的方框."
L["Do you want to view it now ?"] = "现在想查看吗?"



-- ** Services / Account Sharing **
L["Sending table of content to %s (%d items)"] = "发送列表内容 %s (%d 物品)"
-- L["%sTransferring item %s%d|r/%s%d|r"] = true

L["Account sharing request received from %s"] = "收到%s的帐户共享请求"
L["You have received an account sharing request\nfrom %s%s|r, accept it?"] = [[你收到帐户共享请求
请求者 %s%s|r, 接受吗?]]
L["%sWarning:|r if you accept, %sALL|r information known\nby Altoholic will be sent to %s%s|r (bags, money, etc..)"] = [[%s警告:|r 如接受, %s所有|r 已知的资料
会被 Altoholic 传送给 %s%s|r (背包, 金钱, 等等..)]]
L["Request rejected by %s"] = "请求被%s驳回"
L["%s is in combat, request cancelled"] = "%s在战斗中, 请求被驳回"
L["%s has disabled account sharing"] = "%s的帐户共享功能关闭"
L["Reference data received (%s) !"] = "接受的参考数据 (%s) !"
L["Sending account sharing request to %s"] = "向%s发送帐户共享的请求"
-- L["Getting table of content from %s"] = true
-- L["Talent Tree Reference"] = true

-- L["SHARING_TRANSFER_OK"] = "Transfer completed successfully !"
-- L["SHARING_TRANSFER_CANCELLED"] = "Transfer has been cancelled, no data has been imported."
-- L["SHARING_TOC_RECEIVED"] = "|cFFFFFFFFTable of content received (|r|cFF00FF00%d|r |cFFFFFFFFitems)|r"
-- L["SHARING_OPTION_DISABLED"] = "You must enable account sharing first !"
-- L["SHARING_INVALID_TARGET"] = "You must select a target, or enter the name of the character who will receive the sharing request"

-- ** Services / Shared Content **
L["Containers"] = "容器"
L["Equipment"] = "装备"
L["Mails"] = "邮件"
L["Quests"] = "任务"
L["Reputations"] = "声望"

-- ** Services / Events **

L["%s is now ready (%s on %s)"] = "%s 现准备好 (%s 之 %s)"
L["%s is now unlocked (%s on %s)"] = "%s 现解锁 (%s 之 %s)"
L["%s starts in %d minutes (%s on %s)"] = "%s 在 %d 分钟后开始 (%s 之 %s)"
L["%s will be ready in %d minutes (%s on %s)"] = "%s 在 %d 分钟后准备好 (%s on %s)"
L["%s will be unlocked in %d minutes (%s on %s)"] = "%s 將在 %d 分鐘後解鎖(%s on %s)"
L["Do you want to open Altoholic's calendar for details ?"] = "你想开启Altoholic日历来了解详情吗?"


-- ** Services / Tooltip **

L["Transmute"] = "转化"
L["Bags"] = "背包"
L["Bank"] = "银行"
L["AH"] = "拍卖行"
L["Mail"] = "邮件"
L["Equipped"] = "已装备"
L["Already known by"] = "已学会"
L["Could be learned by"] = "可学习"
L["Will be learnable by"] = "将学习"
L["Total owned"] = "总计"
L["Source"] = "来源"
-- L["Goes in"] = true
L["Are also on this quest:"] = "有相同任务: "
-- L["Could be stored on"] = true