extends Control

@onready var score: Label = $score

func _ready() -> void:
	score.text = "%s : " % Global.Player_1_score + "%s" % Global.Player_2_score
