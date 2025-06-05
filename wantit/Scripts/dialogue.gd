extends Resource
class_name Dialogue

@export var dialogue: DialogueResource
@export var condition_items: Array[String] = [] # list of item names needed
@export var auto_start: bool = false # auto-start when condition met?
@export var started: bool = false
