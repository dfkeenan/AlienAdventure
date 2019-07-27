tool
extends CanvasLayer
class_name TransitionLayer

#const TransitionOption = preload("res://transitions/Transition.gd").TransitionOption

export(float,0,1.0) var cutoff : float setget set_cutoff
export(float) var transition_duration : float = 1

export(Resource) var default_transition setget set_default_transition


signal transition_complete

# Called when the node enters the scene tree for the first time.
func _ready():
	self.cutoff = cutoff
	pass # Replace with function body.

func set_cutoff(value : float) -> void:
	cutoff = value
	if $ColorRect:
		$ColorRect.material.set("shader_param/cutoff",value)

func set_default_transition(value : Resource) -> void:
	if (not value) or value is Transition:
		default_transition = value
	
	
func transition_in(transition: Transition) -> void:	
	$Tween.stop_all()
	self.cutoff = 1
	_set_shader_transition(transition, true)
	$Tween.interpolate_method(self,"set_cutoff", 1,0,transition_duration,Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()
	yield($Tween,"tween_completed")
	$ColorRect.visible = false
	emit_signal("transition_complete")
	
func transition_out(transition : Transition) -> void:	
	$Tween.stop_all()
	self.cutoff = 0
	$ColorRect.visible = true
	_set_shader_transition(transition, false)
	$Tween.interpolate_method(self,"set_cutoff", 0,1,transition_duration,Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()
	yield($Tween,"tween_completed")
	emit_signal("transition_complete")
	

func _set_shader_transition(transition : Transition, is_in : bool) -> void:
	var new_transition = transition
	
	if not new_transition:
		new_transition = default_transition
		
	if not new_transition:
		print("no transition")
		return
		
	var material : ShaderMaterial = $ColorRect.material
	
	material.set("shader_param/transition_map", new_transition.transition_map)
	material.set("shader_param/transition_color", new_transition.transition_color)
	
	var options = new_transition.transition_in_option if is_in else new_transition.transition_out_option
	
	material.set("shader_param/invert", options & Transition.TransitionOption.INVERT != 0)
	material.set("shader_param/flip_x", options & Transition.TransitionOption.FLIP_X != 0)
	material.set("shader_param/flip_y", options & Transition.TransitionOption.FLIP_Y != 0)
	
func _get_configuration_warning():
	var warnings = PoolStringArray()
	if not default_transition:
		warnings.append("% is missing a default transition." % name)
	
	elif not default_transition is Transition:
		warnings.append("% is has invalid a default transition." % name)
		
	return warnings.join("\n")