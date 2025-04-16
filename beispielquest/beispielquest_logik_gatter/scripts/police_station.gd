extends Control

@onready var show_helpsys: TextureRect = $show_helpsys


func _on_helpsys_questionmark_found() -> void:
	show_helpsys.queue_free()
