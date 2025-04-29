extends Button

@export_multiline var labelText: String
var showing: bool

func _ready() -> void:
	%Label.text = labelText
	%Label.position = Vector2(self.icon.get_size().x + 20, 0)
	self.size = self.icon.get_size()

func _on_pressed() -> void:
	if showing: 
		%Label.hide()
		showing = false
	else:
		%Label.show()
		showing = true
