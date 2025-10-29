extends Control
@onready var draggable: Control = $draggable
var dragging_point:Vector2



func _process(delta: float) -> void:
	if Input.is_action_pressed("right_mouse"):
		dragging_point = draggable.global_position - get_global_mouse_position()
		draggable.global_position = get_global_mouse_position() - dragging_point
	if Input.is_action_just_released("right_mouse"):
		draggable.global_position = get_global_mouse_position() - dragging_point
