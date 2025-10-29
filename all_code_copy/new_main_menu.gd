extends Control

@onready var start: TextureButton = $menu/VBoxContainer/Start
@onready var start_lbl: RichTextLabel = $menu/VBoxContainer/Start/Start_lbl
@onready var quit: TextureButton = $menu/VBoxContainer/Quit
@onready var quit_lbl: RichTextLabel = $menu/VBoxContainer/Quit/Quit_lbl
@onready var credit: TextureButton = $menu/VBoxContainer/credit
@onready var credit_lbl: RichTextLabel = $menu/VBoxContainer/credit/credit_lbl
#@onready var koi_light: PointLight2D
@onready var background_koi: Sprite2D = $BackgroundKoi
@onready var main_menu_mouse_stop: ColorRect = $"../main_menu_mouse_stop"
@onready var koi_icon_trans_export: Sprite2D = $KoiIconTransExport

#var koi_round_shader:ShaderMaterial
var in_credit_scene:bool
@onready var blur: ColorRect = $blur
#@onready var blur: ColorRect = $CanvasLayer/blur
#@onready var background_koi: Sprite2D = $CanvasLayer/BackgroundKoi
var ray_shader:ShaderMaterial
var blur_shader:ShaderMaterial
const WATER_SURFACE_MAIN = preload("res://main/water_surface_main.tscn")
var graphic_core:GraphicKernel
var main_menu_tween:Tween
func _ready() -> void:
	#koi_light = get_tree().get_first_node_in_group("light")
	graphic_core = get_tree().get_first_node_in_group("main")
	blur_shader = blur.material
	ray_shader = background_koi.material
	#koi_round_shader = background_koi.material
	
#@onready var transition: Transition = $"../Camera2D/CanvasLayer/transition"

#@onready var transition: Transition = $"../CanvasLayer/transition"
#func transition_anime():
	#transition.total_transition()
	#transition.visible = true
	#transition.global_position = get_local_mouse_position()
	#transition.modulate = Color(GlobalVariables.color_list.pick_random())
	#get_local_mouse_position()+Vector2(960+1920,0)
	#await transition
func _on_start_button_down() -> void:
	#print("start")
	#transition_anime()
	main_menu_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel(true)
	#main_menu_tween.tween_property(blur_shader,"shader_parameter/sigma",0.0,1.0)
	main_menu_tween.tween_property(self,"modulate",Color(1,1,1,0),1.0)
	main_menu_tween.tween_property(ray_shader,"shader_parameter/size",100.0,1.0)
	main_menu_tween.tween_property(koi_icon_trans_export,"modulate",Color(1,1,1,0),1.0)
	#main_menu_tween.tween_property(koi_round_shader,"shader_parameter/modulate",0.0,1.0)
	main_menu_mouse_stop.visible = false
	await main_menu_tween.finished
	self.visible = false
	_on_transition_start_game()
	graphic_core.show_ui()


func _on_quit_button_down() -> void:

	get_tree().quit()



func _on_start_mouse_entered() -> void:
	start_lbl.text = "[rainbow][wave][font_size={64}]Start Game"
	var tween = create_tween()
	tween.tween_property(start_lbl,"self_modulate",Color(1.4,1.4,1.4,1),0.1)

func _on_start_mouse_exited() -> void:
	start_lbl.text = "[wave][font_size={64}]Start Game"
	var tween = create_tween()
	tween.tween_property(start_lbl,"self_modulate",Color(1,1,1,1),0.1)


func _on_quit_mouse_entered() -> void:
	quit_lbl.text = "[rainbow][font_size={64}]Quit"
	var tween = create_tween()
	tween.tween_property(quit_lbl,"self_modulate",Color(1.4,1.4,1.4,1),0.1)


func _on_quit_mouse_exited() -> void:
	quit_lbl.text = "[font_size={64}]Quit"
	var tween = create_tween()
	tween.tween_property(quit_lbl,"self_modulate",Color(1,1,1,1),0.1)


@onready var credit_scene: Node2D = $credit_scene
func _on_credit_button_down() -> void:
	credit_scene.visible = true
	var tween = create_tween()
	tween.tween_property(credit_scene,"modulate",Color(1,1,1,1),1.0)
	


func _on_credit_mouse_entered() -> void:
	credit_lbl.text = "[rainbow][font_size={64}]Credits"
	var tween = create_tween()
	tween.tween_property(credit_lbl,"self_modulate",Color(1.4,1.4,1.4,1),0.1)


func _on_credit_mouse_exited() -> void:
	credit_lbl.text = "[font_size={64}]Credits"
	var tween = create_tween()
	tween.tween_property(credit_lbl,"self_modulate",Color(1,1,1,1),0.1)


func _on_transition_start_game() -> void:
	graphic_core.game_start()


#
#func tween_light():
	#var tween = create_tween()
	##tween.tween_property(koi_light,"texture_scale",3.0,3.0)
	#await  tween.finished
	#var new_tween = create_tween()
	##new_tween.tween_property(koi_light,"texture_scale",5.0,3.0)
	#await new_tween.finished
	#tween_light()
	#


func _on_close_credit_mouse_entered() -> void:
	in_credit_scene = true


func _on_close_credit_mouse_exited() -> void:
	in_credit_scene = false

func _process(_delta: float) -> void:
	if in_credit_scene:
		if Input.is_action_just_pressed("left_mouse"):
			in_credit_scene = false
			var tween = create_tween()
			tween.tween_property(credit_scene,"modulate",Color(1,1,1,0),1.0)
			await tween.finished
			credit_scene.visible = false
