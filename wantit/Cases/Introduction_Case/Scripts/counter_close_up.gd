extends Control

func _ready() -> void:
	var Inventory = GlobalInventory.get_inventory()
	add_child(Inventory)
	
	if CaseManager.CaseGlobals.waffle_collected:
		%Waffle.hide()
