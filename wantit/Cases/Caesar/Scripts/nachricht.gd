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
	if Globals.Nachricht_picked == true and Globals.had_tutorial == false:
		self.visible = false

func _on_button_pressed() -> void:
	if not Globals.Nachricht_picked:
		DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/" + dialogue + ".dialogue"), dialogue_start)
		if dialogue == "Küche":
			Globals.items_found += 1
			Globals.Nachricht_picked = true
		$Button.visible = false
		$Button.disabled = true
