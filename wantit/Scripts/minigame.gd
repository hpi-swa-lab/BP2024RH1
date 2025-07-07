extends Location
class_name Minigame

var attempts = []
var attempt_num = 0

func _ready() -> void:
	super._ready()
	GlobalTimer.start_timer(location_name)

func add_attempt(correct_answers: int, wrong_answers: int):
	var new_attempt = {
		"attemp_number": attempt_num,
		"correct_answers": correct_answers,
		"wrong_answers": wrong_answers
	}
	attempt_num += 1
	attempts.append(new_attempt)

func close_minigame():
	GlobalTimer.end_timer(location_name)
	Analytics.add_minigame_analytics(location_name, GlobalTimer.get_time(location_name), attempts)
