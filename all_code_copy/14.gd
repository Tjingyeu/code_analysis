extends StaticBody2D

var deco_control:DecoControl

const item_id:= 14
var save_pos:Vector2 

var natural_speed:float = 0.5
var next_pos:Vector2
var current_pos:Vector2
var moving_range:float
var t:float
var moving_mode:bool
var can_drag:bool
@onready var drag_timer: Timer = $drag_timer

var outline_shader:ShaderMaterial

var mouse_rect_entered:bool
var dragging:bool

var mouse_to_dragging_point:Vector2

var selling_effect:AudioStreamPlayer2D

func _ready() -> void:
	save_pos = global_position
	var random_angle = randf_range(-PI,PI)
	current_pos = sprite_2d.position
	moving_range = randf_range(5.0,15.0)
	next_pos = Vector2(cos(random_angle),sin(random_angle))*moving_range
	natural_speed = randf_range(0.1,0.4)
	#sprite_2d.material.duplicate()
	outline_shader = sprite_2d.material
	outline_shader.set_shader_parameter("outline_size",0.0)
	selling_effect = get_tree().get_first_node_in_group("selling_effect")
	deco_control = get_tree().get_first_node_in_group("deco_control")

@onready var sprite_2d: Sprite2D = $Sprite2D

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
			
func _process(delta: float) -> void:
	if deco_control.current_deco_node == self:
		outline_shader.set_shader_parameter("outline_size",4.0)
	else:outline_shader.set_shader_parameter("outline_size",0.0)
		
	if !dragging:
		natural_movement(delta)
	if Input.is_action_just_pressed("left_mouse") and mouse_rect_entered and !dragging:
		deco_control.deco_control_init()
		deco_control.set_deco_node(self,1)
		
	if moving_mode:
		position = get_global_mouse_position() + mouse_to_dragging_point
		dragging = true
		GlobalVariables.mouse_is_dragging = true
		
		if Input.is_action_just_pressed("left_mouse") and can_drag:
			cancel_selection()

func natural_movement(delta:float):

	t += delta*natural_speed
	sprite_2d.position = current_pos.lerp(next_pos,t)
	if t>=1.0:
		t = 0.0
		natural_speed = randf_range(0.1,0.4)
		current_pos = next_pos
		moving_range = randf_range(5.0,15.0)
		next_pos = Vector2(cos(randf_range(-PI,PI)),sin(randf_range(-PI,PI)))*moving_range



func _on_color_rect_mouse_entered() -> void:
	if !GlobalVariables.mouse_is_dragging:
		mouse_rect_entered = true


func _on_color_rect_mouse_exited() -> void:
	mouse_rect_entered = false

func to_sell():
	selling_effect.play()
	queue_free()


func _on_drag_timer_timeout() -> void:
	can_drag = true
