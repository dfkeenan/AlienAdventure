extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _inventory_container : Control = $CenterContainer/InventoryContainer
# Called when the node enters the scene tree for the first time.
func _ready():
	_inventory_container.visible = false
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("toggle_inventory"):
		_inventory_container.visible = !_inventory_container.visible