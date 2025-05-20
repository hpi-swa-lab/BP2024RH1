extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/Label
#var main = preload("res://scenes/main.tscn")
#@onready var collectable_2: TextureButton = $Collectable2
var slot: InventorySlot  # Speichert den aktuellen Slot
var dragged_item: Sprite2D  # Referenz zum gezogenen Item
var tolerance_area = 300
var future_ladder_position = Vector2(181, 324)
#var easter_egg: TextureButton

#signal show_egg_sig
#var instance
#func _ready():
	#var instance = main.instantiate()
	#get_tree().root.add_child(instance)
	#easter_egg = instance.get_node("Collectable2") as TextureButton


func update(new_slot: InventorySlot):
	slot = new_slot  # Speichert die Slot-Referenz
	if !slot.item:
		item_visual.visible = false
		amount_text.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		amount_text.visible = slot.amount > 1
		amount_text.text = str(slot.amount)

func _on_gui_input(event: InputEvent) -> void: #beim ancklicken
	if event is InputEventMouseButton and event.is_pressed():
		if item_visual.texture and item_visual.texture.resource_path == "res://images/leiter.png":
			spawn_dragged_item(slot.item)


func spawn_dragged_item(item: InventoryItem): #neue Sprite erstellen, die an Maus hängt
	dragged_item = Sprite2D.new()
	dragged_item.texture = item.texture
	dragged_item.scale = Vector2(1, 1)
	dragged_item.position = get_global_mouse_position()
	get_tree().current_scene.add_child(dragged_item)
	set_process_input(true) #der Mausbewegung folgen

func _input(event): # beim loslassen
	if dragged_item:
		if event is InputEventMouseMotion:
			dragged_item.position = event.position
		elif event is InputEventMouseButton and not event.pressed:
			if is_near_tree(dragged_item.position):
				place_dragged_item()
				remove_inventory_item()
			else:
				dragged_item.queue_free()
				set_process_input(false)
		
func is_near_tree(item_position: Vector2) -> bool:
	return item_position.distance_to(future_ladder_position) < tolerance_area

func place_dragged_item(): #Leiter ablegen -> Osterei zeiegen
	if not dragged_item:
		return
	var new_item_node = TextureButton.new()
	new_item_node.texture_normal = dragged_item.texture
	new_item_node.position = future_ladder_position # an fester Position ablegen (immer die gleiche)
	get_tree().current_scene.add_child(new_item_node)
	Global.tree_egg_found = true
	dragged_item.queue_free()
#	show_egg_sig.emit()
	set_process_input(false)  #stoppt das Tracking

func remove_inventory_item():
	if not slot or not slot.item:
		return  # Falls kein Item vorhanden ist, nichts tun
	var removed_item = slot.item  # Speichert das Item
	slot.amount -= 1
	if slot.amount <= 0:
		slot.item = null  
	update(slot)
