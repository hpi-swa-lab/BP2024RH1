extends Control

@onready var pic = $QuestionMark
@onready var table = $Gegenstände/Table
@onready var knife = $Gegenstände/Knife
@onready var apple = $Gegenstände/Apple


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pic.visible = false
	load_level_parameters()

# load parameters to know which hint has already been found
func load_level_parameters():
	table.visible = Global.level_parameters.hinweis1
	knife.visible = Global.level_parameters.hinweis2
	apple.visible = Global.level_parameters.hinweis3

func _on_question_timer_timeout() -> void:
	pic.visible = true


func _on_question_mark_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("linksklick"):
		print("emit signal")
		get_tree().change_scene_to_file("res://helpscreen.tscn")


func _on_table_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("linksklick"):
		table.visible = false
		Global.level_parameters.hinweis1 = false
		print(Global.level_parameters.hinweis1)

func _on_knife_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("linksklick"):
		knife.visible = false
		Global.level_parameters.hinweis2 = false

func _on_apple_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("linksklick"):
		apple.visible = false
		Global.level_parameters.hinweis3 = false

	
