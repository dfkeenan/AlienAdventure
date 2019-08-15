extends Node
class_name GameStateManager

signal state_changing

func change_state(next_state_name: String) -> void:
	emit_signal("state_changing")
		
	pass