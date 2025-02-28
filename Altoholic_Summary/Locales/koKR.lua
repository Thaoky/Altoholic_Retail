local L = AddonFactory:SetLocale("Altoholic", "koKR")
if not L then return end

L["Calendar"] = "달력"
L["Tooltip"] = "툴팁"
-- L["Getting support"] = true
-- L["Memory used"] = true
L["Reset all data"] = "모든 데이터 초기화"
L["WIPE_DATABASE"] = "데이터베이스를 지울까요?"
L["WIPE_WARNING"] = "경고: 모든 정보가 손실됩니다!"
L["DATABASE_WIPED"] = "DataStore에 저장된 정보가 완전히 지워졌습니다!"
  
L["Account"] = "계정"
L["Default"] = "기본값"
L["Characters"] = "캐릭터"
L["Realms"] = "서버"
-- L["%s%d%s characters found : did you set your filters properly ?"] = true
 
-- ** Menu **
-- L["Character Information"] = true
L["Account Summary"] = "계정 요약"
-- L["Experience"] = true
L["Levels"] = "레벨"
-- L["Location"] = true
L["Bag Usage"] = "가방 사용"
L["Activity"] = "활동"
-- L["Currencies"] = true
L["PATCH_X.0"] = "Expansion Patch"
L["PATCH_9.1"] = "Chains of Domination"
L["PATCH_9.2"] = "Eternity's End"
L["PATCH_10.1"] = "Embers of Neltharion"
L["PATCH_10.2"] = "Guardians of the Dream"

-- ** Filter Icons **
L["FILTER_CLASSES"] = "직업 필터"
L["FILTER_FACTIONS"] = "평판 필터"
L["FILTER_LEVELS"] = "레벨 필터"
L["FILTER_PROFESSIONS"] = "전문기술 필터"
L["FILTER_REALMS"] = "서버 필터"
-- L["FILTER_RACES"] = "Race filter"
-- L["FILTER_MISC"] = "Miscellaneous filters"
-- L["FILTER_BANKTYPE"] = "Bank characters filters"
L["This realm"] = "이 서버"
L["All realms"] = "모든 서버"
L["This account"] = "이 계정"
L["All accounts"] = "모든 계정"
L["This faction"] = "이 평판"
L["Both factions"] = "양쪽 진영"
L["Any"] = "모두"
-- L["Allied Races"] = true
L["ACCOUNT_SHARING_BUTTON_TITLE"] = "계정 공유 요청"
L["ACCOUNT_SHARING_BUTTON_INFO"] =  [[사용자에게 그 사람의 Altoholic 데이터베이스
전부를 공유하고 당신의 데이터베이스에 추가할
것인지 물어보려면 이 버튼을 클릭]]

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
L["Totals"] = "총합"
L["Right-Click for options"] = "옵션은 오른쪽 클릭"
L["Character %s successfully deleted"] = "%s 캐릭터를 성공적으로 삭제함"
L["Realm %s successfully deleted"] = "%s 서버를 성공적으로 삭제함"
L["Cannot delete current character"] = "현재 캐릭터는 삭제할 수 없음"
L["Cannot delete current realm"] = "현재 서버는 삭제할 수 없음"
L["Delete this Alt"] = "이 캐릭터 삭제"
L["Delete this Realm"] = "이 서버 삭제"
L["Update from %s%s"] = true

L["View"] = "보기"
-- L["Mark as bank"] = true
-- L["Add to group"] = true
-- L["Remove from group"] = true



-- Column Level
L["COLUMN_LEVEL_SUBTITLE"] = "레벨 클릭하여 소수점 보기"
L["COLUMN_LEVEL_TITLE"] = "캐릭터 레벨"
L["COLUMN_LEVEL_TITLE_SHORT"] = "레벨"

-- Column Rest XP
L["COLUMN_RESTXP_SUBTITLE"] = "클릭하여 100%/150% 모드 변경"
L["COLUMN_RESTXP_TITLE"] = "남은 경험치"
L["COLUMN_RESTXP_TITLE_SHORT"] = "남은 경험치"
-- L["COLUMN_RESTXP_DETAIL_1"] = "It takes 8 hours to gain 1 XP bubble (5%)."
-- L["COLUMN_RESTXP_DETAIL_2"] = "The maximum rested XP is 30 XP bubbles, or 1.5 level."
-- L["COLUMN_RESTXP_DETAIL_3"] = "It is achieved in 10 days."
-- L["COLUMN_RESTXP_DETAIL_4"] = "%d%% mode : fully rested is displayed as '%d%%'"
-- L["Fully rested"] = true
-- L["Fully rested in"] = true
-- L["CHARACTER_NOT_IN_RESTING_AREA"] = "This character is not in a resting area !"

-- Column Money
L["COLUMN_MONEY_TITLE"] = "돈"
L["COLUMN_MONEY_TITLE_SHORT"] = "돈"
-- L["COLUMN_MONEY_SUBTITLE_1"] = "Your shinies"
-- L["COLUMN_MONEY_SUBTITLE_2"] = "Mo Money Mo Problems"
L["COLUMN_MONEY_SUBTITLE_3"] = "탐욕은 선이다"
-- L["COLUMN_MONEY_SUBTITLE_4"] = "Can't buy happiness .. but buys loads of mounts !"
-- L["COLUMN_MONEY_SUBTITLE_5"] = "Does not grow on World Trees"

-- Column Played
L["COLUMN_PLAYED_SUBTITLE"] = "클릭해서 실제 플레이 시간 표시/숨김"
L["COLUMN_PLAYED_TITLE"] = "총 플레이 시간"
L["COLUMN_PLAYED_TITLE_SHORT"] = "플레이함"

-- Column iLevel
L["COLUMN_ILEVEL_SUBTITLE"] = "클릭하여 소수점 표시"
L["COLUMN_ILEVEL_TITLE"] = "평균 템렙"
L["COLUMN_ILEVEL_TITLE_SHORT"] = "템렙"

-- Column Last Online
L["COLUMN_LASTONLINE_SUBTITLE"] = "마지막으로 캐릭터 접속한 시간"
L["COLUMN_LASTONLINE_TITLE"] = "최근 접속"
L["COLUMN_LASTONLINE_TITLE_SHORT"] = "최근 접속"

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
L["COLUMN_BAGS_SUBTITLE_1"] = "가방 착용 칸"
L["COLUMN_BAGS_SUBTITLE_2"] = "언제나 큰 게 더 낫지"
L["COLUMN_BAGS_TITLE"] = "캐릭터 가방"
L["COLUMN_BAGS_TITLE_SHORT"] = "가방"
L["COLUMN_FREEBAGSLOTS_SUBTITLE"] = "남은 공간 / 전체 공간"
L["COLUMN_FREEBAGSLOTS_TITLE"] = "남은 은행 공간"
L["COLUMN_FREEBAGSLOTS_TITLE_SHORT"] = "남음"
L["COLUMN_BANK_TITLE"] = "캐릭터 은행"
L["COLUMN_BANK_TITLE_SHORT"] = "은행"
L["COLUMN_BANK_SUBTITLE_1"] = "은행 장착 칸"
-- L["COLUMN_BAGS_SUBTITLE_2"] = "Bigger is always better"
L["COLUMN_FREEBANKLOTS_SUBTITLE"] = "남은 공간 / 전체 공간"
L["COLUMN_FREEBANKLOTS_TITLE"] = "남은 은행 공간"
L["COLUMN_FREEBANKLOTS_TITLE_SHORT"] = "남음"
L["NUM_SLOTS_AND_FREE"] = "%s%d%s 공간, %s%d%s 남음"

L["Bags"] = "가방"
L["Bank"] = "은행"
L["Bank bag"] = "은행 가방"
L["Bank not visited yet"] = "아직 은행을 방문하지 않음"
L["slots"] = "칸"

-- *** Skills ***
L["COLUMN_PROFESSION_1_TITLE"] = "Erster Beruf"
L["COLUMN_PROFESSION_1_TITLE_SHORT"] = "Beruf 1"
L["COLUMN_PROFESSION_2_TITLE"] = "Zweiter Beruf"
L["COLUMN_PROFESSION_2_TITLE_SHORT"] = "Beruf 2"
-- L["COLUMN_RIDING_UPGRADEABLE_MALE"] = "This character could upgrade his riding skill"
-- L["COLUMN_RIDING_UPGRADEABLE_FEMALE"] = "This character could upgrade her riding skill"
L["COLOR_GREEN"] = "녹색"
L["COLOR_GREY"] = "회색"
L["COLOR_ORANGE"] = "주황"
L["COLOR_RED"] = "빨강"
L["COLOR_YELLOW"] = "노랑"

L["up to"] = "최대한"
L["at"] = "에서"
L["and above"] = "이상"
L["No data"] = "데이터 없음"
L["Suggestion"] = "권장"
L["All cooldowns are up"] = "대기시간(cooldown)이 남아있는 제조법 없음"
L["Riding"] = "탈것 타기"
 
-- *** Activity ***
L["COLUMN_MAILS_SUBTITLE"] = "우편물 수량"
L["COLUMN_MAILS_TITLE"] = "우편함 내용물"
L["COLUMN_MAILS_TITLE_SHORT"] = "우편"
-- L["COLUMN_MAILS_DETAIL_1"] = "Beyond a certain limit, mails are queued server-side."
-- L["COLUMN_MAILS_DETAIL_2"] = "These mails are not accounted for here."
L["COLUMN_MAILBOX_VISITED_SUBTITLE"] = "우편함 내용물 확인한 최근 시간"
L["COLUMN_MAILBOX_VISITED_TITLE"] = "최근 우편함 확인"
L["COLUMN_MAILBOX_VISITED_TITLE_SHORT"] = "방문함"
L["COLUMN_AUCTIONS_SUBTITLE"] = "경매장에서 진행중인 경매 건 수"
L["COLUMN_AUCTIONS_TITLE"] = "경매장 경매"
L["COLUMN_AUCTIONS_TITLE_SHORT"] = "경매"
L["COLUMN_BIDS_SUBTITLE"] = "경매장에서 입찰한 수"
L["COLUMN_BIDS_TITLE"] = "경매장 입찰"
L["COLUMN_BIDS_TITLE_SHORT"] = "입찰"
L["COLUMN_AUCTIONHOUSE_VISITED_SUBTITLE"] = "최근 경매장 방문 시간"
L["COLUMN_AUCTIONHOUSE_VISITED_TITLE"] = "마지막으로 경매장 방문"
L["COLUMN_AUCTIONHOUSE_VISITED_TITLE_SHORT"] = "방문함"
L["COLUMN_GARRISON_MISSIONS_DETAIL_1"] = "임무 하나 이상 완료"
L["COLUMN_GARRISON_MISSIONS_DETAIL_2"] = "모든 임무 완료"
L["COLUMN_GARRISON_MISSIONS_DETAIL_3"] = "진행중인 임무 없음"
L["COLUMN_GARRISON_MISSIONS_SUBTITLE"] = "마지막으로 임무 확인한 시간"
L["COLUMN_GARRISON_MISSIONS_TITLE"] = "주둔지 임무"
L["COLUMN_GARRISON_MISSIONS_TITLE_SHORT"] = "임무"

L["Visited"] = "방문함"
 
 
-- *** Currencies ***
L["Last collected"] = "최종 모은"
L["Garrison resources"] = "추종자 자원"
L["Uncollected resources"] = "모으지 못한 자원"
L["Max. uncollected resources in"] = "모으지 못한 자원 최대량, "
 
 
-- *** Expansion Features / Garrison Followers ***
L["COLUMN_FOLLOWERS_LV40_TITLE"] = "40렙 추종자"
L["COLUMN_FOLLOWERS_LV40_TITLE_SHORT"] = "40렙"
L["COLUMN_FOLLOWERS_LV40_SUBTITLE"] = "렙 40 / 전체 추종자"
L["COLUMN_FOLLOWERS_RARITY_SUBTITLE"] = "희귀 / 영웅 등급"
L["COLUMN_FOLLOWERS_RARITY_TITLE"] = "추종자 등급"
L["COLUMN_FOLLOWERS_RARITY_TITLE_SHORT"] = "등급"
L["COLUMN_FOLLOWERS_ILEVEL_SUBTITLE"] = "템렙 %s"
L["COLUMN_FOLLOWERS_ILEVEL_TITLE"] = "%s 템렙 추종자"
L["COLUMN_FOLLOWERS_AIL_SUBTITLE"] = "활성화된 추종자 평균 템렙"
L["COLUMN_FOLLOWERS_AIL_TITLE"] = "추종자 평균 템렙"
L["COLUMN_FOLLOWERS_AIL_TITLE_SHORT"] = "템렙"

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

