local L = LibStub("AceLocale-3.0"):NewLocale( "Altoholic", "frFR" )

if not L then return end

L["TAB_SUMMARY"] = "Résumé"
L["TAB_CHARACTERS"] = "Personnages"
L["TAB_AGENDA"] = "Agenda"
L["TAB_GRIDS"] = "Grilles"
 
L["Shows the UI"] = "Affiche l'interface"
L["Hides the UI"] = "Cache l'interface"
L["Toggles the UI"] = "Inverse l'état de l'interface"
L["Search in bags"] = "Recherche dans les sacs"

L["Left-click to %sopen"] = "Clic-gauche pour %s0ouvrir"
L["Right-click to %sdrag"] = "Clic-droit pour %sdéplacer"

L["NEW_VERSION_AVAILABLE"] = "A new version of Altoholic is available, consider upgrading to get the latest features."
L["OFFICIAL_SOURCES"] = "Official sources : Curseforge & WoW Interface"

L["%s%s|r has requested the bank tab %s%s|r\nSend this information ?"] = [[%s%s|r désire l'onglet de banque %s%s|r
Envoyer ces informations ?]]
L["%sWarning:|r make sure this user may view this information before accepting"] = "%sAttention :|r Vérifiez que ce joueur a le droit de voir ces informations avant d'accepter"
L["%s|r has received a mail from %s"] = "%s|r a reçu un courrier de %s"
L["AUCTION_HOUSE_NOT_VISITED_WARNING"] = "Les enchères n'ont pas été vérifiées sur %s|r depuis %d jours, vérifiez l'hôtel des ventes et votre boîte aux lettres !"

L["Mail is about to expire on at least one character."] = "Du courrier va bientôt expirer sur au moins un personnage."
L["Refer to the activity pane for more details."] = "Référez-vous à l'onglet Activité pour plus de détails."
L["Do you want to view it now ?"] = "Voulez-vous le voir maintenant ?"



-- ** Services / Account Sharing **
L["Sending table of content to %s (%d items)"] = "Envoi de la table des matières à %s (%d objets)"
L["%sTransferring item %s%d|r/%s%d|r"] = "%sTransfert de l'objet %s%d|r/%s%d|r"

L["Account sharing request received from %s"] = "Demande de partage de compte reçue de %s"
L["You have received an account sharing request\nfrom %s%s|r, accept it?"] = [[Vous avez reçu une demande de partage de compte
de la part de %s%s|r. Accepter ?]]
L["%sWarning:|r if you accept, %sALL|r information known\nby Altoholic will be sent to %s%s|r (bags, money, etc..)"] = "%sAttention :|r si vous acceptez, %sTOUTES|r les informations connues d'Altoholic seront envoyées à %s%s|r (sacs, argent, etc.)"
L["Request rejected by %s"] = "Demande rejetée par %s"
L["%s is in combat, request cancelled"] = "%s est en combat, demande annulée"
L["%s has disabled account sharing"] = "%s a désactivé le partage de compte"
L["Reference data received (%s) !"] = "Données de référence reçues (%s) !"
L["Sending account sharing request to %s"] = "Envoi de la demande de partage de compte à %s"
L["Getting table of content from %s"] = "Réception de la table des matières de %s"
L["Talent Tree Reference"] = "Référence des arbres de talent"

L["SHARING_TRANSFER_OK"] = "Transfert terminé avec succès !"
L["SHARING_TRANSFER_CANCELLED"] = "Le transfert a été annulé, aucune donnée n'a été importée."
L["SHARING_TOC_RECEIVED"] = "|cFFFFFFFFTable des matières reçue (|r|cFF00FF00%d|r |cFFFFFFFFobjets)|r"
L["SHARING_OPTION_DISABLED"] = "Vous devez d'abord activer le partage de compte !"
L["SHARING_INVALID_TARGET"] = "Vous devez sélectionner une cible, ou entrer le nom du personnage qui recevra la demande de partage"

-- ** Services / Shared Content **
L["Containers"] = "Conteneurs"
L["Equipment"] = "Equipement"
L["Mails"] = "Courrier"
L["Quests"] = "Quêtes"
L["Reputations"] = "Réputations"

-- ** Services / Events **

L["%s is now ready (%s on %s)"] = "%s est maintenant prêt (%s sur %s)"
L["%s is now unlocked (%s on %s)"] = "%s est maintenant accessible (%s sur %s)"
L["%s starts in %d minutes (%s on %s)"] = "%s débute dans %d minutes (%s sur %s)"
L["%s will be ready in %d minutes (%s on %s)"] = "%s sera prêt dans %d minutes (%s sur %s)"
L["%s will be unlocked in %d minutes (%s on %s)"] = "%s sera disponible dans %d minutes (%s sur %s)"
L["Do you want to open Altoholic's calendar for details ?"] = "Voulez-vous ouvrir le calendrier d'Altoholic pour plus de détails ?"


-- ** Services / Tooltip **

L["Transmute"] = true
L["Bags"] = "Sacs"
L["Bank"] = "Banque"
L["AH"] = "HV"
L["Mail"] = "Courrier"
L["Equipped"] = "Equipé"
L["Already known by"] = "Déjà connu par"
L["Could be learned by"] = "Pourrait être appris par"
L["Will be learnable by"] = "Pourra être appris par"
L["Total owned"] = "Total possédé"
L["Source"] = true
L["Goes in"] = "Va dans"
L["Are also on this quest:"] = "Sont également sur cette quête :"
-- L["Could be stored on"] = true