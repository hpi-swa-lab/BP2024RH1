extends Location
class_name Minigame

var NAME: String
var ANSWERITEMS: int = 5
var ATTEMPTS: int

# interne Startzeit in Millisekunden
var _start_time_ms: int = 0

func _ready() -> void:
	super._ready()

func START(name: String, answer_items: int) -> void:
	NAME = name
	ANSWERITEMS = answer_items
	ATTEMPTS = 1
	_start_time_ms = Time.get_ticks_msec()
	Analytics.add_minigame_analytics(name)

func TRY(wrong_answers: int, right_answers: int = -1) -> void:
	if right_answers == -1:
		# original logic, calculate right_answers
		var calculated_right = ANSWERITEMS - wrong_answers
		Analytics.add_minigame_attempt(NAME, ATTEMPTS, calculated_right, wrong_answers)
	else:
		# use provided right_answers
		Analytics.add_minigame_attempt(NAME, ATTEMPTS, right_answers, wrong_answers)

	ATTEMPTS += 1

func END() -> void:
	var end_time_ms = Time.get_ticks_msec()
	var duration_seconds = int((end_time_ms - _start_time_ms) / 1000)
	# Dauer an Analytics übergeben
	Analytics.set_minigame_duration(NAME, duration_seconds)
	

func export_location_analytics() -> void:
	print("Adding minigame")
	Analytics.add_scene_analytics(location_name, "Minigame", GlobalTimer.get_time(location_name))
