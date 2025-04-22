extends Control

@onready var texture_rect: TextureRect = $TextureRect

func _ready() -> void:
	texture_rect.texture = Globals.CaseGlobals.portrait
