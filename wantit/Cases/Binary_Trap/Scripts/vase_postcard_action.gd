extends  Item

var extended_item: Item

func _ready() -> void:
	super._ready()
	create_overlay()
	
func create_overlay() -> void:
	var overlay: CanvasLayer = load("res://Cases/Binary_Trap/Scenes/item_overlay.tscn").instantiate()
	overlay.new_texture = extended_item.closeup_texture
	get_parent().add_child(overlay)
	await get_tree().process_frame
	
	call_deferred("return_to_inventory")

func return_to_inventory() -> void:
	for child in get_parent().get_children():
		if child is Location:
			print("CHild is Location!!", child, extended_item)
			child.item_found.emit(extended_item, child)
