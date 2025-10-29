extends Node2D

class_name DecoManager

# --- Shader Materials ---
var deco0_shader: ShaderMaterial
var deco1_shader: ShaderMaterial
var deco2_shader: ShaderMaterial
var deco3_shader: ShaderMaterial
var deco4_shader: ShaderMaterial
var deco5_shader: ShaderMaterial
var deco6_shader: ShaderMaterial
var deco7_shader: ShaderMaterial
var deco8_shader: ShaderMaterial
var deco9_shader: ShaderMaterial
var deco10_shader: ShaderMaterial
var deco11_shader: ShaderMaterial
var deco12_shader: ShaderMaterial
var deco13_shader: ShaderMaterial
var deco14_shader: ShaderMaterial
var deco15_shader: ShaderMaterial
var deco16_shader: ShaderMaterial
var deco17_shader: ShaderMaterial

# --- Visual Nodes (SubViewportContainers) ---

# Adjust if your scene structure is different.
@onready var visual_0: SubViewportContainer = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer2/Panel/deco0/visual0"
@onready var visual_1: SubViewportContainer = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer3/Panel/deco1/visual1"
@onready var visual_2: SubViewportContainer = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer4/Panel/deco2/visual2"
@onready var visual_3: SubViewportContainer = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer5/Panel/deco3/visual3"
@onready var visual_4: SubViewportContainer = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer6/Panel/deco4/visual4"
@onready var visual_5: SubViewportContainer = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer7/Panel/deco5/visual5"
@onready var visual_6: SubViewportContainer = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer8/Panel/deco6/visual6"
@onready var visual_7: SubViewportContainer = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer9/Panel/deco7/visual7"
@onready var visual_8: SubViewportContainer = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer10/Panel/deco8/visual8"
@onready var visual_9: SubViewportContainer = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer11/Panel/deco9/visual9"
@onready var visual_10: SubViewportContainer = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer12/Panel/deco10/visual10"
@onready var visual_11: SubViewportContainer = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer13/Panel/deco11/visual11"
@onready var visual_12: SubViewportContainer = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer14/Panel/deco12/visual12"
@onready var visual_13: SubViewportContainer = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer15/Panel/deco13/visual13"
@onready var visual_14: SubViewportContainer = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer16/Panel/deco14/visual14"
@onready var visual_15: SubViewportContainer = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer17/Panel/deco15/visual15"
@onready var visual_16: SubViewportContainer = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer18/Panel/deco16/visual16"
@onready var visual_17: SubViewportContainer = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer19/Panel/deco17/visual17"

@onready var _0: RichTextLabel = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer2/Panel/deco0/0"
@onready var _1: RichTextLabel = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer3/Panel/deco1/1"
@onready var _2: RichTextLabel = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer4/Panel/deco2/2"
@onready var _3: RichTextLabel = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer5/Panel/deco3/3"
@onready var _4: RichTextLabel = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer6/Panel/deco4/4"
@onready var _5: RichTextLabel = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer7/Panel/deco5/5"
@onready var _6: RichTextLabel = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer8/Panel/deco6/6"
@onready var _7: RichTextLabel = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer9/Panel/deco7/7"
@onready var _8: RichTextLabel = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer10/Panel/deco8/8"
@onready var _9: RichTextLabel = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer11/Panel/deco9/9"
@onready var _10: RichTextLabel = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer12/Panel/deco10/10"
@onready var _11: RichTextLabel = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer13/Panel/deco11/11"
@onready var _12: RichTextLabel = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer14/Panel/deco12/12"
@onready var _13: RichTextLabel = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer15/Panel/deco13/13"
@onready var _14: RichTextLabel = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer16/Panel/deco14/14"
@onready var _15: RichTextLabel = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer17/Panel/deco15/15"
@onready var _16: RichTextLabel = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer18/Panel/deco16/16"
@onready var _17: RichTextLabel = $"../CanvasLayer/world_map/Deco/ScrollContainer/GridContainer/MarginContainer19/Panel/deco17/17"

var label_array:=[]

func _ready() -> void:
	deco0_shader = visual_0.material
	deco1_shader = visual_1.material
	deco2_shader = visual_2.material
	deco3_shader = visual_3.material
	deco4_shader = visual_4.material
	deco5_shader = visual_5.material
	deco6_shader = visual_6.material
	deco7_shader = visual_7.material
	deco8_shader = visual_8.material
	deco9_shader = visual_9.material
	deco10_shader = visual_10.material
	deco11_shader = visual_11.material
	deco12_shader = visual_12.material
	deco13_shader = visual_13.material
	deco14_shader = visual_14.material
	deco15_shader = visual_15.material
	deco16_shader = visual_16.material
	deco17_shader = visual_17.material

	label_array = [
		_0,_1,_2,_3,_4,_5,_6,_7,_8,_9,_10,_11,_12,_13,_14,_15,_16,_17
	]

	for i in label_array.size():
		label_array[i].text = "[center]%s
[color=#F7D59C]%s ¥[/color][/center]" %[CostsTable.decoration_database[i],GlobalVariables.number_format(CostsTable.deco_cost_table[i])]


# --- Button Purchase Signals ---

func _on_deco_0_button_up() -> void:
	mouse_clicked_tween(visual_0)
	purchase_underwater_deco(0)


func _on_deco_1_button_up() -> void:
	mouse_clicked_tween(visual_1)
	purchase_floating_deco(1)


func _on_deco_2_button_up() -> void:
	mouse_clicked_tween(visual_2)
	purchase_plant_decoration(2,1000)


func _on_deco_3_button_up() -> void:
	mouse_clicked_tween(visual_3)
	purchase_underwater_deco(3)


func _on_deco_4_button_up() -> void:
	mouse_clicked_tween(visual_4)
	purchase_floating_deco(4)


func _on_deco_5_button_up() -> void:
	mouse_clicked_tween(visual_5)
	purchase_plant_decoration(5)


func _on_deco_6_button_up() -> void:
	mouse_clicked_tween(visual_6)
	purchase_underwater_deco(6)



func _on_deco_7_button_up() -> void:
	mouse_clicked_tween(visual_7)
	purchase_floating_deco(7)



func _on_deco_8_button_up() -> void:
	mouse_clicked_tween(visual_8)
	purchase_floating_deco(8)



func _on_deco_9_button_up() -> void:
	mouse_clicked_tween(visual_9)
	purchase_underwater_deco(9)


func _on_deco_10_button_up() -> void:
	mouse_clicked_tween(visual_10)
	purchase_floating_deco(10)


func _on_deco_11_button_up() -> void:
	mouse_clicked_tween(visual_11)
	purchase_plant_decoration(11)


func _on_deco_12_button_up() -> void:
	mouse_clicked_tween(visual_12)
	purchase_underwater_deco(12)


func _on_deco_13_button_up() -> void:
	mouse_clicked_tween(visual_13)
	purchase_floating_deco(13)


func _on_deco_14_button_up() -> void:
	mouse_clicked_tween(visual_14)
	purchase_plant_decoration(14)


func _on_deco_15_button_up() -> void:
	mouse_clicked_tween(visual_15)
	purchase_underwater_deco(15)


func _on_deco_16_button_up() -> void:
	mouse_clicked_tween(visual_16)
	purchase_floating_deco(16)


func _on_deco_17_button_up() -> void:
	mouse_clicked_tween(visual_17)
	purchase_floating_deco(17)

# --- Purchase Logic ---

@onready var decorations: Control = $"../CanvasLayer/decorations"
@onready var graphic_logic_kernel: GraphicKernel = $".."
@onready var underwater_decos: Node2D = $"../underwater_decos"
@onready var surface_deco: Node2D = $"../CanvasLayer/surface_deco"

func purchase_underwater_deco(button_index:int):
	if GlobalVariables.gold_current >= CostsTable.deco_cost_table[button_index]:
		GlobalVariables.gold_current -= CostsTable.deco_cost_table[button_index]
		var file_path:String = "res://decos/"+str(button_index)+"/"+str(button_index)+".tscn"
		var deco:PackedScene=load(file_path)
		var new_deco = deco.instantiate()
		underwater_decos.add_child(new_deco)
		new_deco.z_index = 1000
		new_deco.global_position = get_global_mouse_position()
		new_deco.outline_shader.set_shader_parameter("outline_size",0.0)
		graphic_logic_kernel._on_closing_button_down()

func purchase_floating_deco(button_index:int):
	var c :int = 0
	for i in surface_deco.get_children():
		if i.is_in_group("leaf"):
			c+=1
	if c<= 200:
		if GlobalVariables.gold_current >= CostsTable.deco_cost_table[button_index]:
			GlobalVariables.gold_current -= CostsTable.deco_cost_table[button_index]
			var file_path:String = "res://decos/"+str(button_index)+"/"+str(button_index)+".tscn"
			var deco:PackedScene=load(file_path)
			var new_deco = deco.instantiate()
			surface_deco.add_child(new_deco)
			new_deco.position = get_global_mouse_position()+surface_deco.global_position + get_viewport_rect().size/2
			new_deco.mouse_to_dragging_point = Vector2.ZERO
			new_deco.z_index = 1000
			new_deco.outline_shader.set_shader_parameter("outline_size",0.0)
			graphic_logic_kernel._on_closing_button_down()

func purchase_plant_decoration(button_index:int,extra_z_index:int = 0):
	if GlobalVariables.gold_current >= CostsTable.deco_cost_table[button_index]:
		GlobalVariables.gold_current -= CostsTable.deco_cost_table[button_index]
		var file_path:String = "res://decos/"+str(button_index)+"/"+str(button_index)+".tscn"
		var deco:PackedScene=load(file_path)
		var new_deco = deco.instantiate()
		surface_deco.add_child(new_deco)
		new_deco.position = get_global_mouse_position()+surface_deco.global_position + get_viewport_rect().size/2
		new_deco.z_index = 1000 + extra_z_index
		new_deco.outline_shader.set_shader_parameter("outline_size",0.0)
		graphic_logic_kernel._on_closing_button_down()

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
	#if tween_clicked and tween_clicked.is_running():
		#tween_clicked.kill()
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

## Deco 0
func _on_deco_0_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_0, deco0_shader)
func _on_deco_0_mouse_entered() -> void:
	mouse_enter_tween(visual_0)
func _on_deco_0_mouse_exited() -> void:
	mouse_out_tween(visual_0, deco0_shader)

## Deco 1
func _on_deco_1_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_1, deco1_shader)
func _on_deco_1_mouse_entered() -> void:
	mouse_enter_tween(visual_1)
func _on_deco_1_mouse_exited() -> void:
	mouse_out_tween(visual_1, deco1_shader)

## Deco 2
func _on_deco_2_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_2, deco2_shader)
func _on_deco_2_mouse_entered() -> void:
	mouse_enter_tween(visual_2)
func _on_deco_2_mouse_exited() -> void:
	mouse_out_tween(visual_2, deco2_shader)

## Deco 3
func _on_deco_3_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_3, deco3_shader)
func _on_deco_3_mouse_entered() -> void:
	mouse_enter_tween(visual_3)
func _on_deco_3_mouse_exited() -> void:
	mouse_out_tween(visual_3, deco3_shader)

## Deco 4
func _on_deco_4_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_4, deco4_shader)
func _on_deco_4_mouse_entered() -> void:
	mouse_enter_tween(visual_4)
func _on_deco_4_mouse_exited() -> void:
	mouse_out_tween(visual_4, deco4_shader)

## Deco 5
func _on_deco_5_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_5, deco5_shader)
func _on_deco_5_mouse_entered() -> void:
	mouse_enter_tween(visual_5)
func _on_deco_5_mouse_exited() -> void:
	mouse_out_tween(visual_5, deco5_shader)

## Deco 6
func _on_deco_6_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_6, deco6_shader)
func _on_deco_6_mouse_entered() -> void:
	mouse_enter_tween(visual_6)
func _on_deco_6_mouse_exited() -> void:
	mouse_out_tween(visual_6, deco6_shader)

## Deco 7
func _on_deco_7_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_7, deco7_shader)
func _on_deco_7_mouse_entered() -> void:
	mouse_enter_tween(visual_7)
func _on_deco_7_mouse_exited() -> void:
	mouse_out_tween(visual_7, deco7_shader)

## Deco 8
func _on_deco_8_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_8, deco8_shader)
func _on_deco_8_mouse_entered() -> void:
	mouse_enter_tween(visual_8)
func _on_deco_8_mouse_exited() -> void:
	mouse_out_tween(visual_8, deco8_shader)

## Deco 9
func _on_deco_9_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_9, deco9_shader)
func _on_deco_9_mouse_entered() -> void:
	mouse_enter_tween(visual_9)
func _on_deco_9_mouse_exited() -> void:
	mouse_out_tween(visual_9, deco9_shader)

## Deco 10
func _on_deco_10_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_10, deco10_shader)
func _on_deco_10_mouse_entered() -> void:
	mouse_enter_tween(visual_10)
func _on_deco_10_mouse_exited() -> void:
	mouse_out_tween(visual_10, deco10_shader)

## Deco 11
func _on_deco_11_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_11, deco11_shader)
func _on_deco_11_mouse_entered() -> void:
	mouse_enter_tween(visual_11)
func _on_deco_11_mouse_exited() -> void:
	mouse_out_tween(visual_11, deco11_shader)

## Deco 12
func _on_deco_12_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_12, deco12_shader)
func _on_deco_12_mouse_entered() -> void:
	mouse_enter_tween(visual_12)
func _on_deco_12_mouse_exited() -> void:
	mouse_out_tween(visual_12, deco12_shader)

## Deco 13
func _on_deco_13_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_13, deco13_shader)
func _on_deco_13_mouse_entered() -> void:
	mouse_enter_tween(visual_13)
func _on_deco_13_mouse_exited() -> void:
	mouse_out_tween(visual_13, deco13_shader)

## Deco 14
func _on_deco_14_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_14, deco14_shader)
func _on_deco_14_mouse_entered() -> void:
	mouse_enter_tween(visual_14)
func _on_deco_14_mouse_exited() -> void:
	mouse_out_tween(visual_14, deco14_shader)

## Deco 15
func _on_deco_15_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_15, deco15_shader)
func _on_deco_15_mouse_entered() -> void:
	mouse_enter_tween(visual_15)
func _on_deco_15_mouse_exited() -> void:
	mouse_out_tween(visual_15, deco15_shader)

## Deco 16
func _on_deco_16_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_16, deco16_shader)
func _on_deco_16_mouse_entered() -> void:
	mouse_enter_tween(visual_16)
func _on_deco_16_mouse_exited() -> void:
	mouse_out_tween(visual_16, deco16_shader)

## Deco 17
func _on_deco_17_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_17, deco17_shader)
func _on_deco_17_mouse_entered() -> void:
	mouse_enter_tween(visual_17)
func _on_deco_17_mouse_exited() -> void:
	mouse_out_tween(visual_17, deco17_shader)
