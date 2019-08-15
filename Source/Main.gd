extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	SceneTransition.default_transition = load("res://core/transitions/assets/alien_transition.tres")
	SceneTransition.transition_in(null)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _unhandled_input(event):
	if Input.is_key_pressed(KEY_R):
		SceneTransition.transition_out(null)
		yield(SceneTransition,"transition_complete")
		yield(get_tree().create_timer(1),"timeout")
		get_tree().reload_current_scene()