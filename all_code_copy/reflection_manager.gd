extends Node2D

class_name ReflectionManager
@onready var graphic_logic_kernel: GraphicKernel = $".."

var current_reflection: int = 0

# --- Visual & Sprite Nodes ---
@onready var visual_0: SubViewportContainer = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer2/reflection0/visual0"
@onready var sprite_0: Sprite2D = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer2/reflection0/visual0/SubViewport/Panel/Sprite0"
var refl_shader0:ShaderMaterial

@onready var visual_1: SubViewportContainer = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer3/reflection1/visual1"
@onready var sprite_1: Sprite2D = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer3/reflection1/visual1/SubViewport/Panel/Sprite1"
var refl_shader1:ShaderMaterial

@onready var visual_2: SubViewportContainer = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer4/reflection2/visual2"
@onready var sprite_2: Sprite2D = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer4/reflection2/visual2/SubViewport/Panel/Sprite2"
var refl_shader2:ShaderMaterial

@onready var visual_3: SubViewportContainer = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer5/reflection3/visual3"
@onready var sprite_3: Sprite2D = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer5/reflection3/visual3/SubViewport/Panel/Sprite3"
var refl_shader3:ShaderMaterial

@onready var visual_4: SubViewportContainer = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer6/reflection4/visual4"
@onready var sprite_4: Sprite2D = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer6/reflection4/visual4/SubViewport/Panel/Sprite4"
var refl_shader4:ShaderMaterial

@onready var visual_5: SubViewportContainer = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer7/reflection5/visual5"
@onready var sprite_5: Sprite2D = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer7/reflection5/visual5/SubViewport/Panel/Sprite5"
var refl_shader5:ShaderMaterial

@onready var visual_6: SubViewportContainer = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer8/reflection6/visual6"
@onready var sprite_6: Sprite2D = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer8/reflection6/visual6/SubViewport/Panel/Sprite6"
var refl_shader6:ShaderMaterial

@onready var visual_7: SubViewportContainer = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer9/reflection7/visual7"
@onready var sprite_7: Sprite2D = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer9/reflection7/visual7/SubViewport/Panel/Sprite7"
var refl_shader7:ShaderMaterial

@onready var visual_8: SubViewportContainer = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer10/reflection8/visual8"
@onready var sprite_8: Sprite2D = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer10/reflection8/visual8/SubViewport/Panel/Sprite8"
var refl_shader8:ShaderMaterial

@onready var visual_9: SubViewportContainer = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer11/reflection9/visual9"
@onready var sprite_9: Sprite2D = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer11/reflection9/visual9/SubViewport/Panel/Sprite9"
var refl_shader9:ShaderMaterial

@onready var visual_10: SubViewportContainer = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer12/reflection10/visual10"
@onready var sprite_10: Sprite2D = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer12/reflection10/visual10/SubViewport/Panel/Sprite10"
var refl_shader10:ShaderMaterial

@onready var visual_11: SubViewportContainer = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer13/reflection11/visual11"
@onready var sprite_11: Sprite2D = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer13/reflection11/visual11/SubViewport/Panel/Sprite11"
var refl_shader11:ShaderMaterial

@onready var visual_12: SubViewportContainer = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer14/reflection12/visual12"
@onready var sprite_12: Sprite2D = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer14/reflection12/visual12/SubViewport/Panel/Sprite12"
var refl_shader12:ShaderMaterial

@onready var visual_13: SubViewportContainer = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer15/reflection13/visual13"
@onready var sprite_13: Sprite2D = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer15/reflection13/visual13/SubViewport/Panel/Sprite13"
var refl_shader13:ShaderMaterial

@onready var visual_14: SubViewportContainer = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer16/reflection14/visual14"
@onready var sprite_14: Sprite2D = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer16/reflection14/visual14/SubViewport/Panel/Sprite14"
var refl_shader14:ShaderMaterial

@onready var visual_15: SubViewportContainer = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer17/reflection15/visual15"
@onready var sprite_15: Sprite2D = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer17/reflection15/visual15/SubViewport/Panel/Sprite15"
var refl_shader15:ShaderMaterial

@onready var visual_16: SubViewportContainer = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer18/reflection16/visual16"
@onready var sprite_16: Sprite2D = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer18/reflection16/visual16/SubViewport/Panel/Sprite16"
var refl_shader16:ShaderMaterial

@onready var visual_17: SubViewportContainer = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer19/reflection17/visual17"
@onready var sprite_17: Sprite2D = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer19/reflection17/visual17/SubViewport/Panel/Sprite17"
var refl_shader17:ShaderMaterial

# ADDED: A list to easily access visual nodes by index
var visual_list = []

@onready var _0_label: RichTextLabel = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer2/reflection0/0_label"
@onready var _1_label: RichTextLabel = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer3/reflection1/1_label"
@onready var _2_label: RichTextLabel = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer4/reflection2/2_label"
@onready var _3_label: RichTextLabel = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer5/reflection3/3_label"
@onready var _4_label: RichTextLabel = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer6/reflection4/4_label"
@onready var _5_label: RichTextLabel = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer7/reflection5/5_label"
@onready var _6_label: RichTextLabel = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer8/reflection6/6_label"
@onready var _7_label: RichTextLabel = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer9/reflection7/7_label"
@onready var _8_label: RichTextLabel = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer10/reflection8/8_label"
@onready var _9_label: RichTextLabel = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer11/reflection9/9_label"
@onready var _10_label: RichTextLabel = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer12/reflection10/10_label"
@onready var _11_label: RichTextLabel = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer13/reflection11/11_label"
@onready var _12_label: RichTextLabel = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer14/reflection12/12_label"
@onready var _13_label: RichTextLabel = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer15/reflection13/13_label"
@onready var _14_label: RichTextLabel = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer16/reflection14/14_label"
@onready var _15_label: RichTextLabel = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer17/reflection15/15_label"
@onready var _16_label: RichTextLabel = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer18/reflection16/16_label"
@onready var _17_label: RichTextLabel = $"../CanvasLayer/world_map/Surface/ScrollContainer/GridContainer/MarginContainer19/reflection17/17_label"

var lable_array:=[]

func _ready() -> void:
	refl_shader0 = visual_0.material
	refl_shader1 = visual_1.material
	refl_shader2 = visual_2.material
	refl_shader3 = visual_3.material
	refl_shader4 = visual_4.material
	refl_shader5 = visual_5.material
	refl_shader6 = visual_6.material
	refl_shader7 = visual_7.material
	refl_shader8 = visual_8.material
	refl_shader9 = visual_9.material
	refl_shader10 = visual_10.material
	refl_shader11 = visual_11.material
	refl_shader12 = visual_12.material
	refl_shader13 = visual_13.material
	refl_shader14 = visual_14.material
	refl_shader15 = visual_15.material
	refl_shader16 = visual_16.material
	refl_shader17 = visual_17.material
	
	# ADDED: Populating the list with all the visual nodes
	visual_list = [
		visual_0, visual_1, visual_2, visual_3, visual_4, visual_5, 
		visual_6, visual_7, visual_8, visual_9, visual_10, visual_11, 
		visual_12, visual_13, visual_14, visual_15, visual_16, visual_17
	]
	lable_array = [
		_0_label,_1_label,_2_label,_3_label,_4_label,_5_label,_6_label,_7_label,_8_label,_9_label,_10_label,_11_label,_12_label,_13_label,_14_label,_15_label,_16_label,_17_label
	]
	
	for i in lable_array.size():
		lable_array[i].text = "[center]%s
[color=#F7D59C]%s ¥[/color][/center]" %[CostsTable.pond_reflection_database[i],GlobalVariables.number_format(CostsTable.surface_cost_table[i])]

# --- NEW/MODIFIED FUNCTIONS START HERE ---

# MODIFIED: This function now handles purchasing AND selecting owned items.
func reflection_purchase_button(button_index:int) -> void:
	if GlobalVariables.shopping_list_surface[button_index] == false:
		# Logic for purchasing a new item
		if GlobalVariables.gold_current >= CostsTable.surface_cost_table[button_index]:
			GlobalVariables.gold_current -= CostsTable.surface_cost_table[button_index]
			GlobalVariables.shopping_list_surface[button_index] = true
			
			reset_visual(current_reflection)
			graphic_logic_kernel.set_surface(button_index)
			graphic_logic_kernel.to_save_game()
			set_visual(button_index)
			current_reflection = button_index
	else:
		# Logic for selecting an already-owned item
		reset_visual(current_reflection)
		graphic_logic_kernel.set_surface(button_index)
		graphic_logic_kernel.to_save_game()
		set_visual(button_index)
		current_reflection = button_index

# ADDED: Functions to visually show the current selection
func set_visual(button_index:int):
	var tween:Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(visual_list[button_index].get_parent().material,"shader_parameter/size",1.0,1.0)

func reset_visual(button_index:int):
	var tween:Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(visual_list[button_index].get_parent().material,"shader_parameter/size",2.0,1.0)
	
# --- UNCHANGED CODE CONTINUES BELOW ---


# --- Button Down Signals ---

func _on_reflection_0_button_down() -> void:
	mouse_clicked_tween(visual_0)
	reflection_purchase_button(0)

func _on_reflection_1_button_down() -> void:
	mouse_clicked_tween(visual_1)
	reflection_purchase_button(1)

func _on_reflection_2_button_down() -> void:
	mouse_clicked_tween(visual_2)
	reflection_purchase_button(2)

func _on_reflection_3_button_down() -> void:
	mouse_clicked_tween(visual_3)
	reflection_purchase_button(3)

func _on_reflection_4_button_down() -> void:
	mouse_clicked_tween(visual_4)
	reflection_purchase_button(4)

func _on_reflection_5_button_down() -> void:
	mouse_clicked_tween(visual_5)
	reflection_purchase_button(5)

func _on_reflection_6_button_down() -> void:
	mouse_clicked_tween(visual_6)
	reflection_purchase_button(6)

func _on_reflection_7_button_down() -> void:
	mouse_clicked_tween(visual_7)
	reflection_purchase_button(7)

func _on_reflection_8_button_down() -> void:
	mouse_clicked_tween(visual_8)
	reflection_purchase_button(8)

func _on_reflection_9_button_down() -> void:
	mouse_clicked_tween(visual_9)
	reflection_purchase_button(9)

func _on_reflection_10_button_down() -> void:
	mouse_clicked_tween(visual_10)
	reflection_purchase_button(10)

func _on_reflection_11_button_down() -> void:
	mouse_clicked_tween(visual_11)
	reflection_purchase_button(11)

func _on_reflection_12_button_down() -> void:
	mouse_clicked_tween(visual_12)
	reflection_purchase_button(12)

func _on_reflection_13_button_down() -> void:
	mouse_clicked_tween(visual_13)
	reflection_purchase_button(13)

func _on_reflection_14_button_down() -> void:
	mouse_clicked_tween(visual_14)
	reflection_purchase_button(14)

func _on_reflection_15_button_down() -> void:
	mouse_clicked_tween(visual_15)
	reflection_purchase_button(15)

func _on_reflection_16_button_down() -> void:
	mouse_clicked_tween(visual_16)
	reflection_purchase_button(16)

func _on_reflection_17_button_down() -> void:
	mouse_clicked_tween(visual_17)
	reflection_purchase_button(17)

# --- UI Effect Logic & Helpers ---

var tween_hover:Tween
var tween_rot:Tween
var tween_clicked:Tween
var tween_sprite:Tween
var angle_x_max:float = 0.3
var angle_y_max:float = 0.3

func D2_perspect_gui(viewport:SubViewportContainer,shader:ShaderMaterial):
	var mouse_pos:Vector2 = get_local_mouse_position() + Vector2(1920.0/2,1088.0/2) - viewport.global_position
	
	var lerp_val_x:float=remap(mouse_pos.x,0.0,viewport.size.x,0,1)
	var lerp_val_y:float=remap(mouse_pos.y,0.0,viewport.size.y,0,1)
	
	var rot_x:float = rad_to_deg(lerp_angle(-angle_x_max,angle_x_max,lerp_val_x))
	var rot_y:float = rad_to_deg(lerp_angle(angle_y_max,-angle_y_max,lerp_val_y))

	shader.set_shader_parameter("x_rot",rot_y)
	shader.set_shader_parameter("y_rot",rot_x)

func mouse_clicked_tween(viewport:SubViewportContainer):
	tween_clicked = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BOUNCE)
	tween_clicked.tween_property(viewport,"scale",Vector2(0.75,0.75),0.1)
	tween_clicked.tween_property(viewport,"scale",Vector2(1.0,1.0),0.1)

func mouse_enter_tween(viewport:SubViewportContainer):
	viewport.pivot_offset = viewport.size/2
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO).set_parallel(true)
	tween_hover.tween_property(viewport,"scale",Vector2(1.2,1.2),0.5)

func mouse_out_tween(viewport:SubViewportContainer,shader:ShaderMaterial,sprite:Sprite2D):
	tween_rot = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).set_parallel(true)
	tween_rot.tween_property(shader,"shader_parameter/x_rot",0.0,0.5)
	tween_rot.tween_property(shader,"shader_parameter/y_rot",0.0,0.5)

	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(viewport,"scale",Vector2.ONE,0.55)
	
	tween_sprite = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO).set_parallel(true)
	tween_sprite.tween_property(sprite,"region_rect",Rect2(256.0,256.0,1536.0,1536.0),0.2)

func sprite_region_remap(viewport:SubViewportContainer,sprite:Sprite2D):
	var mouse_pos:Vector2 = get_local_mouse_position() + Vector2(1920.0/2,1088.0/2) - viewport.global_position
	
	var region_x_remap = remap(mouse_pos.x,0.0,viewport.size.x,0.0,512.0)
	var region_y_remap = remap(mouse_pos.y,0.0,viewport.size.y,0.0,512.0)
	
	sprite.region_rect = Rect2(region_x_remap,region_y_remap,1536.0,1536.0)
	
# --- UI Interaction Signals ---

## Reflection 0
func _on_reflection_0_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		sprite_region_remap(visual_0,sprite_0)
		D2_perspect_gui(visual_0,refl_shader0)
func _on_reflection_0_mouse_entered() -> void:
	mouse_enter_tween(visual_0)
func _on_reflection_0_mouse_exited() -> void:
	mouse_out_tween(visual_0,refl_shader0,sprite_0)

## Reflection 1
# ... and so on for all 17 reflections, unchanged.
func _on_reflection_1_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		sprite_region_remap(visual_1,sprite_1)
		D2_perspect_gui(visual_1,refl_shader1)
func _on_reflection_1_mouse_entered() -> void:
	mouse_enter_tween(visual_1)
func _on_reflection_1_mouse_exited() -> void:
	mouse_out_tween(visual_1,refl_shader1,sprite_1)

## Reflection 2
func _on_reflection_2_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		sprite_region_remap(visual_2,sprite_2)
		D2_perspect_gui(visual_2,refl_shader2)
func _on_reflection_2_mouse_entered() -> void:
	mouse_enter_tween(visual_2)
func _on_reflection_2_mouse_exited() -> void:
	mouse_out_tween(visual_2,refl_shader2,sprite_2)

## Reflection 3
func _on_reflection_3_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		sprite_region_remap(visual_3,sprite_3)
		D2_perspect_gui(visual_3,refl_shader3)
func _on_reflection_3_mouse_entered() -> void:
	mouse_enter_tween(visual_3)
func _on_reflection_3_mouse_exited() -> void:
	mouse_out_tween(visual_3,refl_shader3,sprite_3)

## Reflection 4
func _on_reflection_4_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		sprite_region_remap(visual_4,sprite_4)
		D2_perspect_gui(visual_4,refl_shader4)
func _on_reflection_4_mouse_entered() -> void:
	mouse_enter_tween(visual_4)
func _on_reflection_4_mouse_exited() -> void:
	mouse_out_tween(visual_4,refl_shader4,sprite_4)

## Reflection 5
func _on_reflection_5_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		sprite_region_remap(visual_5,sprite_5)
		D2_perspect_gui(visual_5,refl_shader5)
func _on_reflection_5_mouse_entered() -> void:
	mouse_enter_tween(visual_5)
func _on_reflection_5_mouse_exited() -> void:
	mouse_out_tween(visual_5,refl_shader5,sprite_5)

## Reflection 6
func _on_reflection_6_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		sprite_region_remap(visual_6,sprite_6)
		D2_perspect_gui(visual_6,refl_shader6)
func _on_reflection_6_mouse_entered() -> void:
	mouse_enter_tween(visual_6)
func _on_reflection_6_mouse_exited() -> void:
	mouse_out_tween(visual_6,refl_shader6,sprite_6)

## Reflection 7
func _on_reflection_7_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		sprite_region_remap(visual_7,sprite_7)
		D2_perspect_gui(visual_7,refl_shader7)
func _on_reflection_7_mouse_entered() -> void:
	mouse_enter_tween(visual_7)
func _on_reflection_7_mouse_exited() -> void:
	mouse_out_tween(visual_7,refl_shader7,sprite_7)

## Reflection 8
func _on_reflection_8_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		sprite_region_remap(visual_8,sprite_8)
		D2_perspect_gui(visual_8,refl_shader8)
func _on_reflection_8_mouse_entered() -> void:
	mouse_enter_tween(visual_8)
func _on_reflection_8_mouse_exited() -> void:
	mouse_out_tween(visual_8,refl_shader8,sprite_8)

## Reflection 9
func _on_reflection_9_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		sprite_region_remap(visual_9,sprite_9)
		D2_perspect_gui(visual_9,refl_shader9)
func _on_reflection_9_mouse_entered() -> void:
	mouse_enter_tween(visual_9)
func _on_reflection_9_mouse_exited() -> void:
	mouse_out_tween(visual_9,refl_shader9,sprite_9)

## Reflection 10
func _on_reflection_10_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		sprite_region_remap(visual_10,sprite_10)
		D2_perspect_gui(visual_10,refl_shader10)
func _on_reflection_10_mouse_entered() -> void:
	mouse_enter_tween(visual_10)
func _on_reflection_10_mouse_exited() -> void:
	mouse_out_tween(visual_10,refl_shader10,sprite_10)

## Reflection 11
func _on_reflection_11_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		sprite_region_remap(visual_11,sprite_11)
		D2_perspect_gui(visual_11,refl_shader11)
func _on_reflection_11_mouse_entered() -> void:
	mouse_enter_tween(visual_11)
func _on_reflection_11_mouse_exited() -> void:
	mouse_out_tween(visual_11,refl_shader11,sprite_11)

## Reflection 12
func _on_reflection_12_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		sprite_region_remap(visual_12,sprite_12)
		D2_perspect_gui(visual_12,refl_shader12)
func _on_reflection_12_mouse_entered() -> void:
	mouse_enter_tween(visual_12)
func _on_reflection_12_mouse_exited() -> void:
	mouse_out_tween(visual_12,refl_shader12,sprite_12)

## Reflection 13
func _on_reflection_13_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		sprite_region_remap(visual_13,sprite_13)
		D2_perspect_gui(visual_13,refl_shader13)
func _on_reflection_13_mouse_entered() -> void:
	mouse_enter_tween(visual_13)
func _on_reflection_13_mouse_exited() -> void:
	mouse_out_tween(visual_13,refl_shader13,sprite_13)

## Reflection 14
func _on_reflection_14_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		sprite_region_remap(visual_14,sprite_14)
		D2_perspect_gui(visual_14,refl_shader14)
func _on_reflection_14_mouse_entered() -> void:
	mouse_enter_tween(visual_14)
func _on_reflection_14_mouse_exited() -> void:
	mouse_out_tween(visual_14,refl_shader14,sprite_14)

## Reflection 15
func _on_reflection_15_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		sprite_region_remap(visual_15,sprite_15)
		D2_perspect_gui(visual_15,refl_shader15)
func _on_reflection_15_mouse_entered() -> void:
	mouse_enter_tween(visual_15)
func _on_reflection_15_mouse_exited() -> void:
	mouse_out_tween(visual_15,refl_shader15,sprite_15)

## Reflection 16
func _on_reflection_16_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		sprite_region_remap(visual_16,sprite_16)
		D2_perspect_gui(visual_16,refl_shader16)
func _on_reflection_16_mouse_entered() -> void:
	mouse_enter_tween(visual_16)
func _on_reflection_16_mouse_exited() -> void:
	mouse_out_tween(visual_16,refl_shader16,sprite_16)

## Reflection 17
func _on_reflection_17_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		sprite_region_remap(visual_17,sprite_17)
		D2_perspect_gui(visual_17,refl_shader17)
func _on_reflection_17_mouse_entered() -> void:
	mouse_enter_tween(visual_17)
func _on_reflection_17_mouse_exited() -> void:
	mouse_out_tween(visual_17,refl_shader17,sprite_17)
