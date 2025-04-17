extends Control

@onready var pic = $QuestionMark
@onready var desktop = $Gegenstände/Desktop
@onready var chopsticks = $Gegenstände/Chopsticks


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pic.visible = false
	load_level_parameters()

func load_level_parameters():
	desktop.visible = Global.level_parameters.hinweis1
	chopsticks.visible = Global.level_parameters.hinweis2



func _on_question_mark_gui_input(event: InputEvent) -> void:
		# emit signal to scene switcher mit level parameters - emit_signal("change_to_helpscreen",)
	if event.is_action_pressed("linksklick"):
		print("emit signal")
		get_tree().change_scene_to_file("res://helpscreen.tscn")

	
func _on_question_timer_timeout() -> void:
	pic.visible = true



func _on_desktop_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("linksklick"):
		desktop.visible = false
		Global.level_parameters.hinweis1 = false
		print(Global.level_parameters.hinweis1)


func _on_chopsticks_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("linksklick"):
		chopsticks.visible = false
		Global.level_parameters.hinweis2 = false
