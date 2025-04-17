extends Control

@onready var pic = $QuestionMark
@onready var chair = $Gegenstände/Chair
@onready var spoon = $Gegenstände/Spoon
@onready var banana = $Gegenstände/Banana


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pic.visible = false
	load_level_parameters()

func load_level_parameters():
	chair.visible = Global.level_parameters.hinweis1
	spoon.visible = Global.level_parameters.hinweis2
	banana.visible = Global.level_parameters.hinweis3



func _on_question_mark_gui_input(event: InputEvent) -> void:
		# emit signal to scene switcher mit level parameters - emit_signal("change_to_helpscreen",)
	if event.is_action_pressed("linksklick"):
		print("emit signal")
		get_tree().change_scene_to_file("res://helpscreen.tscn")

	
func _on_question_timer_timeout() -> void:
	pic.visible = true


func _on_chair_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("linksklick"):
		chair.visible = false
		Global.level_parameters.hinweis1 = false
		print(Global.level_parameters.hinweis1)


func _on_spoon_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("linksklick"):
		spoon.visible = false
		Global.level_parameters.hinweis2 = false


func _on_banana_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("linksklick"):
		banana.visible = false
		Global.level_parameters.hinweis3 = false
