extends Control

@export var item_name: String
@onready var lock: Control = $Lock

func _ready() -> void:
	lock.set_font_color(Color.BLACK)

func _on_lock_succeeded() -> void:
	var interaction_item = Item.new()
	interaction_item.item_name = item_name
	interaction_item.is_collectable = false
	get_parent().item_found.emit(interaction_item, self)
