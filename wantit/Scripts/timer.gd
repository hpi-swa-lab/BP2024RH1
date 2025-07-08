extends Node

var Times = {}

func start_timer(time_name: String):	#You need to end the timer to restart it
	var time = Time.get_ticks_msec() / 1000.0
	if Times.has(time_name):
		var time_before = Times[time_name]
		Times[time_name] = time - time_before
	else:
		Times[time_name] = time
	print("starting timer " + time_name)
	
func end_timer(TimerName: String):
	if Times.has(TimerName):
		var startTime = Times[TimerName]
		var endTime = Time.get_ticks_msec() / 1000.0
		Times[TimerName] = endTime - startTime
	print("ending timer " + TimerName)

func get_time(time_name: String) -> int:
	if Times.has(time_name):
		return Times[time_name]
	push_error("ERROR: No such timer found!")
	return 0

func clear_times():
	Times.clear()
