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
	for newlog in Log.keys():
		returnString += str(Log[newlog]) + " :  " + newlog + "\n"
	return returnString

func export_analytics():
	var http := HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(_on_request_completed)
	
	var combindedAnalytics = {
		"timers": Times,
		"logs": Log,
		"case": "Logikgatter",
		"timestamp": Time.get_unix_time_from_system(),
	}
	
	var json_data = JSON.stringify(combindedAnalytics)
	
	var url = "https://onourispvhwvrdykywli.supabase.co/rest/v1/analytics"
	var headers = [
		"apikey: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9ub3VyaXNwdmh3dnJkeWt5d2xpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc2NjA0MTcsImV4cCI6MjA2MzIzNjQxN30.JkxHV2ft0-HcB2OBC2Z0IQOgstLRqrY9_8mQArx-gng",
		"Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9ub3VyaXNwdmh3dnJkeWt5d2xpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc2NjA0MTcsImV4cCI6MjA2MzIzNjQxN30.JkxHV2ft0-HcB2OBC2Z0IQOgstLRqrY9_8mQArx-gng",
		"Content-Type: application/json"
		]
		
	var err = http.request(url, headers, HTTPClient.METHOD_POST, json_data)
	if err != OK:
			print("HTTP Request Error: ", err)

func _on_request_completed(_result, response_code, _headers, body):
	print("Completed")
	print("Status: ", response_code)
	print("Answer: ", body.get_string_from_utf8())
