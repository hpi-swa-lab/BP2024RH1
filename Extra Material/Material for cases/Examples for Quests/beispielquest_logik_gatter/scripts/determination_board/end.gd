extends Node2D

@export var colour: ColorRect
@export var animal: Sprite2D

func _ready() -> void:
	GlobalTimer.end_timer("Logik Gatter Full Game")
	DialogueManager.show_dialogue_balloon(load("res://dialogue/logik_gatter.dialogue"), "end_scene")
	
func show_animal():
	animal.position = Vector2(593, 325)
	animal.scale = Vector2(1.5, 1.5)
	colour.color = Color(0.961, 0.741, 0.0) #gelborange
	if Global.Fun == "ja":
		match Global.Difficult:
			"einfach":
				animal.texture = load("res://assets/animals/perry.jpg")
			"mittel":
				animal.texture = load("res://assets/animals/penguin.jpg")
			"schwer":
				animal.texture = load("res://assets/animals/monkey.jpg")
	if Global.Fun == "nein":
		match Global.Difficult:
			"einfach":
				animal.texture = load("res://assets/animals/whale.jpg")
			"mittel":
				animal.texture = load("res://assets/animals/elephant.jpg")
			"schwer":
				animal.texture = load("res://assets/animals/bear.jpg")
	$Label.text = GlobalTimer.print_times()
