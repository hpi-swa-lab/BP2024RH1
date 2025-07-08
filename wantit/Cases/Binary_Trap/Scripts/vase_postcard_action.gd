extends  Item

var location: Location
	
func _ready() -> void:
	create_overlay()
	
	#for child in get_parent().get_children():
	#	if child is Location:
	#		location.item_found.emit()
	#
	
func create_overlay() -> void:
	var overlay: CanvasLayer = load("res://Cases/Binary_Trap/Scenes/item_overlay.tscn").instantiate()
	overlay.item = self.texture_normal
	
	get_parent().add_child(overlay)
