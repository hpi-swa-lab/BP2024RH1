extends Control

var Questionmark_Found: bool = false
var Start_Dialougue_Shown: bool = false

@onready var show_helpsys: TextureRect = $show_helpsys
@onready var timer_blackout_beginn: Timer = $Timer_Blackout_beginn
@onready var dark_mode_blackout: Sprite2D = $Dark_Mode_Blackout

func _ready() -> void:
		GlobalTimer.add_log_entry("entered scene: akt_1")

func _on_helpsys_questionmark_found() -> void:
	if Questionmark_Found:
		timer_blackout_beginn.start()
	else:
		show_helpsys.queue_free()
		Questionmark_Found = true


func _on_timer_blackout_beginn_timeout() -> void:
	dark_mode_blackout.show()
	if !Start_Dialougue_Shown:
		DialogueManager.show_dialogue_balloon(load("res://dialogue/logik_gatter.dialogue"), "start")
		Start_Dialougue_Shown = true
		

func _on_tech_room_electricity_box_pressed() -> void:
	if dark_mode_blackout.visible:
		print("start mini game")	
		#HIER erst dialog starten: kurz das etwas mit dem stromkasten nicht stimmt und verbindungen repariert werden müssen also hier dann erst dialog starten und wait fkt bis dialog fertig dann minigame starten 
		#DialogueManager.show_dialogue_balloon(load("res://dialogue/logik_gatter.dialogue"), "start")

		
		#hier minigame wird über dialog gestartet
		DialogueManager.show_dialogue_balloon(load("res://dialogue/logik_gatter.dialogue"), "electricityBox")
