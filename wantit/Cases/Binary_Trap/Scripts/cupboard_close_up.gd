extends Location

func _ready() -> void:
	super._ready()
	
#func _enter_tree() -> void:
#	await get_tree().process_frame
#	if is_item_in_inventory("Vase"):
#		%Vase.hide()

#func is_item_in_inventory(item: String) -> bool:
#	for slot in inventory.inventory_slots:
#		if slot.stored_item.item_name == item:
#			return true
#	return false
