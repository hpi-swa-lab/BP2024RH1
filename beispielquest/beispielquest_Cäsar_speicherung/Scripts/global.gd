extends Node

var portrait: CompressedTexture2D
var character_portrait_path: String = ""

var last_visited_scene: String = ""

var map_clicked: bool = false
var items_found: int = 0 
var CrimeScene_visited: bool = false
#var Restaurant_visited: bool = false

var verschiebung_found: bool = false
var schluesselwort_found: bool = false
var secret_message_found: bool = false

var had_tutorial: bool = false
var caesar_decrypted: bool = false
var culprit_found: bool = false
var office_szene: int = 0

var optional_route: bool = false
var Ende: int

# decorative items
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
