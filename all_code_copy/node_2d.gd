extends Node2D

@onready var icon: Sprite2D = $Icon
var in_lerping:bool = false
var starting_angle:float
var ending_angle:float
var elapsed = 0.0
func _process(delta):
	if Input.is_action_just_pressed("left_mouse")and!in_lerping:
		starting_angle = icon.rotation
		ending_angle = (-get_global_mouse_position()+icon.global_position).angle()+PI/2
		in_lerping = true
	if in_lerping:
		icon.rotation = lerp_angle(starting_angle, ending_angle, elapsed)
		elapsed += delta
		print(rad_to_deg(icon.rotation))
		if elapsed >= 1.0:
			in_lerping = false
			elapsed = 0
