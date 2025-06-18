extends TextureButton

signal display_helpscreen


func _ready() -> void:
	visible = false
		
	#if texture_normal:
		#var image: Image = texture_normal.get_image()
		#var bitmap: BitMap = BitMap.new()
		#bitmap.create_from_image_alpha(image)
		#texture_click_mask = bitmap

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton: #is_action_pressed("left_click"):	
		print("Fragezeichen geklickt")
		#GlobalTimer.add_log_entry("entered scene: helpsystem")
		#event.accept()
		visible = false
		emit_signal("display_helpscreen")


func _on_timer_timeout() -> void:
	visible = true
