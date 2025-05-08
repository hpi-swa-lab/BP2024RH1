extends Control

@onready var waffle: TextureButton = $Waffle

func _ready() -> void:
	if CaseManager.CaseGlobals.waffle_collected:
		waffle.disabled = true
		waffle.hide()
	
