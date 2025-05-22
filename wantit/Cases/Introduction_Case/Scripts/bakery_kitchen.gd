extends Control
#extends Location

@onready var flour_sack: TextureButton = $"Flour Sack"
@onready var key: TextureButton = $Key

func _ready() -> void:
	
	#all this code is mainly about showing closing dialog after all clues are found, 
	#but I guess it's responsibility of a case to open in when all case clues are found
	#Do we need then this script at all?
	add_child(Inventory)
	
	if CaseManager.clues_completed:
		DialogueManager.show_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "found_hints")
	
	if case.interactions.has("flour_sack_clicked"): #this could be taken to location class
		disable_floursack()
	
	if case.inventory.has("key"): #same
		key.disabled = true
		key.hide()
	
func _on_flour_sack_pressed() -> void:
	disable_floursack()
	%Key.show()
	
func disable_floursack() -> void:
	flour_sack.disabled = true
	flour_sack.z_index = 0
