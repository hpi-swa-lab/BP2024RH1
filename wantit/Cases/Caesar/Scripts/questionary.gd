extends Node2D

@export var colour: ColorRect
@export var animal: Sprite2D
@export var times: Label

func _ready() -> void:
	DialogueManager.show_example_dialogue_balloon(load ("res://Cases/Caesar/dialogues/Questionary.dialogue"), "questionary")
	
func show_animal():
	animal.position = Vector2(593, 325)
	animal.scale = Vector2(1.5, 1.5)
	colour.color = Color(0.35, 0.606, 0.947) #blau
	if Globals.CaseGlobals.fun == "ja":
		match Globals.CaseGlobals.difficulty:
			"einfach":
				animal.texture = load("res://Assets/animals/perry.png")
			"mittel":
				animal.texture = load("res://Assets/animals/penguin.png")
			"schwer":
				animal.texture = load("res://Assets/animals/monkey.jpg")
	if Globals.CaseGlobals.fun == "nein":
		match Globals.CaseGlobals.difficulty:
			"einfach":
				animal.texture = load("res://Assets/animals/whale.jpg")
			"mittel":
				animal.texture = load("res://Assets/animals/elephant.png")
			"schwer":
				animal.texture = load("res://Assets/animals/bear.jpg")
	times.text = GlobalTimer.print_times()
