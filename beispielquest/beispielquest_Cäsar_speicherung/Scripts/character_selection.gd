extends Control

@onready var scene_switcher_button: Button = $SceneSwitcherButton

func _ready() -> void:
	scene_switcher_button.process_mode = Node.PROCESS_MODE_DISABLED
	scene_switcher_button.visible = false
	
func _on_portrait_pressed() -> void:	
	Global.character_portrait_path = "res://Assets/young_detective.png"
	#print("Character selected")
	GameSaver.save_game()
	scene_switcher_button.process_mode = Node.PROCESS_MODE_INHERIT
	scene_switcher_button.visible = true


func _on_portrait_7_pressed() -> void:
	Global.character_portrait_path = "res://Assets/robot.png"
	GameSaver.save_game()
	scene_switcher_button.process_mode = Node.PROCESS_MODE_INHERIT
	scene_switcher_button.visible = true


func _on_portrait_8_pressed() -> void:
	Global.character_portrait_path = "res://Assets/robot2.png"
	GameSaver.save_game()
	scene_switcher_button.process_mode = Node.PROCESS_MODE_INHERIT
	scene_switcher_button.visible = true


func _on_portrait_2_pressed() -> void:
	Global.character_portrait_path = "res://Assets/boy_detective.png"
	GameSaver.save_game()
	scene_switcher_button.process_mode = Node.PROCESS_MODE_INHERIT
	scene_switcher_button.visible = true


func _on_portrait_3_pressed() -> void:
	Global.character_portrait_path = "res://Assets/female_detective2.png"
	GameSaver.save_game()
	scene_switcher_button.process_mode = Node.PROCESS_MODE_INHERIT
	scene_switcher_button.visible = true


func _on_portrait_4_pressed() -> void:
	Global.character_portrait_path = "res://Assets/female_detective1.png"
	GameSaver.save_game()
	scene_switcher_button.process_mode = Node.PROCESS_MODE_INHERIT
	scene_switcher_button.visible = true


func _on_portrait_5_pressed() -> void:
	Global.character_portrait_path = "res://Assets/old_detective.png"
	GameSaver.save_game()
	scene_switcher_button.process_mode = Node.PROCESS_MODE_INHERIT
	scene_switcher_button.visible = true


func _on_portrait_6_pressed() -> void:
	Global.character_portrait_path = "res://Assets/robot3.png"
	GameSaver.save_game()
	scene_switcher_button.process_mode = Node.PROCESS_MODE_INHERIT
	scene_switcher_button.visible = true
