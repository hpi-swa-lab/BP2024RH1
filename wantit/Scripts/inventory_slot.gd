extends Panel
class_name InventorySlot

var stored_item: Item = null
var action_script: Node

func _ready() -> void:
	%Sprite2D.scale = self.custom_minimum_size / %Sprite2D.texture.get_size()

func add_item(new_item: Item) -> void:
	%CenterContainer.size = self.size
	
	stored_item = new_item
	#print("Item just added to inventory: " + str(stored_item.item_name))
	
	if new_item.action_script != null:
		action_script = new_item.action_script.new()
	%DisplayedItem.icon = update_item_size(new_item.texture_normal)
	%DisplayedItem.show()

func remove_item():
	if action_script != null and action_script is Node:
		if "extended_item" in action_script:
			action_script.extended_item = stored_item
		if not action_script.is_inside_tree():
			get_tree().root.get_child(2).add_child(action_script)	#root.get_child(2) is game
	#
	#var parent = get_parent()
	#parent.inventory_items.erase(stored_item.name)
	#action_script = null
	stored_item = null
	%DisplayedItem.hide()

func update_item_size(Icon: CompressedTexture2D) -> ImageTexture:	#Used to scale Icon Size
	var ItemSize = self.size * 0.8
	var img = Icon.get_image()
	
	img.resize(ItemSize.x, ItemSize.y, Image.INTERPOLATE_LANCZOS)
	var newIcon = ImageTexture.create_from_image(img)
	return newIcon

func _on_displayed_item_button_down() -> void:
	%DisplayedItem.pivot_offset = %DisplayedItem.size / 2
	if action_script != null:
		remove_item()
	else:
		%AnimationPlayer.play("remove_item")

func is_empty() -> bool:
	if stored_item == null:
		return true
	return false
