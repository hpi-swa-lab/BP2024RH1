extends Control

@onready var plate: TextureButton = $Plate
@onready var helpsystem_timer = $Helpsystem/Question_mark/Timer

func _ready() -> void:
	if State.showroom_intro_shown == false:
		
		# pause timer of helpsystem until the first dialog is finished
		helpsystem_timer.paused = true
		print(helpsystem_timer.paused)
		
		DialogueManager.show_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "crime_scene")
		
		await DialogueManager.dialogue_ended
		State.showroom_intro_shown = true
		helpsystem_timer.paused = false
		print(helpsystem_timer.paused)
	
	var Inventory = GlobalInventory.get_inventory()
	Inventory.position = Vector2(908, 0)
	add_child(Inventory)
	
	if CaseManager.CaseGlobals.showroom_intro_shown == false:
		DialogueManager.show_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "crime_scene")
		CaseManager.CaseGlobals.showroom_intro_shown = true
	
	if CaseManager.CaseGlobals.waffle_collected:
		plate.texture_normal = load("res://Cases/Introduction_Case/assets/interactable_items/plate_empty.png")
