extends Control

@export var item_texture: Texture

@onready var item: TextureRect = $Item

func _ready() -> void:
	item.texture = item_texture

func _on_close_button_pressed() -> void:
	self.queue_free()
