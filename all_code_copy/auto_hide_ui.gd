extends Node2D
@onready var texture_rect: TextureRect = $"../CanvasLayer/TextureRect"
@onready var texture_rect_2: TextureRect = $"../CanvasLayer/TextureRect2"
@onready var panel_container: PanelContainer = $"../CanvasLayer/PanelContainer"

var Graphic_kernel:GraphicKernel

var original_pos0:Vector2
var original_pos1:Vector2
var original_pos2:Vector2
var mouse_detected:bool = false
var ui_tween:Tween

func _ready() -> void:
	original_pos0 = texture_rect.global_position
	original_pos1 = texture_rect_2.global_position
	original_pos2 = panel_container.global_position
	Graphic_kernel = get_tree().get_first_node_in_group("main")
@onready var autohide: Timer = $autohide

func _input(event: InputEvent) -> void:
	if GlobalVariables.auto_hide:
		if event is InputEventMouseMotion:
			_on_mouse_detection_mouse_entered()
			autohide.start()

func _on_mouse_detection_mouse_entered() -> void:
	mouse_detected = true
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	ui_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel(true)
	ui_tween.tween_property(texture_rect,"position",Vector2(0,4),0.2)

	ui_tween.tween_property(texture_rect_2,"position",Vector2(472,-1),0.2)

	ui_tween.tween_property(panel_container,"position",Vector2(0,0),0.2)


func _on_mouse_detection_mouse_exited() -> void:
	ui_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel(true)
	ui_tween.tween_property(texture_rect,"global_position",original_pos0,1.0)
	ui_tween.tween_property(texture_rect_2,"global_position",original_pos1,1.0)
	ui_tween.tween_property(panel_container,"global_position",original_pos2,1.0)
	mouse_detected = false
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_autohide_timeout() -> void:
	_on_mouse_detection_mouse_exited()
	Graphic_kernel.fold_pond_panel()
