extends KinematicBody2D

export(NodePath) onready var tile_map = get_node(tile_map)


var speed: float = 400
var _velocity : Vector2 = Vector2.ZERO
var _direction : Vector2 = Vector2.ZERO

onready var _cell_offset : Vector2 = Vector2(0, tile_map.get_cell_size().y / 2)
onready var _state_machine : AnimationNodeStateMachinePlayback = $AnimationTree["parameters/playback"]
# Called when the node enters the scene tree for the first time.
func _ready():
	assert( tile_map == null or tile_map is TileMap) # asset tile_Map is a TileMap
	
	var pos = position
	var cell = tile_map.world_to_map(pos)
	pos = tile_map.map_to_world(cell)
	pos += _cell_offset
	position = pos
	
	pass # Replace with function body.

func _unhandled_input(event):
	var direction : Vector2 = _direction
	
	if event.is_action_pressed("player_left") or event.is_action_released("player_right"):
		direction.x -= 1
	if event.is_action_pressed("player_right") or event.is_action_released("player_left"):
		direction.x += 1
	if event.is_action_pressed("player_up") or event.is_action_released("player_down"):
		direction.y -= 1
	if event.is_action_pressed("player_down") or event.is_action_released("player_up"):
		direction.y += 1
		
	if direction != _direction:
		_direction = direction
		get_tree().set_input_as_handled()
		if direction == Vector2.ZERO:
			_state_machine.travel("idle")
		else:
			_state_machine.travel("walk")
			$Sprite.scale.x = 1 if direction.x == 0 else sign(direction.x)
	
func _physics_process(delta):	
	
	var current_speed = speed if Input.is_action_pressed("player_run") else speed * 0.5
	_velocity = _direction.normalized() * current_speed
	_velocity = move_and_slide(_velocity)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
