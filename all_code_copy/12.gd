
extends RigidBody2D

var deco_control:DecoControl

var moving_mode:bool = false

const item_id:= 12

var save_pos:Vector2 

var outline_shader:ShaderMaterial

var mouse_rect_entered:bool
var dragging:bool

var mouse_to_dragging_point:Vector2



var selling_effect:AudioStreamPlayer2D
func _ready() -> void:
	selling_effect = get_tree().get_first_node_in_group("selling_effect")
	deco_control = get_tree().get_first_node_in_group("deco_control")
	save_pos = global_position
	outline_shader = sprite_2d.material
	outline_shader.set_shader_parameter("outline_size",0.0)


@onready var sprite_2d: Sprite2D = $Sprite2D


@onready var drag_timer: Timer = $drag_timer

#@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
func set_dragging_default():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	drag_timer.start()
	mouse_to_dragging_point = position - get_global_mouse_position()

func cancel_selection():
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			can_drag = false
			moving_mode = false
			dragging = false
			GlobalVariables.mouse_is_dragging = false
			


func _process(_delta: float) -> void:
	if deco_control.current_deco_node == self:
		outline_shader.set_shader_parameter("outline_size",4.0)
	else:outline_shader.set_shader_parameter("outline_size",0.0)
		
	if !dragging:
		freeze = false
	else:
		freeze = true
	if Input.is_action_just_pressed("left_mouse") and mouse_rect_entered and !dragging:
		deco_control.deco_control_init()
		deco_control.set_deco_node(self,0)
		
	if moving_mode:
		position = get_global_mouse_position() + mouse_to_dragging_point
		dragging = true
		GlobalVariables.mouse_is_dragging = true
		
		if Input.is_action_just_pressed("left_mouse") and can_drag:
			linear_velocity = Vector2.ZERO
			angular_velocity = 0.0
			cancel_selection()


		
func _on_color_rect_mouse_entered() -> void:
	if !GlobalVariables.mouse_is_dragging:
		mouse_rect_entered = true



func _on_color_rect_mouse_exited() -> void:
	mouse_rect_entered = false

func to_sell():
	selling_effect.play()
	queue_free()

var can_drag:bool



func _on_drag_timer_timeout() -> void:
	can_drag = true
