extends Area2D

class_name Player

@onready var movement_animation: AnimatedSprite2D = $movement_animation
@onready var raycast: Raycast = $Raycast
@onready var bomb_placement_sys: BombPlacementSys = $BombPlacementSys
@onready var power_up_sys: PowerUpSys = $PowerUpSys

@export var movement_speed: float = 55
@export var max_bombs_at_once = 1
@export var explosion_size = 1
@export var player_id = 1

@export var last_movement_direction: Vector2 = Vector2.DOWN

var movement: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	
	var collisions = raycast.check_collisions()
	if collisions.has(movement):
		return
	
	position += movement * delta * movement_speed

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("place_bomb_%s" % [player_id]):
		bomb_placement_sys.place_bomb()
	
	if Input.is_action_pressed("left_%s" % [player_id]):
		movement = Vector2.LEFT
		movement_animation.play("walk_left")
		last_movement_direction = Vector2.LEFT
	elif Input.is_action_pressed("down_%s" % [player_id]):
		movement = Vector2.DOWN
		movement_animation.play("walk_down")
		last_movement_direction = Vector2.DOWN
	elif Input.is_action_pressed("up_%s" % [player_id]):
		movement = Vector2.UP
		movement_animation.play("walk_up")
		last_movement_direction = Vector2.UP
	elif Input.is_action_pressed("right_%s" % [player_id]):
		movement = Vector2.RIGHT
		movement_animation.play("walk_right")
		last_movement_direction = Vector2.RIGHT
	else:
		movement = Vector2.ZERO
		movement_animation.stop()

func die():
	print("die")
	movement_animation.play("die")
	movement = Vector2.ZERO
	set_process_input(false)
	


func _on_area_entered(area: Area2D) -> void:
	if area is PowerUp:
		power_up_sys.enable_power_up((area as PowerUp).type)
		area.queue_free()


func _on_movement_animation_animation_finished() -> void:
	#if movement_animation.animation == "die":
	#	if(player_id == 1):
	#		Global.Player_2_score += 1
	#	if(player_id == 2):
	#		Global.Player_1_score += 1
	pass
		
		
