class_name TravelKernel
extends Node2D


var demo_lock:bool = false

var final_levels:bool=false
@onready var shop_switch_lbl0: Label = $"../CanvasLayer/world_map/shop_tabs/Koi_tab/shop_switch_lbl"
@onready var shop_switch_lbl1: Label = $"../CanvasLayer/world_map/shop_tabs/Deco_tab/shop_switch_lbl"
@onready var shop_switch_lbl2: Label = $"../CanvasLayer/world_map/shop_tabs/Bed_tab/shop_switch_lbl"
@onready var shop_switch_lbl3: Label = $"../CanvasLayer/world_map/shop_tabs/Surface_tab/shop_switch_lbl"

@onready var graphic_logic_kernel: GraphicKernel = $".."
@onready var texture_rect: TextureRect = $"../CanvasLayer/TextureRect"
@onready var texture_rect_2: TextureRect = $"../CanvasLayer/TextureRect2"

@onready var upgrade_background: ColorRect = $"../CanvasLayer/upgrade_background"
@onready var upgrade_panel: Control = $"../CanvasLayer/upgrade_panel"
@onready var world_map: Control = $"../CanvasLayer/world_map"
@onready var panel_container: PanelContainer = $"../CanvasLayer/PanelContainer"

@onready var unlock_sure: Control = $"../CanvasLayer/unlock_sure"

@onready var unlock_lbl: RichTextLabel = $"../CanvasLayer/unlock_sure/PanelContainer2/VBoxContainer/MarginContainer/unlock_lbl"



@onready var canvas_layer: CanvasLayer = $"../CanvasLayer"

@onready var camera_2d: Camera2D = $"../Camera2D"

var destination:String

@onready var transition: Transition = $"../Camera2D/CanvasLayer/transition"

@onready var cost_lbl: RichTextLabel = $"../CanvasLayer/world_map/infoPanel/VBoxContainer/MarginContainer/cost_lbl"

@onready var snakes_lvl: RichTextLabel = $"../CanvasLayer/world_map/infoPanel/VBoxContainer/MarginContainer3/PanelContainer/snakes_lvl"

@onready var info_panel: PanelContainer = $"../CanvasLayer/world_map/infoPanel"

var buttons:Array
var buttons_visual:Array
var techs:Array
var lvl_lbl:Array
var ul_lbl:Array
var unlocking_button
var unlocking_cost

var b_0_shader:ShaderMaterial
var b_1_shader:ShaderMaterial
var b_2_shader:ShaderMaterial
var b_3_shader:ShaderMaterial
var b_4_shader:ShaderMaterial
var b_5_shader:ShaderMaterial
var b_6_shader:ShaderMaterial
var b_7_shader:ShaderMaterial
var b_8_shader:ShaderMaterial
var b_9_shader:ShaderMaterial
var b_10_shader:ShaderMaterial
var b_11_shader:ShaderMaterial
var b_12_shader:ShaderMaterial
var b_13_shader:ShaderMaterial
var b_14_shader:ShaderMaterial
var b_15_shader:ShaderMaterial
var b_16_shader:ShaderMaterial
var b_17_shader:ShaderMaterial
@onready var visual_0: SubViewportContainer = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer/Panel/b_0/visual0"
@onready var visual_1: SubViewportContainer = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer2/Panel/b_1/visual1"
@onready var visual_2: SubViewportContainer = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer3/Panel/b_2/visual2"
@onready var visual_3: SubViewportContainer = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer4/Panel/b_3/visual3"
@onready var visual_4: SubViewportContainer = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer5/Panel/b_4/visual4"
@onready var visual_5: SubViewportContainer = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer6/Panel/b_5/visual5"
@onready var visual_6: SubViewportContainer = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer7/Panel/b_6/visual6"
@onready var visual_7: SubViewportContainer = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer8/Panel/b_7/visual7"
@onready var visual_8: SubViewportContainer = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer9/Panel/b_8/visual8"
@onready var visual_9: SubViewportContainer = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer10/Panel/b_9/visual9"
@onready var visual_10: SubViewportContainer = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer11/Panel/b_10/visual10"
@onready var visual_11: SubViewportContainer = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer12/Panel/b_11/visual11"
@onready var visual_12: SubViewportContainer = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer13/Panel/b_12/visual12"
@onready var visual_13: SubViewportContainer = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer14/Panel/b_13/visual13"
@onready var visual_14: SubViewportContainer = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer15/Panel/b_14/visual14"
@onready var visual_15: SubViewportContainer = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer16/Panel/b_15/visual15"
@onready var visual_16: SubViewportContainer = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer17/Panel/b_16/visual16"
@onready var visual_17: SubViewportContainer = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer18/Panel/b_17/visual17"

func connect_shaders():
	b_0_shader = visual_0.material
	b_1_shader = visual_1.material
	b_2_shader = visual_2.material
	b_3_shader = visual_3.material
	b_4_shader = visual_4.material
	b_5_shader = visual_5.material
	b_6_shader = visual_6.material
	b_7_shader = visual_7.material
	b_8_shader = visual_8.material
	b_9_shader = visual_9.material
	b_10_shader = visual_10.material
	b_11_shader = visual_11.material
	b_12_shader = visual_12.material
	b_13_shader = visual_13.material
	b_14_shader = visual_14.material
	b_15_shader = visual_15.material
	b_16_shader = visual_16.material
	b_17_shader = visual_17.material
	

func _process(_delta: float) -> void:
	for i in buttons.size():
		check_gold_enough(i)

func check_gold_enough(lvl_index:int):
	match graphic_logic_kernel.local_pond_index:
		0:
			if graphic_logic_kernel.snakes.size()+fish_cards.in_box_fish_count>=GlobalVariables.tank_size[GlobalVariables.tank_size_lvl0]:
				buttons[lvl_index].disabled = true
				buttons_visual[lvl_index].disabled = true
			elif graphic_logic_kernel.snakes.size()+fish_cards.in_box_fish_count<GlobalVariables.tank_size[GlobalVariables.tank_size_lvl0]:
				buttons[lvl_index].disabled = false
				buttons_visual[lvl_index].disabled = false
		1:
			if graphic_logic_kernel.snakes.size()+fish_cards.in_box_fish_count>=GlobalVariables.tank_size[GlobalVariables.tank_size_lvl1]:
				buttons[lvl_index].disabled = true
				buttons_visual[lvl_index].disabled = true
			elif graphic_logic_kernel.snakes.size()+fish_cards.in_box_fish_count<GlobalVariables.tank_size[GlobalVariables.tank_size_lvl1]:
				buttons[lvl_index].disabled = false
				buttons_visual[lvl_index].disabled = false
		2:
			if graphic_logic_kernel.snakes.size()+fish_cards.in_box_fish_count>=GlobalVariables.tank_size[GlobalVariables.tank_size_lvl2]:
				buttons[lvl_index].disabled = true
				buttons_visual[lvl_index].disabled = true
			elif graphic_logic_kernel.snakes.size()+fish_cards.in_box_fish_count<GlobalVariables.tank_size[GlobalVariables.tank_size_lvl2]:
				buttons[lvl_index].disabled = false
				buttons_visual[lvl_index].disabled = false
	if GlobalVariables.gold_current < CostsTable.unlocking_cost[lvl_index]:
			buttons[lvl_index].disabled=true
			buttons_visual[lvl_index].disabled = true



func refresh_labels():
	for i in lvl_lbl.size():
		lvl_lbl[i].set_text("[center]%s
%s
[color=lightblue] %s[/color] [/center]" % [GlobalVariables.first_line_characters[i],GlobalVariables.second_line_characters[i],"Koi Pack"])


func set_cost_labels():
	for i in ul_lbl.size():
		ul_lbl[i].set_text("[center]???
[color=gold] %s $[/color] [/center]" % GlobalVariables.number_format(CostsTable.unlocking_cost[i+1]))
	for i in GlobalVariables.unlocked_location:
		ul_lbl[i-1].visible = false
		lvl_lbl[i].visible = true
	

func start_game() -> void:
	lvl_lbl = get_tree().get_nodes_in_group("lvl_lbl")
	ul_lbl = get_tree().get_nodes_in_group("ul_lbl")
	buttons = get_tree().get_nodes_in_group("destinationButtons")
	buttons_visual = get_tree().get_nodes_in_group("visual_buttons")
	techs = get_tree().get_nodes_in_group("tech_buttons")
	
	for i in range(1,buttons.size()):
		buttons_visual[i].texture_normal = covered_textures[i-1]
		buttons_visual[i].texture_disabled = covered_textures[i-1]
	if GlobalVariables.unlocked_location == []:
		GlobalVariables.unlocked_location.append(0)
	for i in range(1,GlobalVariables.unlocked_location.size()):
		buttons_visual[i].texture_normal = normal_textures[i-1]
	if GlobalVariables.location_unlocking == []:
		for i in buttons.size():
			GlobalVariables.location_unlocking.append(i)
	for i in GlobalVariables.unlocked_location:
		if GlobalVariables.location_unlocking.has(i):
			GlobalVariables.location_unlocking.erase(i)
	for i in range(1,GlobalVariables.location_unlocking.size()):
		buttons[GlobalVariables.location_unlocking[i]].visible = false


	info_panel.visible = false
	unlock_sure.visible = false
	refresh_labels()
	set_cost_labels()
	
	shop_buttons = [koi_btn,deco_btn,bed_btn,surface_btn]
	shop_tabs = [world_tab,deco_tab,bed_tab,surface_tab]
	shop_labels = [shop_switch_lbl0,shop_switch_lbl1,shop_switch_lbl2,shop_switch_lbl3]
	
	shop_page_manager(0)
	connect_shaders()





@onready var cards: Control = $"../CanvasLayer/cards"

const CARD = preload("res://animation_card/card.tscn")

func set_unlock_lbl_text(location_index:int):
	unlock_lbl.text = "[center]Pay " + str(CostsTable.unlocking_cost[location_index]) + " to unlock " + str(GlobalVariables.first_line_characters[location_index])+" "+str(GlobalVariables.second_line_characters[location_index])

func card_purchase_animation(color: Color):
	world_map_effect.play()
	var snake_id
	var rarity_indicator: String
	var randomf = randf()
	
	# Get the luck index (from 2.0 to 42.0)
	var luck_index: float = GlobalVariables.get_luck_index()
	
	# Calculate new thresholds based on luck
	# The formula is: base - (fail_chance * (luck_index / 100.0))
	# This "shaves off" a percentage of the fail chance, adding it to the success chance.
	var r_tier_threshold: float = 0.68 - (1.0 - 0.68) * (luck_index / 100.0)  # 0.32 fail chance
	var vr_tier_threshold: float = 0.98 - (1.0 - 0.98) * (luck_index / 100.0)  # 0.02 fail chance
	var lgdr_tier_threshold: float = 0.998 - (1.0 - 0.998) * (luck_index / 100.0) # 0.002 fail chance

	# --- Example Chances ---
	# BASE CHANCES (Luck Lvl 1, index=2.0):
	# Lgdr: 0.204%
	# VR:   1.836%
	# Rare: 30.64%
	# Cmn:  67.32%
	#
	# MAX CHANCES (Luck Lvl 21, index=42.0):
	# Lgdr: 0.284% (A 42% increase from base!)
	# VR:   2.556% (A 42% increase from base!)
	# Rare: 42.6%  (A 42% increase from base!)
	# Cmn:  54.56%
	
	if randomf <= r_tier_threshold:
		rarity_indicator = "c"
	elif randomf > r_tier_threshold and randomf <= vr_tier_threshold:
		rarity_indicator = "r"
	elif randomf > vr_tier_threshold and randomf <= lgdr_tier_threshold:
		rarity_indicator = "vr"
	elif randomf > lgdr_tier_threshold:
		rarity_indicator = "lgdr"
		
	var keys_list: Array = Destinations.World[destination][rarity_indicator].keys()
	keys_list.shuffle()
	snake_id = Destinations.World[destination][rarity_indicator][keys_list[0]]["id"]
	
	fish_cards.in_box_fish_count += 1
	var new_card = CARD.instantiate()
	new_card.global_position = get_global_mouse_position() + Vector2(1920, 1088) / 2
	new_card.z_index = 4096
	new_card.self_modulate = color
	new_card.snake_id = snake_id
	new_card.color = color
	new_card.dest = animation_destination.global_position
	new_card.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	cards.add_child(new_card)
	
@onready var animation_destination: Marker2D = $"../CanvasLayer/world_map/animation_destination"
@onready var fish_cards: FishCardBox = $"../CanvasLayer/fish_cards"

@onready var world_map_effect: AudioStreamPlayer2D = $"../Camera2D/world_map_effect"

signal tween_02_btn
var once:bool = false
func to_unlock_sure(index:int):
		if GlobalVariables.gold_current >= CostsTable.unlocking_cost[index]:
			unlocking_button = index
			unlocking_cost = CostsTable.unlocking_cost[index]
			unlock_sure.visible = true
			set_unlock_lbl_text(index)

func b_0():
	mouse_clicked_tween(visual_0)
	if GlobalVariables.tutorial and !once:
		once = true
		tween_02_btn.emit()
	GlobalVariables.gold_current -= CostsTable.unlocking_cost[0]
	#travel_sure.visible = true
	destination = "N.EU"
	#unlock_sure_lable_change(destination)
	card_purchase_animation(GlobalVariables.location_color[0])
	GlobalVariables.location_count[0]+=1
	
func b_1():
	mouse_clicked_tween(visual_1)
	if !GlobalVariables.unlocked_location.has(1):
		to_unlock_sure(1)
	else:
		GlobalVariables.gold_current -= CostsTable.unlocking_cost[1]
		#travel_sure.visible = true
		destination = "C.AS"
		#unlock_sure_lable_change(destination)
		card_purchase_animation(GlobalVariables.location_color[1])
		GlobalVariables.location_count[1]+=1

func _on_b_2_button_down() -> void:
	mouse_clicked_tween(visual_2)
	if !GlobalVariables.unlocked_location.has(2):
		to_unlock_sure(2)
	else:
		GlobalVariables.gold_current -= CostsTable.unlocking_cost[2]
		#travel_sure.visible = true
		destination = "E.EU"
		#unlock_sure_lable_change(destination)
		card_purchase_animation(GlobalVariables.location_color[2])
		GlobalVariables.location_count[2]+=1

func _on_b_3_button_down() -> void:
	mouse_clicked_tween(visual_3)
	if !GlobalVariables.unlocked_location.has(3):
		to_unlock_sure(3)
	else:
		GlobalVariables.gold_current -= CostsTable.unlocking_cost[3]
		#travel_sure.visible = true
		destination = "N.AM"
		card_purchase_animation(GlobalVariables.location_color[3])
		GlobalVariables.location_count[3]+=1


func _on_b_4_button_down() -> void:
	mouse_clicked_tween(visual_4)
	if !GlobalVariables.unlocked_location.has(4):
		to_unlock_sure(4)
	else:
		GlobalVariables.gold_current -= CostsTable.unlocking_cost[4]
		#travel_sure.visible = true
		destination = "W.EU"
		#unlock_sure_lable_change(destination)
		card_purchase_animation(GlobalVariables.location_color[4])
		GlobalVariables.location_count[4]+=1


func _on_b_5_button_down() -> void:
	mouse_clicked_tween(visual_5)
	if !GlobalVariables.unlocked_location.has(5):
		to_unlock_sure(5)
	else:
		GlobalVariables.gold_current -= CostsTable.unlocking_cost[5]
		#travel_sure.visible = true
		destination = "E.AS"
		#unlock_sure_lable_change(destination)
		card_purchase_animation(GlobalVariables.location_color[5])
		GlobalVariables.location_count[5]+=1


func _on_b_6_button_down() -> void:
	mouse_clicked_tween(visual_6)
	if !GlobalVariables.unlocked_location.has(6):
		to_unlock_sure(6)
	else:
		GlobalVariables.gold_current -= CostsTable.unlocking_cost[6]
		#travel_sure.visible = true
		destination = "S.EU"
		#unlock_sure_lable_change(destination)
		card_purchase_animation(GlobalVariables.location_color[6])
		GlobalVariables.location_count[6]+=1


func _on_b_7_button_down() -> void:
	mouse_clicked_tween(visual_7)
	if !GlobalVariables.unlocked_location.has(7):
		to_unlock_sure(7)
	else:
		GlobalVariables.gold_current -= CostsTable.unlocking_cost[7]
		#travel_sure.visible = true
		destination = "N.AF"
		#unlock_sure_lable_change(destination)
		card_purchase_animation(GlobalVariables.location_color[7])
		GlobalVariables.location_count[7]+=1


func _on_b_8_button_down() -> void:
	mouse_clicked_tween(visual_8)
	if !GlobalVariables.unlocked_location.has(8):
		to_unlock_sure(8)
	else:
		GlobalVariables.gold_current -= CostsTable.unlocking_cost[8]
		#travel_sure.visible = true
		destination = "W.AS"
		#unlock_sure_lable_change(destination)
		card_purchase_animation(GlobalVariables.location_color[8])
		GlobalVariables.location_count[8]+=1

func _on_b_9_button_down() -> void:
	mouse_clicked_tween(visual_9)
	if !GlobalVariables.unlocked_location.has(9):
		to_unlock_sure(9)
	else:
		GlobalVariables.gold_current -= CostsTable.unlocking_cost[9]
		#travel_sure.visible = true
		destination = "A.NZ"
		#unlock_sure_lable_change(destination)
		card_purchase_animation(GlobalVariables.location_color[9])
		GlobalVariables.location_count[9]+=1


func _on_b_10_button_down() -> void:
	mouse_clicked_tween(visual_10)
	if !GlobalVariables.unlocked_location.has(10):
		to_unlock_sure(10)
	else:
		GlobalVariables.gold_current -= CostsTable.unlocking_cost[10]
		#travel_sure.visible = true
		destination = "S.AF"
		#unlock_sure_lable_change(destination)
		card_purchase_animation(GlobalVariables.location_color[10])
		GlobalVariables.location_count[10]+=1


func _on_b_11_button_down() -> void:
	mouse_clicked_tween(visual_11)
	if !GlobalVariables.unlocked_location.has(11):
		to_unlock_sure(11)
	else:
		GlobalVariables.gold_current -= CostsTable.unlocking_cost[11]
		#travel_sure.visible = true
		destination = "L.AM"
		#unlock_sure_lable_change(destination)
		card_purchase_animation(GlobalVariables.location_color[11])
		GlobalVariables.location_count[11]+=1


func _on_b_12_button_down() -> void:
	mouse_clicked_tween(visual_12)
	if !GlobalVariables.unlocked_location.has(12):
		to_unlock_sure(12)
	else:
		GlobalVariables.gold_current -= CostsTable.unlocking_cost[12]
		#travel_sure.visible = true
		destination = "C.AM"
		#unlock_sure_lable_change(destination)
		card_purchase_animation(GlobalVariables.location_color[12])
		GlobalVariables.location_count[12]+=1


func _on_b_13_button_down() -> void:
	mouse_clicked_tween(visual_13)
	if !GlobalVariables.unlocked_location.has(13):
		to_unlock_sure(13)
	else:
		GlobalVariables.gold_current -= CostsTable.unlocking_cost[13]
		#travel_sure.visible = true
		destination = "POLY"
		#unlock_sure_lable_change(destination)
		card_purchase_animation(GlobalVariables.location_color[13])
		GlobalVariables.location_count[13]+=1

func _on_b_14_button_down() -> void:
	mouse_clicked_tween(visual_14)
	if !GlobalVariables.unlocked_location.has(14):
		to_unlock_sure(14)
	else:
		GlobalVariables.gold_current -= CostsTable.unlocking_cost[14]
		#travel_sure.visible = true
		destination = "S.AS"
		#unlock_sure_lable_change(destination)
		card_purchase_animation(GlobalVariables.location_color[14])
		GlobalVariables.location_count[14]+=1


func _on_b_15_button_down() -> void:
	mouse_clicked_tween(visual_15)
	if !GlobalVariables.unlocked_location.has(15):
		to_unlock_sure(15)
	else:
		GlobalVariables.gold_current -= CostsTable.unlocking_cost[15]
		#travel_sure.visible = true
		destination = "SE.AS"
		#unlock_sure_lable_change(destination)
		card_purchase_animation(GlobalVariables.location_color[15])
		GlobalVariables.location_count[15]+=1


func _on_b_16_button_down() -> void:
	mouse_clicked_tween(visual_16)
	if !GlobalVariables.unlocked_location.has(16):
		to_unlock_sure(16)
	else:
		GlobalVariables.gold_current -= CostsTable.unlocking_cost[16]
		#travel_sure.visible = true
		destination = "MELA"
		#unlock_sure_lable_change(destination)
		card_purchase_animation(GlobalVariables.location_color[16])
		GlobalVariables.location_count[16]+=1


func _on_b_17_button_down() -> void:
	mouse_clicked_tween(visual_17)
	if !GlobalVariables.unlocked_location.has(17):
		to_unlock_sure(17)
	else:
		GlobalVariables.gold_current -= CostsTable.unlocking_cost[17]
		#travel_sure.visible = true
		destination = "MICR"
		#unlock_sure_lable_change(destination)
		card_purchase_animation(GlobalVariables.location_color[17])
		GlobalVariables.location_count[17]+=1


func refresh_visibilities():
		for i in buttons:
			i.visible = true
		for i in range(1,GlobalVariables.location_unlocking.size()):
			buttons[GlobalVariables.location_unlocking[i]].visible = false



const ANN_COVERED = preload("uid://c6se60kqw8a6l")
const CA_COVERED = preload("uid://cglq33jax1qns")
const CARRIBEAN_COVERED = preload("uid://cb1q5intqln6u")
const EA_COVERED = preload("uid://b56ld22whetdy")
const EEU_COVERED = preload("uid://bmdnl1sml5b33")
const MELANESIA_COVERED = preload("uid://dtxrjnb3pgry7")
const MICRONESIA_COVERED = preload("uid://btckss667rvbd")
const NA_COVERED = preload("uid://cje6rank7a13u")
const NAF_COVERED = preload("uid://d3vhvaa0k6us0")
const POLYNESIA_COVERED = preload("uid://bx3oy1o21dmnw")
const SA_COVERED = preload("uid://cyush04bil7c1")
const SEA_COVERED = preload("uid://b68lx2re64rfe")
const SEU_COVERED = preload("uid://bcs2n1n2d3ax")
const SOUTH_ASIA_COVERED = preload("uid://bq44eiulxjjb2")
const SUBAF_COVERED = preload("uid://bympxwbmwrbhs")
const WAS_COVERED = preload("uid://djuhxp24hkjt5")
const WE_COVERED = preload("uid://c1l5c57asi3yn")

const ANN = preload("uid://bj0panefkraa6")
const CA = preload("uid://blobygcx0nj0t")
const CARRIBEAN = preload("uid://dgrsof2aqh7rx")
const EA = preload("uid://npdyko6yjer4")
const EEU = preload("uid://drq715apo0nun")
const MELANESIA = preload("uid://ian78ox32xi7")
const MICRONESIA = preload("uid://b7dyv02g02iks")
const NA = preload("uid://bj7hljabce7mo")
const NAF = preload("uid://cls82hyjr6aka")
const POLYNESIA = preload("uid://cesaflqbqghpw")
const SA = preload("uid://dvacgn361122p")
const SEA = preload("uid://bbivxqwpbfrrx")
const SEU = preload("uid://flfkafasxr2e")
const SOUTH_ASIA = preload("uid://c5qu270e24u32")
const SUBAF = preload("uid://ba2f135214axa")
const WAS = preload("uid://bmu0kt5ymlv5l")
const WE = preload("uid://bive6yhmu2p4f")

const ANN_DISABLED = preload("uid://bgb8r6gtm765i")
const CARRIBEAN_DISABLED = preload("uid://dh0qoeakkyequ")
const CA_DISABLED = preload("uid://f57x503sji56")
const EA_DISABLED = preload("uid://cm5441er2d7ln")
const EEU_DISABLED = preload("uid://b8rbtp48u0h52")
const MELANESIA_DISABLED = preload("uid://clkek6dskkoum")
const MICRONESIA_DISABLED = preload("uid://bpkpp5ukcl0er")
const NAF_DISABLED = preload("uid://b5d8nff7hba22")
const NA_DISABLED = preload("uid://djuelyjtin675")
const POLYNESIA_DISABLED = preload("uid://dxnjpcx7c0a5g")
const SA_DISABLED = preload("uid://biyl677itjdbs")
const SEA_DISABLED = preload("uid://bnyb3hm16q0rm")
const SEU_DISABLED = preload("uid://lu12agb06tsw")
const SOUTH_ASIA_DISABLED = preload("uid://ca0dfqj150p0w")
const SUBAF_DISABLED = preload("uid://koka40i3r5j")
const WAS_DISABLED = preload("uid://c2814w1lvyyms")
const WE_DISABLED = preload("uid://1jh4x5vrabff")

var covered_textures:=[CA_COVERED,EEU_COVERED,NA_COVERED,WE_COVERED,EA_COVERED,SEU_COVERED,NAF_COVERED,WAS_COVERED,ANN_COVERED,SUBAF_COVERED,SA_COVERED,CARRIBEAN_COVERED,POLYNESIA_COVERED,SOUTH_ASIA_COVERED,SEA_COVERED,MELANESIA_COVERED,MICRONESIA_COVERED]
var normal_textures:=[CA,EEU,NA,WE,EA,SEU,NAF,WAS,ANN,SUBAF,SA,CARRIBEAN,POLYNESIA,SOUTH_ASIA,SEA,MELANESIA,MICRONESIA]
var disabled_textures:=[CA_DISABLED,EEU_DISABLED,NA_DISABLED,WE_DISABLED,EA_DISABLED,SEU_DISABLED,NAF_DISABLED,WAS_DISABLED,ANN_DISABLED,SUBAF_DISABLED,SA_DISABLED,CARRIBEAN_DISABLED,POLYNESIA_DISABLED,SOUTH_ASIA_DISABLED,SEA_DISABLED,MELANESIA_DISABLED,MICRONESIA_DISABLED]
func _on_unlock_sure_button_down() -> void:
	if GlobalVariables.gold_current < unlocking_cost:return
	buttons[unlocking_button].get_child(0).visible = false
	GlobalVariables.gold_current -= unlocking_cost
	GlobalVariables.unlocked_location.append(unlocking_button)
	GlobalVariables.location_unlocking.erase(unlocking_button)
	buttons_visual[unlocking_button].texture_normal = normal_textures[unlocking_button-1]
	buttons_visual[unlocking_button].texture_disabled = disabled_textures[unlocking_button-1]
	refresh_visibilities()
	unlock_sure.visible = false
	set_cost_labels()


func _on_closing_unlock_button_down() -> void:
	unlock_sure.visible = false
	unlocking_button = null

func show_info(destination_index:int,):
	var cost = CostsTable.unlocking_cost[destination_index]
	
	var snake_id_range_floor:int
	var snake_id_range_roof:int
	
	snake_id_range_floor = destination_index*6
	snake_id_range_roof = destination_index*6+6
	
	cost_lbl.set_text("[center]Pack Price [color=gold]%s¥[/color][/center]" %GlobalVariables.number_format(round(cost)))

	var local_snake_ids:=[]
	var local_snake_names :=[]
	var local_snake_count:=[]
	var rarity_keys:=["c","r","vr","lgdr"]
	
	
	for i in range(snake_id_range_floor,snake_id_range_roof):
		local_snake_ids.append(i)
		local_snake_count.append(GlobalVariables.snake_count[i])
	for i in rarity_keys:
		for j in Destinations.World[Destinations.World.keys()[destination_index]][i]:
			local_snake_names.append(j)
	
	var line_break:="\n"
	
	var text:String=""
	var color_code="[color=sky_blue]"
	#Color.sky
	for i in local_snake_ids.size():

		if i == 0 or i == 1:
			color_code = "[color=#FFEECC]"
			text += " [font_size=24]"+color_code+local_snake_names[i]+"[/color]"+" [color=green]"+str(local_snake_count[i])+"[/color]"+"[/font_size]"+line_break
		elif i == 2 or i==3:
			color_code="[color=#CCFFEE]"
			text += " [font_size=24]"+color_code+local_snake_names[i]+"[/color]"+" [color=green]"+str(local_snake_count[i])+"[/color]"+"[/font_size]"+line_break
		elif i == 4:
			color_code = "[color=#EECCFF]"
			text += " [font_size=24]"+color_code+local_snake_names[i]+"[/color]"+" [color=green]"+str(local_snake_count[i])+"[/color]"+"[/font_size]"+line_break
		if i==5:
			color_code = "[rainbow]"
			text += " [font_size=24]"+color_code+local_snake_names[i]+"[/rainbow]"+" [color=green]"+str(local_snake_count[i])+"[/color]"+line_break
			
		
	snakes_lvl.set_text(text)
	extra_info.set_text(" [font_size=24]Bought count: "+str(GlobalVariables.location_count[destination_index]))


@onready var cr_0: ColorRect = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer/Panel/b_0/cr0"
@onready var extra_info: RichTextLabel = $"../CanvasLayer/world_map/infoPanel/VBoxContainer/MarginContainer4/extra_info"

func _on_b_0_mouse_entered() -> void:
	info_panel.visible = true
	info_panel.global_position =lvl_lbl[0].global_position+Vector2(0,80)
	show_info(0)
	cr_0.color = Color("#7c7c7c6e")
	mouse_enter_tween(visual_0)


func _on_b_0_mouse_exited() -> void:
	info_panel.visible = false
	cr_0.color = Color("#00000000")
	mouse_out_tween(visual_0,b_0_shader)


@onready var cr_1: ColorRect = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer2/Panel/b_1/cr1"

func _on_b_1_mouse_entered() -> void:
	info_panel.visible = true
	info_panel.global_position =lvl_lbl[1].global_position+Vector2(0,80)
	show_info(1)
	cr_1.color = Color("#7c7c7c6e")
	mouse_enter_tween(visual_1)

func _on_b_1_mouse_exited() -> void:
	info_panel.visible = false
	cr_1.color = Color("#00000000")
	mouse_out_tween(visual_1,b_1_shader)

@onready var cr_2: ColorRect = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer3/Panel/b_2/cr2"

func _on_b_2_mouse_entered() -> void:
	info_panel.visible = true
	info_panel.global_position =lvl_lbl[2].global_position+Vector2(0,80)
	show_info(2)
	cr_2.color = Color("#7c7c7c6e")
	mouse_enter_tween(visual_2)

func _on_b_2_mouse_exited() -> void:
	info_panel.visible = false
	cr_2.color = Color("#00000000")
	mouse_out_tween(visual_2,b_2_shader)

@onready var cr_3: ColorRect = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer4/Panel/b_3/cr3"

func _on_b_3_mouse_entered() -> void:
	info_panel.visible = true
	info_panel.global_position =lvl_lbl[3].global_position+Vector2(0,80)
	show_info(3)
	cr_3.color = Color("#7c7c7c6e")
	mouse_enter_tween(visual_3)


func _on_b_3_mouse_exited() -> void:
	info_panel.visible = false
	cr_3.color = Color("#00000000")
	mouse_out_tween(visual_3,b_3_shader)


@onready var cr_4: ColorRect = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer5/Panel/b_4/cr4"

func _on_b_4_mouse_entered() -> void:
	info_panel.visible = true
	info_panel.global_position =lvl_lbl[4].global_position+Vector2(0,80)
	show_info(4)
	cr_4.color = Color("#7c7c7c6e")
	mouse_enter_tween(visual_4)

func _on_b_4_mouse_exited() -> void:
	info_panel.visible = false
	cr_4.color = Color("#00000000")
	mouse_out_tween(visual_4,b_4_shader)
	
	

@onready var cr_5: ColorRect = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer6/Panel/b_5/cr5"

func _on_b_5_mouse_entered() -> void:
	info_panel.visible = true
	info_panel.global_position =lvl_lbl[5].global_position+Vector2(0,80)
	show_info(5)
	cr_5.color = Color("#7c7c7c6e")
	mouse_enter_tween(visual_5)


func _on_b_5_mouse_exited() -> void:
	info_panel.visible = false
	cr_5.color = Color("#00000000")
	mouse_out_tween(visual_5,b_5_shader)


@onready var cr_6: ColorRect = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer7/Panel/b_6/cr6"

func _on_b_6_mouse_entered() -> void:
	info_panel.visible = true
	info_panel.global_position =lvl_lbl[6].global_position+Vector2(0,80)
	show_info(6)
	cr_6.color = Color("#7c7c7c6e")
	mouse_enter_tween(visual_6)


func _on_b_6_mouse_exited() -> void:
	info_panel.visible = false
	cr_6.color = Color("#00000000")
	mouse_out_tween(visual_6,b_6_shader)
	

@onready var cr_7: ColorRect = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer8/Panel/b_7/cr7"

func _on_b_7_mouse_entered() -> void:
	info_panel.visible = true
	info_panel.global_position =lvl_lbl[7].global_position+Vector2(0,80)
	show_info(7)
	cr_7.color = Color("#7c7c7c6e")
	mouse_enter_tween(visual_7)
	

func _on_b_7_mouse_exited() -> void:
	info_panel.visible = false
	cr_7.color = Color("#00000000")
	mouse_out_tween(visual_7,b_7_shader)

@onready var cr_8: ColorRect = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer9/Panel/b_8/cr8"

func _on_b_8_mouse_entered() -> void:
	info_panel.visible = true
	info_panel.global_position =lvl_lbl[8].global_position+Vector2(0,80)
	show_info(8)
	cr_8.color = Color("#7c7c7c6e")
	mouse_enter_tween(visual_8)

func _on_b_8_mouse_exited() -> void:
	info_panel.visible = false
	cr_8.color = Color("#00000000")
	mouse_out_tween(visual_8,b_8_shader)

@onready var cr_9: ColorRect = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer10/Panel/b_9/cr9"

func _on_b_9_mouse_entered() -> void:
	info_panel.visible = true
	info_panel.global_position =lvl_lbl[9].global_position+Vector2(0,80)
	show_info(9)
	cr_9.color = Color("#7c7c7c6e")
	mouse_enter_tween(visual_9)

func _on_b_9_mouse_exited() -> void:
	info_panel.visible = false
	cr_9.color = Color("#00000000")
	mouse_out_tween(visual_9,b_9_shader)

@onready var cr_10: ColorRect = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer11/Panel/b_10/cr10"

func _on_b_10_mouse_entered() -> void:
	info_panel.visible = true
	info_panel.global_position =lvl_lbl[10].global_position+Vector2(0,80)
	show_info(10)
	cr_10.color = Color("#7c7c7c6e")
	mouse_enter_tween(visual_10)


func _on_b_10_mouse_exited() -> void:
	info_panel.visible = false
	cr_10.color = Color("#00000000")
	mouse_out_tween(visual_10,b_10_shader)


@onready var cr_11: ColorRect = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer12/Panel/b_11/cr11"

func _on_b_11_mouse_entered() -> void:
	info_panel.visible = true
	info_panel.global_position =lvl_lbl[11].global_position+Vector2(0,80)
	show_info(11)
	cr_11.color = Color("#7c7c7c6e")
	mouse_enter_tween(visual_11)


func _on_b_11_mouse_exited() -> void:
	info_panel.visible = false
	cr_11.color = Color("#00000000")
	mouse_out_tween(visual_11,b_11_shader)


@onready var cr_12: ColorRect = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer13/Panel/b_12/cr12"

func _on_b_12_mouse_entered() -> void:
	info_panel.visible = true
	info_panel.global_position =lvl_lbl[12].global_position+Vector2(0,80)
	show_info(12)
	cr_12.color = Color("#7c7c7c6e")
	mouse_enter_tween(visual_12)

func _on_b_12_mouse_exited() -> void:
	info_panel.visible = false
	cr_12.color = Color("#00000000")
	mouse_out_tween(visual_12,b_12_shader)
	

@onready var cr_13: ColorRect = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer14/Panel/b_13/cr13"

func _on_b_13_mouse_entered() -> void:
	info_panel.visible = true
	info_panel.global_position =lvl_lbl[13].global_position+Vector2(0,80)
	show_info(13)
	cr_13.color = Color("#7c7c7c6e")
	mouse_enter_tween(visual_13)

func _on_b_13_mouse_exited() -> void:
	info_panel.visible = false
	cr_13.color = Color("#00000000")
	mouse_out_tween(visual_13,b_13_shader)


@onready var cr_14: ColorRect = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer15/Panel/b_14/cr14"

func _on_b_14_mouse_entered() -> void:
	info_panel.visible = true
	info_panel.global_position =lvl_lbl[14].global_position+Vector2(0,80)
	show_info(14)
	cr_14.color = Color("#7c7c7c6e")
	mouse_enter_tween(visual_14)

func _on_b_14_mouse_exited() -> void:
	info_panel.visible = false
	cr_14.color = Color("#00000000")
	mouse_out_tween(visual_14,b_14_shader)

@onready var cr_15: ColorRect = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer16/Panel/b_15/cr15"

func _on_b_15_mouse_entered() -> void:
	info_panel.visible = true
	info_panel.global_position =lvl_lbl[15].global_position+Vector2(0,80)
	show_info(15)
	cr_15.color = Color("#7c7c7c6e")
	mouse_enter_tween(visual_15)

func _on_b_15_mouse_exited() -> void:
	info_panel.visible = false
	cr_15.color = Color("#00000000")
	mouse_out_tween(visual_15,b_15_shader)

@onready var cr_16: ColorRect = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer17/Panel/b_16/cr16"

func _on_b_16_mouse_entered() -> void:
	info_panel.visible = true
	info_panel.global_position =lvl_lbl[16].global_position+Vector2(0,80)
	show_info(16)
	cr_16.color = Color("#7c7c7c6e")
	mouse_enter_tween(visual_16)

func _on_b_16_mouse_exited() -> void:
	info_panel.visible = false
	cr_16.color = Color("#00000000")
	mouse_out_tween(visual_16,b_16_shader)

@onready var cr_17: ColorRect = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer18/Panel/b_17/cr17"

func _on_b_17_mouse_entered() -> void:
	info_panel.visible = true
	info_panel.global_position =lvl_lbl[17].global_position+Vector2(0,80)
	show_info(17)
	cr_17.color = Color("#7c7c7c6e")
	mouse_enter_tween(visual_17)


func _on_b_17_mouse_exited() -> void:
	info_panel.visible = false
	cr_17.color = Color("#00000000")
	mouse_out_tween(visual_17,b_17_shader)

@onready var koi_btn: Button = $"../CanvasLayer/world_map/shop_tabs/Koi_tab/koi_btn"
@onready var deco_btn: Button = $"../CanvasLayer/world_map/shop_tabs/Deco_tab/deco_btn"
@onready var bed_btn: Button = $"../CanvasLayer/world_map/shop_tabs/Bed_tab/bed_btn"
@onready var surface_btn: Button = $"../CanvasLayer/world_map/shop_tabs/Surface_tab/surface_btn"
@onready var world_tab: PanelContainer = $"../CanvasLayer/world_map/PanelContainer"
@onready var deco_tab: PanelContainer = $"../CanvasLayer/world_map/Deco"
@onready var bed_tab: PanelContainer = $"../CanvasLayer/world_map/Bed"
@onready var surface_tab: PanelContainer = $"../CanvasLayer/world_map/Surface"

var shop_tabs = []
var shop_buttons = []
var shop_labels = []

func shop_page_manager(page_index:int):
	for i:PanelContainer in shop_tabs:
		i.visible = false
	for i:Label in shop_labels:
		i.remove_theme_constant_override("shadow_offset_y")
	for i:Button in shop_buttons:
		i.self_modulate = Color(0.3,0.3,0.3,1)
	shop_labels[page_index].add_theme_constant_override("shadow_offset_y",4)
	shop_tabs[page_index].visible = true
	shop_buttons[page_index].self_modulate = Color(1,1,1,1)



func _on_koi_tab_button_down() -> void:
	shop_page_manager(0)


func _on_deco_tab_button_down() -> void:
	shop_page_manager(1)


func _on_bed_tab_button_down() -> void:
	shop_page_manager(2)


func _on_surface_tab_button_down() -> void:
	shop_page_manager(3)

var angle_x_max:float = 0.3
var angle_y_max:float = 0.3
@onready var grid_container: GridContainer = $"../CanvasLayer/world_map/PanelContainer/GridContainer"

func _on_b_0_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_0,b_0_shader)

#@onready var sub_viewport_0: SubViewport = $"../CanvasLayer/world_map/PanelContainer/GridContainer/MarginContainer/Panel/b_0/visual0/SubViewport0"
var tween_hover:Tween
var tween_rot:Tween
var tween_clicked:Tween

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
	


func _on_b_1_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_1,b_1_shader)


func _on_b_2_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_2,b_2_shader)


func _on_b_3_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_3,b_3_shader)


func _on_b_4_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_4,b_4_shader)


func _on_b_5_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_5,b_5_shader)

func _on_b_6_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_6,b_6_shader)


func _on_b_7_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_7,b_7_shader)


func _on_b_8_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_8,b_8_shader)


func _on_b_9_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_9,b_9_shader)

func _on_b_10_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_10,b_10_shader)


func _on_b_11_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_11,b_11_shader)


func _on_b_12_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_12,b_12_shader)


func _on_b_13_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_13,b_13_shader)


func _on_b_14_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_14,b_14_shader)


func _on_b_15_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_15,b_15_shader)


func _on_b_16_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_16,b_16_shader)


func _on_b_17_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		D2_perspect_gui(visual_17,b_17_shader)
