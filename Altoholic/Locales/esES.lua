local addonName = ...
local L = AddonFactory:SetLocale(addonName,  "esES")
if not L then return end

L["TAB_SUMMARY"] = "Resumen"
L["TAB_CHARACTERS"] = "Personajes"
L["TAB_AGENDA"] = "Agenda"
L["TAB_GRIDS"] = "Parrillas"

L["Shows the UI"] = "Mostrar el interfaz"
L["Hides the UI"] = "Ocultar el interfaz"
L["Toggles the UI"] = "Alternar el interfaz"
L["Search in bags"] = "Buscar en las bolsas"

L["Left-click to %sopen"] = "Click-Izd. para %sabrir"
L["Right-click to %sdrag"] = "Click-Dch. para %sdesplazar"

L["NEW_VERSION_AVAILABLE"] = "Una nueva versión de Altoholic está disponible, considere la posibilidad de actualizar para obtener las últimas características."
L["OFFICIAL_SOURCES"] = "Fuentes oficiales: Curseforge & WoW Interface"

L["%s%s|r has requested the bank tab %s%s|r\nSend this information ?"] = "%s%s|r ha solicitado la pestaña del banco %s%s|r/n¿Enviar esta información?"
L["%sWarning:|r make sure this user may view this information before accepting"] = "%sCuidado:|r asegúrate de que quieres que este usuario vea la información antes de aceptar"
L["%s|r has received a mail from %s"] = "%s|r ha recibido un correo de %s"
L["AUCTION_HOUSE_NOT_VISITED_WARNING"] = "Las subastas no se han comprobado en %s|r hace %d días, ¡compruebe la casa de subastas y el buzón."

L["Mail is about to expire on at least one character."] = "Hay correo a punto de expirar en al menos un personaje."
L["Refer to the activity pane for more details."] = "Revisa el panel de actividad para saber más detalles."
L["Do you want to view it now ?"] = "¿Quieres verlo ahora?"



-- ** Services / Account Sharing **
L["Sending table of content to %s (%d items)"] = "Mandando tabla de contenidos a %s (%d partes)"
L["%sTransferring item %s%d|r/%s%d|r"] = "%sTransfiriendo item %s%d|r/%s%d|r"

L["Account sharing request received from %s"] = "Petición para compartir cuenta recibida de %s"
L["You have received an account sharing request\nfrom %s%s|r, accept it?"] = "Has recibido una solicitud para compartir cuenta de %s%s|r, ¿la aceptas?"
L["%sWarning:|r if you accept, %sALL|r information known\nby Altoholic will be sent to %s%s|r (bags, money, etc..)"] = "%sCuidado:|r si aceptas, %sTODA|r la información conocida por Altoholic será enviada a %s%s|r (bolsas, dinero, etc...)"
L["Request rejected by %s"] = "Petición rechazada por %s"
L["%s is in combat, request cancelled"] = "%s está en combate, petición cancelada"
L["%s has disabled account sharing"] = "%s tiene desconectada la compartición de cuenta"
L["Reference data received (%s) !"] = "Datos de referencia recibidos (%s)"
L["Sending account sharing request to %s"] = "Mandando petición dee compartir cuenta a %s"
L["Getting table of content from %s"] = "Obtener la tabla de contenidos de %s"
L["Talent Tree Reference"] = "Referencia del Árbol de Talentos"

L["SHARING_TRANSFER_OK"] = "¡Transferencia completada con éxito!"
L["SHARING_TRANSFER_CANCELLED"] = "La transferencia ha sido cancelada, no se ha importado ningún dato."
L["SHARING_TOC_RECEIVED"] = "|cFFFFFFFFTabla de contenidos recibidos (|r|cFF00FF00%d|r |cFFFFFFFFitems)|r"
L["SHARING_OPTION_DISABLED"] = "Primero debes habilitar el uso compartido de cuentas."
L["SHARING_INVALID_TARGET"] = "Debe seleccionar un objetivo, o introducir el nombre del personaje que recibirá la solicitud de compartición"

-- ** Services / Shared Content **
L["Containers"] = "Almacenamiento"
L["Equipment"] = "Equipo"
L["Mails"] = "Correos"
L["Quests"] = "Misiones"
L["Reputations"] = "Reputación"

-- ** Services / Events **

L["%s is now ready (%s on %s)"] = "%s ya está listo (%s en %s)"
L["%s is now unlocked (%s on %s)"] = "%s ya está desbloqueado (%s en %s)"
L["%s starts in %d minutes (%s on %s)"] = "%s empieza en %d minutos (%s en %s)"
L["%s will be ready in %d minutes (%s on %s)"] = "%s estará listo en %d minutos (%s en %s)"
L["%s will be unlocked in %d minutes (%s on %s)"] = "%s será desbloqueado en %d minutos (%s en %s)"
L["Do you want to open Altoholic's calendar for details ?"] = "¿Deseas abrir el calendario de Altoholic para obtener más información?"


-- ** Services / Tooltip **

L["Transmute"] = "Transmutar"
L["Bags"] = "Bolsas"
L["Bank"] = "Banco"
L["Reagent Bag"] = "Bolsa de componentes"
L["AH"] = "Casa de subastas"
L["Mail"] = "Correo"
L["Equipped"] = "Equipado"
L["Already known by"] = "Conocido actualmente por:"
L["Could be learned by"] = "Puede aprenderlo:"
L["Will be learnable by"] = "Podría aprenderlo:"
L["Total owned"] = "Total poseídos"
L["Source"] = "Fuente:"
L["Goes in"] = "Puede colocarse en"
L["Are also on this quest:"] = "También están en esta misión:"
L["Could be stored on"] = "Se puede almacenar en"
