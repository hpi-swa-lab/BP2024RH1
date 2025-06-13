extends Location

@onready var plate: TextureButton = $Plate
@onready var helpsystem_timer = $Helpsystem/Question_mark/Timer

func _ready() -> void:
	super._ready()
	#update_plate_image()

func update_plate_image(player_items: Array):
	if player_items.has("Waffle"):
		plate.texture_normal = load("res://Cases/Introduction_Case/assets/interactable_items/plate_empty.png")
