extends Control

func _on_mouse_entered() -> void:
	$GooseMouthClosed.visible = false
	$GooseMouthOpen.visible = true

func _on_mouse_exited() -> void:
	$GooseMouthClosed.visible = true
	$GooseMouthOpen.visible = false
