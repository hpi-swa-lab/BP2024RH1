extends Control

@onready var plate: TextureButton = $Plate

func _ready() -> void:
	if State.waffle_collected:
		plate.texture_normal = load("res://Cases/Introduction_Case/assets/interactable_items/plate_empty.png")
