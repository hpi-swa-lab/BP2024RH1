extends Control

var ziel_input: bool = false

func _ready() -> void:
	GlobalTimer.add_log_entry("entered scene: minigame_1")

func _on_level_1_ziel_input_false() -> void:
	ziel_input = false

func _on_level_1_ziel_input_true() -> void:
	ziel_input = true
	


func _on_check_button_pressed() -> void:
	if ziel_input == true:
		GlobalTimer.end_timer("Logik Gatter Mini Games")
		get_tree().change_scene_to_file("res://scenes/Akte_main_scenes/police_station_akt2.tscn")
		#dialog strom funktioniert aber internet verbindung noch weg
		#szenen wechsle in dialog
		
