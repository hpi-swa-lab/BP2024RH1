extends Control

func _ready() -> void:
	var Inventory = GlobalInventory.get_inventory()
	add_child(Inventory)
	GlobalTimer.end_timer("safe")
	
	if not GlobalTimer.timer_active("pliers"):
		GlobalTimer.start_timer("pliers")
		
	if not GlobalTimer.timer_active("screwdriver"):
		GlobalTimer.start_timer("screwdriver")
		
	if not GlobalTimer.timer_active("fingerprints"):
		GlobalTimer.start_timer("fingerprints")
