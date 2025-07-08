extends Location
class_name Minigame

var attempts = []
var attempt_num = 0

func add_attempt(correct_answers: int, wrong_answers: int):
	var new_attempt = {
		"attempt_number": attempt_num,
		"correct_answers": correct_answers,
		"wrong_answers": wrong_answers
	}
	attempt_num += 1
	attempts.append(new_attempt)

func _exit_tree() -> void:
	print("exiting")
	GlobalTimer.end_timer(location_name)
	Analytics.add_minigame_analytics(location_name, GlobalTimer.get_time(location_name), attempts)

func export_location_analytics():
	Analytics.add_scene_analytics(location_name, "Minigame", GlobalTimer.get_time(location_name))
