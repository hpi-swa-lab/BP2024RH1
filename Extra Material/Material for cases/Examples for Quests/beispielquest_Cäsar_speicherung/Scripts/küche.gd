extends Node2D

func _ready() -> void:
	Global.last_visited_scene = "res://Scenes/küche.tscn"
	GameSaver.save_game()
	
	if Global.Papierkorb_picked == true:
		disable("Papierkorb")
		GameSaver.save_game()

func _on_fenster_abdrücke_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and Global.Fenster_picked == false:
		Global.items_found += 1
		Global.Fenster_picked = true
		DialogueManager.show_dialogue_balloon(load("res://dialogues/Küche.dialogue"), "Fenster")

func disable(NodeName):
	var path_to_button = "%" + NodeName
	var button = get_node(path_to_button)
	if button and button is Button:
		button.visible = false
		button.disabled = true
	else:
		print("The path is probably wrong:", path_to_button)


func _on_papierkorb_pressed() -> void:
	Global.Papierkorb_picked = true
	disable("Papierkorb")
	GameSaver.save_game()
