extends Control

@onready var screwdriver: TextureButton = $Screwdriver
@onready var pliers: TextureButton = $Pliers

func _ready() -> void:
	if State.pliers_collected:
		hide_item(pliers)
		
	if State.screwdriver_collected:
		hide_item(screwdriver)

func hide_item(item: TextureButton) -> void:
	item.disabled = true
	item.hide()
