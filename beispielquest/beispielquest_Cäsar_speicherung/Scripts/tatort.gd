extends Node2D

var dialogue = "Tatort"

func _ready() -> void:
	Global.last_visited_scene = "res://Scenes/tatort.tscn"
	GameSaver.save_game()
	
	if Global.CrimeScene_visited == false:
		DialogueManager.show_dialogue_balloon(load("res://dialogues/Tatort.dialogue"), "start")
	if Global.Caesar_picked == true:
		disable("Caesar")
		GameSaver.save_game()
	if Global.Businesskarte_picked == true:
		disable("Businesskarte")
		GameSaver.save_game()
	if Global.Bild_picked == true:
		disable("Bild")
		GameSaver.save_game()

	
func go_back() -> void:
	SceneSwitcher.switch_scene("res://Scenes/büro.tscn")

func _on_button_pressed() -> void:
	DialogueManager.show_dialogue_balloon(load("res://dialogues/Tatort.dialogue"), "zurueck") 
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


func _on_caesar_pressed() -> void:
	Global.Caesar_picked = true
	disable("Caesar")
	GameSaver.save_game()


func _on_businesskarte_pressed() -> void:
	Global.Businesskarte_picked = true
	disable("Businesskarte")
	GameSaver.save_game()


func _on_bild_pressed() -> void:
	Global.Bild_picked = true
	disable("Bild")
	GameSaver.save_game()
