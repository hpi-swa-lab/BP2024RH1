extends Control

@onready var plate: TextureButton = $Plate

func _ready() -> void:
	GlobalInventory.get_inventory()
	
	if State.showroom_intro_shown == false:
		DialogueManager.show_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "crime_scene")
		State.showroom_intro_shown = true
	
	if State.waffle_collected:
		plate.texture_normal = load("res://Cases/Introduction_Case/assets/interactable_items/plate_empty.png")
