local L = DataStore:SetLocale("Altoholic", "esES")
if not L then return end

-- ** Menu **
L["Settings"] = "Ajustes"
L["Calendar"] = "Calendario"
L["Tooltip"] = "Ventana emergente"
L["Enabled"] = "Activado"
L["Disabled"] = "Desactivado"
L["Character"] = "Personaje"
L["Characters"] = "Personajes"
L["Alt groups"] = "Grupos de alters"
L["Bank characters"] = "Personajes banco"
L["Account Sharing"] = "Compartición de cuenta"
L["How to"] = "Cómo"
L["Saved Variables"] = "Variables guardadas"
L["Getting support"] = "Obtener soporte"
L["About"] = "Acerca de"

L["CTRL_C_TO_COPY"] = "|cFF1CFAFECTRL+C|r para copiar esta dirección, |cFF1CFAFEESC|r para ocultar"
L["WOWI_ICON_ON_ENTER"] = "Click para mostrar la página de inicio del complemento en WoW Interface"
L["CURSE_ICON_ON_ENTER"] = "Click para mostrar la página de inicio del complemento en Curseforge"
L["DISCORD_ICON_ON_ENTER"] = "Click para mostrar la dirección del servidor de Discord"
L["EMAIL_ICON_ON_ENTER"] = "Click para mostrar la dirección de correo electrónico de Thaoky"
L["TAB_NOT_LOADED_YET"] = "Pestaña no cargada aún"

-- ** Settings / Altoholic / General **
L["General Options"] = "Opciones generales"
L["Minimap Icon Angle"] = "Ángulo del icono del minimapa"
L["Minimap Icon Radius"] = "Radio del icono del minimapa"
L["Transparency"] = "Transparencia"

L["BANK_AUTO_UPDATE_TEXT"] = "Autorizar automáticamente las actualizaciones en el banco de la hermandad"
L["BANK_AUTO_UPDATE_TITLE"] = "Actualizaciones del banco de hermanda"
L["BANK_AUTO_UPDATE_ENABLED"] = "Tus compañeros de hermandad que también usen Altoholic podrán actualizar automáticamente la información de su banco de hermandad con el tuyo, si es más reciente."
L["BANK_AUTO_UPDATE_DISABLED"] = "Se requerirá su confirmación antes de enviar cualquier información."

L["CLAMP_TO_SCREEN_TEXT"] = "Fijar ventana a la pantalla"
L["CLAMP_TO_SCREEN_TITLE"] = "Fijar ventana a la pantalla"
L["CLAMP_TO_SCREEN_ENABLED"] = "La interfaz de usuario de Altoholic no se desborda fuera de los límites de la pantalla"
L["CLAMP_TO_SCREEN_DISABLED"] = "La interfaz de usuario de Altoholic será movible en cualquier lugar, con partes que salen de la pantalla"

L["SHOW_ICON_TEXT"] = "Mostrar icono en el minimapa"
L["SHOW_ICON_TITLE"] = "Mostrar icono en el minimapa"
L["SHOW_ICON_ENABLED"] = "El icono de Altoholic será visible en el minimapa"
L["SHOW_ICON_DISABLED"] = "El icono de Altoholic estará oculto"

L["Move to change the angle of the minimap icon"] = "Mover para cambiar el ángulo del icono en el minimapa"
L["Move to change the radius of the minimap icon"] = "Mover para cambiar el angulo del icono en el minimapa"
L["UI_SCALE_TOOLTIP"] = "Mover para cambiar la escala de la interfaz de usuario"
L["UI_TRANSPARENCY_TOOLTIP"] = "Mover para que la interfaz de usuario sea transparente"


-- ** Settings / Altoholic / Mail **
L["Mail Options"] = "Opciones de correo"

L["AUTO_COMPLETE_PRIORITY"] = "Prioridad de autocompletado"
L["AUTO_COMPLETE_BY_NAME"] = "Orden alfabético"
L["AUTO_COMPLETE_BY_MOST_PLAYED"] = "Más alto/jugado"
L["AUTO_COMPLETE_BY_LAST_PLAYED"] = "Jugado más recientemente"

L["GUILD_WARNING_TEXT"] = "Nueva notificación de correo"
L["GUILD_WARNING_TITLE"] = "Notificación de correo de hermandad"
L["GUILD_WARNING_ENABLED"] = "Recibirás una notificación cuando un compañero de hermandad envíe un correo a uno de tus alters.\n\nEl contenido del correo será directamente visible sin tener que volver a conectar con ese alter."
L["GUILD_WARNING_DISABLED"] = "El correo seguirá cayendo directamente en el buzón de su alter, pero no se le notificará."

L["AUTO_COMPLETE_TEXT"] = "Autocompletar nombre del destinatario"
L["AUTO_COMPLETE_TITLE"] = "Autocompletar nombre del destinatario"
L["AUTO_COMPLETE_ENABLED"] = "Los nombres de tus alters se usarán como sugerencias cuando completes el nombre del destinatario en un buzón."
L["AUTO_COMPLETE_DISABLED"] = "Los nombres de tus alters no se utilizarán como sugerencias."

L["TIME_TO_NEXT_WARNING_TEXT"] = "Tiempo hasta el próximo aviso"
L["TIME_TO_NEXT_WARNING_TOOLTIP"] = "Tiempo mínimo antes de recibir el siguiente aviso de expiración del correo."


-- ** Settings / Altoholic / Tooltip **
L["Tooltip Options"] = "Opciones de ventana emergente"

L["TT_SHOW_ITEMSOURCE_TEXT"] = "Mostrar la fuente del item"
L["TT_SHOW_ITEMSOURCE_TITLE"] = "Fuente del item"
L["TT_SHOW_ITEMSOURCE_ENABLED"] = [[Muestra información sobre el origen del item, como la profesión o la mazmorra donde cae.

-- Ej.

 -- |cFFFFD700Info:|r |cFF00FF9AAlchemy, 65|r
 -- |cFFFFD700Goes in:|r |cFF00FF9AGem Bag|r
 
-- or

 -- |cFFFFD700Raid:|r |cFF00FF9AMolten Core|r
 -- |cFFFFD700Boss:|r |cFF00FF9ARagnaros|r]]
L["TT_SHOW_ITEMSOURCE_DISABLED"] = "No se muestra ninguna información."

L["TT_SHOW_ITEMCOUNT_TEXT"] = "Mostrar el recuento de items por personaje"
L["TT_SHOW_ITEMCOUNT_TITLE"] = "Recuento de items por personaje"
L["TT_SHOW_ITEMCOUNT_ENABLED"] = [[Muestra una línea de información por cada personaje que posea al menos una copia del item sobre el que se pasa el ratón.

-- Ej.

    -- |cFF69CCF0Thaoky|r     |cFFFF7F003|r |cFFFFFFFF(Bags: |cFF00FF9A3|r)|r
    -- |cFFABD473Sira|r           |cFFFF7F006|r |cFFFFFFFF(Bags: |cFF00FF9A6|r)|r]]
L["TT_SHOW_ITEMCOUNT_DISABLED"] = "No se muestra ninguna información."

L["TT_SHOW_SIMPLECOUNT_TEXT"] = "Mostrar el recuento de items sin detalles"
L["TT_SHOW_SIMPLECOUNT_TITLE"] = "Recuento de items sin detalles"
L["TT_SHOW_SIMPLECOUNT_ENABLED"] = [[Muestra sólo la cantidad de items que posee un personaje, sin la ubicación.

-- Ej.

    -- |cFF69CCF0Thaoky|r     |cFFFF7F003|r]]
L["TT_SHOW_SIMPLECOUNT_DISABLED"] = [[La información sobre la ubicación se mostrará normalmente.

-- Tenga en cuenta que esta opción está vinculada a 
-- |cFFFF7F00Show item count per character|r]]

L["TT_SHOW_TOTALCOUNT_TEXT"] = "Mostrar el recuento total de items"
L["TT_SHOW_TOTALCOUNT_TITLE"] = "Recuento total de items"
L["TT_SHOW_TOTALCOUNT_ENABLED"] = [[Muestra la cantidad total de items que poseen todos los personajes que aparecen en la ventana emergente

-- Tenga en cuenta que este total está influenciado por otras múltiples opciones de ventanas emergentes y varía en función de los alters que haya elegido mostrar.

-- Ej.

 -- |cFFFFD700Total poseídos:|r |cFF00FF9A217|r]]
L["TT_SHOW_TOTALCOUNT_DISABLED"] = "La línea del total no se muestra."

L["TT_SHOW_RECIPES_TEXT"] = "Mostrar recetas ya conocidas/aprendidas por"
L["TT_SHOW_RECIPES_TITLE"] = "Mostrar recetas ya conocidas/aprendidas por"
L["TT_SHOW_RECIPES_ENABLED"] = [[Muestra información sobre los alters que ya conocen, podrían aprender o podrían aprender más adelante una receta.

-- Ej.

    -- |cFF00FF9AYa conocida por:|r |cFF69CCF0Thaoky|r
    -- |cFFFFFF00Puede ser aprendida por:|r |cFFABD473Sira|r]]
L["TT_SHOW_RECIPES_DISABLED"] = "No se muestra ninguna información."

L["TT_SHOW_GUILDBANKCOUNT_TEXT"] = "Mostrar el recuento del banco de la hermandad"
L["TT_SHOW_GUILDBANKCOUNT_TITLE"] = "Recuento del banco de la hermandad"
L["TT_SHOW_GUILDBANKCOUNT_ENABLED"] = [[Muestra la cantidad total de artículos almacenados en los bancos de hermandad.

-- Ej. 

    -- |cFF00FF00Odysseüs|r     |cFFFF7F0084|r |cFFFFFFFF(Guild Bank: |cFF00FF9A84|r)|r]]
L["TT_SHOW_GUILDBANKCOUNT_DISABLED"] = "No se muestra ninguna información."

L["TT_INCLUDE_GUILDBANKCOUNT_TEXT"] = "Incluir el recuento del banco de hermandad en el total"
L["TT_INCLUDE_GUILDBANKCOUNT_TITLE"] = "Incluir el recuento del banco de hermandad en el recuento total"
L["TT_INCLUDE_GUILDBANKCOUNT_ENABLED"] = "La cantidad de items almacenados en los bancos de hermandad se contabilizará en el total."
L["TT_INCLUDE_GUILDBANKCOUNT_DISABLED"] = "La cantidad de items almacenados en los bancos de hermandad se ignorará."

L["TT_DETAILED_BANKCOUNT_TEXT"] = "Recuento detallado del banco de hermandad"
L["TT_DETAILED_BANKCOUNT_TITLE"] = "Recuento detallado del banco de hermandad"
L["TT_DETAILED_BANKCOUNT_ENABLED"] = [[Muestra la cantidad de items almacenados en los bancos de hermandad, por pestaña.

-- Ej.

    -- |cFF00FF00Odysseüs|r     |cFFFF7F0084|r |cFFFFFFFF(Consumables: |cFF00FF9A84|r)|r]]
L["TT_DETAILED_BANKCOUNT_DISABLED"] = [[Mostrar 'Banco de hermandad' en lugar del nombre de la pestaña.]]

L["TT_SHOW_GUILDBANKREALM_TEXT"] = "Mostrar el reino del banco de hermandad"
L["TT_SHOW_GUILDBANKREALM_TITLE"] = "Reino del bando de hermandad"
L["TT_SHOW_GUILDBANKREALM_ENABLED"] = [[Muestra el reino en el que reside el banco de hermandad

-- Ej. 

    -- |cFF00FF00Odysseüs|r |cFFFFFF00(Marécages de Zangar)|r    |cFFFF7F0084|r |cFFFFFFFF(Guild Bank: |cFF00FF9A84|r)|r]]
L["TT_SHOW_GUILDBANKREALM_DISABLED"] = "Mostrar sólo el nombre de la hermandad"

L["TT_SHOW_ITEMID_TEXT"] = "Mostrar ID de item y nivel de item"
L["TT_SHOW_ITEMID_TITLE"] = "ID de item y nivel de item"
L["TT_SHOW_ITEMID_ENABLED"] = [[Muestra el ID del item y el nivel del item en la parte inferior de la ventana emergente.

-- Ej.

    -- |cFFFFD700Item ID:|r |cFF00FF00140192|r             |cFFFFD700iLvl:|r |cFF00FF0035|r]]
L["TT_SHOW_ITEMID_DISABLED"] = "No se muestra ninguna información."

L["TT_SHOW_ITEMXPACK_TEXT"] = "Mostrar información ampliada del item"
L["TT_SHOW_ITEMXPACK_TITLE"] = "Información ampliada del item"
L["TT_SHOW_ITEMXPACK_ENABLED"] = [[Muestra información ampliada sobre el item, como la expansión a la que pertenece.

-- Ej.

 -- |cFFFFD700Info:|r |cFF00FF9AAlchemy, 65|r
 -- |cFFFFD700Entra en:|r |cFF00FF9AGem Bag|r
 -- |cFFFFD700Expansión:|r |cFF00FF9ABurning Crusade|r |cFFFFFF00(2.0)|r]]
L["TT_SHOW_ITEMXPACK_DISABLED"] = [[No se muestra ninguna información.

-- Tenga en cuenta que esta opción está vinculada a 
-- |cFFFF7F00Show item source|r]]

L["TT_SHOW_COULDBESTORED_TEXT"] = "Mostrar el lugar de almacenamiento alternativo"
L["TT_SHOW_COULDBESTORED_TITLE"] = "Muestra el lugar de almacenamiento alternativo"
L["TT_SHOW_COULDBESTORED_ENABLED"] = [[Muestra en qué banco de alters se pueden almacenar materiales de expansiones anteriores.

Ej.

 |cFFFFD700Podría ser almacenado en:|r |cFF69CCF0Thaoky|r]]
L["TT_SHOW_COULDBESTORED_DISABLED"] = "No se muestra ninguna información."

L["TT_SHOW_NODES_TEXT"] = "Mostrar contadores en los nodos de recolección"
L["TT_SHOW_NODES_TITLE"] = "Mostrar contadores en los nodos de recolección"
L["TT_SHOW_NODES_ENABLED"] = "Al pasar el ratón por un nodo de recolección (hierbas, menas), muestra la cantidad de objetos relacionados que se poseen."
L["TT_SHOW_NODES_DISABLED"] = "No se muestra ninguna información."

L["TT_SHOW_BOTHFACTIONS_TEXT"] = "Mostrar contadores para ambas facciones"
L["TT_SHOW_BOTHFACTIONS_TITLE"] = "Mostrar contadores para ambas facciones"
L["TT_SHOW_BOTHFACTIONS_ENABLED"] = "Muestra la cantidad de items que poseen los personajes de la facción contraria."
L["TT_SHOW_BOTHFACTIONS_DISABLED"] = "Sólo se muestra información sobre la facción actual."

L["TT_SHOW_MERGEDREALMS_TEXT"] = "Mostrar contadores de reinos conectados"
L["TT_SHOW_MERGEDREALMS_TITLE"] = "Mostrar contadores de reinos conectados"
L["TT_SHOW_MERGEDREALMS_ENABLED"] = "Muestra la cantidad de items que poseen los personajes de los reinos conectados al reino actual."
L["TT_SHOW_MERGEDREALMS_DISABLED"] = "Sólo se muestra información sobre el reino actual."

L["TT_SHOW_ALLREALMS_TEXT"] = "Mostrar contadores para todos los reinos"
L["TT_SHOW_ALLREALMS_TITLE"] = "Mostrar contadores para todos los reinos"
L["TT_SHOW_ALLREALMS_ENABLED"] = "La información de todos los reinos también se muestra para los items vinculados a la cuenta."
L["TT_SHOW_ALLREALMS_DISABLED"] = [[Sólo se muestra información sobre el reino actual.

-- Nota: esta opción reemplaza a |cFFFF7F00Mostrar contadores de los reinos conectados|r para los items vinculados a la cuenta.]]

L["TT_SHOW_ALLACCOUNTS_TEXT"] = "Mostrar los contadores para todas las cuentas"
L["TT_SHOW_ALLACCOUNTS_TITLE"] = "Mostrar los contadores para todas las cuentas"
L["TT_SHOW_ALLACCOUNTS_ENABLED"] = "También se muestra la información de todas las cuentas importadas."
L["TT_SHOW_ALLACCOUNTS_DISABLED"] = "Sólo se muestra información sobre la cuenta actual."

L["TT_SHOW_HEARTHSTONE_TEXT"] = "Mostrar contadores para las piedras de hogar"
L["TT_SHOW_HEARTHSTONE_TITLE"] = "Mostrar contadores para las piedras de hogar"
L["TT_SHOW_HEARTHSTONE_ENABLED"] = "Muestra contadores al pasar el ratón por encima de una piedra de hogar, la brújula del almirante o el silbato del jefe de vuelo."
L["TT_SHOW_HEARTHSTONE_DISABLED"] = "Oculta los contadores cuando pasa el ratón por encima de uno de estos items."




-- ** Settings / Altoholic / Calendar **
L["Calendar Options"] = "Opciones de calendario"
L["Week starts on Monday"] = "La semana empieza el Lunes"
L["Display warnings in a dialog box"] = "Mostrar alertas en un recuadro de diálogo"
L["Disable warnings"] = "Desactivar alertas"
L["Profession Cooldowns"] = "Reutilización de profesión"
L["Dungeon Resets"] = "Reinicios de mazmorras"
L["Calendar Events"] = "Eventos del calendario"
L["Item Timers"] = "Temporizadores de items"

L["CALENDAR_WEEKSTART_MONDAY_TEXT"] = "La semana empieza el lunes"
L["CALENDAR_WEEKSTART_MONDAY_TITLE"] = "La semana empieza el lunes"
L["CALENDAR_WEEKSTART_MONDAY_ENABLED"] = "PARA HACER."
L["CALENDAR_WEEKSTART_MONDAY_DISABLED"] = "PARA HACER."

L["CALENDAR_WARNINGS_DIALOG_TEXT"] = "Mostrar advertencias en un cuadro de diálogo"
L["CALENDAR_WARNINGS_DIALOG_TITLE"] = "Mostrar advertencias en un cuadro de diálogo"
L["CALENDAR_WARNINGS_DIALOG_ENABLED"] = "Las advertencias se mostrarán en un cuadro de diálogo, en lugar del chat."
L["CALENDAR_WARNINGS_DIALOG_DISABLED"] = "Las advertencias solo se mostrarán en el chat."

L["CALENDAR_WARNINGS_ENABLED_TEXT"] = "Activar advertencias"
L["CALENDAR_WARNINGS_ENABLED_TITLE"] = "Activar advertencias"
L["CALENDAR_WARNINGS_ENABLED_ENABLED"] = "Altoholic mostrará un aviso cuando se produzca un determinado evento."
L["CALENDAR_WARNINGS_ENABLED_DISABLED"] = "Altoholic no mostrará ninguna advertencia."

-- ** Settings / Altoholic / Miscellaneous **
L["Miscellaneous Options"] = "Opciones varias"
L["Use color-coding for recipes at the AH"] = "Usar códigos de colores para las recetas en la subasta"
L["Use color-coding for recipes at vendors"] = "Usar códigos de colores para las recetas en los vendedores"


-- ** Settings / DataStore / Auctions **
L["DataStore_Auctions' Options"] = "Opciones"

L["LAST_VISIT_SLIDER_LABEL"] = "Aviso de última visita"
L["LAST_VISIT_SLIDER_TITLE"] = "Aviso de la última visita a la casa de subastas"
L["LAST_VISIT_SLIDER_TOOLTIP"] = "Avisa cuando la casa de subastas no ha sido visitada desde hace más días que este valor"

L["LAST_VISIT_CHECK_DISABLED"] = "No se comprobará la hora de la última visita a la casa de subastas."
L["LAST_VISIT_CHECK_ENABLED"] = "Se comprobará la hora de la última visita a la casa de subastas de cada personaje. Los complementos del cliente recibirán una notificación por cada personaje que no haya visitado la casa de subastas durante más tiempo que este valor."
L["LAST_VISIT_CHECK_LABEL"] = "Última visita a la casa de subastas"
L["LAST_VISIT_CHECK_TITLE"] = "Comprobar la hora de la última visita"

L["CLEAR_EXPIRED_ITEMS_LABEL"] = "Borrar automáticamente subastas y pujas terminadas"
L["CLEAR_EXPIRED_ITEMS_TITLE"] = "Borrar objetos de la Casa de Subastas"
L["CLEAR_EXPIRED_ITEMS_ENABLED"] = "Objetos con tiempo terminado son borrados automáticamente de la base de datos."
L["CLEAR_EXPIRED_ITEMS_DISABLED"] = "Objetos con tiempo terminado permanecen en la base de datos hasta que el jugador visite de nuevo la casa de subastas."

-- ** Settings / DataStore / Characters **
L["DataStore_Characters' Options"] = "DataStore_Characters' Opciones"
L["HIDE_PLAYTIME_DISABLED"] = "Se mostrará su tiempo de juego real."
L["HIDE_PLAYTIME_ENABLED"] = "Se mostrará un tiempo de juego de cero días."
L["HIDE_PLAYTIME_TEXT"] = "Oculta el tiempo de juego real."
L["HIDE_PLAYTIME_TITLE"] = "Ocultar el tiempo de juego real"

L["REQUEST_PLAYTIME_DISABLED"] = "El tiempo de juego no se consultará al iniciar la sesión. El último valor conocido se enviará a los complementos del cliente."
L["REQUEST_PLAYTIME_ENABLED"] = "El tiempo de juego se consultará cada vez que se conecte."
L["REQUEST_PLAYTIME_TEXT"] = "Solicita tiempo de juego al iniciar la sesión."
L["REQUEST_PLAYTIME_TITLE"] = "Solicitar tiempo de juego"


-- ** Settings / DataStore / Garrisons **
-- L["DataStore_Garrisons' Options"] = true
L["REPORT_LEVEL_LABEL"] = "Reportar en %s%s"
L["REPORT_LEVEL_TITLE"] = "Umbral de Reportar Nivel"
L["REPORT_LEVEL_TOOLTIP"] = "Reportar cuando el nivel de recursos no recogidos sea superior a este valor"

L["REPORT_UNCOLLECTED_LABEL"] = "Reportar recursos no recogidos"
L["REPORT_UNCOLLECTED_TITLE"] = "Reportar recursos no recogidos"
L["REPORT_UNCOLLECTED_ENABLED"] = "Al iniciar sesión, los alters con más de 400 recursos sin recoger serán informados en el chat."
L["REPORT_UNCOLLECTED_DISABLED"] = "No se informará nada."
L["UNCOLLECTED_RESOURCES_ALERT"] = "%s tiene %s recursos sin recoger"

-- ** Settings / DataStore / Inventory **
-- L["DataStore_Inventory's Options"] = true
L["CLEAR_INVENTORY_TEXT"] = "Borrar automáticamente el equipamiento de los miembros de la hermandad"
L["CLEAR_INVENTORY_TITLE"] = "Borrado del equipamiento de los miembros de la hermandad"
L["CLEAR_INVENTORY_ENABLED"] = "Para ahorrar memoria, los inventarios de los miembros de la hermandad se borran cada vez que inicies sesión."
L["CLEAR_INVENTORY_DISABLED"] = "El equipo de tus compañeros de hermandad permanece en la base de datos, y es visible incluso si están desconectados."

L["BROADCAST_AIL_TEXT"] = "Informar mi nivel de objeto a la hermandad al iniciar sesión"
L["BROADCAST_AIL_TITLE"] = "Informar nivel de objeto"
L["BROADCAST_AIL_ENABLED"] = "El nivel medio de los items de tus alters se enviará al chat de la hermandad al iniciar sesión."
L["BROADCAST_AIL_DISABLED"] = "No se enviará nada en absoluto."

L["EQUIP_REQ_TEXT"] = "Ser notificado cuando alguien inspeccione el equipo de uno de mis alters."
L["EQUIP_REQ_TITLE"] = "Notificación de solicitud de equipo"
L["EQUIP_REQ_ENABLED"] = "Un mensaje de chat te informará sobre qué miembro de la hermandad está inspeccionando qué alter."
L["EQUIP_REQ_DISABLED"] = "No se mostrará nada en absoluto."

-- ** Settings / DataStore / Mails **
-- L["DataStore_Mails' Options"] = true

L["SLIDER_EXPIRY_TITLE"] = "Umbral de expiración de correo"
L["SLIDER_EXPIRY_TOOLTIP"] = "Avisar cuando el correo sea borrado en menos días que los indicados"

L["EXPIRY_CHECK_LABEL"] = "Advertencia de borrado de Correo"
L["EXPIRY_CHECK_TITLE"] = "Revisar tiempos de borrado de Correo"
L["EXPIRY_CHECK_ENABLED"] = "Los tiempos de borrado de correo serán revisados 5 segundos después de iniciar sesión. Accesorios que use DataStore serán notificados si un correo a punto de borrarse es encontrado."
L["EXPIRY_CHECK_DISABLED"] = "No se realizará una revisón de tiempos de borrado."

L["REPORT_EXPIRED_MAILS_LABEL"] = "Aviso de caducidad del correo (chat frame)"
L["REPORT_EXPIRED_MAILS_TITLE"] = "Aviso de caducidad del correo (chat frame)"
L["REPORT_EXPIRED_MAILS_ENABLED"] = "Durante la comprobación de caducidad del correo, la lista de caracteres con correos electrónicos caducados también se mostrará en el chat."
L["REPORT_EXPIRED_MAILS_DISABLED"] = "No se mostrará nada en el chat."

L["SCAN_MAIL_BODY_LABEL"] = "Escanear el contenido de los correos (marcarlos como leídos)"
L["SCAN_MAIL_BODY_TITLE"] = "Escaneo Completo del Correo"
L["SCAN_MAIL_BODY_ENABLED"] = "Los correos serán completamente escaneados al abrir el buzón. Todos los correos serán marcados como leídos."
L["SCAN_MAIL_BODY_DISABLED"] = "Sólo correos leídos serán escaneados. Los correos seguirán teniendo el estado de no leídos."

L["EXPIRY_ALL_ACCOUNTS_LABEL"] = "Revisar todos los tiempos de borrado de correo en todas las cuentas conocidas"
L["EXPIRY_ALL_ACCOUNTS_TITLE"] = "Revisión de Todas las Cuentas"
L["EXPIRY_ALL_ACCOUNTS_ENABLED"] = "La revisión de los tiempos de borrado de correo mirará todas las cuentas conocidas."
L["EXPIRY_ALL_ACCOUNTS_DISABLED"] = "Sólo la cuenta actual será tomada en consideración; cuentas importadas serán ignoradas."

L["EXPIRY_ALL_REALMS_LABEL"] = "Revisar todos los tiempos de borrado de correo en todas los reinos conocidos"
L["EXPIRY_ALL_REALMS_TITLE"] = "Revisión de Todos los Reinos"
L["EXPIRY_ALL_REALMS_ENABLED"] = "La revisión de los tiempos de borrado de correo mirará todas los reinos conocidos."
L["EXPIRY_ALL_REALMS_DISABLED"] = "Sólo el reino actual será tomado en consideración; otros reinos serán ignorados."

L["EXPIRED_EMAILS_WARNING"] = "%s (%s) tiene correos caducados (o a punto de caducar)"


-- ** Settings / DataStore / Quests **
-- L["DataStore_Quests' Options"] = true

L["TRACK_TURNINS_LABEL"] = "Seguimiento de entregas de misiones"
L["TRACK_TURNINS_TITLE"] = "Seguimiento de entregas de misiones"
L["TRACK_TURNINS_ENABLED"] = "Las misiones entregadas se guardan en el historial, para asegurarse de que siga siendo válida constantemente."
L["TRACK_TURNINS_DISABLED"] = "El historial de misiones permanecerá en su estado actual, ya sea vacío o desactualizado."

L["AUTO_UPDATE_LABEL"] = "Actualización automática del historial"
L["AUTO_UPDATE_TITLE"] = "Actualización automática del historial de misiones"
L["AUTO_UPDATE_ENABLED"] = "El historial de misiones de un personaje se actualizará cada vez que inicies sesión con ese personaje."
L["AUTO_UPDATE_DISABLED"] = "El historial de misiones permanecerá en su estado actual, ya sea vacío o desactualizado."

L["DAILY_QUESTS_RESET_LABEL"] = "Restablecer misiones diarias en"


-- ** Sharing / Authorizations **
L["Authorizations"] = "Autorizaciones"
L["Ask"] = "Preguntar"
L["Auto"] = "Auto"

L["ACCOUNT_SHARING_ACTIVE_LABEL"] = "Compartir cuenta activado"
L["ACCOUNT_SHARING_ACTIVE_TITLE"] = "Compartir cuenta activado"
L["ACCOUNT_SHARING_ACTIVE_ENABLED"] = [[Otros usuarios podrán enviarle solicitudes para compartir la cuenta.

-- Su confirmación seguirá siendo necesaria cada vez que alguien solicite su información.]]
L["ACCOUNT_SHARING_ACTIVE_DISABLED"] = [[Todas las solicitudes serán rechazadas automáticamente.

-- |cFF1CFAFESugerencia de seguridad|r: Sólo active esto cuando realmente necesite transferir datos, desactívelo en caso contrario.]]

L["ACCOUNT_SHARING_AUTH_INFO"] = [[Esta lista permite automatizar las respuestas a las solicitudes de compartición de cuentas.
-- Puede elegir que se haga de forma automática |cFF00FF00aceptar|r o |cFFFF0000cancelar|r solicitudes, o |cFFFFFF00preguntar|r cuando llega una solicitud.
-- Si la compartición de cuentas está totalmente desactivada, esta lista será ignorada y todas las solicitudes serán rechazadas.]]

L["ACCOUNT_SHARING_AUTH_ASK"] = "Pregúntame cada vez que este jugador envíe una solicitud para compartir una cuenta"
L["ACCOUNT_SHARING_AUTH_AUTO"] = "Autorizar automáticamente las solicitudes de compartición de cuentas enviadas por este jugador"
L["ACCOUNT_SHARING_AUTH_NEVER"] = "Rechazar automáticamente las solicitudes de compartición de cuentas enviadas por este jugador"

-- ** Sharing / Content **
L["Shared Content"] = "Contenido compartido"


L["SHARED_CONTENT_INFO"] = [[Seleccione el contenido que será visible para los jugadores que le envíen solicitudes para compartir la cuenta.]]

-- ** Sharing / Share ! **
L["Share"] = "Compartir"
L["Account Name"] = "Nombre de la cuenta"
L["Send account sharing request to:"] = "Envíe la solicitud de compartir la cuenta a:"
L["Send Request"] = "Enviar solicitud"
L["Request Content"] = "Solicitar contenido"

L["ACCOUNT_NAME_INFO"] = [[Introduzca un nombre de cuenta que se utilizará para |cFF00FF00mostrar|r propósitos solamente.

-- Este nombre puede ser cualquier cosa, de hecho |cFFFF0000NO|r tiene porque ser el nombre real de la cuenta. Este campo |cFFFF0000no puede|r dejarse vacío.]]

L["EMPTY_ACCOUNT_WARNING"] = "[Nombre de la cuenta] Este campo |cFF00FF00no puede|r dejarse vacío."



-- ** Help **
L["HELP_SHARING_HOWTO"] = [[
-- |cFF00FF00Q:|cFFFFFFFF ¿Cómo puedo compartir datos entre dos cuentas?|r|r

-- Ambas cuentas deben estar conectadas al mismo tiempo para que esta característica funcione. Si eres el propietario de ambas cuentas, debes ejecutar dos instancias paralelas del cliente de WoW.

-- |cFF00FF00Q:|cFFFFFFFF ¿La transferencia de información es bidireccional?|r|r

-- No. La transferencia utiliza los canales de comunicación del juego, por lo que el rendimiento se ve limitado. Si quieres tener los mismos datos en ambos lados, tienes que repetir el proceso dos veces.

-- |cFF00FF00Q:|cFFFFFFFF ¿Hay alguna configuración antes de poder compartir los datos?|r|r

-- Sí. Por defecto y por motivos de seguridad, la compartición de cuentas está desactivada, por lo que el primer paso es activarla en ambos lados, esto se hace en |cFF1CFAFE2|r|cFFFFFFFF. Autorizaciones|r.

-- El siguiente paso es configurar las autorizaciones. La cuenta que recibe la información debe determinar quién puede enviarle solicitudes. Cualquier solicitante que no esté en la lista verá su solicitud rechazada.

-- El último paso es determinar qué información se comparte, esto se hace en |cFF1CFAFE3|r|cFFFFFFFF. Contenido compartido|r.

-- |cFF00FF00Q:|cFFFFFFFF La transferencia parece lenta, incluso se detiene a veces, ¿cuál es el problema?|r|r

-- Como se ha mencionado anteriormente, la transferencia utiliza los canales de comunicación del juego, por lo que esto significa que toda la información se envía de la cuenta A a la cuenta B a través del servidor de Blizzard. Esto tomará tiempo, séa paciente. Mientras no haya un error de Lua, todo está bien, los datos llegarán. 

-- |cFF00FF00Q:|cFFFFFFFF ¿Se puede mejorar el proceso?|r|r

-- No. Los datos se comprimen antes de ser enviados para minimizar el tráfico en la red, pero cuanta más información comparte, más tiempo tardará. Si tiene dudas sobre el proceso, pruébelo con un solo personaje para validar que las cosas funcionan y luego vuelva a intentarlo con más.
-- ]]

L["HELP_ALTOHOLIC_GENERAL"] = [[
-- |cFF00FF00Q:|cFFFFFFFF ¿Cómo funciona el complemento?|r|r

-- Cuando uno de tus alters entra en el mundo, la base de datos del complemento se rellena automáticamente con un máximo de información.
-- Sin embargo, parte de esta información no puede leerse a menos que se active el evento que la hace disponible. Esta es una restricción impuesta por el juego, no una limitación del complemento.

-- |cFF00FF00Q:|cFFFFFFFF ¿Qué tipo de información?|r|r

-- El buzón, la casa de subastas y tanto tu banco como el de la hermandad están sujetos a esta restricción.
-- Tu personaje tiene que estar físicamente presente en esos lugares para que el complemento pueda leer esta información.

-- La información de la profesión también se ve afectada, tendrás que abrir el panel de cada profesión para beneficiarte plenamente de las funcionalidades del complemento.

-- |cFF00FF00Q:|cFFFFFFFF ¿Admite Altoholic opciones de línea de comandos?|r|r

-- Sí, escribe |cFFFF7F00/alto|r o |cFFFF7F00/altoholic|r para obtener la lista de opciones de la línea de comandos.

-- |cFF00FF00Q:|cFFFFFFFF Mi icono del minimapa ha desaparecido, ¿cómo lo recupero?|r|r

-- Permanezca en la pestaña Opciones, haga clic en |cFFFF7F00Ajustes => Altoholic => General|r, y marque la opción "Mostrar el icono en el minimapa".

-- |cFF00FF00Q:|cFFFFFFFF ¿Puedo vincular Altoholic a una tecla específica?|r|r

-- Sí. Utiliza la función del juego |cFFFF7F00Atajos de teclado|r para seleccionar la tecla que más le guste. 

-- Personalmente, lo vinculo a la letra |cFF1CFAFEJ|r, porque la cresta hace que sea fácil de encontrar.
-- ]]

L["HELP_ALTOHOLIC_CHARACTERS"] = [[
-- |cFF00FF00Q:|cFFFFFFFF ¿Por qué sólo puedo ver un alter?|r|r

-- Si es la primera vez que usas el complemento, es normal. Los complementos sólo pueden obtener información sobre el personaje con el que estás jugando en ese momento. Esta es otra restricción del juego.

-- |cFF00FF00Q:|cFFFFFFFF ¿Quieres decir que tengo que iniciar sesión en todos mis 60 alters, uno por uno?|r|r

-- Sí, lo sé. No hay otra manera.

-- |cFF00FF00Q:|cFFFFFFFF He borrado un alter, o lo he movido a otro reino, ¿por qué el complemento no lo ve?|r|r

-- El complemento sólo está activo cuando el juego está en marcha y tu personaje está en el mundo del juego. Todo lo que ocurre fuera de eso está fuera del alcance de todos los complementos.
-- Si te sobra un alter, puedes simplemente borrarlo en el complemento.

-- |cFF00FF00Q:|cFFFFFFFF ¿Cómo puedo eliminar un alter de la base de datos del complemento?|r|r

-- Ve a la pestaña |cFFFF7F00Resumen|r, |cFF1CFAFEclick derecho|r sobre el nombre del alter y elija |cFFFF7F00Borrar este Alter|r.

-- |cFF00FF00Q:|cFFFFFFFF No puedo ver ningún alter, ¿qué está pasando?|r|r

-- Hay dos posibles razones:

-- - Puede tener una combinación de filtros en el |cFFFF7F00Resumen de la cuenta|r que impide que se muestre cualquier alter, así que compruebe la configuración de su filtro.

-- - Puede haber un error de Lua que no se muestra. 

-- Asegúrese de habilitar los errores de Lua con este comando: |cFFFFFFFF/console scriptErrors|r |cFF00FF001|r

-- Si desea desactivar los errores de Lua después: |cFFFFFFFF/console scriptErrors|r |cFF00FF000|r
-- ]]

L["HELP_DATASTORE_GENERAL"] = [[
-- |cFF00FF00Q:|cFFFFFFFF ¿Qué es DataStore?|r|r

-- DataStore es el componente principal de una serie de complementos que sirven como depósitos de datos en el juego. Su propósito respectivo es ofrecer servicios de exploración y almacenamiento a otros complementos.

-- |cFF00FF00Q:|cFFFFFFFF ¿Por qué hacer esto? ¡Ahora tengo 17 carpetas sólo para esto!|r|r

-- Las ventajas son múltiples, tanto para los jugadores como para los desarrolladores

-- - Los datos son |cFFFF7F00escaneados|r sólo una vez para todos los complementos del cliente (|cFF00FF00aumento de rendimiento|r).

-- - Los datos son |cFFFF7F00almacenados|r sólo una vez para todos los complementos del cliente (|cFF00FF00aumento de memoria|r).

-- - Los autores de complementos pueden dedicar más tiempo a codificar funciones de mayor nivel.

-- - Cada módulo es un complemento independiente y por lo tanto, tiene su propio archivo de Variables guardadas, lo que significa que podría limpiar los datos de un módulo sin perturbar otros módulos.

-- |cFF00FF00Q:|cFFFFFFFF ¿Qué hacen todos estos módulos? ¿Tengo que activarlos todos?|r|r

-- |cFFFF7F00DataStore|r es el módulo principal, los complementos de los clientes deben depender de él, por lo que debe permanecer activado todo el tiempo, ya que es la interfaz utilizada para acceder a los datos de los distintos módulos.
-- Los demás módulos son técnicamente opcionales y pueden activarse o desactivarse según sus necesidades. Sin embargo, algunos de estos módulos, como |cFFFF7F00DataStore_Characters|r, juegan un papel importante en Altoholic y deben permanecer habilitados. 

-- |cFF00FF00Q:|cFFFFFFFF ¿Cómo debo actualizar DataStore y sus módulos?|r|r

-- |cFF1CFAFEAltoholic|r siempre está empaquetado con las últimas versiones, la mayoría de los usuarios deberían actualizar utilizando este método. Consulte la página de inicio del complemento en el panel |cFFFF7F00Acerca de|r.
-- ]]

L["HELP_DATASTORE_SAVEDVARS"] = [[
-- |cFF00FF00Q:|cFFFFFFFF ¿Cómo se borran los datos de DataStore?|r|r

-- Los personajes y hermandades pueden ser borrados de la interfaz de usuario de Altoholic.
-- Si quieres tener más control sobre la información que debe ser eliminada, usted puede |cFF1CFAFEeditar|r o |cFF1CFAFEeliminar|r los archivos de la carpeta |cFFFF7F00Saved Variables|r.

-- |cFF00FF00Q:|cFFFFFFFF ¿Dónde se encuentran las variables guardadas?|r|r

-- Las bases de datos se encuentran en |cFFFF7F00WTF \\ Account \\ |cFF1CFAFEyour_account|r \\ SavedVariables|r.

-- |cFF00FF00Q:|cFFFFFFFF ¿Cuáles son los archivos relevantes?|r|r

-- Los archivos son |cFFFF7F00DataStore.lua|r y todos los |cFFFF7F00DataStore_*.lua|r.

-- |cFF00FF00Q:|cFFFFFFFF ¿Cuándo puedo |cFF1CFAFEmodificar|r o |cFF1CFAFEborrar|r esos archivos?|r|r

-- Es |cFFFF0000crítico|r y usted |cFFFF0000NO DEBERIA|r modificar esos archivos mientras el juego se está ejecutando.
-- Algunos lo han intentado y han tenido problemas.

-- No intentes ser más astuto que el juego. 
-- Deténgalo, haga sus cambios y vuelva a iniciarlo.

-- |cFF00FF00Q:|cFFFFFFFF ¿Cómo puedo editar esos archivos?|r|r

-- Utilice un editor de texto adecuado, como |cFF1CFAFENotepad++|r. 

-- Los clásicos Bloc de notas y Wordpad no son recomendables.
-- ]]

L["HELP_GETTING_SUPPORT"] = [[
-- |cFF00FF00Q:|cFFFFFFFF He encontrado un error, ¿cómo/dónde lo reporto?|r|r

-- Utilice la sección de tickets de CurseForge, también leo los comentarios y respondo tan a menudo como puedo materialmente, así que no dudes en informar en uno de estos lugares.

-- |cFF00FF00Q:|cFFFFFFFF ¿Qué debo hacer antes de reportar?|r|r

-- Un par de cosas:

-- |cFF1CFAFE1)|r Asegúrese de que tiene la última versión del complemento.

-- |cFF1CFAFE2)|r Si sospecha que hay un conflicto con otro complemento, intente reproducir el problema sólo con Altoholic activado. Como el complemento se ocupa de muchas cosas, siempre es posible que haya un conflicto.

-- |cFF1CFAFE3)|r Asegúrese de que su problema no ha sido ya comunicado por otra persona.

-- |cFF1CFAFE4)|r ¡Nunca, jamás, informes que "no funciona", esta es la frase más inútil del mundo! 
-- Sea |cFFFF7F00específico|r sobre lo que no funciona.

-- |cFF1CFAFE5)|r |cFFFF0000NO DEBE|r copiar toda la pila de llamadas en caso de error de Lua. Las primeras 5-6 líneas son suficientes.

-- |cFF00FF00Q:|cFFFFFFFF Estoy recibiendo múltiples errores, ¿debo informar de todos ellos?|r|r

-- No, simplemente hay que reportar el primero de la lista, los demás suelen ser consecuencia del primero.

-- |cFF00FF00Q:|cFFFFFFFF ¿Dónde puedo obtener asistencia en directo?|r|r

-- Únase al servidor de |cFF1CFAFEDiscord|r. Estoy presente por la tarde (hora belga), e incluso cuando no lo estoy, tenemos una buena comunidad dispuesta a ayudar en caso de problemas.
-- ]]

L["ABOUT_ALTOHOLIC"] = [[
-- |cFF00FF00Q:|cFFFFFFFF Cúando se creó Altoholic?|r|r

-- El desarrollo comenzó en |cFF1CFAFEDiciembre del 2007|r, y la primera versión fue |cFFFF7F002.4.001|r, publicada el |cFF1CFAFE29 de marzo del 2008|r.

-- |cFF00FF00Q:|cFFFFFFFF ¿Cuántas personas trabajan en Altoholic?|r|r

-- Una. Tengo un trabajo a tiempo completo y mi disponibilidad fluctúa. Sin embargo, de vez en cuando recibo ayuda de la comunidad, y quiero dar las gracias a todos los que me han echado una mano a lo largo de los años.
-- El complemento no sería lo que es hoy sin su ayuda y sugerencias.

-- |cFF00FF00Q:|cFFFFFFFF ¿Cuántos idiomas admite el complemento?|r|r

-- Once: deDE, enUS, esES, esMX, frFR, itIT, koKR, ptBR, ruRU, zhCN, zhCW.

-- |cFF00FF00Q:|cFFFFFFFF ¿Puedo ayudar con las traducciones?|r|r

-- Sí, su ayuda será bienvenida, únase a nosotros en |cFF1CFAFEDiscord|r y proporcioneme los archivos de traducción.

-- |cFF1CFAFENota:|r las traducciones se reparten ahora entre los múltiples complementos de Altoholic* (una por pestaña).

-- |cFF00FF00Q:|cFFFFFFFF ¿Dónde puedo obtener las actualizaciones?|r|r

Los dos únicos sitios oficiales son |cFFFF7F00Curse Forge|r and |cFFFF7F00WoW Interface|r.

Cualquier otra fuente significa que estás usando una versión no oficial y no estás apoyando el considerable esfuerzo que se hizo para desarrollar esto.

Absolutamente |cFFFF0000No se brindará soporte|r para ninguna versión no oficial.
-- ]]

L["ABOUT_DATASTORE"] = [[
-- |cFF00FF00Q:|cFFFFFFFF ¿Por qué se creó DataStore?|r|r

-- DataStore se lanzó en |cFF1CFAFEAgosto del 2009|r, como parte de la versión |cFFFF7F003.2|r.

-- Después de unos 18 meses aprendiendo sobre el desarrollo de WoW, añadiendo características en Altoholic y gestionando una base de datos monolítica, sentí que era el momento de un enfoque más profesional y creé una capa adecuada para gestionar todos los datos.

-- |cFF00FF00Q:|cFFFFFFFF ¿Por qué separar los datos y la interfaz de usuario?|r|r

-- Porque es lo que hay que hacer y porque tenía entonces y sigo teniendo a día de hoy, múltiples complementos en mente que harán uso de toda esta información.

-- Además, ofrece una interfaz limpia para gestionar personajes, hermandades, reinos y cuentas.

-- |cFF00FF00Q:|cFFFFFFFF ¿Habrá más módulos en el futuro?|r|r

-- Estoy satisfecho con los módulos actuales, pero no descarto añadir más si surge una necesidad real.

-- |cFF00FF00Q:|cFFFFFFFF Soy desarrollador y quiero saber más sobre DataStore.|r|r

-- El código está bien comentado, estructurado y se explica por sí mismo. 

-- Si todavía tiene preguntas, únase al servidor de |cFF1CFAFEDiscord|r ¡y pregúnteme!
-- ]]

L["HELP_ALTOHOLIC_BANKCHARACTERS"] = [[
-- |cFF00FF00Q:|cFFFFFFFF ¿Qué son los personajes banco?|r|r

-- Si juegas con muchos personajes, lo más probable es que utilices algunos de ellos como banco. 
-- Altoholic tiene ahora una forma de seguirlo en la pestaña |cFFFF7F00Resumen|r.

-- |cFF00FF00Q:|cFFFFFFFF ¿Cómo puedo marcar un personaje como personaje banco?|r|r

-- En cualquier panel de la pestaña |cFFFF7F00Resumen|r, |cFF1CFAFEclick derecho|r sobre el nombre del alter, elija |cFFFF7F00Marcar como banco|r y seleccione el tipo de banco que debe ser ese alter.

-- |cFF00FF00Q:|cFFFFFFFF ¿Puedo marcar un personaje banco con varios tipos?|r|r

-- Sí.

-- |cFF00FF00Q:|cFFFFFFFF ¿Dónde puedo tener una visión general de mis personajes banco?|r|r

-- En la pestaña |cFFFF7F00Resumen|r, seleccione el panel |cFFFF7F00Miscelánea|r.

-- |cFF00FF00Q:|cFFFFFFFF ¿Cómo me ayuda el marcado de un personaje a gestionar mis alters?|r|r

-- Si lo desea, una de las opciones de información sobre herramientas le permitirá ver si puede enviar un artículo a un personaje banco.
-- ]]

L["HELP_ALTOHOLIC_ALTGROUPS"] = [[
-- |cFF00FF00Q:|cFFFFFFFF ¿Qué son los grupos de alters?|r|r

-- Los grupos de alters son una forma sencilla de gestionar sus alters agrupándolos en base a criterios que no están relacionados con el juego. Por ejemplo, he puesto mis 12 alters principales en un grupo y mis 12 alters banco en el mismo reino, en otro grupo.

-- |cFF00FF00Q:|cFFFFFFFF ¿Existe un límite para la cantidad de alters en un grupo?|r|r

-- No, no lo hay. También puede añadir alters de otro reino, otra facción o incluso otra cuenta en el mismo grupo.

-- |cFF00FF00Q:|cFFFFFFFF ¿Existe un límite en la cantidad de grupos que puedo crear?|r|r

-- No, puede crear tantos grupos como quiera, aunque crear demasiados probablemente anule el propósito de los grupos. Usted está al mando, puede organizar los grupos como quiera.

-- |cFF00FF00Q:|cFFFFFFFF ¿Cómo puedo añadir un personaje a un grupo?|r|r

-- En cualquier panel de la pestaña |cFFFF7F00Resumen|r, |cFF1CFAFEclick derecho|r sobre el nombre del alter, elija |cFFFF7F00Añadir al grupo|r y seleccione el grupo al que deba añadirse ese alter.

-- |cFF00FF00Q:|cFFFFFFFF ¿Cómo puedo eliminar un personaje de un grupo?|r|r

-- En cualquier panel de la pestaña |cFFFF7F00Resumen|r, |cFF1CFAFEclick derecho|r sobre el nombre del alter, elija |cFFFF7F00Eliminar del grupo|r y seleccione el grupo del que deba eliminarse ese alter.

-- |cFF00FF00Q:|cFFFFFFFF ¿Puede un personaje formar parte de varios grupos?|r|r

-- Sí.
-- ]]


L["HELP_ALTOHOLIC_SEARCH"] = [[
-- |cFF00FF00Q:|cFFFFFFFF ¿Cómo funciona el proceso de búsqueda?|r|r

-- El proceso buscará todos los filtros activos y tratará de encontrar los items y/o recetas de profesiones conocidas que coincidan con esos filtros. La búsqueda sólo se producirá en los lugares establecidos en el ícono |cFFFF7F00Ubicación de la búsqueda|r.

-- |cFF00FF00Q:|cFFFFFFFF ¿Los filtros se configuran sólo con los iconos superiores?|r|r

-- No, las categorías de la izquierda también actúan como filtros. Al hacer clic en una categoría determinada, se desencadena inmediatamente una búsqueda de items que coincidan con esa categoría, y a continuación puede filtrar aún más añadiendo un valor en el cuadro de edición, o filtrar por rareza, por ejemplo. Si sólo introduce un texto e inicia la búsqueda, obtendrá todos los resultados cuyo nombre contenga el valor que ha introducido.

-- |cFF00FF00Q:|cFFFFFFFF Estoy confundido por los resultados que veo, ¿qué está pasando?|r|r

-- Tenga en cuenta que los resultados se ven afectados por los filtros que haya establecido. Asegúrese de comprobar el mensaje de estado para ver qué filtros se han tenido en cuenta durante el proceso de búsqueda. 
-- En caso de duda, pulse el botón |cFF1CFAFEReset|r para borrar todos los filtros y volver a intentarlo.

-- |cFF00FF00Q:|cFFFFFFFF Algunos resultados no aparecen, ¿por qué?|r|r

-- Los resultados pueden verse afectados por los ítems conocidos por el cliente del juego, puede ocurrir que tenga que ejecutar la búsqueda una segunda vez para ver los resultados adecuados. La información de los ítems requerida por el proceso de búsqueda no siempre está disponible y para cuando vuelve del servidor, la búsqueda ya ha terminado.

-- |cFF00FF00Q:|cFFFFFFFF Ordenar por rareza o nivel de item no parece funcionar, ¿por qué?|r|r

-- La clasificación por rareza funciona, pero en el caso de los objetos mejorables, pueden tener un nivel de rareza |cFF0070DDazul|r y ser realmente |cFFA335EEépicos|r porque tienes la versión actualizada.
-- ]]
