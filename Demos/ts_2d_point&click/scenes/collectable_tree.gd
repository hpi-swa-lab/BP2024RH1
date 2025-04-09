extends TextureButton

@export var item: InventoryItem
@export var game: TextureRect #muss im Inspector dann zugewiesen werden -> dann kann man fremde Funktionen aufrufen
@export var inventory_ui: Control

func _ready():
	if texture_normal is Texture2D: # hier möchte ich eine BitMap erstellen für das Bild, das als Textur eingefügt wurde. Mit dieser BitMap kann dann entlang der echten Außenlineie des Bildes dieses angelickt werden
		var image = texture_normal.get_image() # image aus Inspektor erhalten
		var mask = BitMap.new() #BitMap ermöglicht Einteilung in wo Clicks erkannt werden sollen und wo nicht
		mask.create_from_image_alpha(image, 0.1)  # 0.1 = Transparenz-Schwelle
		self.set_click_mask(mask)
	#var inv_ui_slot = load("res://inventory/inventory_ui_slot.tscn").instantiate()
	#inv_ui_slot.show_egg_sig.connect(_on_show_egg_sig)
	#get_tree().root.add_child(inv_ui_slot)
	
func _on_gui_input(event: InputEvent) -> void:
	if  event is InputEventMouseButton and event.is_pressed() and Global.tree_egg_found == true:
		gamecollect()
		openinventory_ui()
		self.queue_free()
		
func gamecollect(): 
	game.collect(item)

func openinventory_ui(): #ruft Funktion vom Control Inventory Ui auf
	inventory_ui.open()

#func _on_show_egg_sig() -> void: #signal_funktion muss über den Node neben Inspector hinzugefügt werden
	#print("egg")
	#self.visible = true
