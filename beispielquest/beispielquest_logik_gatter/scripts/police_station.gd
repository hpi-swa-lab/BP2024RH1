extends Control

var Qestionmark_Found: bool = false

@onready var show_helpsys: TextureRect = $show_helpsys
@onready var timer_blackout_beginn: Timer = $Timer_Blackout_beginn
@onready var dark_mode_blackout: Sprite2D = $Dark_Mode_Blackout



func _on_helpsys_questionmark_found() -> void:
	if Qestionmark_Found:
		timer_blackout_beginn.start()
	else:
		show_helpsys.queue_free()
		Qestionmark_Found = true


func _on_timer_blackout_beginn_timeout() -> void:
	dark_mode_blackout.show()


func _on_tech_room_electricity_box_pressed() -> void:
	if dark_mode_blackout.visible:
		print("start mini game")	
		#maybe erst dialog kurz das etwas mit dem stromkasten nicht stimmt und verbindungen repariert werden müssen also hier dann erst dialog starten und wait fkt bis dialog fertig dann minigame starten 
		
		
		#hier minigame 1 starten
		get_tree().change_scene_to_file("res://scenes/Minigames/Logik_Gatter_level_introduction.tscn")
