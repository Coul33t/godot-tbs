extends Node2D

enum DIRECTIONS {LEFT, UP, RIGHT, DOWN}
var _directions: Dictionary = {DIRECTIONS.LEFT : Vector2i(0, -1),
							   DIRECTIONS.UP   : Vector2i(1, 0),
							   DIRECTIONS.RIGHT: Vector2i(0, 1),
							   DIRECTIONS.DOWN : Vector2i(-1, 0)}

func move_sprite(dir):
	var dxdy: Vector2i = _directions[dir]
	var dx: int = dxdy[0]
	var dy: int = dxdy[1]
	if (dx > 1 or dx < 1) and dx != 0:
		dx = dx/abs(dx)
	if (dy > 1 or dy < 1) and dy != 0:
		dy = dy/abs(dy)
	
	var current_pos: Vector2i = $Tiles.local_to_map($Red.position)
	current_pos.x += dx
	current_pos.y += dy
	$Red.position = $Tiles.map_to_local(current_pos)
	
func rotate_sprite(dir: int):
	if dir == DIRECTIONS.DOWN:
		$Red.play("default_down")
	elif dir == DIRECTIONS.LEFT:
		$Red.play("default_left")
	elif dir == DIRECTIONS.UP:
		$Red.play("default_up")
	elif dir == DIRECTIONS.RIGHT:
		$Red.play("default_right")
	
func move_and_rotate_sprite(dir: int):
	rotate_sprite(dir)
	move_sprite(dir)
	
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
		move_and_rotate_sprite(DIRECTIONS.RIGHT)
	elif Input.is_action_just_pressed("ui_left"):
		move_and_rotate_sprite(DIRECTIONS.LEFT)
	elif Input.is_action_just_pressed("ui_up"):
		move_and_rotate_sprite(DIRECTIONS.UP)
	elif Input.is_action_just_pressed("ui_down"):
		move_and_rotate_sprite(DIRECTIONS.DOWN)
