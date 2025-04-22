extends Button

signal clicked(text: String)

func _pressed() -> void:
	clicked.emit(self.text)
	print("clicked")
	print("text is:" + self.text)
