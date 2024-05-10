local addonName = ...
local L = DataStore:SetLocale(addonName, "deDE")
if not L then return end

L["TAB_SUMMARY"] = "Zusammenfassung"
L["TAB_CHARACTERS"] = "Charaktere"
L["TAB_AGENDA"] = "Agenda"
L["TAB_GRIDS"] = "Gitter"
 
L["Shows the UI"] = "Benutzeroberfläche anzeigen"
L["Hides the UI"] = "Benutzeroberfläche verbergen"
L["Toggles the UI"] = "Benutzeroberfläche umschalten"
L["Search in bags"] = "In Taschen suchen"

L["Left-click to %sopen"] = "Links-Klick zum %sÖffnen"
L["Right-click to %sdrag"] = "Rechts-Klick, um zu %sziehen"

-- L["NEW_VERSION_AVAILABLE"] = "A new version of Altoholic is available, consider upgrading to get the latest features."
-- L["OFFICIAL_SOURCES"] = "Official sources : Curseforge & WoW Interface"

L["%s%s|r has requested the bank tab %s%s|r\nSend this information ?"] = [[%s%s|r hat das Bank-Tab %s%s|r angefordert.
Diese Informationen senden?]]
L["%sWarning:|r make sure this user may view this information before accepting"] = "%sWarnung:|r vor Annahme versichere dich, dass dieser Spieler diese Informationen auch einsehen darf."
L["%s|r has received a mail from %s"] = "%s|r hat Post von %s erhalten"
-- L["AUCTION_HOUSE_NOT_VISITED_WARNING"] = "Auctions have not been checked on %s|r since %d days, check the auction house and your mailbox !"

L["Mail is about to expire on at least one character."] = "Bei mindestens einem Charakter wird in Kürze Post verfallen."
L["Refer to the activity pane for more details."] = "Verweise auf Aktivitätsfeld für weitere Details."
L["Do you want to view it now ?"] = "Möchtest du es jetzt ansehen?"



-- ** Services / Account Sharing **
L["Sending table of content to %s (%d items)"] = "Sende Inhaltsverzeichnis an %s (%d Gegenstände)"
-- L["%sTransferring item %s%d|r/%s%d|r"] = true

L["Account sharing request received from %s"] = "Anfrage zu Account-Austausch von %s erhalten"
L["You have received an account sharing request\nfrom %s%s|r, accept it?"] = [[Du hast von %s%s|r eine Anfrage wegen
Account-Austausch erhalten - annehmen?]]
L["%sWarning:|r if you accept, %sALL|r information known\nby Altoholic will be sent to %s%s|r (bags, money, etc..)"] = [[%sWarnung:|r bei Annahme werden %sALLE|r Informationen, die
Altoholic bekannt sind, an %s%s|r gesendet (Taschen, Geld, etc.)]]
L["Request rejected by %s"] = "Anfrage von %s abgewiesen"
L["%s is in combat, request cancelled"] = "%s ist im Kampf, Anfrage wurde storniert."
L["%s has disabled account sharing"] = "%s hat den Account-Austausch deaktiviert"
L["Reference data received (%s) !"] = "Referenzdaten empfangen (%s)!"
L["Sending account sharing request to %s"] = "Sende Anfrage wegen Account-Austausch an %s"
-- L["Getting table of content from %s"] = true
-- L["Talent Tree Reference"] = true

-- L["SHARING_TRANSFER_OK"] = "Transfer completed successfully !"
-- L["SHARING_TRANSFER_CANCELLED"] = "Transfer has been cancelled, no data has been imported."
-- L["SHARING_TOC_RECEIVED"] = "|cFFFFFFFFTable of content received (|r|cFF00FF00%d|r |cFFFFFFFFitems)|r"
-- L["SHARING_OPTION_DISABLED"] = "You must enable account sharing first !"
-- L["SHARING_INVALID_TARGET"] = "You must select a target, or enter the name of the character who will receive the sharing request"

-- ** Services / Shared Content **
L["Containers"] = "Behälter"
L["Equipment"] = "Ausrüstung"
L["Mails"] = "Post"
L["Quests"] = true
L["Reputations"] = "Ruf"

-- ** Services / Events **

L["%s is now ready (%s on %s)"] = "%s ist jetzt bereit (%s auf %s)"
L["%s is now unlocked (%s on %s)"] = "%s wurde gerade zurückgesetzt (%s auf %s)"
L["%s starts in %d minutes (%s on %s)"] = "%s beginnt in %d Minute(n) (%s auf %s)"
L["%s will be ready in %d minutes (%s on %s)"] = "%s wird in %d Minute(n) bereit sein (%s auf %s)"
L["%s will be unlocked in %d minutes (%s on %s)"] = "%s wird in %d Minute(n) zurückgesetzt (%s auf %s)"
L["Do you want to open Altoholic's calendar for details ?"] = "Möchtest du den Altoholic-Kalender für weitere Details öffnen?"


-- ** Services / Tooltip **

L["Transmute"] = "Transmutieren"
L["Bags"] = "Taschen"
L["Bank"] = true
L["AH"] = true
L["Mail"] = "Post"
L["Equipped"] = "Ausgerüstet"
L["Already known by"] = "Schon bekannt durch"
L["Could be learned by"] = "Kann erlernt werden von"
L["Will be learnable by"] = "Wird demnächst erlernbar sein von"
L["Total owned"] = "Summe aller im Besitz"
L["Source"] = "Quelle"
-- L["Goes in"] = true
L["Are also on this quest:"] = "Sind auch in dieser Quest:"
-- L["Could be stored on"] = true