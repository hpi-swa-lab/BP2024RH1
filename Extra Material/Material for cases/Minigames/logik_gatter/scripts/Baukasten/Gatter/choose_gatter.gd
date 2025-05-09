extends OptionButton

@export var input_connection_1: Connection
@export var input_connection_2: Connection

@export var output_connection: Connection

var child: Node = null

const AND_GATTER = preload("res://logik_gatter/scenes/Baukasten/Gatter/And_Gatter.tscn")
const OR_GATTER = preload("res://logik_gatter/scenes/Baukasten/Gatter/Or_Gatter.tscn")

func _on_item_selected(index: int) -> void:
	if child != null:
		child.queue_free() 
	
	if index == 0:
		child = AND_GATTER.instantiate()
	if index == 1:
		child = OR_GATTER.instantiate()
	
	self.add_child(child)
	
	child.input_connection_1 = input_connection_1
	child.input_connection_2 = input_connection_2
	child.output_connection = output_connection
	
	child.visible = false
