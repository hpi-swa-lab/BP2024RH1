extends Node

const supabase_url = "https://stats.bp.tmbe.me/functions/v1/commitEntry"
const api_key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlzcyI6InN1cGFiYXNlIiwiaWF0IjoxNzUwMTExMjAwLCJleHAiOjE5MDc4Nzc2MDB9.mHBPurwI373b8JR1G5WLmEScvaPWoYPcXchITo7TXUg"
var hex = "0123456789abcdef"

var session_data = {
		"session_id": "",
		"case": "",
		"date": get_datetime(),
		"total_duration_seconds": 0,
		"dialogs": [],
		"hints": [],
		"scene_times": [],
		"knowledge_tests": [],
		"game_survey": []
	}

var header =  [
	"apikey: " + api_key,
	"Authorization: Bearer " + api_key,
	"Content-Type: application/json"
	]

func create_uuid() -> String:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return "%s-%s-4%s-%s%s-%s" % [
		rand_hex(rng, 8),
		rand_hex(rng, 4),
		rand_hex(rng, 3), # next group starts with literal 4
		hex[rng.randi_range(8, 11)], # variant first hex (8–b)
		rand_hex(rng, 3),            # rest of variant group
		rand_hex(rng, 12)
	]

func rand_hex(rng, n):
	var result = ""
	for i in range(n):
		result += hex[rng.randi_range(0, 15)]
	return result


func send_analytics():
	print(JSON.stringify(session_data))
	var http := HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(_on_request_completed)
	
	var err = http.request(supabase_url, header, HTTPClient.METHOD_POST, JSON.stringify(session_data))
	if err != OK:
			print("HTTP Request Error: ", err)

func _on_request_completed(result, response_code, _headers, body):
	if result == OK and response_code == 201 || 200:
		print("Succesfully exported Analytics")
		print(response_code, body, result, _headers)
	else:
		push_error("ERROR at sending Analytics! Response:", response_code, "Body: ", body)

func get_datetime() -> String:
	var current_date_time = Time.get_datetime_dict_from_system()
	var formatted_date_time = "%04d-%02d-%02dT%02d:%02d:%02dZ" % [current_date_time["year"], current_date_time["month"], current_date_time["day"], current_date_time["hour"], current_date_time["minute"], current_date_time["second"]]
	return formatted_date_time

func clear_session_data():
	session_data = {
		"session_id": "",
		"case": "",
		"date": get_datetime(),
		"total_duration_seconds": 0,
		"dialogs": [],
		"hints": [],
		"scene_times": [],
		"knowledge_tests": [],
		"game_survey":[]
	}

func export_analytics(case_name: String, case_time: int):
	session_data["session_id"] = create_uuid()
	session_data["case"] = case_name
	session_data["total_duration_seconds"] = case_time
	send_analytics()
	clear_session_data()
	GlobalTimer.clear_times()

func add_dialogue_analytics(dialogue_name: String, dialogue_time: int):
	var dialogue_data = {
		"dialog_id": dialogue_name,
		"total_duration_seconds": dialogue_time
	}
	session_data["dialogs"].append(dialogue_data)

func add_hint_analytics(hint_name: String):
	var hint_data = {
		"hint_id": hint_name,
		"shown_at": get_datetime()
	}
	session_data["hints"].append(hint_data)

func add_scene_analytics(location_name: String, location_type: String, location_time: int):
	var scene_data = {
		"scene_id": location_name,
		"scene_type": location_type,
		"total_duration_seconds": location_time
	}
	session_data["scene_times"].append(scene_data)
	print("adding scene analytics", session_data, "\n")

func add_knowledge_test_analytics(phase: String, answers: Array, duration: Array[int]):
	var knowledge_data = {
		"phase": phase,
		"answers": answers,
		"duration_answers": duration
	}
	session_data["knowledge_tests"].append(knowledge_data)

func add_game_survey_analytics(answers: Array[int], duration: int):
	var survey_data = {
		"answers": answers,
		"total_duration_seconds": duration
	}
	session_data["game_survey"].append(survey_data)
