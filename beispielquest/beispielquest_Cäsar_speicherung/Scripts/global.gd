extends Node


var portrait: CompressedTexture2D
var character_portrait_path: String = ""
var current_scene_path: String = ""

var case := {
	"dialogues_shown": {},  # "kitchen_intro": true
	"scene_collectables_found": {       # scene_name -> item_name -> picked
		"küche": {
			"Fenster": false,
			"Nachricht": false,
			"Papierkorb": false
		},
		"tatort": {
			"Caesar": false,
			"Businesskarte": false,
			"Bild": false
		}
	},
	"scene_noncollectables_found": {
		"küche": {
			"Papierkorb": false
		},
		"tatort": {
			"Buch": false,
			"Zeitung": false
		}
	},
	"next_scene": "res://Scenes/büro.tscn",
	"scene_flow": {
		"küche": "tatort",
		"tatort": "büro",
		"büro": "restaurant",
		"restaurant": "..."
	}
}


#var last_visited_scene: String = ""

var map_clicked: bool = false
#var items_found: int = 0 
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
#var Buch_picked: bool = false
#var Mikrowelle_picked: bool = false
#var Zeitung_picked: bool = false

var cases := {
	"case_1": { 
		"dialogues_shown": {},  # "kitchen_intro": true
		"scene_collectables_found": {       # scene_name -> item_name -> picked
			"küche": {
				"Fenster": false,
				"Nachricht": false,
				"Papierkorb": false
			},
			"tatort": {
				"Caesar": false,
				"Businesskarte": false,
				"Bild": false
			}
		},
		"scene_noncollectables_found": {
			"küche": {
				"Papierkorb": false
			},
			"tatort": {
				"Buch": false,
				"Zeitung": false
			}
		},
		"next_scene": "res://Scenes/büro.tscn",
		"scene_flow": {
			"küche": "tatort",
			"tatort": "büro",
			"büro": "restaurant",
			"restaurant": "..."
			 },
	"case_2": { 
		"dialogues_shown": {}, 
		"scene_collectables_found":{} }
	}
}
