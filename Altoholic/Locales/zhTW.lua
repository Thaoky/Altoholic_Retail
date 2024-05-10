local addonName = ...
local L = DataStore:SetLocale(addonName, "zhTW")
if not L then return end

L["TAB_SUMMARY"] = "摘要"
L["TAB_CHARACTERS"] = "角色"
L["TAB_AGENDA"] = "行程表"
L["TAB_GRIDS"] = "網格"
 
L["Shows the UI"] = "顯示圖形介面"
L["Hides the UI"] = "隱藏圖形介面"
L["Toggles the UI"] = "切換圖形介面的顯示/隱藏"
L["Search in bags"] = "在背包中搜索"

L["Left-click to %sopen"] = "左鍵 %s開啟"
L["Right-click to %sdrag"] = "右鍵 %s拖曳"

-- L["NEW_VERSION_AVAILABLE"] = "A new version of Altoholic is available, consider upgrading to get the latest features."
-- L["OFFICIAL_SOURCES"] = "Official sources : Curseforge & WoW Interface"

L["%s%s|r has requested the bank tab %s%s|r\nSend this information ?"] = [[%s%s|r 要求公會金庫分頁 %s%s|r
要傳送這項資料嗎 ?]]
L["%sWarning:|r make sure this user may view this information before accepting"] = "%s警告:|r 請確定此用戶可以查看分頁的資料才接受"
L["%s|r has received a mail from %s"] = "%s|r 已收到的郵件, 寄件者: %s"
-- L["AUCTION_HOUSE_NOT_VISITED_WARNING"] = "Auctions have not been checked on %s|r since %d days, check the auction house and your mailbox !"

L["Mail is about to expire on at least one character."] = "至少有一個角色的郵件即將到期."
L["Refer to the activity pane for more details."] = "詳細請參照活動."
L["Do you want to view it now ?"] = "你想立即查看嗎 ?"



-- ** Services / Account Sharing **
L["Sending table of content to %s (%d items)"] = "發送列表內容 %s (%d 物品)"
-- L["%sTransferring item %s%d|r/%s%d|r"] = true

L["Account sharing request received from %s"] = "收到%s的帳戶共享資料要求"
L["You have received an account sharing request\nfrom %s%s|r, accept it?"] = [[你收到帳戶共享資料的要求
要求者 %s%s|r, 接受嗎?]]
L["%sWarning:|r if you accept, %sALL|r information known\nby Altoholic will be sent to %s%s|r (bags, money, etc..)"] = [[%s警告:|r 如接受, %s所有|r 已知的資料
會被 Altoholic 傳送給 %s%s|r (背包, 金錢, 等等..)]]
L["Request rejected by %s"] = "要求被%s駁回"
L["%s is in combat, request cancelled"] = "%s在戰鬥中, 要求被駁回"
L["%s has disabled account sharing"] = "%s的帳戶共享資料功能關閉"
L["Reference data received (%s) !"] = "收到參考的資料 (%s) !"
L["Sending account sharing request to %s"] = "向%s發送帳戶共享資料的要求"
-- L["Getting table of content from %s"] = true
-- L["Talent Tree Reference"] = true

-- L["SHARING_TRANSFER_OK"] = "Transfer completed successfully !"
-- L["SHARING_TRANSFER_CANCELLED"] = "Transfer has been cancelled, no data has been imported."
-- L["SHARING_TOC_RECEIVED"] = "|cFFFFFFFFTable of content received (|r|cFF00FF00%d|r |cFFFFFFFFitems)|r"
-- L["SHARING_OPTION_DISABLED"] = "You must enable account sharing first !"
-- L["SHARING_INVALID_TARGET"] = "You must select a target, or enter the name of the character who will receive the sharing request"

-- ** Services / Shared Content **
L["Containers"] = "容器"
L["Equipment"] = "裝備"
L["Mails"] = "郵件"
L["Quests"] = "任務"
L["Reputations"] = "聲望"

-- ** Services / Events **

L["%s is now ready (%s on %s)"] = "%s 現準備好 (%s 之 %s)"
L["%s is now unlocked (%s on %s)"] = "%s現在已重置 (%s-%s)"
L["%s starts in %d minutes (%s on %s)"] = "%s 在 %d 分鐘後開始 (%s 之 %s)"
L["%s will be ready in %d minutes (%s on %s)"] = "%s 在 %d 分鐘後準備好 (%s 之 %s)"
L["%s will be unlocked in %d minutes (%s on %s)"] = "%s將在%d分鐘後重置(%s-%s)"
L["Do you want to open Altoholic's calendar for details ?"] = "你想開啟Altoholic日曆來了解詳情嗎？"


-- ** Services / Tooltip **

L["Transmute"] = "轉化"
L["Bags"] = "背包"
L["Bank"] = "銀行"
L["AH"] = "拍賣場"
L["Mail"] = "郵件"
L["Equipped"] = "已裝備"
L["Already known by"] = "已經學會"
L["Could be learned by"] = "這可以被誰學會"
L["Will be learnable by"] = "這將以被誰學會"
L["Total owned"] = "總共擁有"
L["Source"] = "來源"
-- L["Goes in"] = true
L["Are also on this quest:"] = "也有這個任務:"
-- L["Could be stored on"] = true