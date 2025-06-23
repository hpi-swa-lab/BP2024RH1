extends Location

func _ready() -> void:
	var new_item = Item.new()
	new_item.item_name = "Salesperson"
	new_item.is_collectable == false
	new_item.item_found.emit(new_item)
