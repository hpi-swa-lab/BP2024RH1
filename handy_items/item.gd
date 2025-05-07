extends Button

@export var inventory: Control
@export var ActionScript: Script

func _ready() -> void:
	self.pivot_offset = self.size / 2

func highlight():
	%AnimationPlayer.play("Highlight")

func _on_pressed() -> void:
	inventory.add_item(self)
	%AnimationPlayer.play("clicked")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "clicked":
		self.hide()
