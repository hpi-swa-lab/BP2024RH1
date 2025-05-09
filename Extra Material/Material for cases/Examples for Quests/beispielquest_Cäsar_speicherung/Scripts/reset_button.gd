extends Button

func _ready() -> void:
	# Button setup (optional: add some styling here)
	self.text = "Reset Spiel"

func _pressed() -> void:
	GameSaver.clear_save_data()
	GameSaver.start_new_game()
