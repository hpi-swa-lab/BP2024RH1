extends Node

# This function can be used to track the time it takes to solve our minigames
# It should be pretty straightforward to use, just make sure you set it as a global (autoload)
# Look at the scene as how to use it - By default the name of the Global should be GlobalTimer ig.

var Times = {}
var Log = {}

func add_log_entry(EntryName: String):
	var time = Time.get_ticks_msec() / 1000.0
	Log[EntryName] = time
	print("Log for " + EntryName + " at " + str(time))

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
		
func timer_active(TimerName: String) -> bool:
	if Times.has(TimerName):
		return true
	return false

func print_times() -> String:
	var returnString = ""
	for timer in Times.keys():
		returnString += timer + ": " + str(Times[timer]) + "\n"
	return returnString
	
func print_log() -> String:
	var returnString = ""
	for log in Log.keys():
		returnString += log + ": " + str(Log[log]) + "\n"
	return returnString
