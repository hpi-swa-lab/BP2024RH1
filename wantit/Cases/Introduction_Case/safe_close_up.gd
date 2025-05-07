extends Control

@onready var pliers: TextureButton = $Pliers
@onready var screwdriver: TextureButton = $Screwdriver

func _ready() -> void:
	if State.pliers_collected:
		pliers.disabled = true
		pliers.hide()
	
	if State.screwdriver_collected:
		screwdriver.disabled = true
		screwdriver.hide()
