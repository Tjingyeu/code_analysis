class_name DecoControl
extends Control
@onready var h_box_container: HBoxContainer = $HBoxContainer

var self_width:float
var current_deco_node:Node2D
var old_deco_node:Node2D
func _ready() -> void:
	self.pivot_offset = h_box_container.size/2
	self_width = h_box_container.size.x/2
	self.position = Vector2.ZERO

func _process(_delta: float) -> void:
	if current_deco_node!=null and is_instance_valid(current_deco_node):
		if Input.is_action_just_pressed("left_mouse") and !current_deco_node.mouse_rect_entered:
			current_deco_node.cancel_selection()
			deco_control_collapse()
			current_deco_node = null
		
func deco_control_init():
	self.visible = true
	self.modulate = Color(1,1,1,1)

func set_deco_node(node:Node2D,mode:int):
	if old_deco_node!= null and is_instance_valid(old_deco_node):
		old_deco_node.cancel_selection()
	self.set("current_deco_node",node)
	match mode:
		0:
			position = current_deco_node.global_position +Vector2(960,544) - Vector2(self_width,128.0)
		1:
			position = current_deco_node.global_position  - Vector2(self_width,128.0)
	old_deco_node = current_deco_node
	

func deco_control_collapse():
	self.modulate = Color(1,1,1,0)
	self.visible = false
	global_position = Vector2.ZERO
	#current_deco_node.cancel_selection()
	current_deco_node = null
	



func _on_move_button_button_down() -> void:

	current_deco_node.set("moving_mode",true)
	current_deco_node.set_dragging_default()
	deco_control_collapse()




func _on_trash_button_button_down() -> void:

	current_deco_node.to_sell()
	deco_control_collapse()
