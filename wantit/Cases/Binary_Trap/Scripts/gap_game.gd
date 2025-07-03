extends Control

@onready var gaps: Array = [$HBoxContainer/Gap1, $HBoxContainer/Gap2, $HBoxContainer/Gap3, $HBoxContainer/Gap4]
@onready var result_label: Label = $"HBoxContainer/Result Label"

func _ready() -> void:
	var weights: Array = [8, 4, 2, 1]
	gaps[gaps.size() -1].operation_label.text = "="
	
	for i in range(gaps.size()):
		gaps[i].weight = weights[i]
		gaps[i].set_weight()
		gaps[i].connect("value_changed", _on_gap_changed)
		
	update_result()
		
func _on_gap_changed() -> void:
	update_result()

func update_result() -> void:
	var result: int = 0
	for gap in gaps:
		result += gap.get_value()
	result_label.text = str(result)
