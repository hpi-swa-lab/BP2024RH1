extends TextureButton

var moved: bool = false

func _ready():
	position = Vector2(805, 381)
	if texture_normal is Texture2D:
		var image = texture_normal.get_image() # image aus Inspektor erhalten
		var mask = BitMap.new() #BitMap ermöglicht Einteilung in wo Clicks erkannt werden sollen und wo nicht
		mask.create_from_image_alpha(image, 0.1)  # 0.1 = Transparenz-Schwelle
		self.set_click_mask(mask)
	

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if moved == false:
			position.x += 150
			moved = true
		else:
			position.x -= 150
			moved = false
