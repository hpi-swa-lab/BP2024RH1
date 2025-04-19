extends Node2D

var end
var dont = false

func _ready() -> void:
	end = Globals.Ende
	if Globals.optional_route:
		%"Option 1".position = Vector2(-200, 0)
		%"Option 2".position = Vector2(200, 0)
		%"Option 2".visible = true

func _process(_delta: float) -> void:
	if Globals.Ende != end and not dont:
		DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Ende.dialogue"), "start")
		dont = true

func quit():
	get_tree().quit()
