extends Control

var ziel_input: bool = false

func _on_ziel_ziel_input_false() -> void:
	ziel_input = false

func _on_ziel_ziel_input_true() -> void:
	ziel_input = true

func _ready() -> void:
	#GlobalTimer.add_log_entry("entered scene: minigame_1")
	pass

func _on_check_pressed() -> void:
	if ziel_input == true:
		#GlobalTimer.end_timer("Logik Gatter Mini Games")
		get_tree().change_scene_to_file("res://Cases/A_Completely_Normal_Day/Scenes/police_station_rooms/technic_room_light_is_back.tscn")

	
