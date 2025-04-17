extends Button

@export_file var level_path

var original_size := scale
var grow_size := Vector2(1.1, 1.1)


func _on_mouse_entered() -> void:
	grow_btn(grow_size, .1)
	

func _on_mouse_exited() -> void:
	grow_btn(original_size, .1)
	

# plays an animation, that skills the button up if hovering over it and skills back down if not hovering over it
func grow_btn(end_size: Vector2, duration: float) -> void:
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, 'scale', end_size, duration)

func reset_parameters():
	Global.level_parameters.hinweis1 = true
	Global.level_parameters.hinweis2 = true
	Global.level_parameters.hinweis3 = true

func _on_pressed() -> void:
	if level_path == null:
		return
	reset_parameters()
	var level = level_path.trim_prefix('res://levels/level_').trim_suffix('.tscn')
	get_tree().change_scene_to_file(level_path)
	Global.level_parameters.level = level
