extends Location

@onready var on_or_off_label: Label = $"on_or_off label"
@onready var digit_label: Label = $"digit label"
@onready var switch: TextureButton = $switch

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	on_or_off_label.text = "Aus"
	digit_label.text = "0"

func update_display() -> void:
	on_or_off_label.text = "An" if switch.button_pressed else "Aus"
	digit_label.text = "1" if switch.button_pressed else "0"

func _on_switch_toggled(_toggled_on: bool) -> void:
	update_display()
