extends Control

@onready var slots: Array = %GridContainer.get_children()
var opened: bool = false
	
func add_item(Item: Button):
	for slot in slots:
		if slot.StoredItem == null:
			slot.add_item(Item)
			break
	
func open():
	self.show()

func _on_button_pressed() -> void:
	self.hide()
