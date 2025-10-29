extends RigidBody2D

var dragging:bool
var selling_effect:AudioStreamPlayer2D
const item_id:= 4
var mouse_to_dragging_point:Vector2
var outline_shader:ShaderMaterial
var selling_point:Marker2D
var mouse_rect_entered:bool
@onready var sprite_2d: Sprite2D = $Sprite2D

var deco_control:DecoControl
var moving_mode = false

func _ready() -> void:
	selling_effect = get_tree().get_first_node_in_group("selling_effect")
	deco_control = get_tree().get_first_node_in_group("deco_control")
	selling_effect = get_tree().get_first_node_in_group("selling_effect")
	rotate(randf_range(-PI,PI))
	var rng = RandomNumberGenerator.new()
	rng.randomize() 
	var random_direction = Vector2(rng.randf_range(-1.0, 1.0), rng.randf_range(-1.0, 1.0)).normalized()
	var impulse_magnitude = 50.0
	apply_torque_impulse(randf_range(-80.0,80.0))
	apply_central_impulse(random_direction * impulse_magnitude)
	outline_shader = sprite_2d.material
	outline_shader.set_shader_parameter("outline_size",0.0)
	selling_point = get_tree().get_first_node_in_group("selling_point")
	sprite_2d.hframes = 4
	sprite_2d.vframes = 1
	sprite_2d.frame_coords = Vector2i(randi_range(0,3),0)
func set_dragging_default():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	drag_timer.start()
	mouse_to_dragging_point = position - get_global_mouse_position()

func cancel_selection():
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			can_drag = false
			moving_mode = false
			dragging = false
			freeze = false
			GlobalVariables.mouse_is_dragging = false
			
func _process(_delta: float) -> void:
	if deco_control.current_deco_node == self:
		outline_shader.set_shader_parameter("outline_size",4.0)
	else:outline_shader.set_shader_parameter("outline_size",0.0)
		
	if global_position.distance_squared_to(Vector2(960,544)) > 1300000:
		global_position = Vector2(960,544)
	
	if linear_velocity.length_squared()>90000.0:
		linear_velocity = linear_velocity.normalized()*250.0
	if !dragging:
		freeze = false
		if linear_velocity.length_squared()<= 400.0:
			to_apply_force()
	else:
		freeze = true
	if Input.is_action_just_pressed("left_mouse") and mouse_rect_entered and !dragging:
		deco_control.deco_control_init()
		deco_control.set_deco_node(self,1)
		dragging = true
	if moving_mode:
		position = get_global_mouse_position() + mouse_to_dragging_point
		GlobalVariables.mouse_is_dragging = true
		if Input.is_action_just_pressed("left_mouse") and can_drag:
			linear_velocity = Vector2.ZERO
			angular_velocity = 0.0
			cancel_selection()

	
func to_apply_force():
	if linear_velocity.length_squared()>0:
		var impulse_magnitude = 10.0
		apply_central_impulse(linear_velocity.normalized() * impulse_magnitude)
		apply_torque_impulse(randf_range(-120.0,120.0))
	else:
		var rng = RandomNumberGenerator.new()
		rng.randomize() 
		var random_direction = Vector2(rng.randf_range(-1.0, 1.0), rng.randf_range(-1.0, 1.0)).normalized()
		var impulse_magnitude = 10.0
		apply_central_impulse(random_direction * impulse_magnitude)
		apply_torque_impulse(randf_range(-120.0,120.0))

func to_sell():
	selling_effect.play()
	queue_free()


func _on_color_rect_mouse_entered() -> void:
	if !GlobalVariables.mouse_is_dragging:
		mouse_rect_entered = true


func _on_color_rect_mouse_exited() -> void:
	mouse_rect_entered = false

@onready var drag_timer: Timer = $drag_timer

var can_drag:bool = false
func _on_drag_timer_timeout() -> void:
	can_drag = true
