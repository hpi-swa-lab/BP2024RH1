extends Node2D


func start_scene() -> void:	
	Global.map_clicked = false
	%NextButton.visible = false
	%CloseMapButton.visible = false
	if Global.office_szene == 0:
		DialogueManager.show_dialogue_balloon(load("res://dialogues/Büro_1.dialogue"), "start")
		%NextButton.position = Vector2(200, -125)
	elif Global.office_szene == 1:
		DialogueManager.show_dialogue_balloon(load("res://dialogues/Büro_1.dialogue"), "Teil2")
	elif Global.office_szene == 2:
		DialogueManager.show_dialogue_balloon(load("res://dialogues/Büro_1.dialogue"), "Teil3")
	elif Global.office_szene == 3:
		%NextButton.NextSceneString = "restaurant"
		%NextButton.position = Vector2(-200, 75)
		DialogueManager.show_dialogue_balloon(load("res://dialogues/Büro_1.dialogue"), "Teil4")
	elif Global.office_szene == 4:
		#if Global.secret_message_found:
		#	%Geheim.visible = true
		Global.caesar_decrypted = false
		DialogueManager.show_dialogue_balloon(load("res://dialogues/Büro_1.dialogue"), "Teil5")

func _process(_delta: float) -> void:
	if Global.secret_message_found:
		%Geheim.show()
		
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		Global.map_clicked = true
		%CloseMapButton.visible = true
		%CloseMapButton.disabled = false
		%NextButton.visible = true
		%NextButton.disabled = false

func _on_close_map_button_pressed() -> void:
	Global.map_clicked = false
	%CloseMapButton.visible = false
	%CloseMapButton.disabled = true
	%NextButton.visible = false
	%NextButton.disabled = true

func load_tutorial() -> void:
	SceneSwitcher.switch_to_scene("res://Scenes/tutorial.tscn")

func load_minigame() -> void:
	SceneSwitcher.switch_to_scene("res://Scenes/decrypting_caesar.tscn")

func load_second_game() -> void:
	SceneSwitcher.switch_to_scene("res://Scenes/Cäsars_big_brother.tscn")

func load_end():
	SceneSwitcher.switch_to_scene("res://Scenes/ende.tscn")
