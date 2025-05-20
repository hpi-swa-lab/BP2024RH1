extends Area2D

class_name CentralExplosion

@onready var raycasts: Array[RayCast2D] = [
	$Raycast/Up,
	$Raycast/Right,
	$Raycast/Down,
	$Raycast/Left
]

var TILE_SIZE = Global.TILE_SIZE
var animation_names = ["up", "right", "down", "left"]
var animation_directions: Array[Vector2] = [
	Vector2(0, -TILE_SIZE),
	Vector2(TILE_SIZE, 0),
	Vector2(0, TILE_SIZE),
	Vector2(-TILE_SIZE, 0)
]

const DIRECTIONAL_EXPLOSION = preload("res://scenes/bombs/DirectionalExplosion.tscn")

#explosion size für alle richtungen, wird vom player übernommen
@export var explosion_size = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	check_raycasts()
	
func check_raycasts():
	#für alle richtungen einzel aufrufen
	for i in raycasts.size():
		check_raycast_for_direction(animation_names[i], raycasts[i], animation_directions[i])


func check_raycast_for_direction(animation_name: String, raycast: RayCast2D, animation_direction: Vector2):
	#raycast ende auf theoretisches ende von explosion mappen um zu gucken ob bomb explosion in diese richtung vollständig ausgeführt wird
	raycast.target_position = raycast.target_position * explosion_size
	raycast.force_raycast_update()
	#create_explosion_for_size(explosion_size, animation_name, animation_direction)
	if !raycast.is_colliding():
		create_explosion_for_size(explosion_size, animation_name, animation_direction)
	#explosion kann nicht vollständig ausgeführt werden  
	else: 
		var size_of_explosion = calculate_size_of_explosion(raycast)
		var collider = raycast.get_collider()
		if size_of_explosion != null:
			create_explosion_for_size(size_of_explosion, animation_name, animation_direction)
		#da explosion durch das nächste ojekt durchgehen würde, wird mit der folgenden funktion eine vorhandene brickwall zerstört
		execute_explosion_collision(collider)


func create_explosion_for_size(size: int, animation_name: String, animation_position: Vector2):
	for i in size: 
		if i < size - 1:
#				until we hit the last tile create middle animations
			create_explosion_animation_slice("%s_mid" % animation_name, animation_position * (i+1))
		else: 
			create_explosion_animation_slice("%s_end" % animation_name, animation_position * (i+1))


func create_explosion_animation_slice(animation_name: String, animation_position: Vector2):
	print_debug(animation_name)
	var directional_explosion = DIRECTIONAL_EXPLOSION.instantiate()
	#directional_explosion.play_animation(animation_name)
	directional_explosion.position = animation_position
	add_child(directional_explosion)
	directional_explosion.play_animation(animation_name)


func calculate_size_of_explosion(raycast: RayCast2D):
	var collider = raycast.get_collider()
	if (collider is TileMapLayer) || (collider is BrickWall):
		
		var collision_point = raycast.get_collision_point()
		var distance_to_collider = raycast.global_position.distance_to(collision_point)
		
		var size_of_explosion_before_collider = max(roundi(absf(distance_to_collider)/ TILE_SIZE - 1), 0)
		return size_of_explosion_before_collider


func execute_explosion_collision(collider: Object):
	if collider is BrickWall:
		(collider as BrickWall).destroy()


func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		(area as Player).die()
	
	#if area is Enemy:
	#	(area as Enemy).die()


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
