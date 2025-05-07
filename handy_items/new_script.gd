extends Node

var dragging: bool
var newItem: Button
var oldItem: Button

func do_smt(Item: Button):
	oldItem = Item
	
	var button = Button.new()
	button.icon = Item.icon
	button.scale = Item.scale
	
	button.button_down.connect(item_down)
	button.button_up.connect(item_up)
	
	newItem = button
	
	get_tree().root.add_child(newItem)
	
	await get_tree().process_frame
	button.position = get_viewport().get_mouse_position() - button.size / 2

func item_down():
	print(newItem)
	dragging = true
	set_process_input(true)

func item_up():
	GlobalInventory.add_item(oldItem)
	get_tree().root.remove_child(newItem)
	queue_free()

func _input(event: InputEvent) -> void:
	if dragging:
		if event is InputEventMouseMotion:
			newItem.global_position = event.position - newItem.size / 2
