local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "frFR" )

if not L then return end

L["Calendar"] = "Calendrier"
L["Tooltip"] = true
L["Getting support"] = "Obtenir de l'aide"
L["Memory used"] = "Mémoire utilisée"
L["Reset all data"] = "Réinitialiser les données"
L["WIPE_DATABASE"] = "Nettoyer les données ?"
L["WIPE_WARNING"] = "Attention: toutes les données seront perdues !"
L["DATABASE_WIPED"] = "Les données sauvegardées dans DataStore ont été complètement effacées !"
  
L["Account"] = "Compte"
L["Default"] = "Défaut"
L["Characters"] = "Personnages"
L["Realms"] = "Royaumes"
L["%s%d%s characters found : did you set your filters properly ?"] = "%s%d%s personnages trouvés : avez-vous correctement défini vos filtres ?"
 
-- ** Menu **
L["Character Information"] = "Infos Personnages"
L["Account Summary"] = "Résumé du compte"
L["Experience"] = "Expérience"
L["Levels"] = "Niveaux"
-- L["Location"] = true
L["Bag Usage"] = "Util. des sacs"
L["Activity"] = "Activités"
L["Currencies"] = "Monnaies"
L["PATCH_X.0"] = "Expansion Patch"
L["PATCH_9.1"] = "Chains of Domination"
L["PATCH_9.2"] = "Eternity's End"
L["PATCH_10.1"] = "Embers of Neltharion"
L["PATCH_10.2"] = "Guardians of the Dream"

-- ** Filter Icons **
L["FILTER_CLASSES"] = "Filtrer par classe"
L["FILTER_FACTIONS"] = "Filtrer par faction"
L["FILTER_LEVELS"] = "Filtrer par niveau"
L["FILTER_PROFESSIONS"] = "Filtrer par profession"
L["FILTER_REALMS"] = "Filtrer par royaume"
L["FILTER_MISC"] = "Filtres divers"
L["FILTER_BANKTYPE"] = "Filtrer par type de banque"
L["This realm"] = "Ce royaume"
L["All realms"] = "Tous les royaumes"
L["This account"] = "Ce compte"
L["All accounts"] = "Tous les comptes"
L["Both factions"] = "Les 2 factions"
L["This faction"] = "Cette faction"
L["Any"] = "Tout"
L["ACCOUNT_SHARING_BUTTON_TITLE"] = "Demande de partage de compte"
L["ACCOUNT_SHARING_BUTTON_INFO"] = [[Cliquez sur ce bouton pour demander
à un joueur de partager toute sa base de
données Altoholic et l'ajouter à la vôtre]]

L["FILTER_ALT_GROUPS"] = "Groupes de rerolls"
L["FILTER_GROUP_CREATE"] = "Créer un groupe"
L["FILTER_GROUP_DELETE"] = "Effacer un groupe"
L["FILTER_GROUP_RENAME"] = "Renommer un groupe"
L["ENTER_GROUP_NAME"] = "Entrez un nouveau nom de groupe"
L["CHANGE_GROUP_NAME"] = "Choisissez un nom pour %s%s|r"
L["ENTER_GROUP_NAME_WARNING"] = "Il est recommandé d'éviter les caractères spéciaux"
L["DELETE_GROUP_NAME"] = "Effacer ce groupe ?"
L["ALT_GROUP_CREATED"] = "Groupe de rerolls %s créé."
L["ALT_GROUP_ALREADY_EXISTS"] = "Le groupe de rerolls %s existe déjà."
L["ALT_GROUP_RENAMED"] = "%s renommé en %s"
L["ALT_GROUP_NOT_RENAMED"] = "%s n'a pas pu être renommé en %s"
L["ALT_GROUP_DELETED"] = "Groupe de rerolls %s effacé."
L["ALT_GROUP_NOT_FOUND"] = "Groupe de rerolls %s non trouvé."

-- L["COLORED_SKILL_LEVELS"] = "Use color for skill levels"
L["FILTER_MISC_HAVE_MAILS"] = "Avec du courrier"
L["FILTER_MISC_HAVE_MAILS_EXPIRE_SOON"] = "Avec du courrier proche de l'expiration"
L["FILTER_MISC_HAVE_AUCTIONS_EXPIRE_SOON"] = "Hôtel des ventes non visité récemment"
L["FILTER_MISC_GUILD_EXALTED"] = "Exalté auprès de la guilde"
L["FILTER_MISC_GUILD_NOT_EXALTED"] = "Pas exalté auprès de la guilde"
L["FILTER_MISC_UPGRADE_RIDING_SKILL"] = "Pourraient améliorer leur compétence de monte"


-- *** Character Information / Account Summary ***
-- Column Name
L["Totals"] = "Totaux"
L["Right-Click for options"] = "Clic-droit pour les options"
L["Character %s successfully deleted"] = "Personnage %s effacé avec succès"
L["Realm %s successfully deleted"] = "Royaume %s effacé avec succès"
L["Cannot delete current character"] = "Impossible d'effacer le personnage en cours"
L["Cannot delete current realm"] = "Impossible d'effacer le royaume en cours"
L["Delete this Alt"] = "Effacer ce reroll"
L["Delete this Realm"] = "Effacer ce royaume"
L["Update from %s%s"] = "Mise-à-jour de %s%s"

L["View"] = "Voir"
L["Mark as bank"] = "Marquer comme banque"
L["Add to group"] = "Ajouter au groupe"
L["Remove from group"] = "Retirer du groupe"



-- Column Level
L["COLUMN_LEVEL_TITLE"] = "Niveau du personnage"
L["COLUMN_LEVEL_TITLE_SHORT"] = "Niveau"
L["COLUMN_LEVEL_SUBTITLE"] = "Cliquez sur le niveau pour basculer les décimales"

-- Column Rest XP
L["COLUMN_RESTXP_TITLE"] = "XP de repos"
L["COLUMN_RESTXP_TITLE_SHORT"] = "XP rep"
L["COLUMN_RESTXP_SUBTITLE"] = "Cliquez pour basculer en mode 100%/150%"
L["COLUMN_RESTXP_DETAIL_1"] = "Il faut 8 heures pour gagner 1 bulle d'XP (5%)."
L["COLUMN_RESTXP_DETAIL_2"] = "Le maximum d'XP au repos est de 30 bulles d'XP, ou 1 niveau et demi."
L["COLUMN_RESTXP_DETAIL_3"] = "Il est atteint en 10 jours."
L["COLUMN_RESTXP_DETAIL_4"] = "Mode %d%% : entièrement reposé est affiché comme '%d%%'"
L["Fully rested"] = "Entièrement reposé"
L["Fully rested in"] = "Entièrement reposé dans"
L["CHARACTER_NOT_IN_RESTING_AREA"] = "Ce personnage n'est pas dans une zone de repos !"

-- Column Money
L["COLUMN_MONEY_TITLE"] = "Argent"
L["COLUMN_MONEY_TITLE_SHORT"] = "Argent"
L["COLUMN_MONEY_SUBTITLE_1"] = "Vos brillants"
L["COLUMN_MONEY_SUBTITLE_2"] = "Pas d'argent, pas de fierté!"
L["COLUMN_MONEY_SUBTITLE_3"] = "Devenez cupide!"
L["COLUMN_MONEY_SUBTITLE_4"] = "On peux pas acheter le bonheur... En fait si, suffit d'acheter des tonnes de montures!"
L["COLUMN_MONEY_SUBTITLE_5"] = "Ne pousse pas sur les arbres!"

-- Column Played
L["COLUMN_PLAYED_TITLE"] = "Temps total joué"
L["COLUMN_PLAYED_TITLE_SHORT"] = "Joué"
L["COLUMN_PLAYED_SUBTITLE"] = "Cliquez pour afficher/masquer le temps de jeu réel"

-- Column iLevel
L["COLUMN_ILEVEL_TITLE"] = "Niveau d'objet moyen"
L["COLUMN_ILEVEL_TITLE_SHORT"] = "iLvl"
L["COLUMN_ILEVEL_SUBTITLE"] = "Cliquez sur le niveau pour basculer les décimales"

-- Column Last Online
L["COLUMN_LASTONLINE_TITLE"] = "Dernier en ligne"
L["COLUMN_LASTONLINE_TITLE_SHORT"] = "Dernier en ligne"
L["COLUMN_LASTONLINE_SUBTITLE"] = "La dernière fois qu'un personnage a été connecté"

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
L["COLUMN_GUILD_TITLE"] = "Nom de guilde"
L["COLUMN_GUILDRANK_TITLE"] = "Rang de guilde"
L["COLUMN_GUILDRANK_TITLE_SHORT"] = "Rang de guilde"
L["COLUMN_GUILDRANK_SUBTITLE"] = "Rang du personnage dans la guilde"
L["COLUMN_GUILDREP_TITLE"] = "Réputation de guilde"
L["COLUMN_GUILDREP_SUBTITLE"] = "Réputation du personnage auprès de la guilde"

-- *** Character Information / Location ***
L["COLUMN_HEARTHSTONE_TITLE"] = "Pierre de foyer"
L["COLUMN_HEARTHSTONE_SUBTITLE"] = "Ce nid douillet qu'on appelle maison"
L["COLUMN_SUBZONE_TITLE"] = "Sous-zone"

-- *** Character Information / Miscellaneous ***
L["COLUMN_CLASS_SUBTITLE"] = "Classe et spécialisation active du personnage"
L["COLUMN_BANK_TYPE_MARKS"] = "Types de banques"
L["COLUMN_BANK_TYPE_MARKS_SUBTITLE"] = "Liste des marques définies pour les personnages banques"

-- *** Bag Usage ***
L["COLUMN_BAGS_TITLE"] = "Sacs du personnage"
L["COLUMN_BAGS_TITLE_SHORT"] = "Sacs"
L["COLUMN_BAGS_SUBTITLE_1"] = "Vos principaux emplacements d'inventaire"
L["COLUMN_BAGS_SUBTITLE_2"] = "Plus grand est toujours mieux"
L["COLUMN_FREEBAGSLOTS_TITLE"] = "Emplacements libres dans l'inventaire"
L["COLUMN_FREEBAGSLOTS_TITLE_SHORT"] = "Libre"
L["COLUMN_FREEBAGSLOTS_SUBTITLE"] = "Libre vs Emplacements total"
L["COLUMN_BANK_TITLE"] = "Banque du personnage"
L["COLUMN_BANK_TITLE_SHORT"] = "Banque"
L["COLUMN_BANK_SUBTITLE_1"] = "Vos emplacements dans votre banque"
L["COLUMN_BANK_SUBTITLE_2"] = "Où les vieux loots vont se reposer"
L["COLUMN_FREEBANKLOTS_TITLE"] = "Emplacements libres en banque"
L["COLUMN_FREEBANKLOTS_TITLE_SHORT"] = "Libre"
L["COLUMN_FREEBANKLOTS_SUBTITLE"] = "Libre vs Emplacements total"
L["NUM_SLOTS_AND_FREE"] = "%s%d%s emplacement(s), %s%d%s libre(s)"

L["Bags"] = "Sacs"
L["Bank"] = "Banque"
L["Bank bag"] = "Sac en banque"
L["Bank not visited yet"] = "Banque non visitée"
L["slots"] = "emplacements"

-- *** Skills ***
L["COLUMN_PROFESSION_1_TITLE"] = "1ère profession"
L["COLUMN_PROFESSION_1_TITLE_SHORT"] = "Prof. 1"
L["COLUMN_PROFESSION_2_TITLE"] = "2ème profession"
L["COLUMN_PROFESSION_2_TITLE_SHORT"] = "Prof. 2"
L["COLUMN_RIDING_UPGRADEABLE_MALE"] = "Ce personnage pourrait améliorer sa compétence de monte"
L["COLUMN_RIDING_UPGRADEABLE_FEMALE"] = "Ce personnage pourrait améliorer sa compétence de monte"
L["COLOR_GREEN"] = "Vert"
L["COLOR_GREY"] = "Gris"
L["COLOR_ORANGE"] = "Orange"
L["COLOR_RED"] = "Rouge"
L["COLOR_YELLOW"] = "Jaune"

L["up to"] = "jusqu'à"
L["at"] = "à"
L["and above"] = "et au-delà"
L["No data"] = "Aucune données"
L["Suggestion"] = true
L["All cooldowns are up"] = [[Tous les cooldowns
sont disponibles]]
L["Riding"] = "Monte"
 
-- *** Activity ***
L["COLUMN_MAILS_TITLE"] = "Contenu de la boîte aux lettres"
L["COLUMN_MAILS_TITLE_SHORT"] = "Courriers"
L["COLUMN_MAILS_SUBTITLE"] = "Nombre d'objets dans la boîte aux lettres"
L["COLUMN_MAILS_DETAIL_1"] = "Au-delà d'une certaine limite, les courriers sont mis en file d'attente côté serveur."
L["COLUMN_MAILS_DETAIL_2"] = "Ces courriers ne sont pas comptabilisés ici."
L["COLUMN_MAILBOX_VISITED_TITLE"] = "Dernière boite au lettre vérifié"
L["COLUMN_MAILBOX_VISITED_TITLE_SHORT"] = "A été relevé"
L["COLUMN_MAILBOX_VISITED_SUBTITLE"] = "La dernière fois que le courrier a été relevé"
L["COLUMN_AUCTIONS_TITLE"] = "Enchères de l'hotel des ventes"
L["COLUMN_AUCTIONS_TITLE_SHORT"] = "Enchères"
L["COLUMN_AUCTIONS_SUBTITLE"] = "Nombre d'enchères actives à l'hotel des ventes"
L["COLUMN_BIDS_TITLE"] = "Offres de l'hotel des ventes"
L["COLUMN_BIDS_TITLE_SHORT"] = "Offres"
L["COLUMN_BIDS_SUBTITLE"] = "Nombre d'offres placées à l'hotel des ventes"
L["COLUMN_AUCTIONHOUSE_VISITED_TITLE"] = "Dernière visite de l'hotel des ventes"
L["COLUMN_AUCTIONHOUSE_VISITED_TITLE_SHORT"] = "A été visité"
L["COLUMN_AUCTIONHOUSE_VISITED_SUBTITLE"] = "La dernière fois que l'hotel des ventes a été visité"
L["COLUMN_GARRISON_MISSIONS_DETAIL_1"] = "Au moins une mission est terminée"
L["COLUMN_GARRISON_MISSIONS_DETAIL_2"] = "Toutes les missions sont terminées"
L["COLUMN_GARRISON_MISSIONS_DETAIL_3"] = "Aucune mission en cours"
L["COLUMN_GARRISON_MISSIONS_SUBTITLE"] = "La dernière fois que le statut de la mission a été vérifié"
L["COLUMN_GARRISON_MISSIONS_TITLE"] = "Missions"
L["COLUMN_GARRISON_MISSIONS_TITLE_SHORT"] = "Missions"

L["Visited"] = "Visité"
 
 
-- *** Currencies ***
L["Last collected"] = "Dernière collecte"
L["Garrison resources"] = "Ressources du fief"
L["Uncollected resources"] = "Ressources non collectées"
L["Max. uncollected resources in"] = "Max. ressources non collectées dans"
 
 
-- *** Expansion Features / Garrison Followers ***
L["COLUMN_FOLLOWERS_LV40_TITLE"] = "Sujets Niveau 40"
L["COLUMN_FOLLOWERS_LV40_TITLE_SHORT"] = "Niv 40"
L["COLUMN_FOLLOWERS_LV40_SUBTITLE"] = "Sujets 40 vs Total"
L["COLUMN_FOLLOWERS_RARITY_TITLE"] = "Niveau de rareté des Sujets"
L["COLUMN_FOLLOWERS_RARITY_TITLE_SHORT"] = "Rareté"
L["COLUMN_FOLLOWERS_RARITY_SUBTITLE"] = "Rareté Rare vs Epique" 
L["COLUMN_FOLLOWERS_ILEVEL_TITLE"] = "Sujets avec iLevel %s"
L["COLUMN_FOLLOWERS_ILEVEL_SUBTITLE"] = "iLevel %s" 
L["COLUMN_FOLLOWERS_AIL_TITLE"] = "AiL des Sujets"
L["COLUMN_FOLLOWERS_AIL_TITLE_SHORT"] = "iLvl"
L["COLUMN_FOLLOWERS_AIL_SUBTITLE"] = "Niveau d'objet moyen de tous les sujets actifs" 

-- *** Expansion Features / Artifacts ***
 
-- *** Expansion Features / Covenant ***
L["COLUMN_COVENANT_SUBTITLE"] = "Cliquez pour voir vos liens d'âmes"
L["COLUMN_COVENANT_TITLE"] = "Congrégation choisie"
L["COLUMN_COVENANT_TITLE_SHORT"] = "Congrégation"
L["COLUMN_SOULBIND_SUBTITLE"] = "Cliquez pour voir vos liens d'âmes"
L["COLUMN_SOULBIND_TITLE"] = "Lien d'âme actif"
L["COLUMN_SOULBIND_TITLE_SHORT"] = "Lien d'âme"
L["COLUMN_RENOWN_SUBTITLE"] = "Cliquez pour voir votre niveau de renom et récompenses"
L["COLUMN_RENOWN_TITLE"] = "Niveau de Renom"
L["COLUMN_CAMPAIGNPROGRESS_TITLE_SHORT"] = "Histoire"
L["COLUMN_CAMPAIGNPROGRESS_TITLE"] = "Progression de la campagne"
L["COLUMN_CAMPAIGNPROGRESS_SUBTITLE"] = "Nombre de chapitres complétés dans la campagne de congrégation"

-- *** Expansion Features / Reservoir ***
-- L["COLUMN_TRANSPORT_NETWORK_TITLE"] = "Transport Network"
-- L["COLUMN_ANIMA_TITLE"] = "Anima Conductor"
-- L["COLUMN_COMMAND_TABLE_TITLE"] = "Command Table"
-- L["COLUMN_SANCTUM_UNIQUE_TITLE"] = "Sanctum Unique"

L["Overall"] = "Globalement"
L["Torghast"] = true
-- L["Single target build"] = true
L["AOE build"] = "Build AOE"
L["Recommended Covenant"] = "Congrégation recommandée"
L["Equally viable"] = "Tout aussi viable"


-- *** Mythic Keystone ***
L["Mythic+ Keystone"] = "Clé Mythic+"
L["COLUMN_KEYNAME_TITLE"] = "Clé Mythic+ actuelle"
L["COLUMN_KEYNAME_TITLE_SHORT"] = "Clé Mythic+"
L["COLUMN_KEYNAME_SUBTITLE"] = "Votre prochaine aventure"
L["COLUMN_KEYLEVEL_TITLE"] = "Niveau de clé Mythic+ actuel"
L["COLUMN_KEYLEVEL_SUBTITLE"] = "Vous n'êtes définitivement pas préparé!"
L["COLUMN_WEEKLYBEST_KEYNAME_TITLE"] = "Meilleure clé Mythic+ de la semaine"
-- L["COLUMN_WEEKLYBEST_KEYNAME_SUBTITLE"] = "Mouse over for weekly best for all maps"
L["COLUMN_WEEKLYBEST_KEYLEVEL_TITLE"] = "Meilleure niveau Mythic+ de la semaine"
-- L["COLUMN_WEEKLYBEST_KEYLEVEL_SUBTITLE"] = "How deep down the rabbit hole you dared to go"
L["COLUMN_WEEKLYBEST_KEYTIME_TITLE"] = "Meilleure temps Mythic+ de la semaine"
-- L["COLUMN_WEEKLYBEST_KEYTIME_SUBTITLE"] = "Mouse over for season best for all maps"
