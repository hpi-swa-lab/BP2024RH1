extends Node2D

@export var colour: ColorRect
@export var animal: Sprite2D
@export var times: Label

func show_dialogue():
	DialogueManager.show_dialogue_balloon(load ("res://dialogue/main.dialogue"), "end_scene")
	
func show_animal():
	animal.position = Vector2(593, 325)
	animal.scale = Vector2(1.5, 1.5)
	colour.color = Color(0.552, 0.973, 0.539) #grün
	if Global.Fun == "ja":
		match Global.Difficult:
			"einfach":
				animal.texture = load("res://Assets/animals/perry.png")
			"mittel":
				animal.texture = load("res://Assets/animals/penguin.png")
			"schwer":
				animal.texture = load("res://Assets/animals/monkey.jpg")
	if Global.Fun == "nein":
		match Global.Difficult:
			"einfach":
				animal.texture = load("res://Assets/animals/whale.jpg")
			"mittel":
				animal.texture = load("res://Assets/animals/elephant.png")
			"schwer":
				animal.texture = load("res://Assets/animals/bear.jpg")
	times.text = GlobalTimer.print_times()
