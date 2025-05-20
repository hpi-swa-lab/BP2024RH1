extends Node2D

var emotion: String = "sleeping"
var is_awake: bool = false
var search_status: String = "not started"
var ending: String = ""

func set_emotion(new_emotion: String) -> void:
	emotion = new_emotion
	
func wake_up() -> void:
	is_awake = true
	
func go_to_sleep() -> void:
	is_awake = false
	
func start_search() -> void:
	search_status = "started"

func update_search() -> void:
	search_status = "successful"

func end_search() -> void:
	search_status = "ended"
	
func set_ending(new_ending: String) -> void:
	assert(new_ending == "good" || new_ending == "bad", "Error: Not an appropriate ending mode.")
	ending = new_ending
		


	
