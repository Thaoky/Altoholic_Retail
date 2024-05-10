local L = DataStore:SetLocale("Altoholic", "esES")
if not L then return end

L["Calendar"] = "Calendario"
L["Tooltip"] = "Ventana emergente"
L["Getting support"] = "Obtener apoyo"
L["Memory used"] = "Memoria utilizada"
L["Reset all data"] = "Restablecer todos los datos"
L["WIPE_DATABASE"] = "¿Borrar la base de datos?"
L["WIPE_WARNING"] = "Advertencia: ¡toda la información se perderá!"
L["DATABASE_WIPED"] = "¡La información guardada en DataStore se ha eliminado por completo!"

L["Account"] = "Cuenta"
L["Default"] = "Predeterminado"
L["Characters"] = "Personajes"
L["Realms"] = "Reinos"
L["%s%d%s characters found : did you set your filters properly ?"] = "%s%d%s personajes encontrados: ¿has configurado bien tus filtros?"

-- ** Menu **
L["Character Information"] = "Información del personaje"
L["Account Summary"] = "Resumen de la Cuenta"
L["Experience"] = "Experiencia"
L["Levels"] = "Niveles"
L["Location"] = "Ubicación"
L["Bag Usage"] = "Bolsas"
L["Activity"] = "Actividad"
L["Currencies"] = "Monedas"
L["PATCH_X.0"] = "Expansión base"
L["PATCH_9.1"] = "Cadenas de dominación"
L["PATCH_9.2"] = "Fin de la eternidad"
L["PATCH_10.1"] = "Embers of Neltharion"
L["PATCH_10.2"] = "Guardians of the Dream"

-- ** Filter Icons **
L["FILTER_REALMS"] = "Filtro de reinos"
L["FILTER_FACTIONS"] = "Filtro de facción"
L["FILTER_LEVELS"] = "Filtro de nivel"
L["FILTER_PROFESSIONS"] = "Filtro de profesión"
L["FILTER_CLASSES"] = "Filtro de clase"
L["FILTER_MISC"] = "Filtros varios"
L["FILTER_BANKTYPE"] = "Filtros de personajes banqueros"
L["This realm"] = "Este reino"
L["All realms"] = "Todos los reinos"
L["This account"] = "Esta cuenta"
L["All accounts"] = "Todas las cuentas"
L["This faction"] = "Esta facción"
L["Both factions"] = "Ambas facciones"
L["Any"] = "Todos"
L["ACCOUNT_SHARING_BUTTON_TITLE"] = "Solicitud de compartición de cuenta"
L["ACCOUNT_SHARING_BUTTON_INFO"] = "Haz click en este botón para preguntarle a un jugador\nsi quiere compartir toda su base de datos de Altoholic\npara añadirla a la tuya"

L["FILTER_ALT_GROUPS"] = "Grupos de alters"
L["FILTER_GROUP_CREATE"] = "Crear nuevo grupo"
L["FILTER_GROUP_DELETE"] = "Borrar grupo de alters"
L["FILTER_GROUP_RENAME"] = "Renombrar grupo de alters"
L["ENTER_GROUP_NAME"] = "Introduce un nuevo nombre de grupo"
L["CHANGE_GROUP_NAME"] = "Escoge un nuevo nombre para %s%s|r"
L["ENTER_GROUP_NAME_WARNING"] = "Se recomienda evitar los caracteres especiales"
L["DELETE_GROUP_NAME"] = "¿Borrar este grupo de alters"
L["ALT_GROUP_CREATED"] = "El grupo %s fue creado con éxito."
L["ALT_GROUP_ALREADY_EXISTS"] = "El grupo %s ya existe."
L["ALT_GROUP_RENAMED"] = "%s se ha renombrado con éxito a %s"
L["ALT_GROUP_NOT_RENAMED"] = "%s no pudo ser renombrado a %s"
L["ALT_GROUP_DELETED"] = "El grupo %s fue borrado con éxito."
L["ALT_GROUP_NOT_FOUND"] = "El grupo %s no se encontró."

L["COLORED_SKILL_LEVELS"] = "Usar color para los niveles de habilidad"
L["FILTER_MISC_HAVE_MAILS"] = "Con correo"
L["FILTER_MISC_HAVE_MAILS_EXPIRE_SOON"] = "Con correo a punto de expirar"
L["FILTER_MISC_HAVE_AUCTIONS_EXPIRE_SOON"] = "Casa de subastas no revisada recientemente"
L["FILTER_MISC_GUILD_EXALTED"] = "Exaltado con la hermandad"
L["FILTER_MISC_GUILD_NOT_EXALTED"] = "No exaltado con la hermandad"
L["FILTER_MISC_UPGRADE_RIDING_SKILL"] = "Podría mejorar su habilidad de equitación"


-- *** Character Information / Account Summary ***
-- Column Name
L["Totals"] = "Totales"
L["Right-Click for options"] = "Click derecho para opciones"
L["Character %s successfully deleted"] = "Personaje %s eliminado correctamente"
L["Realm %s successfully deleted"] = "Reino %s borrado correctamente"
L["Cannot delete current character"] = "No se puede borrar el personaje actual"
L["Cannot delete current realm"] = "No se puede borrar el reino actual"
L["Delete this Alt"] = "Borrar este alter"
L["Delete this Realm"] = "Borrar este reino"
L["Update from %s%s"] = "Actualizar desde %s%s"

L["View"] = "Ver"
L["Mark as bank"] = "Marcar como banco"
L["Add to group"] = "Añadir al grupo"
L["Remove from group"] = "Retirar del grupo"



-- Column Level
L["COLUMN_LEVEL_TITLE"] = "Nivel del personaje"
L["COLUMN_LEVEL_TITLE_SHORT"] = "Nivel"
L["COLUMN_LEVEL_SUBTITLE"] = "Haz click para ordenar"

-- Column Rest XP
L["COLUMN_RESTXP_TITLE"] = "Experiencia de descanso"
L["COLUMN_RESTXP_TITLE_SHORT"] = "Rest XP"
L["COLUMN_RESTXP_SUBTITLE"] = "Haz click para ordenar"
L["COLUMN_RESTXP_DETAIL_1"] = "Se necesitan 8 horas para ganar 1 burbuja de XP (5%)."
L["COLUMN_RESTXP_DETAIL_2"] = "El máximo de XP de descanso es de 30 burbujas de XP, o de 1,5 niveles."
L["COLUMN_RESTXP_DETAIL_3"] = "Se consigue en 10 días."
L["COLUMN_RESTXP_DETAIL_4"] = "%d%% modo completamente descansado se muestra como: '%d%%'"
L["Fully rested"] = "Completamente descansado"
L["Fully rested in"] = "Completamente descansado en"
L["CHARACTER_NOT_IN_RESTING_AREA"] = "¡Este personaje no está en un área de descanso!"

-- Column Money
L["COLUMN_MONEY_TITLE"] = "Oro"
L["COLUMN_MONEY_TITLE_SHORT"] = "Oro"
L["COLUMN_MONEY_SUBTITLE_1"] = "Tus brillos"
L["COLUMN_MONEY_SUBTITLE_2"] = "Más dinero, más problemas"
L["COLUMN_MONEY_SUBTITLE_3"] = "La codicia es buena"
L["COLUMN_MONEY_SUBTITLE_4"] = "No se puede comprar la felicidad... ¡pero se pueden comprar montones de monturas!"
L["COLUMN_MONEY_SUBTITLE_5"] = "No crece en los árboles del mundo."

-- Column Played
L["COLUMN_PLAYED_TITLE"] = "Tiempo total jugado"
L["COLUMN_PLAYED_TITLE_SHORT"] = "Tiempo jugado"
L["COLUMN_PLAYED_SUBTITLE"] = "Haz click para mostrar/ocultar el tiempo de juego real"

-- Column iLevel
L["COLUMN_ILEVEL_TITLE"] = "Nivel de objeto"
L["COLUMN_ILEVEL_TITLE_SHORT"] = "iLvl"
L["COLUMN_ILEVEL_SUBTITLE"] = "Haz click para ordenar"

-- Column Last Online
L["COLUMN_LASTONLINE_TITLE"] = "Última conexión"
L["COLUMN_LASTONLINE_TITLE_SHORT"] = "Sesión"
L["COLUMN_LASTONLINE_SUBTITLE"] = "Última vez que el personaje se conectó"

--*** Character Information / Experiencie ***
L["COLUMN_MAXRESTXP_TITLE"] = "Máximo descanso de XP"
L["COLUMN_MAXRESTXP_TITLE_SHORT"] = "Máxima XP"
L["COLUMN_MAXRESTXP_SUBTITLE"] = "Máxima experiencia de descanso que se puede acumular"
L["COLUMN_SAVEDRESTXP_TITLE"] = "XP de descanso acumulada"
L["COLUMN_SAVEDRESTXP_TITLE_SHORT"] = "XP acumulada"
L["COLUMN_SAVEDRESTXP_SUBTITLE"] = "Cantidad de experiencia de descanso no utilizada al cerrar sesión"
L["COLUMN_EARNEDRESTXP_TITLE"] = "XP obtenida durante el descanso"
L["COLUMN_EARNEDRESTXP_TITLE_SHORT"] = "XP ganada"
L["COLUMN_EARNEDRESTXP_SUBTITLE"] = "Cantidad de experiencia de descanso que se ganó mientras se descansaba"

-- *** Character Information / Guild ***
L["COLUMN_GUILD_TITLE"] = "Nombre de la hermandad"
L["COLUMN_GUILDRANK_TITLE"] = "Rango de hermandad"
L["COLUMN_GUILDRANK_TITLE_SHORT"] = "Rango"
L["COLUMN_GUILDRANK_SUBTITLE"] = "Rango del personaje en la hermandad"
L["COLUMN_GUILDREP_TITLE"] = "Reputación de hermandad"
L["COLUMN_GUILDREP_SUBTITLE"] = "Reputación del personaje con la hermandad"

--*** Character Information / Location ***
L["COLUMN_HEARTHSTONE_TITLE"] = "Piedra de hogar"
L["COLUMN_HEARTHSTONE_SUBTITLE"] = "Ese lugar especial al que llamas hogar"
L["COLUMN_SUBZONE_TITLE"] = "Subzona"

-- *** Character Information / Miscellaneous ***
L["COLUMN_CLASS_SUBTITLE"] = "Clase del personaje y especialización activa"
L["COLUMN_BANK_TYPE_MARKS"] = "Marcas tipo banco"
L["COLUMN_BANK_TYPE_MARKS_SUBTITLE"] = "Lista de marcas establecidas para los personajes banqueros"

-- *** Bag Usage ***
L["COLUMN_BAGS_TITLE"] = "Bolsas del personaje"
L["COLUMN_BAGS_TITLE_SHORT"] = "Bolsas"
L["COLUMN_BAGS_SUBTITLE_1"] = "Las ranuras de tu inventario principal"
L["COLUMN_BAGS_SUBTITLE_2"] = "Más grande siempre es mejor"
L["COLUMN_FREEBAGSLOTS_TITLE"] = "Ranuras para bolsas libres"
L["COLUMN_FREEBAGSLOTS_TITLE_SHORT"] = "Libre"
L["COLUMN_FREEBAGSLOTS_SUBTITLE"] = "Ranuras libres vs totales"
L["COLUMN_BANK_TITLE"] = "Banco del personaje"
L["COLUMN_BANK_TITLE_SHORT"] = "Banco"
L["COLUMN_BANK_SUBTITLE_1"] = "Tus ranuras de inventario del banco"
L["COLUMN_BANK_SUBTITLE_2"] = "Donde los materiales viejos van a descansar"
L["COLUMN_FREEBANKLOTS_TITLE"] = "Ranuras del banco libres"
L["COLUMN_FREEBANKLOTS_TITLE_SHORT"] = "Libre"
L["COLUMN_FREEBANKLOTS_SUBTITLE"] = "Ranuras libres vs totales"
L["NUM_SLOTS_AND_FREE"] = "%s%d%s ranuras, %s%d%s libre"

L["Bags"] = "Bolsas"
L["Bank"] = "Banco"
L["Bank bag"] = "Bolsa en banco"
L["Bank not visited yet"] = "Banco no visitado aún"
L["slots"] = "ranuras"

-- *** Skills ***
L["COLUMN_PROFESSION_1_TITLE"] = "Primera profesión."
L["COLUMN_PROFESSION_1_TITLE_SHORT"] = "Prof. 1"
L["COLUMN_PROFESSION_2_TITLE"] = "Segunda profesión."
L["COLUMN_PROFESSION_2_TITLE_SHORT"] = "Prof. 2"
L["COLUMN_RIDING_UPGRADEABLE_MALE"] = "Este personaje podría mejorar su habilidad de equitación"
L["COLUMN_RIDING_UPGRADEABLE_FEMALE"] = "Este personaje podría mejorar su habilidad de equitación"
L["COLOR_GREEN"] = "Verde"
L["COLOR_GREY"] = "Gris"
L["COLOR_ORANGE"] = "Naranja"
L["COLOR_RED"] = "Rojo"
L["COLOR_YELLOW"] = "Amarillo"

L["up to"] = "hasta"
L["at"] = "a"
L["and above"] = "y por encima"
L["No data"] = "Sin datos"
L["Suggestion"] = "Sugerencia"
L["All cooldowns are up"] = "No hay habilidades recargándose"
L["Riding"] = "Equitación"

-- *** Activity ***
L["COLUMN_MAILS_TITLE"] = "Contenido del buzón"
L["COLUMN_MAILS_TITLE_SHORT"] = "Correos"
L["COLUMN_MAILS_SUBTITLE"] = "Número de items en el buzón"
L["COLUMN_MAILS_DETAIL_1"] = "Más allá de un determinado límite, los correos se ponen en cola en el servidor."
L["COLUMN_MAILS_DETAIL_2"] = "Estos correos no están contabilizados aquí."
L["COLUMN_MAILBOX_VISITED_TITLE"] = "Última comprobación del buzón"
L["COLUMN_MAILBOX_VISITED_TITLE_SHORT"] = "Visita"
L["COLUMN_MAILBOX_VISITED_SUBTITLE"] = "Última vez que se comprobó el contenido del buzón"
L["COLUMN_AUCTIONS_TITLE"] = "Subastas en la casa de subastas"
L["COLUMN_AUCTIONS_TITLE_SHORT"] = "Subastas"
L["COLUMN_AUCTIONS_SUBTITLE"] = "Número de subastas activas en la casa de subastas"
L["COLUMN_BIDS_TITLE"] = "Pujas en la casa de subastas"
L["COLUMN_BIDS_TITLE_SHORT"] = "Pujas"
L["COLUMN_BIDS_SUBTITLE"] = "Número de pujas realizadas en la casa de subastas"
L["COLUMN_AUCTIONHOUSE_VISITED_TITLE"] = "Última visita a la casa de subastas"
L["COLUMN_AUCTIONHOUSE_VISITED_TITLE_SHORT"] = "Visita"
L["COLUMN_AUCTIONHOUSE_VISITED_SUBTITLE"] = "Última vez que se visitó la casa de subastas"
L["COLUMN_GARRISON_MISSIONS_TITLE"] = "Misiones de la ciudadela"
L["COLUMN_GARRISON_MISSIONS_TITLE_SHORT"] = "Misiones"
L["COLUMN_GARRISON_MISSIONS_SUBTITLE"] = "Última vez que se comprobó el estado de la misión"
L["COLUMN_GARRISON_MISSIONS_DETAIL_1"] = "Al menos una misión está completa"
L["COLUMN_GARRISON_MISSIONS_DETAIL_2"] = "Todas las misiones están completas"
L["COLUMN_GARRISON_MISSIONS_DETAIL_3"] = "No hay misiones en curso"

L["Visited"] = "Visitado"


--*** Currencies ***
L["Last collected"] = "Última recogida"
L["Garrison resources"] = "Recursos de la ciudadela"
L["Uncollected resources"] = "Recursos sin recoger"
L["Max. uncollected resources in"] = "Máximo de recursos no recogidos en"


-- *** Expansion Features / Garrison Followers ***
L["COLUMN_FOLLOWERS_LV40_TITLE"] = "Seguidores de nivel 40"
L["COLUMN_FOLLOWERS_LV40_TITLE_SHORT"] = "Lv 40"
L["COLUMN_FOLLOWERS_LV40_SUBTITLE"] = "Nivel 40 vs Total de seguidores"
L["COLUMN_FOLLOWERS_RARITY_TITLE"] = "Nivel de rareza de los seguidores"
L["COLUMN_FOLLOWERS_RARITY_TITLE_SHORT"] = "Rareza"
L["COLUMN_FOLLOWERS_RARITY_SUBTITLE"] = "Rareza vs. Rareza Épica"
L["COLUMN_FOLLOWERS_ILEVEL_TITLE"] = "Seguidores con %s iLevel"
L["COLUMN_FOLLOWERS_ILEVEL_SUBTITLE"] = "iLevel %s"
L["COLUMN_FOLLOWERS_AIL_TITLE"] = "AiL de los seguidores"
L["COLUMN_FOLLOWERS_AIL_TITLE_SHORT"] = "iLvl"
L["COLUMN_FOLLOWERS_AIL_SUBTITLE"] = "Nivel promedio de items de todos los seguidores activos"

-- *** Expansion Features / Artifacts ***

-- *** Expansion Features / Covenant ***
L["COLUMN_COVENANT_SUBTITLE"] = "Click para ver nexo de almas"
L["COLUMN_COVENANT_TITLE"] = "Curia elegida"
L["COLUMN_COVENANT_TITLE_SHORT"] = "Curia"
L["COLUMN_SOULBIND_SUBTITLE"] = "Click para ver nexo de almas"
L["COLUMN_SOULBIND_TITLE"] = "Nexo de almas activo"
L["COLUMN_SOULBIND_TITLE_SHORT"] = "Nexo de almas"
L["COLUMN_RENOWN_SUBTITLE"] = "Click para ver tu nivel de renombre y recompensas"
L["COLUMN_RENOWN_TITLE"] = "Nivel de Renombre"
L["COLUMN_CAMPAIGNPROGRESS_TITLE_SHORT"] = "Historia"
L["COLUMN_CAMPAIGNPROGRESS_TITLE"] = "Progreso de la campaña"
L["COLUMN_CAMPAIGNPROGRESS_SUBTITLE"] = "Número de capítulos completados en la campaña de la curia"

-- *** Expansion Features / Reservoir ***
L["COLUMN_TRANSPORT_NETWORK_TITLE"] = "Red de transporte"
L["COLUMN_ANIMA_TITLE"] = "Conductor de ánima"
L["COLUMN_COMMAND_TABLE_TITLE"] = "Mesa de seguidores"
L["COLUMN_SANCTUM_UNIQUE_TITLE"] = "Actividad única"

L["Overall"] = "Overall"
L["Torghast"] = "Torghast"
L["Single target build"] = "Build de un solo objetivo"
L["AOE build"] = "Build AOE"
L["Recommended Covenant"] = "Curia recomendada"
L["Equally viable"] = "igualmente viable"


-- *** Mythic Keystone ***
-- L["Mythic+ Keystone"] = true
L["COLUMN_KEYNAME_TITLE"] = "Mítica actual+ Piedra angular"
L["COLUMN_KEYNAME_TITLE_SHORT"] = "Piedra angular"
L["COLUMN_KEYNAME_SUBTITLE"] = "Tu próxima aventura"
L["COLUMN_KEYLEVEL_TITLE"] = "Mítica actual+ nivel de la piedra angular"
L["COLUMN_KEYLEVEL_SUBTITLE"] = "¡Definitivamente no estás preparado!"
L["COLUMN_WEEKLYBEST_KEYNAME_TITLE"] = "Mejor Mítica Semanal+ Piedra angular"
L["COLUMN_WEEKLYBEST_KEYNAME_SUBTITLE"] = "Pasa el ratón por encima para ver lo mejor de la semana para todos los mapas"
L["COLUMN_WEEKLYBEST_KEYLEVEL_TITLE"] = "Mejor Mítica Semanal+ Nivel"
L["COLUMN_WEEKLYBEST_KEYLEVEL_SUBTITLE"] = "Qué tan profundo en la madriguera del conejo te atreviste a ir"
L["COLUMN_WEEKLYBEST_KEYTIME_TITLE"] = "Mejor Mítica Semanal+ Tiempo"
L["COLUMN_WEEKLYBEST_KEYTIME_SUBTITLE"] = "Pasa el ratón por encima para ver la mejor temporada de todos los mapas"
