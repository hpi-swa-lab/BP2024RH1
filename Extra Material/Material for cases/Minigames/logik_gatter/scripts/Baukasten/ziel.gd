extends Sprite2D

@export var input_connection: Connection
@export var lv_complete_picture: Texture
@export var lv_not_complete_picture: Texture

var lv_complete = false

func _process(delta: float) -> void:
	lv_complete = input_connection.output
	if lv_complete:
		texture = lv_complete_picture
	else:
		texture = lv_not_complete_picture
