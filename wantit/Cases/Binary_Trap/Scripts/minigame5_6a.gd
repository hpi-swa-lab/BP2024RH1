extends Minigame

@export var item_name: String
@onready var lock: Control = $Lock

func _ready() -> void:
	super._ready()
	lock.set_font_color(Color.BLACK)

func _on_lock_succeeded() -> void:
	await get_tree().create_timer(0.5).timeout
	var interaction_item = Item.new()
	interaction_item.item_name = item_name
	interaction_item.is_collectable = false
	self.item_found.emit(interaction_item, self)
