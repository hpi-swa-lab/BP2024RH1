extends Resource
class_name Dialogue

@export var dialogue_resource: DialogueResource
@export var is_dialogue: bool
@export var is_monologue: bool
var is_started: bool = false
var baloon_type: String

var monologue_baloon_path: String = "res://dialogue_balloons/monologue/balloon_monologue.tscn"
var dialogue_baloon_path: String = "res://dialogue_balloons/monologue/balloon_monologue.tscn"
#@export var condition_items: Array[String] = [] # list of item names needed
#@export var auto_start: bool = false # auto-start when condition met?

func _init():
	set_baloon_type()	

func set_baloon_type():
	if is_dialogue:
		baloon_type = dialogue_baloon_path
	else:
		baloon_type = monologue_baloon_path
