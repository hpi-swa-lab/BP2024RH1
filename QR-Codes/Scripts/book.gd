extends Node2D

@export var back: Button
@export var card1: ColorRect
@export var card2: ColorRect
@export var card3: ColorRect

func _on_ready() -> void:
	DialogueManager.show_dialogue_balloon(load ("res://dialogue/main.dialogue"), "book")
	#show_card(Global.Card1_collected, card1)
	#show_card(Global.Card2_collected, card2)
	#show_card(Global.Card3_collected, card3)
	
#func show_card(global, card):
	#if global == false:
		#card.visible = true
	#else:
		#card.visible = false
		
	if Global.Card_collected == false:
		card2.visible = true
	else:
		card2.visible = false

func _on_back_gui_input(event: InputEvent) -> void:
	if  event is InputEventMouseButton and event.is_pressed():
		get_tree().change_scene_to_file("res://Scenes/tatort.tscn")

func _on_card_1_gui_input(event: InputEvent) -> void:
	if  event is InputEventMouseButton and event.is_pressed():
		DialogueManager.show_dialogue_balloon(load ("res://dialogue/main.dialogue"), "florist")

func _on_card_2_gui_input(event: InputEvent) -> void:
	if  event is InputEventMouseButton and event.is_pressed():
		DialogueManager.show_dialogue_balloon(load ("res://dialogue/main.dialogue"), "kunsthaendler")
		Global.Card_collected = true

func _on_card_3_gui_input(event: InputEvent) -> void:
	if  event is InputEventMouseButton and event.is_pressed():
		DialogueManager.show_dialogue_balloon(load ("res://dialogue/main.dialogue"), "elektrikerin")

func hide_card():
	card2.visible = false
