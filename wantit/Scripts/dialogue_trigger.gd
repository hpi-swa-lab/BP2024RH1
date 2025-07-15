extends Resource
class_name DialogueTrigger

@export var start_marker: String
@export var required_items: Array[String]
var is_started: bool = false
@export var is_repeatable: bool = false
