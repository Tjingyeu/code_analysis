class_name PondManager
extends Node2D

var current_pond_index:int
#var local_pond_index:int
@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var canvas_layer: CanvasLayer = $"../Camera2D/CanvasLayer"

#@onready var transition: Transition = $"../Camera2D/CanvasLayer/transition"
@onready var p_2_btn: TextureButton = $"../CanvasLayer/TextureRect2/pond_panel/VBoxContainer/p2_btn"
@onready var p_3_btn: TextureButton = $"../CanvasLayer/TextureRect2/pond_panel/VBoxContainer/p3_btn"
#@onready var decorations: Control = $"../CanvasLayer/decorations"
@onready var underwater_decos: Node2D = $"../underwater_decos"
@onready var surface_deco: Node2D = $"../CanvasLayer/surface_deco"

func start() -> void:
	graphic_core = get_tree().get_first_node_in_group("main")
	if GlobalVariables.tank_size_lvl1 > 0 :
		p_2_btn.disabled = false
	if GlobalVariables.tank_size_lvl2 > 0 :
		p_3_btn.disabled = false



func _on_p_2_btn_button_down() -> void:
	current_pond_index = 1
	_on_transition_switch_koi_pond()
	#if current_pond_index!=graphic_core.local_pond_index:
		#transition.global_position = get_global_mouse_position()-camera_2d.global_position
		#transition.to_switch_pond()
	

func _on_p_3_btn_button_down() -> void:
	current_pond_index = 2
	_on_transition_switch_koi_pond()
	#if current_pond_index!=graphic_core.local_pond_index:
		#transition.global_position = get_global_mouse_position()-camera_2d.global_position
		#transition.to_switch_pond()


func _on_p_1_btn_button_down() -> void:
	current_pond_index = 0
	_on_transition_switch_koi_pond()
	#if current_pond_index!=graphic_core.local_pond_index:
		#transition.global_position = get_global_mouse_position()-camera_2d.global_position
		#transition.to_switch_pond()

var graphic_core:GraphicKernel

func _on_transition_switch_koi_pond() -> void:
	graphic_core.to_save_game()
	for i:Snake in graphic_core.snakes:
		i.snake_body.queue_free()
		i.fish_fin.queue_free()
		i.fish_tail.queue_free()
		i.queue_free()
	graphic_core.snakes = []
	
	for i in surface_deco.get_children():
		i.queue_free()
	for i in underwater_decos.get_children():
		i.queue_free()

	
	graphic_core.switch_pond(current_pond_index)
