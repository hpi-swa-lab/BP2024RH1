extends Location

@onready var plate: TextureButton = $Plate

func _ready() -> void:
	super._ready()
	case.connect("item_found", check_item)
	update_plate_image(case.get_player_items())

func update_plate_image(player_items: Array):
	if player_items.has("Waffle"):
		plate.texture_normal = load("res://Cases/Introduction_Case/assets/interactable_items/plate_empty.png")

func check_item(item: Item) -> void:
	if item.item_name =="Waffle":
		update_plate_image(case.get_player_items())
