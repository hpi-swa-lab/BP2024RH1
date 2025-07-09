extends Node

var Times = {}

func start_timer(time_name: String):	#You need to end the timer to restart it
	var now = Time.get_ticks_msec() / 1000.0
	
	if Times.has(time_name) and "end" not in Times[time_name]:
		push_warning("Timer '%s' is already running!" % time_name)
		return
		
	Times[time_name] = {
		"start": now
	}
	print("Started timer '%s' at %.2f" % [time_name, now])
	
func end_timer(time_name: String):
	if not Times.has(time_name):
		push_error("Timer '%s' was never started!" % time_name)
		return
	
	if "end" in Times[time_name]:
		push_warning("Timer '%s' has already been ended!" % time_name)
		
	var now = Time.get_ticks_msec() / 1000.0
	var start_time = Times[time_name]["start"]
	Times[time_name]["end"] = now
	var duration = now - start_time
	print("Ended timer '%s': %.2f seconds" % [time_name, duration])

func get_time(time_name: String) -> int:
	if not Times.has(time_name):
		push_error("No such timer: '%s'" % time_name)
		return 0.0
	
	if "end" in Times[time_name]:
		return Times[time_name]["end"] - Times[time_name]["start"]
		Times.erase(time_name)
	else:
		push_error("Timer still running: ", time_name)
		var now = Time.get_ticks_msec() / 1000.0
		return now - Times[time_name]["start"]

func clear_times():
	Times.clear()
