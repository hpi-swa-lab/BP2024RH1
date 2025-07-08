extends  Item

var extended_item: Item
	
func _ready() -> void:
	create_overlay()
	
func create_overlay() -> void:
	var overlay: CanvasLayer = load("res://Cases/Binary_Trap/Scenes/item_overlay.tscn").instantiate()
	overlay.item = self.texture_normal
	
	get_parent().add_child(overlay)

	#for child in get_parent().get_children():
	#	if child is Location:
	#		print("CHild is Location!!", child, extended_item)
	#		child.item_found.emit(extended_item, child)
