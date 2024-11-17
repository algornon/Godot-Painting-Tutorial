extends Node

@export var painting: PaintingResource = PaintingResource.new()
@onready var canvas = get_tree().current_scene.get_node("%Canvas")

# Called when an InputEvent occurs
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("paint"):
		canvas.show()
