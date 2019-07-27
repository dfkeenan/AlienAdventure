tool
extends CanvasLayer

export(float,0,1.0) var cutoff : float setget set_cutoff
export(float) var transition_duration : float = 1
export(Color, RGBA) var transition_color : Color setget set_transition_color
export(Texture) var transition_map : Texture setget set_transition_map

# Called when the node enters the scene tree for the first time.
func _ready():
	self.cutoff = cutoff
	self.transition_color = transition_color
	self.transition_map = transition_map
	pass # Replace with function body.

func set_cutoff(value : float) -> void:
	cutoff = value
	if $ColorRect:
		$ColorRect.material.set("shader_param/cutoff",value)

func set_transition_color(value : Color) -> void:
	transition_color = value
	if $ColorRect:
		$ColorRect.material.set("shader_param/transition_color",value)
	
func set_transition_map(value : Texture) -> void:
	transition_map = value
	if $ColorRect:
		$ColorRect.material.set("shader_param/transition_map",value)
	
	
func transition_in() -> void:
	$Tween.stop_all()
	$Tween.interpolate_method(self,"set_cutoff", 1,0,transition_duration,Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()
	
func transition_out() -> void:	
	$Tween.stop_all()
	$Tween.interpolate_method(self,"set_cutoff", 0,1,transition_duration,Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()