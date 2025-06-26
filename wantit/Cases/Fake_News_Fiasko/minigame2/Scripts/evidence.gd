extends Control

@export var Texture1: Texture2D
@export var Texture2: Texture2D

signal evidence_inspected(Texture1: Texture2D, Texture2: Texture2D)

func _ready() -> void:
	randomize()
	%HBoxContainer.show()
	check_and_apply_textures()
	self.rotation = randf_range(-0.1745, 0.1745)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		evidence_inspected.emit(Texture1, Texture2)

func check_and_apply_textures():
	if Texture1 != null and Texture2 != null:
		%TextureRect.texture = Texture1
		%TextureRect2.texture = Texture2
	elif Texture1 != null or Texture2 != null:
		%Control2.free()
		%TextureRect.texture = Texture1 if Texture1 != null else Texture2
		
		await get_tree().process_frame
		%HBoxContainer.queue_sort()
		%TextureRect.size = %HBoxContainer.size
