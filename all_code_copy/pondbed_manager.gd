extends Node2D

class_name PondBedManager

@onready var graphic_logic_kernel: GraphicKernel = $".."
var current_bed:int = 0
# --- Shader Materials ---
var under0_shader: ShaderMaterial
var under1_shader: ShaderMaterial
var under2_shader: ShaderMaterial
var under3_shader: ShaderMaterial
var under4_shader: ShaderMaterial
var under5_shader: ShaderMaterial
var under6_shader: ShaderMaterial
var under7_shader: ShaderMaterial
var under8_shader: ShaderMaterial
var under9_shader: ShaderMaterial
var under10_shader: ShaderMaterial
var under11_shader: ShaderMaterial
var under12_shader: ShaderMaterial
var under13_shader: ShaderMaterial
var under14_shader: ShaderMaterial
var under15_shader: ShaderMaterial
var under16_shader: ShaderMaterial
var under17_shader: ShaderMaterial

# --- Visual Nodes (SubViewportContainers) ---
# NOTE: The node path pattern assumes MarginContainer2, MarginContainer3, etc.
# Adjust if your scene structure is different.
@onready var visual_0: SubViewportContainer = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer2/bed0/visual0"
@onready var visual_1: SubViewportContainer = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer3/bed1/visual1"
@onready var visual_2: SubViewportContainer = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer4/bed2/visual2"
@onready var visual_3: SubViewportContainer = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer5/bed3/visual3"
@onready var visual_4: SubViewportContainer = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer6/bed4/visual4"
@onready var visual_5: SubViewportContainer = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer7/bed5/visual5"
@onready var visual_6: SubViewportContainer = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer8/bed6/visual6"
@onready var visual_7: SubViewportContainer = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer9/bed7/visual7"
@onready var visual_8: SubViewportContainer = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer10/bed8/visual8"
@onready var visual_9: SubViewportContainer = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer11/bed9/visual9"
@onready var visual_10: SubViewportContainer = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer12/bed10/visual10"
@onready var visual_11: SubViewportContainer = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer13/bed11/visual11"
@onready var visual_12: SubViewportContainer = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer14/bed12/visual12"
@onready var visual_13: SubViewportContainer = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer15/bed13/visual13"
@onready var visual_14: SubViewportContainer = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer16/bed14/visual14"
@onready var visual_15: SubViewportContainer = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer17/bed15/visual15"
@onready var visual_16: SubViewportContainer = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer18/bed16/visual16"
@onready var visual_17: SubViewportContainer = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer19/bed17/visual17"

var visual_list=[visual_0,visual_1,visual_2,visual_3,visual_4,visual_5,visual_6,visual_7,visual_8,visual_9,visual_10,visual_11,visual_12,visual_13,visual_14,visual_15,visual_16,visual_17]

@onready var _0: RichTextLabel = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer2/bed0/0"
@onready var _1: RichTextLabel = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer3/bed1/1"
@onready var _2: RichTextLabel = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer4/bed2/2"
@onready var _3: RichTextLabel = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer5/bed3/3"
@onready var _4: RichTextLabel = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer6/bed4/4"
@onready var _5: RichTextLabel = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer7/bed5/5"
@onready var _6: RichTextLabel = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer8/bed6/6"
@onready var _7: RichTextLabel = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer9/bed7/7"
@onready var _8: RichTextLabel = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer10/bed8/8"
@onready var _9: RichTextLabel = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer11/bed9/9"
@onready var _10: RichTextLabel = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer12/bed10/10"
@onready var _11: RichTextLabel = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer13/bed11/11"
@onready var _12: RichTextLabel = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer14/bed12/12"
@onready var _13: RichTextLabel = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer15/bed13/13"
@onready var _14: RichTextLabel = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer16/bed14/14"
@onready var _15: RichTextLabel = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer17/bed15/15"
@onready var _16: RichTextLabel = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer18/bed16/16"
@onready var _17: RichTextLabel = $"../CanvasLayer/world_map/Bed/ScrollContainer/GridContainer/MarginContainer19/bed17/17"

var label_array:=[]

func _ready() -> void:
	under0_shader = visual_0.material
	under1_shader = visual_1.material
	under2_shader = visual_2.material
	under3_shader = visual_3.material
	under4_shader = visual_4.material
	under5_shader = visual_5.material
	under6_shader = visual_6.material
	under7_shader = visual_7.material
	under8_shader = visual_8.material
	under9_shader = visual_9.material
	under10_shader = visual_10.material
	under11_shader = visual_11.material
	under12_shader = visual_12.material
	under13_shader = visual_13.material
	under14_shader = visual_14.material
	under15_shader = visual_15.material
	under16_shader = visual_16.material
	under17_shader = visual_17.material
	visual_list=[visual_0,visual_1,visual_2,visual_3,visual_4,visual_5,visual_6,visual_7,visual_8,visual_9,visual_10,visual_11,visual_12,visual_13,visual_14,visual_15,visual_16,visual_17]

	label_array = [
		_0,_1,_2,_3,_4,_5,_6,_7,_8,_9,_10,_11,_12,_13,_14,_15,_16,_17
	]
	
	for i in label_array.size():
		label_array[i].text = "[center]%s
[color=#F7D59C]%s ¥[/color][/center]" %[CostsTable.pond_bed_database[i],GlobalVariables.number_format(CostsTable.bed_cost_table[i])]


# --- Purchase Logic & Signals ---

func bed_purchase_button(button_index:int) -> void:
	if GlobalVariables.shopping_list_bed[button_index]==false:
		if GlobalVariables.gold_current >= CostsTable.bed_cost_table[button_index]:
			GlobalVariables.gold_current -= CostsTable.bed_cost_table[button_index]
			GlobalVariables.shopping_list_bed[button_index]=true
			reset_visual(current_bed)
			graphic_logic_kernel.set_bed(button_index)
			graphic_logic_kernel.to_save_game()
			set_visual(button_index)
			current_bed = button_index
	else:
		reset_visual(current_bed)
		graphic_logic_kernel.set_bed(button_index)
		graphic_logic_kernel.to_save_game()
		set_visual(button_index)
		current_bed = button_index

func set_visual(button_index:int):
	var tween:Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(visual_list[button_index].get_parent().material,"shader_parameter/size",1.0,1.0)

func reset_visual(button_index:int):
	var tween:Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(visual_list[button_index].get_parent().material,"shader_parameter/size",2.0,1.0)

func _on_bed_0_button_down() -> void:
	mouse_clicked_tween(visual_0)
	bed_purchase_button(0)

func _on_bed_1_button_down() -> void:
	mouse_clicked_tween(visual_1)
	bed_purchase_button(1)

func _on_bed_2_button_down() -> void:
	mouse_clicked_tween(visual_2)
	bed_purchase_button(2)

func _on_bed_3_button_down() -> void:
	mouse_clicked_tween(visual_3)
	bed_purchase_button(3)

func _on_bed_4_button_down() -> void:
	mouse_clicked_tween(visual_4)
	bed_purchase_button(4)

func _on_bed_5_button_down() -> void:
	mouse_clicked_tween(visual_5)
	bed_purchase_button(5)

func _on_bed_6_button_down() -> void:
	mouse_clicked_tween(visual_6)
	bed_purchase_button(6)

func _on_bed_7_button_down() -> void:
	mouse_clicked_tween(visual_7)
	bed_purchase_button(7)

func _on_bed_8_button_down() -> void:
	mouse_clicked_tween(visual_8)
	bed_purchase_button(8)

func _on_bed_9_button_down() -> void:
	mouse_clicked_tween(visual_9)
	bed_purchase_button(9)

func _on_bed_10_button_down() -> void:
	mouse_clicked_tween(visual_10)
	bed_purchase_button(10)

func _on_bed_11_button_down() -> void:
	mouse_clicked_tween(visual_11)
	bed_purchase_button(11)

func _on_bed_12_button_down() -> void:
	mouse_clicked_tween(visual_12)
	bed_purchase_button(12)

func _on_bed_13_button_down() -> void:
	mouse_clicked_tween(visual_13)
	bed_purchase_button(13)

func _on_bed_14_button_down() -> void:
	mouse_clicked_tween(visual_14)
	bed_purchase_button(14)

func _on_bed_15_button_down() -> void:
	mouse_clicked_tween(visual_15)
	bed_purchase_button(15)

func _on_bed_16_button_down() -> void:
	mouse_clicked_tween(visual_16)
	bed_purchase_button(16)

func _on_bed_17_button_down() -> void:
	mouse_clicked_tween(visual_17)
	bed_purchase_button(17)

# --- UI Effect Logic & Helpers ---

var tween_hover:Tween
var tween_rot:Tween
var tween_clicked:Tween
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
	if tween_clicked and tween_clicked.is_running():
		tween_clicked.kill()
	tween_clicked = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BOUNCE)
	tween_clicked.tween_property(viewport,"scale",Vector2(0.75,0.75),0.1)
	tween_clicked.tween_property(viewport,"scale",Vector2(1.0,1.0),0.1)

func mouse_enter_tween(viewport:SubViewportContainer):
	viewport.pivot_offset = viewport.size/2
	#if tween_hover and tween_hover.is_running():
		#tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO).set_parallel(true)
	tween_hover.tween_property(viewport,"scale",Vector2(1.2,1.2),0.5)

func mouse_out_tween(viewport:SubViewportContainer,shader:ShaderMaterial):
	#if tween_rot and tween_rot.is_running():
		#tween_rot.kill()
	tween_rot = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).set_parallel(true)
	tween_rot.tween_property(shader,"shader_parameter/x_rot",0.0,0.5)
	tween_rot.tween_property(shader,"shader_parameter/y_rot",0.0,0.5)
	
	#if tween_hover and tween_hover.is_running():
		#tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(viewport,"scale",Vector2.ONE,0.55)

# --- UI Interaction Signals ---

## Bed 0
func _on_bed_0_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_0, under0_shader)
func _on_bed_0_mouse_entered() -> void:
	mouse_enter_tween(visual_0)
	#reset_mouse_out_for_all(0)
func _on_bed_0_mouse_exited() -> void:
	mouse_out_tween(visual_0,under0_shader)

## Bed 1
func _on_bed_1_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_1, under1_shader)
func _on_bed_1_mouse_entered() -> void:
	mouse_enter_tween(visual_1)
	#reset_mouse_out_for_all(1)
func _on_bed_1_mouse_exited() -> void:
	mouse_out_tween(visual_1, under1_shader)

## Bed 2
func _on_bed_2_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_2, under2_shader)
func _on_bed_2_mouse_entered() -> void:
	mouse_enter_tween(visual_2)
	#reset_mouse_out_for_all(2)
func _on_bed_2_mouse_exited() -> void:
	mouse_out_tween(visual_2, under2_shader)

## Bed 3
func _on_bed_3_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_3, under3_shader)
func _on_bed_3_mouse_entered() -> void:
	mouse_enter_tween(visual_3)
	#reset_mouse_out_for_all(3)
func _on_bed_3_mouse_exited() -> void:
	mouse_out_tween(visual_3, under3_shader)

## Bed 4
func _on_bed_4_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_4, under4_shader)
func _on_bed_4_mouse_entered() -> void:
	mouse_enter_tween(visual_4)
	#reset_mouse_out_for_all(4)
func _on_bed_4_mouse_exited() -> void:
	mouse_out_tween(visual_4, under4_shader)

## Bed 5
func _on_bed_5_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_5, under5_shader)
func _on_bed_5_mouse_entered() -> void:
	mouse_enter_tween(visual_5)
	#reset_mouse_out_for_all(5)
func _on_bed_5_mouse_exited() -> void:
	mouse_out_tween(visual_5, under5_shader)

## Bed 6
func _on_bed_6_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_6, under6_shader)
func _on_bed_6_mouse_entered() -> void:
	mouse_enter_tween(visual_6)
	#reset_mouse_out_for_all(6)
func _on_bed_6_mouse_exited() -> void:
	mouse_out_tween(visual_6, under6_shader)

## Bed 7
func _on_bed_7_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_7, under7_shader)
func _on_bed_7_mouse_entered() -> void:
	mouse_enter_tween(visual_7)
	#reset_mouse_out_for_all(7)
func _on_bed_7_mouse_exited() -> void:
	mouse_out_tween(visual_7, under7_shader)

## Bed 8
func _on_bed_8_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_8, under8_shader)
func _on_bed_8_mouse_entered() -> void:
	mouse_enter_tween(visual_8)
	#reset_mouse_out_for_all(8)
func _on_bed_8_mouse_exited() -> void:
	mouse_out_tween(visual_8, under8_shader)

## Bed 9
func _on_bed_9_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_9, under9_shader)
func _on_bed_9_mouse_entered() -> void:
	mouse_enter_tween(visual_9)
	#reset_mouse_out_for_all(9)
func _on_bed_9_mouse_exited() -> void:
	mouse_out_tween(visual_9, under9_shader)

## Bed 10
func _on_bed_10_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_10, under10_shader)
func _on_bed_10_mouse_entered() -> void:
	mouse_enter_tween(visual_10)
	#reset_mouse_out_for_all(10)
func _on_bed_10_mouse_exited() -> void:
	mouse_out_tween(visual_10, under10_shader)

## Bed 11
func _on_bed_11_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_11, under11_shader)
func _on_bed_11_mouse_entered() -> void:
	mouse_enter_tween(visual_11)
	#reset_mouse_out_for_all(11)
func _on_bed_11_mouse_exited() -> void:
	mouse_out_tween(visual_11, under11_shader)

## Bed 12
func _on_bed_12_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_12, under12_shader)
func _on_bed_12_mouse_entered() -> void:
	mouse_enter_tween(visual_12)
	#reset_mouse_out_for_all(12)
func _on_bed_12_mouse_exited() -> void:
	mouse_out_tween(visual_12, under12_shader)

## Bed 13
func _on_bed_13_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_13, under13_shader)
func _on_bed_13_mouse_entered() -> void:
	mouse_enter_tween(visual_13)
	#reset_mouse_out_for_all(13)
func _on_bed_13_mouse_exited() -> void:
	mouse_out_tween(visual_13, under13_shader)

## Bed 14
func _on_bed_14_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_14, under14_shader)
func _on_bed_14_mouse_entered() -> void:
	mouse_enter_tween(visual_14)
	#reset_mouse_out_for_all(14)
func _on_bed_14_mouse_exited() -> void:
	mouse_out_tween(visual_14, under14_shader)

## Bed 15
func _on_bed_15_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_15, under15_shader)
func _on_bed_15_mouse_entered() -> void:
	mouse_enter_tween(visual_15)
	#reset_mouse_out_for_all(15)
func _on_bed_15_mouse_exited() -> void:
	mouse_out_tween(visual_15, under15_shader)

## Bed 16
func _on_bed_16_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_16, under16_shader)
func _on_bed_16_mouse_entered() -> void:
	mouse_enter_tween(visual_16)
	#reset_mouse_out_for_all(16)
func _on_bed_16_mouse_exited() -> void:
	mouse_out_tween(visual_16, under16_shader)

## Bed 17
func _on_bed_17_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_17, under17_shader)
func _on_bed_17_mouse_entered() -> void:
	mouse_enter_tween(visual_17)
	#reset_mouse_out_for_all(17)
func _on_bed_17_mouse_exited() -> void:
	mouse_out_tween(visual_17, under17_shader)
