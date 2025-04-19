extends Node

var nextScene: CaseManager.Location
var selectedCase: CaseManager.Case

var OfficeDialogue: String		# Could be changed to dialogue path type if found out what it is
var OfficeDialogueStart: String

# Temporary because of the Cäsar Case
var portrait: CompressedTexture2D

var map_clicked: bool = false
var items_found: int = 0 # Could be resolved by combinig Küche and tatort into one scene

# tbd dont like it
var CrimeScene_visited: bool = false
var verschiebung_found: bool = false
var schluesselwort_found: bool = false
var secret_message_found: bool = false

var had_tutorial: bool = false
var caesar_decrypted: bool = false
var culprit_found: bool = false

var optional_route: bool = false
var Ende: int

# decorative items - Im pretty sure that can be fixed too if not use old idea of Global for items
var Buch_picked: bool = false
var Mikrowelle_picked: bool = false
var Zeitung_picked: bool = false

# Wichtige Items
var Fenster_picked: bool = false
var Caesar_picked: bool = false
var Bild_picked: bool = false
var Nachricht_picked: bool = false
var Papierkorb_picked: bool = false
var Businesskarte_picked: bool = false
