extends Panel

var StoredItem: Button = null
var ItemSize = Vector2(200, 200)

func add_item(Item: Button):
	StoredItem = Item
	%DisplayedItem.icon = update_item_size(Item.icon)

func remove_item():
	if StoredItem != null:
		StoredItem = null
		%DisplayedItem.hide()

func update_item_size(Icon: CompressedTexture2D) -> ImageTexture:	#Used to scale Icon Size
	var img = Icon.get_image()
	img.resize(ItemSize.x, ItemSize.y, Image.INTERPOLATE_LANCZOS)
	var newIcon = ImageTexture.create_from_image(img)
	return newIcon

func _on_displayed_item_pressed() -> void:
	remove_item()
	print("Now do summin cool") # Should be changed once its clear which kinds of tasked should be done
