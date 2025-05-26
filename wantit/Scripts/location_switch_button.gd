extends TextureButton

class_name LocationSwitchButton

@export var requested_location_name: String

signal location_switch_requested(requested_location_name: String)


func _ready() -> void:
	if texture_normal:
		var image: Image = texture_normal.get_image()
		var bitmap: BitMap = BitMap.new()
		bitmap.create_from_image_alpha(image)
		texture_click_mask = bitmap

func _pressed() -> void:
	emit_signal("location_switch_requested", self.requested_location_name)
	print("Switch to : %s requested." % requested_location_name)
