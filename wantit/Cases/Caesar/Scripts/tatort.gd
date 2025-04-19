extends Node2D

var dialogue = "Tatort"

func _ready() -> void:
	if Globals.CrimeScene_visited == false:
		DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Tatort.dialogue"), "start")
	if Globals.Caesar_picked == true:
		disable("Caesar")
	if Globals.Businesskarte_picked == true:
		disable("Businesskarte")
	if Globals.Bild_picked == true:
		disable("Bild")
	
func go_back() -> void:
	Globals.OfficeDialogueStart = "Teil2"
	CaseManager.new_Location(preload("res://Assets/library.png"), Vector2(0.1, 0.1), Vector2(130, 100), preload("res://Cases/Caesar/Scenes/restaurant.tscn"))
	SceneSwitcher.switch_scene("res://Scenes/office.tscn")

func _on_button_pressed() -> void:
	DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Tatort.dialogue"), "zurueck") 
	# hier wird ein normaler Button statt dem ScenSwitcherButton benutzt, wegen dem Dialog. Da war ich zu faul das zu ändern

#func _on_tür_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
#	if event is InputEventMouseButton:
#		SceneSwitcher.switch_scene("res://Scenes/küche.tscn")

func disable(NodeName):
	var path_to_button = "%" + NodeName
	var button = get_node(path_to_button)
	if button and button is Button:
		button.visible = false
		button.disabled = true
	else:
		print("The path is probably wrong:", path_to_button)
