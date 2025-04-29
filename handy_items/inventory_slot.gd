# Resizable Container for the item slots in the inventory. Logic on what to do when an item is removed needs to be implmented 

extends Panel

var StoredItem: Button = null

func _ready() -> void:
	%Sprite2D.scale = self.custom_minimum_size / %Sprite2D.texture.get_size()

func add_item(Item: Button):
	%CenterContainer.size = self.size
	StoredItem = Item
	%DisplayedItem.icon = update_item_size(Item.icon)
	%DisplayedItem.show()

func remove_item():
	StoredItem = null
	%DisplayedItem.hide()

func update_item_size(Icon: CompressedTexture2D) -> ImageTexture:	#Used to scale Icon Size
	var ItemSize = self.size * 0.8
	var img = Icon.get_image()
	img.resize(ItemSize.x, ItemSize.y, Image.INTERPOLATE_LANCZOS)
	var newIcon = ImageTexture.create_from_image(img)
	return newIcon

func _on_displayed_item_pressed() -> void:
	remove_item()
	print("Now do summin cool") # Should be changed once its clear which kinds of tasked should be done
