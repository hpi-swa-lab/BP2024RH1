extends Button

@export_multiline var labelText: String

func _ready() -> void:
	%Label.text = labelText
	%Label.position = Vector2(self.icon.get_size().x + 20, 0)
	%Label.scale = Vector2(1, 1) / self.scale

func hovered() -> void:
	%Label.show()

func not_hovered():
	%Label.hide()
