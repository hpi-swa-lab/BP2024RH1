extends Control

const LEVEL_BTN = preload("res://gui/lvl_btn.tscn")

@export_dir var dir_path

@onready var grid = $MarginContainer/VBoxContainer/GridContainer

func _ready() -> void:
	get_levels(dir_path)

func get_levels(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			print(file_name)
			# the first %S is replaced by dir.get_current_dir und the scnd by file_name (our file path)
			create_level_btn('%s/%s' % [dir.get_current_dir(), file_name], file_name)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("An error occured when trying to access the path")


func create_level_btn(lvl_path: String, lvl_name: String):
	var btn = LEVEL_BTN.instantiate()
	if lvl_path.contains('tmp'):
		return
	btn.text = lvl_name.trim_suffix('.tscn').replace('_', ' ')
	btn.level_path = lvl_path
	grid.add_child(btn)
	
