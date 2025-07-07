extends Node

var Times = {}

func start_timer(TimerName: String):	#You need to end the timer to restart it
	var time = Time.get_ticks_msec() / 1000.0
	if Times.has(TimerName):
		var time_before = Times[TimerName]
		Times[TimerName] = time - time_before
	else:
		Times[TimerName] = time
	print("starting timer " + TimerName)
	
func end_timer(TimerName: String):
	if Times.has(TimerName):
		var startTime = Times[TimerName]
		var endTime = Time.get_ticks_msec() / 1000.0
		Times[TimerName] = endTime - startTime
	print("ending timer " + TimerName)

func get_times() -> String:
	var returnString = ""
	for timer in Times.keys():
		returnString += timer + ": " + str(Times[timer]) + "\n"
	return returnString

func clear_times():
	Times.clear()
