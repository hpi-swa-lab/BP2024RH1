extends Location

@onready var text_label = $ColorRect/ColorRect/on_or_off
@onready var digit_label = $ColorRect/ColorRect/Panel/digit
@onready var switch = $ColorRect/switch
@onready var btn_state:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text_label.text = "Aus"
	digit_label.text = "0"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if btn_state:
		digit_label.text = "1"
		text_label.text = "An"
	else:
		text_label.text = "Aus"
		digit_label.text = "0"


func _on_switch_toggled(toggled_on: bool) -> void:
	btn_state = toggled_on 
