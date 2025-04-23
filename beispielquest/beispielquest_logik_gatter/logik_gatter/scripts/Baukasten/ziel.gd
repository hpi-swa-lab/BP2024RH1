extends Sprite2D

@export var input_connection: Connection
@export var lv_complete_picture: Texture
@export var lv_not_complete_picture: Texture

signal ziel_input_true
signal ziel_input_false

var lv_complete = false

func _process(delta: float) -> void:
	lv_complete = input_connection.output
	if lv_complete:
		texture = lv_complete_picture
		emit_signal("ziel_input_true")
	else:
		texture = lv_not_complete_picture
		emit_signal("ziel_input_false")
