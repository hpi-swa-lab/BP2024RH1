extends Control

@onready var plate: TextureButton = $Plate
@onready var helpsystem_timer = $Helpsystem/Question_mark/Timer

func _ready() -> void:
	if State.showroom_intro_shown == false:
		
		# pause timer of helpsystem until the first dialog is finished
		helpsystem_timer.paused = true
		print(helpsystem_timer.paused)
		
		DialogueManager.show_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "crime_scene")
		
		await DialogueManager.dialogue_ended
		State.showroom_intro_shown = true
		helpsystem_timer.paused = false
		print(helpsystem_timer.paused)
	if State.waffle_collected:
		plate.texture_normal = load("res://Cases/Introduction_Case/assets/interactable_items/plate_empty.png")
