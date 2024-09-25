extends Node2D

func move_sprite(dx: int, dy: int):
	if (dx > 1 or dx < 1) and dx != 0:
		dx = dx/dx
	if (dy > 1 or dy < 1) and dy != 0:
		dy = dy/dy
	
	var current_pos: Vector2i = $Tiles.local_to_map($Red.position)
	current_pos.x += dx
	current_pos.y += dy
	$Red.position = $Tiles.map_to_local(current_pos)
	
func rotate_sprite():
	pass
	
func move_and_rotate_sprite():
	pass
	
func instantiate_sprite(scene_obj: Resource, name_obj: String, starting_tile: Vector2i, z_level: int, play: bool):
	var output = scene_obj.instantiate()
	output.set_name(name_obj)
	output.position = $Tiles.map_to_local(starting_tile)
	output.z_index = z_level
	
	if play:
		output.play("default")

	add_child(output)

# Called when the node enters the scene tree for the first time.
func _ready():
	var cid_scene = load("res://cid.tscn")
	var red_scene = load("res://red.tscn")
	instantiate_sprite(cid_scene, "Cid", Vector2i(-2, 4), 2, true)
	instantiate_sprite(red_scene, "Red", Vector2i(-1, 3), 2, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		move_sprite(0, 1)
	elif Input.is_action_just_pressed("ui_left"):
		move_sprite(0, -1)
	elif Input.is_action_just_pressed("ui_up"):
		move_sprite(1, 0)
	elif Input.is_action_just_pressed("ui_down"):
		move_sprite(-1, 0)
