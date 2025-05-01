extends Control

@onready var waffle: TextureButton = $Waffle

func _ready() -> void:
	if State.waffle_collected:
		waffle.disabled = true
		waffle.hide()
	
