extends Node

var portrait: CompressedTexture2D

var Difficult: String = ""
var Fun: String = ""

var akt2_first_tech_item_dialogue = true

func startMinigameIntroduction():
	get_tree().change_scene_to_file("res://scenes/Minigames/Minigame_Introduction.tscn")

func startMinigame2():
	get_tree().change_scene_to_file("res://scenes/Minigames/Minigame_2.tscn")
	
func startEnd():
	get_tree().change_scene_to_file("res://scenes/End.tscn")
