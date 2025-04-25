extends Node

# This function can be used to track the time it takes to solve our minigames
# It should be pretty straightforward to use, just make sure you set it as a global (autoload)
# Look at the scene as how to use it - By default the name of the Global should be GlobalTimer ig.

var Times = {}

func start_timer(TimerName: String):	#You need to end the timer to restart it
	var time = Time.get_ticks_msec() / 1000
	if Times.has(TimerName):
		var time_before = Times[TimerName]
		Times[TimerName] = time - time_before
	else:
		Times[TimerName] = time
	
func end_timer(TimerName: String):
	if Times.has(TimerName):
		var startTime = Times[TimerName]
		var endTime = Time.get_ticks_msec() / 1000
		Times[TimerName] = endTime - startTime

func print_times() -> String:
	var returnString = ""
	for timer in Times.keys():
		returnString += "Du hast " + timer + " " + str(Times[timer]) + " Sekunden gespielt.\n"
	return returnString
