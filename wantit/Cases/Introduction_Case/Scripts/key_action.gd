extends Node

var dragging: bool
var newItem: Button
var oldItem: TextureButton

func do_smt(Item: TextureButton):
	oldItem = Item
	
	var button = Button.new()
	button.icon= Item.texture_normal
	button.scale = Item.scale
	
	button.button_down.connect(item_down)
	button.button_up.connect(item_up)
	button.global_position = get_viewport().get_mouse_position() - button.icon.get_size() / 2 * button.scale
	
	newItem = button
	
	get_tree().root.add_child(newItem)

func item_down():
	print("test")
	dragging = true
	set_process_input(true)

func item_up():
	if dragging:
		print("well")
		GlobalInventory.add_item(oldItem)
		newItem.queue_free()
		queue_free()

func _input(event: InputEvent) -> void:
	if dragging:
		if event is InputEventMouseMotion:
			newItem.position = event.position - newItem.icon.get_size() / 2 * newItem.scale
