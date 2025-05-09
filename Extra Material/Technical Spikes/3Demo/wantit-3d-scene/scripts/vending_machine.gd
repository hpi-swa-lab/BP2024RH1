extends StaticBody3D

@onready var collider: Area3D = $ContextCollider
@onready var label: Label3D = $PressLabel
@export var Player : Node3D

func _ready():
	# Ensure the target node is not null
   
		return

func _input(event):
	if collider.overlaps_body(Player):
		label.visible = true
		if Input.is_key_label_pressed(KEY_E):
			set_visibility(true)
	else: label.visible = false
	if Input.is_key_label_pressed(KEY_ESCAPE):
		set_visibility(false)

func set_visibility(event):
		$inGameUI.visible = event
