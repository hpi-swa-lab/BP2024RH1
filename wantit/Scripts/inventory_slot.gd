extends Panel

var StoredItem: TextureButton = null
var ActionScript: Node

func _ready() -> void:
	%Sprite2D.scale = self.custom_minimum_size / %Sprite2D.texture.get_size()

func add_item(Item: TextureButton):
	%CenterContainer.size = self.size
	StoredItem = Item
	if Item.ActionScript != null:
		ActionScript = Item.ActionScript.new()
	%DisplayedItem.icon = update_item_size(Item.texture_normal)
	%DisplayedItem.show()

func remove_item():
	if ActionScript != null and ActionScript is Node:
		if not ActionScript.is_inside_tree():
			get_tree().root.add_child(ActionScript)
		await get_tree().process_frame
		if ActionScript.has_method("do_smt"):
			ActionScript.do_smt(StoredItem)
	
	GlobalInventory.Items.erase(StoredItem.name)
	ActionScript = null
	StoredItem = null
	%DisplayedItem.hide()

func update_item_size(Icon: CompressedTexture2D) -> ImageTexture:	#Used to scale Icon Size
	
	if GlobalInventory.TextureCache.has(StoredItem.name):
		return GlobalInventory.TextureCache[StoredItem.name]
	else:
		var ItemSize = self.size * 0.8
		var img = Icon.get_image()
		
		img.resize(ItemSize.x, ItemSize.y, Image.INTERPOLATE_LANCZOS)
		var newIcon = ImageTexture.create_from_image(img)
		
		GlobalInventory.TextureCache[StoredItem.name] = newIcon
		return newIcon

func _on_displayed_item_button_down() -> void:
	%DisplayedItem.pivot_offset = %DisplayedItem.size / 2
	if ActionScript != null:
		remove_item()
	else:
		%AnimationPlayer.play("remove_item")
