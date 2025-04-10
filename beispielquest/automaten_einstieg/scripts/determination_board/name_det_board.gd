extends Label

@onready var determination_board: Control = $".."

func _ready() -> void:
	self.text = determination_board.NAME_OF_CASE
	
