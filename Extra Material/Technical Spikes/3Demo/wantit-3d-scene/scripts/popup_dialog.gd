extends MarginContainer


# Called when the node enters the scene tree for the first time.


func _ready():
	# Ensure the target node is not null
   
		return

func _input(event):
	if Input.is_key_label_pressed(KEY_E):
		set_visibility(true)
	if Input.is_key_label_pressed(KEY_ESCAPE):
		set_visibility(false)

func set_visibility(event):
		self.visible = event
