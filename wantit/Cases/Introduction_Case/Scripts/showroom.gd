extends Control

@onready var plate: TextureButton = $Plate

func _ready() -> void:
	var Inventory = GlobalInventory.get_inventory()
	Inventory.position = Vector2(908, 0)
	add_child(Inventory)
	
	if CaseManager.CaseGlobals.showroom_intro_shown == false:
		DialogueManager.show_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "crime_scene")
		CaseManager.CaseGlobals.showroom_intro_shown = true
	
	if CaseManager.CaseGlobals.waffle_collected:
		plate.texture_normal = load("res://Cases/Introduction_Case/assets/interactable_items/plate_empty.png")
