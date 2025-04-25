extends Control

@onready var button: Button = $Button

func _ready() -> void:
	button.process_mode = Node.PROCESS_MODE_DISABLED
	button.hide()
	
func _on_portrait_pressed() -> void:
	print("Character selected")
	button.process_mode = Node.PROCESS_MODE_INHERIT
	button.show()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/office.tscn")
