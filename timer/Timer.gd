extends Node

# This function can be used to track the time it takes to solve our minigames
# It should be pretty straightforward to use, just make sure you set it as a global (autoload)
# Look at the scene as how to use it - By default the name of the Global should be GlobalTimer ig.

var Times = {}

func start_timer(TimerName: String):
	var time = Time.get_ticks_msec()
	Times[TimerName] = time
	
func end_timer(TimerName: String):
	if Times.has(TimerName):
		var startTime = Times[TimerName]
		var endTime = Time.get_ticks_msec()
		Times[TimerName] = (endTime - startTime) / 1000

func print_time(TimerName: String) -> String:
	var returnString = ""
	if Times.has(TimerName):
		returnString = "Du hast " + TimerName + " " + str(Times[TimerName]) + " Sekunden gespielt."
	return returnString
