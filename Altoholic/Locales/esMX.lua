local addonName = ...
local L = DataStore:SetLocale(addonName,  "esMX")
if not L then return end

L["TAB_SUMMARY"] = "Resumen"
L["TAB_CHARACTERS"] = "Personajes"
L["TAB_AGENDA"] = "Agenda"
L["TAB_GRIDS"] = "Parrillas"
 
L["Shows the UI"] = "Mostrar el interfaz"
L["Hides the UI"] = "Ocultar el interfaz"
L["Toggles the UI"] = "Alternar el interfaz"
L["Search in bags"] = "Buscar en las bolsas"

L["Left-click to %sopen"] = "Bot�n izquierdo para %sabrir"
L["Right-click to %sdrag"] = "Bot�n derecho para %sdesplazar"

-- L["NEW_VERSION_AVAILABLE"] = "A new version of Altoholic is available, consider upgrading to get the latest features."
-- L["OFFICIAL_SOURCES"] = "Official sources : Curseforge & WoW Interface"

L["%s%s|r has requested the bank tab %s%s|r\nSend this information ?"] = [[%s%s|r ha solicitado la pesta�a del banco %s%s|r
� Mandar esta informaci�n ?]]
L["%sWarning:|r make sure this user may view this information before accepting"] = "%sCuidado:|r aseg�rate de que quieres que este usuario vea la informaci�n antes de aceptar"
L["%s|r has received a mail from %s"] = "%s|r ha recibido un correo de %s"
-- L["AUCTION_HOUSE_NOT_VISITED_WARNING"] = "Auctions have not been checked on %s|r since %d days, check the auction house and your mailbox !"

L["Mail is about to expire on at least one character."] = "Hay correo a punto de expirar en al menos un personaje."
L["Refer to the activity pane for more details."] = "Revisa el panel de actividad para saber m�s detalles."
L["Do you want to view it now ?"] = "� Quieres verlo ahora ?"



-- ** Services / Account Sharing **
L["Sending table of content to %s (%d items)"] = "Mandando tabla de contenidos a %s (%d partes)"
-- L["%sTransferring item %s%d|r/%s%d|r"] = true

L["Account sharing request received from %s"] = "Petici�n de compartir cuenta recibida de %s"
L["You have received an account sharing request\nfrom %s%s|r, accept it?"] = [[Has recibido una petici�n de compartir cuenta
 de %s%s|r, � la aceptas ?]]
L["%sWarning:|r if you accept, %sALL|r information known\nby Altoholic will be sent to %s%s|r (bags, money, etc..)"] = [[%sCuidado:|r si aceptas, %sTODA|r la informaci�n conocida
por Altoholic ser� enviada a %s%s|r (bolsas, dinero, etc..)]]
L["Request rejected by %s"] = "Petici�n rechazada por %s"
L["%s is in combat, request cancelled"] = "%s est� en combate, petici�n cancelada"
L["%s has disabled account sharing"] = "%s tiene desconectado la compartici�n de cuenta"
L["Reference data received (%s) !"] = "Datos de referencia recibidos (%s)"
L["Sending account sharing request to %s"] = "Mandando petici�n de compartir cuenta a %s"
-- L["Getting table of content from %s"] = true
-- L["Talent Tree Reference"] = true

-- L["SHARING_TRANSFER_OK"] = "Transfer completed successfully !"
-- L["SHARING_TRANSFER_CANCELLED"] = "Transfer has been cancelled, no data has been imported."
-- L["SHARING_TOC_RECEIVED"] = "|cFFFFFFFFTable of content received (|r|cFF00FF00%d|r |cFFFFFFFFitems)|r"
-- L["SHARING_OPTION_DISABLED"] = "You must enable account sharing first !"
-- L["SHARING_INVALID_TARGET"] = "You must select a target, or enter the name of the character who will receive the sharing request"

-- ** Services / Shared Content **
L["Containers"] = "Almacenes"
L["Equipment"] = "Equipo"
L["Mails"] = "Correos"
L["Quests"] = "Misiones"
L["Reputations"] = "Reputaci�n"

-- ** Services / Events **

L["%s is now ready (%s on %s)"] = "%s ya est� listo (%s en %s)"
L["%s is now unlocked (%s on %s)"] = "%s ya est� desbloqueado (%s en %s)"
L["%s starts in %d minutes (%s on %s)"] = "%s empieza en %d minutos (%s en %s)"
L["%s will be ready in %d minutes (%s on %s)"] = "%s estar� listo en %d minutos (%s en %s)"
L["%s will be unlocked in %d minutes (%s on %s)"] = "%s ser� desbloqueado en %d minutos (%s en %s)"
L["Do you want to open Altoholic's calendar for details ?"] = "�Desea abrir el calendario de Altoholic para obtener m�s informaci�n?"


-- ** Services / Tooltip **

L["Transmute"] = "Transmutar"
L["Bags"] = "Bolsas"
L["Bank"] = "Banco"
L["AH"] = true
L["Mail"] = "Correo"
L["Equipped"] = "Equipado"
L["Already known by"] = "Conocido actualmente por"
L["Could be learned by"] = "Puede aprenderlo"
L["Will be learnable by"] = "Podr�a aprenderlo"
L["Total owned"] = "Total pose�dos"
L["Source"] = "Fuente:"
-- L["Goes in"] = true
L["Are also on this quest:"] = "Est�n en esta misi�n:"
-- L["Could be stored on"] = true