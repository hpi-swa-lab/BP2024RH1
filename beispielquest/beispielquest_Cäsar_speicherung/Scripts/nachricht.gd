extends Node2D

@export var dialogue: String
@export var dialogue_start: String

enum Options {small, large}
@export var size: Options

func _ready() -> void:
	#var new_texture
	#if size == Options.small:
	#	new_texture = preload("res://Assets/Nachricht_klein.png")
	#	$Button.icon = new_texture
	#elif size == Options.large:
	#	new_texture = preload("res://Assets/Nachricht.png")
	#	$Button.icon = new_texture
	if Global.Nachricht_picked == true and Global.had_tutorial == false:
		self.visible = false

func _on_button_pressed() -> void:
	if not Global.Nachricht_picked:
		DialogueManager.show_dialogue_balloon(load("res://dialogues/" + dialogue + ".dialogue"), dialogue_start)
		if dialogue == "Küche":
			Global.items_found += 1
			Global.Nachricht_picked = true
		$Button.visible = false
		$Button.disabled = true
