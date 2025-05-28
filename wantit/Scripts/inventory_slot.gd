extends Panel

class_name InventorySlot

var stored_item: Clue = null
var ActionScript: Node

func _ready() -> void:
	%Sprite2D.scale = self.custom_minimum_size / %Sprite2D.texture.get_size()

func add_item(new_item: Clue) -> void:
	#%CenterContainer.size = self.size
	
	stored_item = new_item
	print("Item just added to inventory: " + str(stored_item.clue_name))
	
	#if new_item.ActionScript != null:
		#ActionScript = new_item.ActionScript.new()
	#%DisplayedItem.icon = update_item_size(new_item.texture_normal)
	#%DisplayedItem.show()

func remove_item():
	if ActionScript != null and ActionScript is Node:
		if not ActionScript.is_inside_tree():
			get_tree().root.add_child(ActionScript)
		await get_tree().process_frame
		if ActionScript.has_method("do_smt"):
			ActionScript.do_smt(stored_item)
	
	#var parent = get_parent()
	#parent.inventory_items.erase(stored_item.name)
	GlobalInventory.Items.erase(stored_item.name)
	ActionScript = null
	stored_item = null
	%DisplayedItem.hide()

func update_item_size(Icon: CompressedTexture2D) -> ImageTexture:	#Used to scale Icon Size
	
	if GlobalInventory.TextureCache.has(stored_item.name):
		return GlobalInventory.TextureCache[stored_item.name]
	else:
		var ItemSize = self.size * 0.8
		var img = Icon.get_image()
		
		img.resize(ItemSize.x, ItemSize.y, Image.INTERPOLATE_LANCZOS)
		var newIcon = ImageTexture.create_from_image(img)
		
		GlobalInventory.TextureCache[stored_item.name] = newIcon
		return newIcon

func _on_displayed_item_button_down() -> void:
	%DisplayedItem.pivot_offset = %DisplayedItem.size / 2
	if ActionScript != null:
		remove_item()
	else:
		%AnimationPlayer.play("remove_item")

func is_empty() -> bool:
	if stored_item == null:
		return true
	return false
