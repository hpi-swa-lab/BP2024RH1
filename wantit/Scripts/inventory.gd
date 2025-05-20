# To change the position and size of the Inventory slots you need to change the number of columns 
# or resize the Gridcontainer. If you want more slots increase the slotCount

extends Control

var slotCount = 8
var opened: bool = true
var columns = 2
var slots: Array

func _ready() -> void:
	var newSlot: Control
	var slotScene: PackedScene
	
	%GridContainer.columns = columns
	for i in range(slotCount):
		slotScene = load("res://Scenes/inventory_slot.tscn")
		newSlot = slotScene.instantiate()
		newSlot.custom_minimum_size = Vector2(%GridContainer.size.x / columns, %GridContainer.size.x / columns)
		%GridContainer.add_child(newSlot)
	slots = %GridContainer.get_children()
	
	update_inventory()
	hide_inventory()

func add_item(Item: TextureButton):
	for slot in slots:
		if slot.StoredItem == null:
			slot.add_item(Item)
			break

func _on_button_pressed() -> void:
	if opened:
		hide_inventory()
	else:
		show_inventory()
		
func update_inventory():
	for item in GlobalInventory.Items:
		add_item(GlobalInventory.Items[item])
		
func show_inventory():
	GlobalTimer.add_log_entry("entered scene: inventory")
	%Control.show()
	opened = true
	%Button.text = "Schließen"
	
func hide_inventory():
	GlobalTimer.add_log_entry("closed scene: inventory")
	%Control.hide()
	opened = false
	%Button.text = "Inventar"
