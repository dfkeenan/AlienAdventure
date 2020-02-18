extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var _scene_transition : TransitionLayer = $SceneTransition


# Called when the node enters the scene tree for the first time.
func _ready():
	_scene_transition.transition_in(null)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _unhandled_input(event):
	if Input.is_key_pressed(KEY_R):
		_scene_transition.transition_out(null)
		yield(_scene_transition,"transition_complete")
		yield(get_tree().create_timer(1),"timeout")
		get_tree().reload_current_scene()
