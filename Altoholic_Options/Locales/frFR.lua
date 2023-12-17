local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "frFR" )

if not L then return end

-- ** Menu **
L["Settings"] = "Paramètres"
L["Calendar"] = "Calendrier"
L["Tooltip"] = "Info-bulle"
L["Enabled"] = "Activé"
L["Disabled"] = "Désactivé"
L["Character"] = "Personnage"
L["Characters"] = "Personnages"
-- L["Bank characters"] = true
L["Account Sharing"] = "Partage de compte"
L["How to"] = "Comment faire"
-- L["Saved Variables"] = true
L["Getting support"] = "Obtenir de l'aide"
L["About"] = "À propos"

L["CTRL_C_TO_COPY"] = "|cFF1CFAFECTRL+C|r pour copier cette adresse, |cFF1CFAFEECHAP|r pour la cacher"
L["WOWI_ICON_ON_ENTER"] = "Cliquer pour afficher la page de l'add-on sur WoW Interface"
L["CURSE_ICON_ON_ENTER"] = "Cliquer pour afficher la page de l'add-on sur Curseforge"
L["DISCORD_ICON_ON_ENTER"] = "Cliquer pour afficher l'adresse du serveur Discord"
L["EMAIL_ICON_ON_ENTER"] = "Cliquer pour afficher l'adresse e-mail de Thaoky"
L["GITHUB_ICON_ON_ENTER"] = "Cliquer pour afficher l'adresse Github de Thaoky"
L["TAB_NOT_LOADED_YET"] = "Onglet pas encore chargé"

-- ** Settings / Altoholic / General **
L["General Options"] = "Options Générales"
L["Minimap Icon Angle"] = "Angle de l'icône de la minicarte"
L["Minimap Icon Radius"] = "Rayon de l'icône de la minicarte"
L["Transparency"] = "Transparence"

L["BANK_AUTO_UPDATE_TEXT"] = "Autoriser automatiquement les mises à jour de la banque de guilde"
L["BANK_AUTO_UPDATE_TITLE"] = "Mises à jour de la banque de guilde"
L["BANK_AUTO_UPDATE_ENABLED"] = "Les membres de la guilde qui utilisent aussi Altoholic seront automatiquement capables de mettre à jour leurs informations de banque de guilde sur base des vôtres, si elles sont plus récentes."
L["BANK_AUTO_UPDATE_DISABLED"] = "Votre confirmation sera requise avant tout envoi d'information."

L["CLAMP_TO_SCREEN_TEXT"] = "Restreindre la fenêtre à l'écran"
L["CLAMP_TO_SCREEN_TITLE"] = "Restreindre la fenêtre à l'écran"
L["CLAMP_TO_SCREEN_ENABLED"] = "La fenêtre d'Altoholic ne dépassera pas les limites de l'écran"
L["CLAMP_TO_SCREEN_DISABLED"] = "La fenêtre d'Altoholic sera déplaçable partout, même partiellement hors-écran"

L["SHOW_ICON_TEXT"] = "Afficher l'icône de la minicarte"
L["SHOW_ICON_TITLE"] = "Afficher l'icône de la minicarte"
L["SHOW_ICON_ENABLED"] = "L'icône d'Altoholic sera visible autour de la minicarte"
L["SHOW_ICON_DISABLED"] = "L'icône d'Altoholic sera cachée"

L["Move to change the angle of the minimap icon"] = "Déplacer pour changer l'angle de l'icône de la minicarte"
L["Move to change the radius of the minimap icon"] = "Déplacer pour changer le rayon de l'icône de la minicarte"
L["UI_SCALE_TOOLTIP"] = "Déplacer pour changer l'échelle de l'interface"
L["UI_TRANSPARENCY_TOOLTIP"] = "Déplacer pour rendre l'interface transparente"


-- ** Settings / Altoholic / Mail **
L["Mail Options"] = "Options de Messagerie"

L["AUTO_COMPLETE_PRIORITY"] = "Priorité de saisie automatique"
L["AUTO_COMPLETE_BY_NAME"] = "Ordre alphabétique"
L["AUTO_COMPLETE_BY_MOST_PLAYED"] = "Temps de jeu le plus élevé"
L["AUTO_COMPLETE_BY_LAST_PLAYED"] = "Plus récemment joué"

L["GUILD_WARNING_TEXT"] = "Notification de nouveau courrier"
L["GUILD_WARNING_TITLE"] = "Notification de courrier de guilde"
L["GUILD_WARNING_ENABLED"] = "Vous serez notifié lorsqu'un membre de la guilde envoie du courrier à l'un de vos rerolls.\n\nLe contenu du courrier sera directement visible sans avoir à reconnecter ce reroll."
L["GUILD_WARNING_DISABLED"] = "Le courrier sera toujours déposé directement dans la boîte aux lettres de vos rerolls, mais vous ne serez pas notifié."

L["AUTO_COMPLETE_TEXT"] = "Saisie automatique du destinataire"
L["AUTO_COMPLETE_TITLE"] = "Saisie automatique du destinataire"
L["AUTO_COMPLETE_ENABLED"] = "Les noms de vos rerolls seront suggérés lors de la saisie du destinataire à la boîte aux lettres."
L["AUTO_COMPLETE_DISABLED"] = "Les noms de vos rerolls ne seront pas suggérés."

L["TIME_TO_NEXT_WARNING_TEXT"] = "Temps jusqu'à l'avertissement suivant"
L["TIME_TO_NEXT_WARNING_TOOLTIP"] = "Délai minimum avant d'obtenir le prochain avertissement d'expiration de courrier."


-- ** Settings / Altoholic / Tooltip **
L["Tooltip Options"] = "Options Info-Bulle"

-- L["TT_SHOW_ITEMSOURCE_TEXT"] = "Show item source"
-- L["TT_SHOW_ITEMSOURCE_TITLE"] = "Item source"
-- L["TT_SHOW_ITEMSOURCE_ENABLED"] = [[Display information about the source of the item, like the profession or the dungeon where it drops.

-- E.g.

 -- |cFFFFD700Info:|r |cFF00FF9AAlchemy, 65|r
 -- |cFFFFD700Goes in:|r |cFF00FF9AGem Bag|r
 
-- or

 -- |cFFFFD700Raid:|r |cFF00FF9AMolten Core|r
 -- |cFFFFD700Boss:|r |cFF00FF9ARagnaros|r]]
-- L["TT_SHOW_ITEMSOURCE_DISABLED"] = "No information is displayed."

-- L["TT_SHOW_ITEMCOUNT_TEXT"] = "Show item count per character"
-- L["TT_SHOW_ITEMCOUNT_TITLE"] = "Item count per character"
-- L["TT_SHOW_ITEMCOUNT_ENABLED"] = [[Display one line of information per character that owns at least one copy of the item being moused over.

-- E.g.

    -- |cFF69CCF0Thaoky|r     |cFFFF7F003|r |cFFFFFFFF(Bags: |cFF00FF9A3|r)|r
    -- |cFFABD473Sira|r           |cFFFF7F006|r |cFFFFFFFF(Bags: |cFF00FF9A6|r)|r]]
-- L["TT_SHOW_ITEMCOUNT_DISABLED"] = "No information is displayed."

-- L["TT_SHOW_SIMPLECOUNT_TEXT"] = "Show item count without details"
-- L["TT_SHOW_SIMPLECOUNT_TITLE"] = "Item count without details"
-- L["TT_SHOW_SIMPLECOUNT_ENABLED"] = [[Display only the amount of items owned for a character, without the location.

-- E.g.

    -- |cFF69CCF0Thaoky|r     |cFFFF7F003|r]]
-- L["TT_SHOW_SIMPLECOUNT_DISABLED"] = [[Location information will be displayed normally.

-- Note that this option is tied to 
-- |cFFFF7F00Show item count per character|r]]

-- L["TT_SHOW_TOTALCOUNT_TEXT"] = "Show total item count"
-- L["TT_SHOW_TOTALCOUNT_TITLE"] = "Total item count"
-- L["TT_SHOW_TOTALCOUNT_ENABLED"] = [[Display the total amount of items owned by all characters listed in the tooltip.

-- Note that this total is influenced by multiple other tooltip options, and varies depending on which alts you have chosen to display.

-- E.g.

 -- |cFFFFD700Total owned:|r |cFF00FF9A217|r]]
-- L["TT_SHOW_TOTALCOUNT_DISABLED"] = "The total line is not displayed."

-- L["TT_SHOW_RECIPES_TEXT"] = "Show recipes already known/learnable by"
-- L["TT_SHOW_RECIPES_TITLE"] = "Show recipes already known/learnable by"
-- L["TT_SHOW_RECIPES_ENABLED"] = [[Display information about which alts already know, could learn or will later be able to learn a recipe.

-- E.g.

    -- |cFF00FF9AAlready known by :|r |cFF69CCF0Thaoky|r
    -- |cFFFFFF00Could be learned by :|r |cFFABD473Sira|r]]
-- L["TT_SHOW_RECIPES_DISABLED"] = "No information is displayed."

-- L["TT_SHOW_GUILDBANKCOUNT_TEXT"] = "Show guild bank count"
-- L["TT_SHOW_GUILDBANKCOUNT_TITLE"] = "Guild bank count"
-- L["TT_SHOW_GUILDBANKCOUNT_ENABLED"] = [[Display the total amount of items stored in guild banks.

-- E.g. 

    -- |cFF00FF00Odysseüs|r     |cFFFF7F0084|r |cFFFFFFFF(Guild Bank: |cFF00FF9A84|r)|r]]
-- L["TT_SHOW_GUILDBANKCOUNT_DISABLED"] = "No information is displayed."

-- L["TT_INCLUDE_GUILDBANKCOUNT_TEXT"] = "Include guild bank count in the total count"
-- L["TT_INCLUDE_GUILDBANKCOUNT_TITLE"] = "Include guild bank count in the total count"
-- L["TT_INCLUDE_GUILDBANKCOUNT_ENABLED"] = "The amount of items stored in guild banks will be accounted for in the total."
-- L["TT_INCLUDE_GUILDBANKCOUNT_DISABLED"] = "The amount of items stored in guild banks will be ignored."

-- L["TT_DETAILED_BANKCOUNT_TEXT"] = "Detailed guild bank count"
-- L["TT_DETAILED_BANKCOUNT_TITLE"] = "Detailed guild bank count"
-- L["TT_DETAILED_BANKCOUNT_ENABLED"] = [[Display the amount of items stored in guild banks, per tab.

-- E.g.

    -- |cFF00FF00Odysseüs|r     |cFFFF7F0084|r |cFFFFFFFF(Consumables: |cFF00FF9A84|r)|r]]
-- L["TT_DETAILED_BANKCOUNT_DISABLED"] = [[Display 'Guild Bank' instead of the tab name.]]

-- L["TT_SHOW_GUILDBANKREALM_TEXT"] = "Show guild bank realm"
-- L["TT_SHOW_GUILDBANKREALM_TITLE"] = "Guild bank realm"
-- L["TT_SHOW_GUILDBANKREALM_ENABLED"] = [[Display the realm on which a guild bank resides.

-- E.g. 

    -- |cFF00FF00Odysseüs|r |cFFFFFF00(Marécages de Zangar)|r    |cFFFF7F0084|r |cFFFFFFFF(Guild Bank: |cFF00FF9A84|r)|r]]
-- L["TT_SHOW_GUILDBANKREALM_DISABLED"] = "Display only the guild name"

-- L["TT_SHOW_ITEMID_TEXT"] = "Show item ID and item level"
-- L["TT_SHOW_ITEMID_TITLE"] = "Item ID and item level"
-- L["TT_SHOW_ITEMID_ENABLED"] = [[Display the item ID and item level at the bottom of the tooltip.

-- E.g.

    -- |cFFFFD700Item ID:|r |cFF00FF00140192|r             |cFFFFD700iLvl:|r |cFF00FF0035|r]]
-- L["TT_SHOW_ITEMID_DISABLED"] = "No information is displayed."

-- L["TT_SHOW_ITEMXPACK_TEXT"] = "Show extended item information"
-- L["TT_SHOW_ITEMXPACK_TITLE"] = "Extended item information"
-- L["TT_SHOW_ITEMXPACK_ENABLED"] = [[Display extended information about the item, like the expansion it belongs to.

-- E.g.

 -- |cFFFFD700Info:|r |cFF00FF9AAlchemy, 65|r
 -- |cFFFFD700Goes in:|r |cFF00FF9AGem Bag|r
 -- |cFFFFD700Expansion:|r |cFF00FF9ABurning Crusade|r |cFFFFFF00(2.0)|r]]
-- L["TT_SHOW_ITEMXPACK_DISABLED"] = [[No information is displayed.

-- Note that this option is tied to 
-- |cFFFF7F00Show item source|r]]

-- L["TT_SHOW_NODES_TEXT"] = "Show counters on gathering nodes"
-- L["TT_SHOW_NODES_TITLE"] = "Show counters on gathering nodes"
-- L["TT_SHOW_NODES_ENABLED"] = "When mousing over a gathering node (herbs, mines), display the amount of related items owned."
-- L["TT_SHOW_NODES_DISABLED"] = "No information is displayed."

-- L["TT_SHOW_BOTHFACTIONS_TEXT"] = "Show counters for both factions"
-- L["TT_SHOW_BOTHFACTIONS_TITLE"] = "Show counters for both factions"
-- L["TT_SHOW_BOTHFACTIONS_ENABLED"] = "Display the amount of items owned by characters of the opposite faction."
-- L["TT_SHOW_BOTHFACTIONS_DISABLED"] = "Only information about the current faction is displayed."

-- L["TT_SHOW_MERGEDREALMS_TEXT"] = "Show counters for connected realms"
-- L["TT_SHOW_MERGEDREALMS_TITLE"] = "Show counters for connected realms"
-- L["TT_SHOW_MERGEDREALMS_ENABLED"] = "Display the amount of items owned by characters on realms connected to the current realm."
-- L["TT_SHOW_MERGEDREALMS_DISABLED"] = "Only information about the current realm is displayed."

-- L["TT_SHOW_ALLREALMS_TEXT"] = "Show counters for all realms"
-- L["TT_SHOW_ALLREALMS_TITLE"] = "Show counters for all realms"
-- L["TT_SHOW_ALLREALMS_ENABLED"] = "Information from all realms is also displayed for account bound items."
-- L["TT_SHOW_ALLREALMS_DISABLED"] = [[Only information about the current realm is displayed.

-- Note: this option supersedes |cFFFF7F00Show counters for connected realms|r for account bound items.]]

-- L["TT_SHOW_ALLACCOUNTS_TEXT"] = "Show counters for all accounts"
-- L["TT_SHOW_ALLACCOUNTS_TITLE"] = "Show counters for all accounts"
-- L["TT_SHOW_ALLACCOUNTS_ENABLED"] = "Information from all imported accounts is also displayed."
-- L["TT_SHOW_ALLACCOUNTS_DISABLED"] = "Only information about the current account is displayed."

-- L["TT_SHOW_HEARTHSTONE_TEXT"] = "Show counters for hearthstones"
-- L["TT_SHOW_HEARTHSTONE_TITLE"] = "Show counters for hearthstones"
-- L["TT_SHOW_HEARTHSTONE_ENABLED"] = "Display counters when mousing over a hearthstone, the Admiral's Compass, or the Flight Master's Whistle."
-- L["TT_SHOW_HEARTHSTONE_DISABLED"] = "Hide the counters when mousing over one of these items."




-- ** Settings / Altoholic / Calendar **
L["Calendar Options"] = "Options du Calendrier"
L["Week starts on Monday"] = "La semaine commence le lundi"
L["Display warnings in a dialog box"] = "Afficher les avertissements dans une boîte de dialogue"
L["Disable warnings"] = "Désactiver les avertissements"
L["Profession Cooldowns"] = "Temps de recharge des professions"
L["Dungeon Resets"] = "Réinitialisations des donjons"
L["Calendar Events"] = "Evènements calendrier"
-- L["Item Timers"] = true

-- ** Settings / Altoholic / Miscellaneous **
L["Miscellaneous Options"] = "Options Diverses"
L["Use color-coding for recipes at the AH"] = "Colorer les recettes à l'hôtel des ventes"
L["Use color-coding for recipes at vendors"] = "Colorer les recettes chez les vendeurs"


-- ** Settings / DataStore / Auctions **
L["DataStore_Auctions' Options"] = "Options DataStore_Auctions"

L["LAST_VISIT_SLIDER_LABEL"] = "Avertissement de dernière visite"
L["LAST_VISIT_SLIDER_TITLE"] = "Avertissement de dernière visite de l'hôtel des ventes"
L["LAST_VISIT_SLIDER_TOOLTIP"] = "Avertir quand l'hôtel des ventes n'a pas été visité depuis plus de jours que cette valeur"

L["LAST_VISIT_CHECK_LABEL"] = "Dernière visite de l'hôtel des ventes"
L["LAST_VISIT_CHECK_TITLE"] = "Vérifier l'heure de la dernière visite"
L["LAST_VISIT_CHECK_ENABLED"] = "L'heure de la dernière visite de l'hôtel des ventes de chaque personnage sera vérifiée. Les add-ons clients recevront une notification pour chaque personnage n'ayant pas visité l'hôtel des ventes depuis plus longtemps que cette valeur."
L["LAST_VISIT_CHECK_DISABLED"] = "L'heure de la dernière visite de l'hôtel des ventes ne sera pas vérifiée."

L["CLEAR_EXPIRED_ITEMS_LABEL"] = "Effacer automatiquement les enchères et les offres"
L["CLEAR_EXPIRED_ITEMS_TITLE"] = "Effacer les objets de l'hôtel des ventes"
L["CLEAR_EXPIRED_ITEMS_ENABLED"] = "Les objets expirés sont automatiquement effacés de la base de données."
L["CLEAR_EXPIRED_ITEMS_DISABLED"] = "Les objets expirés restent dans la base de données jusqu'à la prochaine visite du joueur à l'hôtel des ventes."

-- ** Settings / DataStore / Characters **
L["DataStore_Characters' Options"] = "Options DataStore_Characters"
L["HIDE_PLAYTIME_TEXT"] = "Cacher le temps de jeu réel."
L["HIDE_PLAYTIME_TITLE"] = "Cacher Le Temps De Jeu Réel"
L["HIDE_PLAYTIME_ENABLED"] = "Un temps de jeu de zéro sera affiché."
L["HIDE_PLAYTIME_DISABLED"] = "Votre temps de jeu réel sera affiché."

L["REQUEST_PLAYTIME_TEXT"] = "Lire le temps de jeu à la connexion."
L["REQUEST_PLAYTIME_TITLE"] = "Lire le temps de jeu"
L["REQUEST_PLAYTIME_ENABLED"] = "Le temps de jeu sera lu à chaque connexion."
L["REQUEST_PLAYTIME_DISABLED"] = "Le temps de jeu ne sera pas lu à la connexion. La dernière valeur connue sera envoyée aux addons clients."


-- ** Settings / DataStore / Garrisons **
L["DataStore_Garrisons' Options"] = "Options DataStore_Garrisons"
L["REPORT_LEVEL_LABEL"] = "Signaler à %s%s"
L["REPORT_LEVEL_TITLE"] = "Niveau limite de signalement"
L["REPORT_LEVEL_TOOLTIP"] = "Signaler quand le niveau de ressources non collectées est supérieur à cette valeur"

L["REPORT_UNCOLLECTED_LABEL"] = "Signaler les ressources non collectées"
L["REPORT_UNCOLLECTED_TITLE"] = "Signaler les ressources non collectées"
L["REPORT_UNCOLLECTED_ENABLED"] = "Au logon, les personnages avec plus de 400 ressources non collectées seront signalés dans la fenêtre de chat."
L["REPORT_UNCOLLECTED_DISABLED"] = "Rien ne sera signalé"
L["UNCOLLECTED_RESOURCES_ALERT"] = "%s a %s ressources non collectées"


-- ** Settings / DataStore / Inventory **
L["DataStore_Inventory's Options"] = "Options DataStore_Inventory"
L["CLEAR_INVENTORY_TEXT"] = "Effacer automatiquement l'équipement des membres de la guilde"
L["CLEAR_INVENTORY_TITLE"] = "Effacer l'équipement des membres de la guilde"
L["CLEAR_INVENTORY_ENABLED"] = "Pour économiser la mémoire, les inventaires locaux des membres de la guilde sont effacés à chaque login."
L["CLEAR_INVENTORY_DISABLED"] = "L'équipement des membres de la guilde reste dans la base de données, et est visible même s'ils sont hors-ligne."

L["BROADCAST_AIL_TEXT"] = "Envoyer le niveau d'objets moyen à la guilde au login."
L["BROADCAST_AIL_TITLE"] = "Envoyer le niveau d'objets moyen"
L["BROADCAST_AIL_ENABLED"] = "Le niveau d'objets moyen de vos rerolls sera envoyé sur le canal guilde au login."
L["BROADCAST_AIL_DISABLED"] = "Rien ne sera envoyé."

L["EQUIP_REQ_TEXT"] = "Etre informé quand quelqu'un inspecte l'équipement d'un de mes personnages."
L["EQUIP_REQ_TITLE"] = "Avertissement de requête d'équipement."
L["EQUIP_REQ_ENABLED"] = "Un message vous informera de quel membre de guilde inspecte quel reroll."
L["EQUIP_REQ_DISABLED"] = "Rien ne sera affiché."

-- ** Settings / DataStore / Mails **
L["DataStore_Mails' Options"] = "Options DataStore_Mails"

L["SLIDER_EXPIRY_TITLE"] = "Mail Expiry Threshold"
L["SLIDER_EXPIRY_TOOLTIP"] = "Avertir quand du courrier arrive à expiration dans moins de jours que cette valeur"

L["EXPIRY_CHECK_LABEL"] = "Avertis. d'expiration du courrier"
L["EXPIRY_CHECK_TITLE"] = "Vérifier les expirations de courrier"
L["EXPIRY_CHECK_ENABLED"] = "Les expirations de courrier seront vérifiées 5 secondes après le login. Les add-ons client en seront informé si au moins un courrier expiré est trouvé."
L["EXPIRY_CHECK_DISABLED"] = "Aucune vérification ne sera effectuée."

L["REPORT_EXPIRED_MAILS_LABEL"] = "Avertis. d'expiration du courrier (fenêtre de chat)"
L["REPORT_EXPIRED_MAILS_TITLE"] = "Avertis. d'expiration du courrier (fenêtre de chat)"
L["REPORT_EXPIRED_MAILS_ENABLED"] = "Lors de la verification d'expiration du courrier, la liste des personnages ayant du courrier expire sera également affichée dans la fenêtre de chat."
L["REPORT_EXPIRED_MAILS_DISABLED"] = "Rien ne sera affiché dans la fenêtre de chat."

L["SCAN_MAIL_BODY_LABEL"] = "Lire le courrier (le marque comme lu)"
L["SCAN_MAIL_BODY_TITLE"] = "Lire le corps du courrier"
L["SCAN_MAIL_BODY_ENABLED"] = "Le corps de chaque lettre sera lu durant le scan de la boîte aux lettres. Tous les courriers seront marqués comme lus."
L["SCAN_MAIL_BODY_DISABLED"] = "Seules les pièces jointes seront lues. Les lettres garderont leur statut 'non-lu'."

L["EXPIRY_ALL_ACCOUNTS_LABEL"] = "Vérifier les expirations sur tous les comptes connus"
L["EXPIRY_ALL_ACCOUNTS_TITLE"] = "Vérifier tous les comptes"
L["EXPIRY_ALL_ACCOUNTS_ENABLED"] = "La routine de vérification recherchera les courriers expirés sur tous les comptes connus."
L["EXPIRY_ALL_ACCOUNTS_DISABLED"] = "Seul le compte en cours d'utilisation sera pris en considération; les comptes importés seront ignorés."

L["EXPIRY_ALL_REALMS_LABEL"] = "Vérifier les expirations sur tous les royaumes connus"
L["EXPIRY_ALL_REALMS_TITLE"] = "Vérifier tous les royaumes"
L["EXPIRY_ALL_REALMS_ENABLED"] = "La routine de vérification recherchera les courriers expirés sur tous les royaumes connus."
L["EXPIRY_ALL_REALMS_DISABLED"] = "Seul le royaume en cours d'utilisation sera pris en considération; les autres royaumes seront ignorés."

L["EXPIRED_EMAILS_WARNING"] = "%s (%s) a du courrier expiré (ou proche de l'expiration)"


-- ** Settings / DataStore / Quests **
L["DataStore_Quests' Options"] = "Options DataStore_Quests"

L["TRACK_TURNINS_LABEL"] = "Suivre les validations de quêtes"
L["TRACK_TURNINS_TITLE"] = "Suivre les validations de quêtes"
L["TRACK_TURNINS_ENABLED"] = "Les validations de quêtes sont sauvées dans l'historique, afin d'assurer qu'il soit toujours valide."
L["TRACK_TURNINS_DISABLED"] = "L'historique de quêtes restera dans son état actuel, soit vide ou obsolète."

L["AUTO_UPDATE_LABEL"] = "Mise à jour automatique de l'historique"
L["AUTO_UPDATE_TITLE"] = "Mise à jour automatique de l'historique de quêtes"
L["AUTO_UPDATE_ENABLED"] = "L'historique de quêtes d'un personnage sera rafraîchi à chaque connexion de ce personnage."
L["AUTO_UPDATE_DISABLED"] = "L'historique de quêtes restera dans son état actuel, soit vide ou obsolète."

L["DAILY_QUESTS_RESET_LABEL"] = "Réinitialiser les quêtes journalières à"


-- ** Sharing / Authorizations **
-- L["Authorizations"] = true
-- L["Ask"] = true
-- L["Auto"] = true

-- L["ACCOUNT_SHARING_ACTIVE_LABEL"] = "Account Sharing Enabled"
-- L["ACCOUNT_SHARING_ACTIVE_TITLE"] = "Account Sharing Enabled"
-- L["ACCOUNT_SHARING_ACTIVE_ENABLED"] = [[Other users will be allowed to send you account sharing requests.

-- Your confirmation will still be required any time someone requests your information.]]
-- L["ACCOUNT_SHARING_ACTIVE_DISABLED"] = [[All requests will automatically be rejected.

-- |cFF1CFAFESecurity hint|r: Only enable this when you actually need to transfer data, disable otherwise.]]

-- L["ACCOUNT_SHARING_AUTH_INFO"] = [[This list allows you to automate responses to account sharing requests.
-- You can choose to automatically |cFF00FF00accept|r or |cFFFF0000reject|r requests, or be |cFFFFFF00asked|r when a request comes in.
-- If account sharing is totally disabled, this list will be ignored, and all requests will be rejected.]]

-- L["ACCOUNT_SHARING_AUTH_ASK"] = "Ask me whenever an account sharing request is sent by this player"
-- L["ACCOUNT_SHARING_AUTH_AUTO"] = "Automatically authorize account sharing requests sent by this player"
-- L["ACCOUNT_SHARING_AUTH_NEVER"] = "Automatically reject account sharing requests sent by this player"

-- ** Sharing / Content **
-- L["Shared Content"] = true


-- L["SHARED_CONTENT_INFO"] = [[Select the content that will be visible to players who send you account sharing requests.]]

-- ** Sharing / Share ! **
-- L["Share"] = true
-- L["Account Name"] = true
-- L["Send account sharing request to:"] = true
-- L["Send Request"] = true
-- L["Request Content"] = true

-- L["ACCOUNT_NAME_INFO"] = [[Enter an account name that will be used for |cFF00FF00display|r purposes only.

-- This name can be anything you like, it does |cFFFF0000NOT|r have to be the real account name. This field |cFFFF0000cannot|r be left empty.]]

-- L["EMPTY_ACCOUNT_WARNING"] = "[Account Name] This field |cFF00FF00cannot|r be left empty."



-- ** Help **
-- L["HELP_SHARING_HOWTO"] = [[
-- |cFF00FF00Q:|cFFFFFFFF How do I share data between two accounts ?|r|r

-- Both accounts must be connected at the same time for this feature to work. If you are the owner of both accounts, you must run two parallel instances of the WoW client.

-- |cFF00FF00Q:|cFFFFFFFF Is the transfer of information bidirectional ?|r|r

-- No. The transfer uses the game's communication channels, so the throughput is throttled. If you want to have the same data on both sides, you have to repeat the process twice.

-- |cFF00FF00Q:|cFFFFFFFF Is there any setup before I can share data ?|r|r

-- Yes. By default, and for security reasons, account sharing is disabled, so the first step is to enable it on both sides, this is done in |cFF1CFAFE2|r|cFFFFFFFF. Authorizations|r.

-- The next step is to setup the authorizations. The account receiving the information must determine who may send it requests. Any requestor not in the list will see its request rejected.

-- The last step is to determine which information is shared, this is done in |cFF1CFAFE3|r|cFFFFFFFF. Shared Content|r.

-- |cFF00FF00Q:|cFFFFFFFF The transfer seems slow, even stopped at times, what is the problem ?|r|r

-- As mentioned above, the transfer uses the game's communication channels, so this means that all the information is sent from account A to account B via Blizzard's server. This will take time, be patient. As long as there is no Lua error, you are fine, data will get through. 

-- |cFF00FF00Q:|cFFFFFFFF Can the process be improved ?|r|r

-- No. Data is compressed before being sent to minize traffic on the network, but the more information you share, the longer it will take. If you have doubts about the process, test it with just one character to validate that things are working, then try again with more.
-- ]]

-- L["HELP_ALTOHOLIC_GENERAL"] = [[
-- |cFF00FF00Q:|cFFFFFFFF How does the add-on work ?|r|r

-- When one of your alts enters the world, a maximum of information will automatically populate the add-on's database.
-- However, some of this information cannot be read unless you trigger the event that makes it available. This is a restriction imposed by the game, not a limitation of the add-on.

-- |cFF00FF00Q:|cFFFFFFFF What kind of information ?|r|r

-- The mailbox, the auction house and both your bank and guild bank are subject to this restriction.
-- Your character has to be physically present at those places for the add-on to be able to read this information.

-- Profession information is also impacted, you will have to open each profession's panel to fully benefit from the add-on's functionalities.

-- |cFF00FF00Q:|cFFFFFFFF Does Altoholic support command line options ?|r|r

-- Yes, type |cFFFF7F00/alto|r or |cFFFF7F00/altoholic|r to get the list of command line options.

-- |cFF00FF00Q:|cFFFFFFFF My minimap icon is gone, how do I get it back ?|r|r

-- Stay in the Options tab, click on |cFFFF7F00Settings => Altoholic => General|r, and check the option 'Show Minimap Icon'.

-- |cFF00FF00Q:|cFFFFFFFF Can I bind Altoholic to a specific key ?|r|r

-- Yes. Use the game's |cFFFF7F00Key Bindings|r menu to select the key you like best. 

-- I personally bind it to the |cFF1CFAFEJ|r key, because the ridge makes it easy to find.
-- ]]

-- L["HELP_ALTOHOLIC_CHARACTERS"] = [[
-- |cFF00FF00Q:|cFFFFFFFF Why can I only see one alt ?|r|r

-- If this is your first time using the add-on, this is normal. Add-on's may only get information about the character you are currently playing with. This is another restriction of the game.

-- |cFF00FF00Q:|cFFFFFFFF You mean I have to log in all my 37 alts one by one ???|r|r

-- Yes I do. There is no other way.

-- |cFF00FF00Q:|cFFFFFFFF I deleted an alt, or moved it to another realm, why does the add-on not see it ?|r|r

-- The add-on is only active when the game is running, and your character is in the game world. Everything that happens outside of that is out of reach for all add-on's.
-- If you have a leftover alt, you can simply delete it in the add-on.

-- |cFF00FF00Q:|cFFFFFFFF How do I delete an alt from the add-on's database ?|r|r

-- Go to the |cFFFF7F00Summary|r tab, |cFF1CFAFEright-click|r the alt's name, and choose |cFFFF7F00Delete this Alt|r.

-- |cFF00FF00Q:|cFFFFFFFF I cannot see any alt, what is going on ?|r|r

-- There are two possible reasons:

-- - You may have a combination of filters in the |cFFFF7F00Account Summary|r that prevents any alt from being displayed, so check your filter settings.

-- - There may be a Lua error that is not displayed. 

-- Be sure to enable Lua errors with this command : |cFFFFFFFF/console scriptErrors|r |cFF00FF001|r

-- If you wish to disable Lua errors afterwards : |cFFFFFFFF/console scriptErrors|r |cFF00FF000|r
-- ]]

-- L["HELP_DATASTORE_GENERAL"] = [[
-- |cFF00FF00Q:|cFFFFFFFF What is DataStore ?|r|r

-- DataStore is the main component of a series of add-ons that serve as data repositories in game. Their respective purpose is to offer scanning and storing services to other add-ons.

-- |cFF00FF00Q:|cFFFFFFFF Why doing this ? Now I have 17 folders just for this !|r|r

-- There are multiple advantages, for both players and developers

-- - Data is |cFFFF7F00scanned|r only once for all client add-ons (|cFF00FF00performance gain|r).

-- - Data is |cFFFF7F00stored|r only once for all client add-ons (|cFF00FF00memory gain|r).

-- - Add-on authors can spend more time coding higher level features.

-- - Each module is an independant add-on, and therefore has its own SavedVariables file, meaning that you could clean a module's data without disturbing other modules.

-- |cFF00FF00Q:|cFFFFFFFF What do all these modules do? Do I need to enable them all ?|r|r

-- |cFFFF7F00DataStore|r is the main module, client add-ons should have a dependency on it, it should therefore remain enabled all the time, as it is the interface used to access data from the various modules.
-- The other modules are technically all optional, and could be enabled/disabled according to your needs. However, some of these modules, like |cFFFF7F00DataStore_Characters|r, play a major role in Altoholic, and must remain enabled. 

-- |cFF00FF00Q:|cFFFFFFFF How should I update DataStore and its modules ?|r|r

-- |cFF1CFAFEAltoholic|r is always packaged with the latest versions, most users should upgrade using this method. Please refer to the add-on's homepage in the |cFFFF7F00About|r panel.
-- ]]

-- L["HELP_DATASTORE_SAVEDVARS"] = [[
-- |cFF00FF00Q:|cFFFFFFFF How do I clear data from DataStore ?|r|r

-- Characters and guilds can be erased from Altoholic's UI.
-- If you want more control over the information that has to be deleted, you can |cFF1CFAFEedit|r or |cFF1CFAFEremove|r the files from the |cFFFF7F00Saved Variables|r folder.

-- |cFF00FF00Q:|cFFFFFFFF Where are the Saved Variables ?|r|r

-- Databases are located in |cFFFF7F00WTF \\ Account \\ |cFF1CFAFEyour_account|r \\ SavedVariables|r.

-- |cFF00FF00Q:|cFFFFFFFF What are the relevant files ?|r|r

-- The files are |cFFFF7F00DataStore.lua|r and all |cFFFF7F00DataStore_*.lua|r.

-- |cFF00FF00Q:|cFFFFFFFF When can I |cFF1CFAFEmodify|r or |cFF1CFAFEdelete|r those files ?|r|r

-- It is |cFFFF0000critical|r that you |cFFFF0000DO NOT|r modify those files while the game is running.
-- Some have tried, they have had problems.

-- Do not try to outsmart the game. 
-- Stop it, make your changes, and start it again.

-- |cFF00FF00Q:|cFFFFFFFF How can I edit those files ?|r|r

-- Use a proper text editor, like |cFF1CFAFENotepad++|r. 

-- The classic Notepad and Wordpad are not recommended.
-- ]]

-- L["HELP_GETTING_SUPPORT"] = [[
-- |cFF00FF00Q:|cFFFFFFFF I found an error, how/where do I report it ?|r|r

-- Use CurseForge's ticket section, I also read comments and respond as often as I materially can, so feel free to report in one of these places.

-- |cFF00FF00Q:|cFFFFFFFF What should I do before reporting ?|r|r

-- A few things:

-- |cFF1CFAFE1)|r Make sure you have the latest version of the add-on.

-- |cFF1CFAFE2)|r If you suspect a conflict with another add-on, try to reproduce the issue with only Altoholic enabled. As the add-on deals with a lot of things, a conflict is always possible.

-- |cFF1CFAFE3)|r Make sure your issue has not already been reported by someone else.

-- |cFF1CFAFE4)|r Never, ever, report that 'it does not work', this is the most useless sentence in the world! 
-- Be |cFFFF7F00specific|r about what does not work.

-- |cFF1CFAFE5)|r |cFFFF0000DO NOT|r copy the entire call stack in case of a Lua error. The first 5-6 lines are enough.

-- |cFF00FF00Q:|cFFFFFFFF I am getting multiple errors, should I report them all ?|r|r

-- No, simply report the first one in the list, the others are usually a consequence of the first one.

-- |cFF00FF00Q:|cFFFFFFFF Where can I get live support ?|r|r

-- Join the |cFF1CFAFEDiscord|r server. I am present in the evening (Belgian Time), and even when I am not, we have a nice community ready to help in case of problem.
-- ]]

-- L["ABOUT_ALTOHOLIC"] = [[
-- |cFF00FF00Q:|cFFFFFFFF When was Altoholic started ?|r|r

-- Development started in |cFF1CFAFEDecember 2007|r, and the first version made public was |cFFFF7F002.4.001|r, released on |cFF1CFAFEMarch 29th 2008|r.

-- |cFF00FF00Q:|cFFFFFFFF How many people work on Altoholic ?|r|r

-- One. I do have a full-time job and my availability fluctuates. I do get the occasional help from the community though, and I want to thank all those who have lent a hand along the years.
-- The add-on would not be what it is today without your help and suggestions.

-- |cFF00FF00Q:|cFFFFFFFF How many languages does the add-on support ?|r|r

-- Eleven: deDE, enUS, esES, esMX, frFR, itIT, koKR, ptBR, ruRU, zhCN, zhCW.

-- |cFF00FF00Q:|cFFFFFFFF Can I help with the localizations ?|r|r

-- Yes ! Your help would be most welcome, join us on |cFF1CFAFEDiscord|r and provide me with the translation files.

-- |cFF1CFAFENote|r that translations are now spread over the multiple Altoholic* add-ons (one per tab).

-- |cFF00FF00Q:|cFFFFFFFF Where can I get my updates from ?|r|r

-- The only two official homes are |cFFFF7F00Curse Forge|r and |cFFFF7F00WoW Interface|r.

-- Any other source means you are using an unofficial release, and not supporting the considerable effort that went into developing this.

-- Absolutely |cFFFF0000no support|r will be given for any such version.
-- ]]

-- L["ABOUT_DATASTORE"] = [[
-- |cFF00FF00Q:|cFFFFFFFF Why was DataStore started ?|r|r

-- DataStore was released in |cFF1CFAFEAugust 2009|r, as part of version |cFFFF7F003.2|r.

-- After about 18 months of learning about WoW development, adding features in Altoholic, and managing a monolithic database, I felt it was time for a more professional approach and created a proper layer to manage all the data.

-- |cFF00FF00Q:|cFFFFFFFF Why separating the data and the UI ?|r|r

-- Because it is the right thing to do, and because I had back then, and still have to this day, multiple add-ons in mind which will make use of all this information.

-- Furthermore, it provides a clean interface to manage characters, guilds, realms and accounts.

-- |cFF00FF00Q:|cFFFFFFFF Will there be more modules in the future ?|r|r

-- I am satisfied with the current modules, but I do not exclude to add more if a real need arises.

-- |cFF00FF00Q:|cFFFFFFFF I am developper, I want to know more about DataStore !|r|r

-- The code is well commented, structured, and pretty much self-explanatory. 

-- If you still have questions, join the |cFF1CFAFEDiscord|r server and ask me !
-- ]]

-- L["HELP_ALTOHOLIC_BANKCHARACTERS"] = [[
-- |cFF00FF00Q:|cFFFFFFFF What are bank characters ?|r|r

-- If you are playing a lot of characters, chances are you are using some of them as banks. 
-- Altoholic now has a way to keep track of that in the |cFFFF7F00Summary|r tab.

-- |cFF00FF00Q:|cFFFFFFFF How do I mark a character as a bank character ?|r|r

-- In any panel of the |cFFFF7F00Summary|r tab, |cFF1CFAFEright-click|r the alt's name, choose |cFFFF7F00Mark as bank|r, and select the type of bank this alt should be.

-- |cFF00FF00Q:|cFFFFFFFF Can I mark a bank character with multiple types ?|r|r

-- Yes.

-- |cFF00FF00Q:|cFFFFFFFF Where can I have an overview of my bank characters ?|r|r

-- In the |cFFFF7F00Summary|r tab, select the |cFFFF7F00Miscellaneous|r panel.

-- |cFF00FF00Q:|cFFFFFFFF How does marking a character help me managing my alts ?|r|r

-- If you so choose, one of the tooltip options will allow you to see if you could send an item to a bank character.
-- ]]

-- L["HELP_ALTOHOLIC_ALTGROUPS"] = [[
-- |cFF00FF00Q:|cFFFFFFFF What are alt groups ?|r|r

-- Alt groups are a simple way to easily manage your alts by grouping them based on criteria that are not related to the game. For instance, I have put my 12 main alts in a group, and my 12 bank alts on the same realm in another group.

-- |cFF00FF00Q:|cFFFFFFFF Is there a limit to the amount of alts in a group ?|r|r

-- No there is not. You can also add alts from another realm, another faction, or even another account into the same group.

-- |cFF00FF00Q:|cFFFFFFFF Is there a limit to the amount of groups I can create ?|r|r

-- No, you can create as many groups as you like, although creating too many is likely to defeat the purpose of groups. You are in charge, you can organize groups the way you like.

-- |cFF00FF00Q:|cFFFFFFFF How do I add a character to a group ?|r|r

-- In any panel of the |cFFFF7F00Summary|r tab, |cFF1CFAFEright-click|r the alt's name, choose |cFFFF7F00Add to group|r, and select the group to which this alt should be added.

-- |cFF00FF00Q:|cFFFFFFFF How do I remove a character from a group ?|r|r

-- In any panel of the |cFFFF7F00Summary|r tab, |cFF1CFAFEright-click|r the alt's name, choose |cFFFF7F00Remove from group|r, and select the group from which this alt should be removed.

-- |cFF00FF00Q:|cFFFFFFFF Can a character be part of multiple groups ?|r|r

-- Yes.
-- ]]


-- L["HELP_ALTOHOLIC_SEARCH"] = [[
-- |cFF00FF00Q:|cFFFFFFFF How does the search process work ?|r|r

-- The process will look for all active filters and try to find the items and/or known profession recipes that match those filters. The search will only occur in the locations set under the |cFFFF7F00Seach Location|r icon.

-- |cFF00FF00Q:|cFFFFFFFF Are the filters set only with the top icons ?|r|r

-- No, the categories on the left also act as filters. When you click on a given category, you immediately trigger a search for items matching that category, you can then filter even more by adding a value in the edit box, or filter by rarity for instance. If you only enter text and start a search, you will get all the results whose name contains the value you entered.

-- |cFF00FF00Q:|cFFFFFFFF I am confused by the results I see, what is going on ?|r|r

-- Keep in mind that the results are affected by the filters you have set. Be sure to check the status message to see which filters were taken into account during the search process. 
-- When in doubt, hit the |cFF1CFAFEReset|r button to clear all the filters and try again.

-- |cFF00FF00Q:|cFFFFFFFF Some results are missing, why ?|r|r

-- The results may be affected by the items known by the game client, it may happen that you will have to execute the search a second time to see the proper results. The item information required by the search process is not always available, and by the time it gets back from the server, the search is already over.

-- |cFF00FF00Q:|cFFFFFFFF Sorting by rarity or item level does not seem to work, why ?|r|r

-- Sorting by rarity does work, but in the case of upgradable items, they may have a |cFF0070DDblue|r rarity level and actually be |cFFA335EEepic|r because you own the upgraded version.
-- ]]
