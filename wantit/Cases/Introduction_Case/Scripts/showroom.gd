extends Control

@onready var plate: TextureButton = $Plate
@onready var helpsystem_timer = $Helpsystem/Question_mark/Timer

func _ready() -> void:
	var Inventory = GlobalInventory.get_inventory()
	add_child(Inventory)
	GlobalTimer.add_log_entry("entered scene: showroom")
	
	if CaseManager.CaseGlobals.showroom_intro_shown == false:
		helpsystem_timer.paused = true
		CaseManager.CaseGlobals.showroom_intro_shown = true
		DialogueManager.show_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "crime_scene")
	
		await DialogueManager.dialogue_ended
		helpsystem_timer.paused = false
	
	if not GlobalTimer.timer_active("waffle"):
		GlobalTimer.start_timer("waffle")
	
	if CaseManager.CaseGlobals.waffle_collected:
		plate.texture_normal = load("res://Cases/Introduction_Case/assets/interactable_items/plate_empty.png")
