extends Area2D

@onready var sprite = $Sprite2D
@onready var original_position = position
var original_scale

func _ready() -> void:
	original_scale = sprite.scale

func _process(_delta):
	if Globals.map_clicked == true:
		position = Vector2(0, 0)
		sprite.scale = Vector2(2.0, 2.0)
	else:
		position = original_position
		sprite.scale = original_scale
