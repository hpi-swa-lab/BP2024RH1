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

func _on_gui_input(event: InputEvent) -> void:
	if  event is InputEventMouseButton and event.is_pressed():
		gamecollect()
		openinventory_ui()
		self.queue_free()
		
func gamecollect(): 
	game.collect(item)

func openinventory_ui(): #ruft Funktion vom Control Inventory Ui auf
	inventory_ui.open()
