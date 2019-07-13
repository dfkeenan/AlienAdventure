extends Node2D

export var max_deflection: float = 20

onready var _bone : Bone2D = $Skeleton2D/Bone2D
onready var _bone_start_rotation : float = $Skeleton2D/Bone2D.rotation_degrees
onready var _collision_shape : CollisionShape2D = $Area2D/CollisionShape2D

var current_collider : PhysicsBody2D

# Called when the node enters the scene tree for the first time.
func _ready():

	
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_bone_rotation()

func _update_bone_rotation() -> void:
	if current_collider != null:	
		var body_position = current_collider.global_position - _collision_shape.global_position
		
		var deflection = (1 - abs(body_position.x / _collision_shape.shape.extents.x)) * max_deflection * sign(body_position.x)
		
		
		_bone.rotation_degrees = _bone_start_rotation - deflection

func _on_Area2D_body_entered(body:PhysicsBody2D):	
	$Tween.stop_all()
	current_collider = body	
	_update_bone_rotation()


func _on_Area2D_body_exited(body):
	current_collider = null
	$Tween.interpolate_property(_bone, "rotation_degrees",
	_bone.rotation_degrees, 
	_bone_start_rotation, 
	1.2,
	Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	
	$Tween.start()
	#_bone.rotation_degrees = _bone_start_rotation
	pass # Replace with function body.
