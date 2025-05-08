extends Control

@onready var pliers: TextureButton = $Pliers
@onready var screwdriver: TextureButton = $Screwdriver
@onready var fingerprints: TextureButton = $Fingerprints

func _ready() -> void:
	if CaseManager.CaseGlobals.pliers_collected:
		pliers.disabled = true
		pliers.hide()
	
	if CaseManager.CaseGlobals.screwdriver_collected:
		screwdriver.disabled = true
		screwdriver.hide()
		
	if CaseManager.CaseGlobals.fingerprints_saved:
		fingerprints.disabled = true
