local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "koKR" )

if not L then return end

L["TAB_SUMMARY"] = "요약"
L["TAB_CHARACTERS"] = "캐릭터"
L["TAB_AGENDA"] = "일정"
L["TAB_GRIDS"] = "대조표"
 
L["Shows the UI"] = "UI 보이기"
L["Hides the UI"] = "UI 숨김"
L["Toggles the UI"] = "UI 숨기기/보이기"
L["Search in bags"] = "가방에서 검색"

L["Left-click to %sopen"] = "왼쪽 클릭 %s열기"
L["Right-click to %sdrag"] = "오른쪽 클릭 %s드래그"

-- L["NEW_VERSION_AVAILABLE"] = "A new version of Altoholic is available, consider upgrading to get the latest features."
-- L["OFFICIAL_SOURCES"] = "Official sources : Curseforge & WoW Interface"

L["%s%s|r has requested the bank tab %s%s|r\nSend this information ?"] = [[%s%s|r의 %s%s|r 은행 탭을 요청했습니다.
이 정보를 보낼까요?]]
L["%sWarning:|r make sure this user may view this information before accepting"] = [[%s경고:|r 승인하기 전에 이 사용자가 이
정보들을 정말 봐도 되는지 확인해 보세요.]]
L["%s|r has received a mail from %s"] = "%s|r %s의 우편물을 받았음"
-- L["AUCTION_HOUSE_NOT_VISITED_WARNING"] = "Auctions have not been checked on %s|r since %d days, check the auction house and your mailbox !"

L["Mail is about to expire on at least one character."] = "한 캐릭터 이상에서 우편물 소멸이 가까워졌습니다."
L["Refer to the activity pane for more details."] = "자세한 내용은 활동 창을 참조해 주세요."
L["Do you want to view it now ?"] = "지금 보겠습니까?"



-- ** Services / Account Sharing **
L["Sending table of content to %s (%d items)"] = "목차 보내는 중 %s (%d 아이템)"
-- L["%sTransferring item %s%d|r/%s%d|r"] = true

L["Account sharing request received from %s"] = "%s한테서 계정 공유 요청을 받음"
L["You have received an account sharing request\nfrom %s%s|r, accept it?"] = "%s%s|r의 계정 공유 요청을 승인하겠습니까?"
L["%sWarning:|r if you accept, %sALL|r information known\nby Altoholic will be sent to %s%s|r (bags, money, etc..)"] = [[%s경고:|r 승인하면, Altoholic이 가지고 있는
%s모든|r 정보(가방, 돈, 기타..)가 %s%s|r로
보내집니다.]]
L["Request rejected by %s"] = "%s, 요청을 거절함"
L["%s is in combat, request cancelled"] = "%s 전투 중, 요청이 중단됨"
L["%s has disabled account sharing"] = "%s, 계정 공유 해제"
L["Reference data received (%s) !"] = "참조 데이터 받음 (%s) !"
L["Sending account sharing request to %s"] = "%s에게 계정 공유 요청을 보내는 중"
-- L["Getting table of content from %s"] = true
-- L["Talent Tree Reference"] = true

-- L["SHARING_TRANSFER_OK"] = "Transfer completed successfully !"
-- L["SHARING_TRANSFER_CANCELLED"] = "Transfer has been cancelled, no data has been imported."
-- L["SHARING_TOC_RECEIVED"] = "|cFFFFFFFFTable of content received (|r|cFF00FF00%d|r |cFFFFFFFFitems)|r"
-- L["SHARING_OPTION_DISABLED"] = "You must enable account sharing first !"
-- L["SHARING_INVALID_TARGET"] = "You must select a target, or enter the name of the character who will receive the sharing request"

-- ** Services / Shared Content **
L["Containers"] = "보관함"
L["Equipment"] = "장비"
L["Mails"] = "우편"
L["Quests"] = "퀘스트"
L["Reputations"] = "평판"

-- ** Services / Events **

L["%s is now ready (%s on %s)"] = "%s 지금 준비 (%s %s)"
L["%s is now unlocked (%s on %s)"] = "%s 지금 풀림 (%s %s)"
L["%s starts in %d minutes (%s on %s)"] = "%s의 시작 시간이 %d 분 남았습니다. (%s , %s)"
L["%s will be ready in %d minutes (%s on %s)"] = "%s의 재사용 시간이 %d분 남았습니다. (%s , %s)"
L["%s will be unlocked in %d minutes (%s on %s)"] = "%s가 %d 분 내에 해제됩니다. (%s, %s)"
L["Do you want to open Altoholic's calendar for details ?"] = "상세 내용을 Altoholic 달력으로 열까요?"


-- ** Services / Tooltip **

L["Transmute"] = "변환"
L["Bags"] = "가방"
L["Bank"] = "은행"
L["AH"] = "경매장"
L["Mail"] = "우편"
L["Equipped"] = "착용"
L["Already known by"] = "이미 배움"
L["Could be learned by"] = "배울 수 있음"
L["Will be learnable by"] = "향 후 배움 가능"
L["Total owned"] = "총 소유"
L["Source"] = "출처"
-- L["Goes in"] = true
L["Are also on this quest:"] = "이 퀘스트 진행 중:"
-- L["Could be stored on"] = true