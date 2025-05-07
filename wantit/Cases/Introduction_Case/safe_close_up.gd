extends Control

@onready var pliers: TextureButton = $Pliers
@onready var screwdriver: TextureButton = $Screwdriver
@onready var fingerprints: TextureButton = $Fingerprints

func _ready() -> void:
	if State.pliers_collected:
		pliers.disabled = true
		pliers.hide()
	
	if State.screwdriver_collected:
		screwdriver.disabled = true
		screwdriver.hide()
		
	if State.fingerprints_saved:
		fingerprints.disabled = true
