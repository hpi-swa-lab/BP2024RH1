extends CanvasLayer
class_name ItemOverlay

var new_texture: 
	get: return new_texture
	set(t):
		new_texture = t
		if is_inside_tree():
			update_overlay()

func _ready() -> void:
	update_overlay()

func _on_close_button_pressed() -> void:
	self.queue_free()

func update_overlay():
	$Item.texture = new_texture
	
