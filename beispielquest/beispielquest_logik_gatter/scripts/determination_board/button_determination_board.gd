extends TextureButton

const DETERMINATION_BOARD = preload("res://scenes/determination_board.tscn")
@onready var office: Control = $".."

func _on_pressed() -> void:
	#when pressed change scene to full screen determination board or show in big 
	#pressed button = picture of board
	var Det_Board = DETERMINATION_BOARD.instantiate()
	office.add_child(Det_Board)
