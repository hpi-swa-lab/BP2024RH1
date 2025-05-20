extends Control

func _ready() -> void:
	var Inventory = GlobalInventory.get_inventory()
	add_child(Inventory)
	
	GlobalTimer.add_log_entry("entered scene: bakery_office")
	
	if not GlobalTimer.timer_active("safe"):
		GlobalTimer.start_timer("safe")

	if not GlobalTimer.timer_active("shoeprints_office"):
		GlobalTimer.start_timer("shoeprints_office")
