extends Control

@onready var flour_sack: TextureButton = $"Flour Sack"
@onready var key: TextureButton = $Key

func _ready() -> void:
	var Inventory = GlobalInventory.get_inventory()
	add_child(Inventory)
	
	if not GlobalTimer.timer_active("flour"):
		GlobalTimer.start_timer("flour")
		
	if not GlobalTimer.timer_active("shoeprints_bakery"):
		GlobalTimer.start_timer("shoeprints_bakery")
	
	if CaseManager.clues_completed:
		DialogueManager.show_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "found_hints")
	
	if CaseManager.CaseGlobals.flour_sack_inspected:
		disable_floursack()
	
	if CaseManager.CaseGlobals.key_collected:
		key.disabled = true
		key.hide()
	
func _on_flour_sack_pressed() -> void:
	disable_floursack()
	%Key.show()
	
func disable_floursack() -> void:
	flour_sack.disabled = true
	flour_sack.z_index = 0
