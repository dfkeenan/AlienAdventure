tool
extends Resource
class_name Transition

enum TransitionOption { FLIP_X = 1, FLIP_Y = 2, INVERT = 4 }

export(Color, RGBA) var transition_color : Color
export(Texture) var transition_map : Texture
export(TransitionOption,FLAGS) var transition_in_option 
export(TransitionOption,FLAGS) var transition_out_option 

#func _get_configuration_warning() -> String:
#	var warnings: = PoolStringArray()
#
#	if not transition_map:
#		warnings.append("Transition map is missing") 
#
#	return warnings.join("\n")
