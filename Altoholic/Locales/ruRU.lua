-- 
-- Russian localization made by Hellbot & Interim @ EU Realms 
-- Перевод выполнен Хэлла и Интерим @ Азурегос 
--

local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "ruRU" )

if not L then return end

L["TAB_SUMMARY"] = "Сводная информация"
L["TAB_CHARACTERS"] = "Персонажи"
L["TAB_AGENDA"] = "Повестка дня"
L["TAB_GRIDS"] = "Сетка"
 
L["Shows the UI"] = "Показать интерфейс"
L["Hides the UI"] = "Скрыть интерфейс"
L["Toggles the UI"] = "Показать / скрыть интерфейс"
L["Search in bags"] = "Искать в сумках"

L["Left-click to %sopen"] = "Щелкните левой кнопкой мыши чтобы %sоткрыть"
L["Right-click to %sdrag"] = "Щелкните правой кнопкой мыши чтобы  %sперетащить"

-- L["NEW_VERSION_AVAILABLE"] = "A new version of Altoholic is available, consider upgrading to get the latest features."
-- L["OFFICIAL_SOURCES"] = "Official sources : Curseforge & WoW Interface"

L["%s%s|r has requested the bank tab %s%s|r\nSend this information ?"] = [[%s%s|r запросил информацию по закладкам банка %s%s|r
Отослать информацию ?]]
L["%sWarning:|r make sure this user may view this information before accepting"] = "%sВнимание:|r Прежде чем принять, убедитесь, может ли этот пользователь просматривать эту информацию, т.е. доверяете ли вы ему"
L["%s|r has received a mail from %s"] = "%s|r получил(а) письмо от %s"
-- L["AUCTION_HOUSE_NOT_VISITED_WARNING"] = "Auctions have not been checked on %s|r since %d days, check the auction house and your mailbox !"

L["Mail is about to expire on at least one character."] = "Срок хранения почты скоро истечет, по крайней мере у одного персонажа."
L["Refer to the activity pane for more details."] = "Обратитесь к панели активности, для более подробной информации."
L["Do you want to view it now ?"] = "Вы хотите просмотреть теперь?"



-- ** Services / Account Sharing **
L["Sending table of content to %s (%d items)"] = "Отсылка содержания %s (%d предметов)"
-- L["%sTransferring item %s%d|r/%s%d|r"] = true

L["Account sharing request received from %s"] = "Получение запрос от |3-1(%s),на совместное использование данных"
L["You have received an account sharing request\nfrom %s%s|r, accept it?"] = [[Вы получили запрос о совместном использование данных уч.записи
от %s%s|r, принять?]]
L["%sWarning:|r if you accept, %sALL|r information known\nby Altoholic will be sent to %s%s|r (bags, money, etc..)"] = [[%sВнимание:|r Если вы согласитесь то, %sВСЯ|r известная информация 
Altoholic'ом будет отослана к %s%s|r (сумки, валюта, и т.д..)]]
L["Request rejected by %s"] = "Запрос отклонен |3-4(%s)"
L["%s is in combat, request cancelled"] = "%s в бою, запрос отменён"
L["%s has disabled account sharing"] = "%s отключил совместное использование данных уч.записи"
L["Reference data received (%s) !"] = "Получение справочных данных: (%s)!"
L["Sending account sharing request to %s"] = "Отсылка запроса |3-2(%s), о совместном использовании данных уч.записи"
-- L["Getting table of content from %s"] = true
-- L["Talent Tree Reference"] = true

-- L["SHARING_TRANSFER_OK"] = "Transfer completed successfully !"
-- L["SHARING_TRANSFER_CANCELLED"] = "Transfer has been cancelled, no data has been imported."
-- L["SHARING_TOC_RECEIVED"] = "|cFFFFFFFFTable of content received (|r|cFF00FF00%d|r |cFFFFFFFFitems)|r"
-- L["SHARING_OPTION_DISABLED"] = "You must enable account sharing first !"
-- L["SHARING_INVALID_TARGET"] = "You must select a target, or enter the name of the character who will receive the sharing request"

-- ** Services / Shared Content **
L["Containers"] = "Сумки"
L["Equipment"] = "Экипировка"
L["Mails"] = "Письма"
L["Quests"] = "Задания"
L["Reputations"] = "Репутация"

-- ** Services / Events **

L["%s is now ready (%s on %s)"] = "%s уже готово (%s - %s)"
L["%s is now unlocked (%s on %s)"] = "%s уже открыто (%s on %s)"
L["%s starts in %d minutes (%s on %s)"] = "%s начнётся через %d минут (%s - %s)"
L["%s will be ready in %d minutes (%s on %s)"] = "%s будет готово через %d минут (%s - %s)"
L["%s will be unlocked in %d minutes (%s on %s)"] = "%s будет разблокировано через %d минут(ы)"
L["Do you want to open Altoholic's calendar for details ?"] = "Вы хотите открыть календарь Altoholic'а для подробной информации?"


-- ** Services / Tooltip **

L["Transmute"] = "Трансмутация"
L["Bags"] = "Сумки"
L["Bank"] = "В банке"
L["AH"] = "АУК"
L["Mail"] = "В почте"
L["Equipped"] = "Надето"
L["Already known by"] = "Изучено"
L["Could be learned by"] = "Может быть изучено"
L["Will be learnable by"] = "Будет изучено"
L["Total owned"] = "Общее количество"
L["Source"] = "Источник"
-- L["Goes in"] = true
L["Are also on this quest:"] = "Этот квест также выполняют:"
-- L["Could be stored on"] = true