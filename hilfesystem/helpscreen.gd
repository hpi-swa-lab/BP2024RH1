extends Control


@onready var hinweis = $MarginContainer/VBoxContainer/MarginContainer/Hinweis

func _ready() -> void:
	var level = int(Global.level_parameters.level)
	match level:
		1:
			load_hint_level1()
		2:
			load_hint_level2()
		3:
			load_hint_level3()

# Hinweis einblenden, je nach Level und Hinweis
# signal ausgeben, wenn auf close gedrückt

# wenn signal gefunden wurde
# load_hint = 'load_hint_level' + str(level_parameters.level) + '()'
# func load_hint


func load_hint_level1():
	if Global.level_parameters.hinweis1:
		hinweis.text = "Hast du dir schon den Tisch genauer angesehen?"
	elif Global.level_parameters.hinweis2:
		hinweis.text = "Hast du dir schon das Messer genauer angesehen?"
	elif Global.level_parameters.hinweis3:
		hinweis.text = "Hast du dir schon den Apfel genauer angesehen?"
	else:
		hinweis.text = "Du hast alle Hinweise gefunden."		

func load_hint_level2():
	if Global.level_parameters.hinweis1:
		hinweis.text = "Hast du dir schon den Stuhl genauer angesehen?"
	elif Global.level_parameters.hinweis2:
		hinweis.text = "Hast du dir schon den Löffel genauer angesehen?"
	elif Global.level_parameters.hinweis3:
		hinweis.text = "Hast du dir schon die Banane genauer angesehen?"
	else:
		hinweis.text = "Du hast alle Hinweise gefunden."	

func load_hint_level3():
	if Global.level_parameters.hinweis1:
		hinweis.text = "Hast du dir schon den Desktop genauer angesehen?"
	elif Global.level_parameters.hinweis2:
		hinweis.text = "Hast du dir schon die Stäbchen genauer angesehen?"
	else:
		hinweis.text = "Du hast alle Hinweise gefunden."	

func _on_close_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("linksklick"):
		print("emit signal")
		var change_to_scene = 'res://levels/level_' + str(Global.level_parameters.level) + '.tscn'
		print(change_to_scene)
		get_tree().change_scene_to_file(change_to_scene)
