extends Node2D

func _ready() -> void:
	elif Globals.office_szene == 2:
		DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Büro_1.dialogue"), "Teil3")
	elif Globals.office_szene == 3:
		%NextButton.NextSceneString = "restaurant"
		%NextButton.position = Vector2(-200, 75)
		DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Büro_1.dialogue"), "Teil4")
	elif Globals.office_szene == 4:
		#if Globals.secret_message_found:
		#	%Geheim.visible = true
		Globals.caesar_decrypted = false
		DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Büro_1.dialogue"), "Teil5")

func _process(_delta: float) -> void:
	if Globals.secret_message_found:
		%Geheim.show()
		
