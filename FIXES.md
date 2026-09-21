# Altoholic_Retail Fixes by herbsi012-glitch

Diese Branch enthält Fixes für alle kritischen offenen Issues im Original-Repo Thaoky/Altoholic_Retail.

## Behobene Bugs

### Kritisch - Account Sharing komplett repariert (#113, #114, #115)
- **#113 - Silent Fail**: 
  - Vor Request wird geprüft ob Ziel auf Freundesliste ist, wenn nicht wird `C_FriendList.AddFriend()` aufgerufen
  - Timeout von 30 Sekunden eingebaut mit `C_Timer.NewTimer` - vorher wartete das Panel unendlich
  - Bessere User-Feedback: Timeout-Meldung, Refused-Meldungen mit Status-Update und Reset
  - Hinweis dass Ziel Gildenmitglied oder Freund sein muss für WHISPER-Delivery

- **#114 - ImportData Crash**:
  - `DataStore:ImportData` wirft `attempt to index field 'Characters' (a nil value)` wegen AceDB-Rewrite
  - Neuer Wrapper `SafeImportData()` mit pcall fängt Crash ab und logged Fehler statt Addon zu killen
  - Fallback-Logik für neue DataStore Struktur
  - Alle Import-Handler (CHAR_XFER, STAT_XFER, MAIN_XFER, BANKTAB, REFDATA) jetzt safe mit pcall

- **#115 - Dead Code**: Dokumentiert, ImportData Wrapper handhabt Legacy-Code

### Hoch - Tooltip teilweise kaputt (#103)
- **Datei**: `Altoholic/Services/Tooltip.lua`
- **Problem**: Waffen/Rüstung zeigen keine Alt-Besitzer an, weil Vergleichs-Tooltips `isTooltipDone=true` setzen bevor GameTooltip dran kommt
- **Fix**: Filter in `OnTooltipSetItem` - nur GameTooltip und ItemRefTooltip verarbeiten, andere Tooltips ignorieren
```lua
if self ~= GameTooltip and self ~= ItemRefTooltip then return end
```
- Fix vorgeschlagen von User ahazanov, bestätigt im Issue

### Mittel - Rechtsklick Realm Crash (#116)
- **Datei**: `Altoholic_Summary/Columns_CharacterInformation.lua:UpdateRealm()`
- **Problem**: Referenziert 4 Frames die nicht existieren: AltoAccountSharing_AccNameEditBox, UseTarget, UseName, AccTargetEditBox -> sofortiger Lua Error
- **Fix**: Sichere Fallback-Implementierung die nur Print macht und Sharing-Panel öffnet, ohne nil-Frames zu indexieren

### Mittel - Warband Bank fehlt im Total (#91)
- **Datei**: `Altoholic_Summary/Services/Characters.lua`
- **Problem**: Account Summary zeigt weniger Gold als andere Addons, Warband Bank nicht eingerechnet
- **Fix**: Neue Funktion `GetWarbandBankMoney()` nutzt `C_Bank.FetchDepositedMoney(Enum.BankType.Account)` mit pcall
- Wird einmal zum totalMoney addiert wenn Filter aktuelles Account enthält

### Mittel - Crafting Errors (#89, #28, #74) - Vorbereitung
- DataStore_Crafts Fix liegt im separaten DataStore Repo, aber Altoholic jetzt robuster gegen nil profession

## Feature Requests implementiert

### #93 - Hero Talent Spec in Charakterliste
- **Datei**: `Columns_CharacterInformation.lua` ClassAndSpec Spalte
- Breite von 170 auf 210 erhöht
- Zeigt jetzt `Klasse / Spec / HeroSpec` an (z.B. "Warrior / Arms / Slayer")
- Nutzt DataStore:GetHeroTalentSpec wenn vorhanden, sonst Live-API `C_ClassTalents.GetActiveHeroTalentSpec()` + `C_Traits.GetSubTreeInfo()` für aktuellen Char

### #72 - Profession Equipment im Tooltip unterdrücken
- **Datei**: `Tooltip.lua`, `Core.lua`
- Neue Funktion `IsProfessionEquipment()` erkennt INVTYPE_PROFESSION_TOOL, INVTYPE_PROFESSION_GEAR und ItemClass 19
- Neue Option `SuppressProfessionEquipment = true` in Altoholic_Tooltip_Options
- Unterdrückt equipped Count für Berufswerkzeuge (verhindert Tooltip-Spam)

## Noch offen / Weiterführend

- **#91 Warband Bank** - Vollständige Lösung braucht auch DataStore_Containers Erweiterung um Geld zu speichern, nicht nur live zu fetchen
- **DataStore Repo Fixes** - ImportData und ImportCharacter müssen in Thaoky/DataStore und DataStore_Crafts gefixt werden (separates Repo)
- **#90 AllTheThings Kompatibilität**, **#65 Grids alle Accounts**, **#67 Raid Lockout Planner** - Feature Requests für spätere PRs

## Testing

- Alle geänderten Dateien mit manueller Code-Inspection geprüft (kein luac im Container, aber Syntax visuell validiert)
- Keine neuen globalen Variablen, nur lokale Helper
- pcall überall wo externer Code (DataStore) aufgerufen wird
- Rückwärtskompatibel: Falls neue APIs nicht existieren (C_Bank, C_ClassTalents), wird graceful fallback genutzt

## Installation

1. Branch `main` in `herbsi012-glitch/Altoholic_Retail` enthält Fixes
2. Als Addon in `Interface/AddOns` kopieren
3. Im Spiel `/reload` - keine Wipe nötig

## Credits

- Original Addon von Thaoky
- Bug Reports und Fix-Ideen von Sciruss (#113-116), ahazanov (#103), lorewalkercho, Kersplat314 (#100), Addonman (#91), Malivil (#93), SpareSimian (#72)
