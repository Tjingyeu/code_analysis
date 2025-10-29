class_name UpdateLogic
extends Node2D


@onready var decorations: Control = $"../CanvasLayer/decorations"
@onready var renshu_btn: Button = $"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade0/PanelContainer/VBoxContainer/MarginContainer2/renshu_btn"
@onready var renshu_lbl: Label = $"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade0/PanelContainer/VBoxContainer/MarginContainer2/renshu_btn/renshu_lbl"
@onready var koi_food_btn: Button = $"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade1/PanelContainer/VBoxContainer/MarginContainer/koi_food_btn"
@onready var koi_food_lbl: Label = $"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade1/PanelContainer/VBoxContainer/MarginContainer/koi_food_btn/koi_food_lbl"
@onready var luck_btn: Button = $"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade2/PanelContainer/VBoxContainer/MarginContainer/luck_btn"
@onready var luck_lbl: Label = $"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade2/PanelContainer/VBoxContainer/MarginContainer/luck_btn/luck_lbl"
@onready var tank_size_btn_0: Button = $"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade3/PanelContainer/VBoxContainer/MarginContainer/tank_size_btn0"
@onready var tank_size_lbl_0: Label = $"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade3/PanelContainer/VBoxContainer/MarginContainer/tank_size_btn0/tank_size_lbl0"
@onready var tank_size_btn_1: Button = $"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade4/PanelContainer/VBoxContainer/MarginContainer/tank_size_btn1"
@onready var tank_size_lbl_1: Label = $"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade4/PanelContainer/VBoxContainer/MarginContainer/tank_size_btn1/tank_size_lbl1"
@onready var tank_size_btn_2: Button = $"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade5/PanelContainer/VBoxContainer/MarginContainer/tank_size_btn2"
@onready var tank_size_lbl_2: Label = $"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade5/PanelContainer/VBoxContainer/MarginContainer/tank_size_btn2/tank_size_lbl2"

@onready var passive_income_lvl: RichTextLabel = $"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade0/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/passive_income_lvl"
@onready var food_lvl: RichTextLabel = $"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade1/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/food_lvl"
@onready var luck_lvl: RichTextLabel = $"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade2/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/luck_lvl"
@onready var tank_0_lvl: RichTextLabel = $"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade3/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/VBoxContainer/tank0_lvl"
@onready var tank_1_lvl: RichTextLabel = $"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade4/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/tank1_lvl"
@onready var tank_2_lvl: RichTextLabel = $"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade5/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/VBoxContainer/tank2_lvl"

var renshu_shader:ShaderMaterial
var koifood_shader:ShaderMaterial
var luck_shader:ShaderMaterial
var tank0_shader:ShaderMaterial
var tank1_shader:ShaderMaterial
var tank2_shader:ShaderMaterial

@onready var graphic_logic_kernel: GraphicKernel = $".."

var game_started:=false

func refresh_shaders():
	renshu_shader.set_shader_parameter("segments",CostsTable.visitors_cost.size()-1)
	koifood_shader.set_shader_parameter("segments",CostsTable.snake_kiss_cost.size()-1)
	luck_shader.set_shader_parameter("segments",CostsTable.luck_cost.size()-1)
	tank0_shader.set_shader_parameter("segments",CostsTable.tank_size_cost.size()-1)
	tank1_shader.set_shader_parameter("segments",CostsTable.tank1_size_cost.size()-1)
	tank2_shader.set_shader_parameter("segments",CostsTable.tank2_size_cost.size()-1)
	renshu_shader.set_shader_parameter("progress",float(GlobalVariables.visitors_lvl)/float(CostsTable.visitors_cost.size()-1))
	koifood_shader.set_shader_parameter("progress",float(GlobalVariables.kissing_lvl)/float(CostsTable.snake_kiss_cost.size()-1))
	luck_shader.set_shader_parameter("progress",float(GlobalVariables.luck_lvl)/float(CostsTable.luck_cost.size()-1))
	tank0_shader.set_shader_parameter("progress",float(GlobalVariables.tank_size_lvl0)/float(CostsTable.tank_size_cost.size()-1))
	tank1_shader.set_shader_parameter("progress",float(GlobalVariables.tank_size_lvl1)/float(CostsTable.tank1_size_cost.size()-1))
	tank2_shader.set_shader_parameter("progress",float(GlobalVariables.tank_size_lvl2)/float(CostsTable.tank2_size_cost.size()-1))
	renshu_shader.set_shader_parameter("gap",0.1)
	koifood_shader.set_shader_parameter("gap",0.04)
	luck_shader.set_shader_parameter("gap",0.1)
	tank0_shader.set_shader_parameter("gap",0.02)
	tank1_shader.set_shader_parameter("gap",0.02)
	tank2_shader.set_shader_parameter("gap",0.02)

func start_game() -> void:
	renshu_shader =$"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade0/PanelContainer/VBoxContainer/PanelContainer/MarginContainer/PanelContainer/renshu_sd".material
	koifood_shader=$"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade1/PanelContainer/VBoxContainer/PanelContainer/MarginContainer/PanelContainer/koifood_sd".material
	luck_shader=$"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade2/PanelContainer/VBoxContainer/PanelContainer/MarginContainer/PanelContainer/luck_sd".material
	tank0_shader=$"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade3/PanelContainer/VBoxContainer/PanelContainer/MarginContainer/PanelContainer/tank0_sd".material
	tank1_shader=$"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade4/PanelContainer/VBoxContainer/PanelContainer/MarginContainer/PanelContainer/tank1_sd".material
	tank2_shader=$"../CanvasLayer/upgrade_panel/upgrades/GridContainer/upgrade5/PanelContainer/VBoxContainer/PanelContainer/MarginContainer/PanelContainer/tank2_sd".material
	
	refresh_shaders()
	
	renshu_lbl.text = str(GlobalVariables.number_format(CostsTable.visitors_cost[GlobalVariables.visitors_lvl]))+"¥"
	koi_food_lbl.text = str(GlobalVariables.number_format(CostsTable.snake_kiss_cost[GlobalVariables.kissing_lvl]))+"¥"
	luck_lbl.text = str(GlobalVariables.number_format(CostsTable.luck_cost[GlobalVariables.luck_lvl]))+"¥"
	tank_size_lbl_0.text = str(GlobalVariables.number_format(CostsTable.tank_size_cost[GlobalVariables.tank_size_lvl0]))+"¥"
	tank_size_lbl_1.text = str(GlobalVariables.number_format(CostsTable.tank1_size_cost[GlobalVariables.tank_size_lvl1]))+"¥"
	tank_size_lbl_2.text = str(GlobalVariables.number_format(CostsTable.tank2_size_cost[GlobalVariables.tank_size_lvl2]))+"¥"


	game_started = true
	pond_management.start()

func _process(_delta: float) -> void:
	if game_started:
		var gold:= GlobalVariables.gold_current
			
		if GlobalVariables.visitors_lvl == CostsTable.visitors_cost.size()-1:
			renshu_lbl.text = "Max"
			renshu_btn.disabled = true
			passive_income_lvl.text = "[rainbow][wave]MAX"
		else:
			passive_income_lvl.text = "[i]Multiplier: x%s" %[str(CostsTable.visitors_count(GlobalVariables.visitors_lvl))]
			if gold < CostsTable.visitors_cost[GlobalVariables.visitors_lvl]:
				renshu_btn.disabled = true
			elif gold >= CostsTable.visitors_cost[GlobalVariables.visitors_lvl]:
				renshu_btn.disabled = false
		
		if GlobalVariables.kissing_lvl == CostsTable.snake_kiss_cost.size()-1:
			koi_food_lbl.text = "Max"
			koi_food_btn.disabled = true
			food_lvl.text = "[rainbow][wave]MAX"
		else:
			food_lvl.text = "[i]Exp: %s" %[str(GlobalVariables.get_food_Exp())]
			if gold < CostsTable.snake_kiss_cost[GlobalVariables.kissing_lvl]:
				koi_food_btn.disabled = true
			elif gold >= CostsTable.snake_kiss_cost[GlobalVariables.kissing_lvl]:
				koi_food_btn.disabled = false
		
		if GlobalVariables.luck_lvl == CostsTable.luck_cost.size()-1:
			luck_lbl.text = "Max"
			luck_btn.disabled = true
			luck_lvl.text = "[rainbow][wave]MAX"
		else:
			luck_lvl.text = "[i]Luckiness: %s" %[str(GlobalVariables.get_luck_index()+20.0)]
			if gold < CostsTable.luck_cost[GlobalVariables.luck_lvl]:
				luck_btn.disabled = true
			elif gold >= CostsTable.luck_cost[GlobalVariables.luck_lvl]:
				luck_btn.disabled = false
		#
		if GlobalVariables.tank_size_lvl0 == CostsTable.tank_size_cost.size()-1:
			tank_size_lbl_0.text = "Max"
			tank_size_btn_0.disabled = true
			tank_0_lvl.text = "[rainbow][wave]MAX"
		else:
			tank_0_lvl.text = "[i]Pond Size: %s" %[str(GlobalVariables.tank_size[GlobalVariables.tank_size_lvl0])]
			if gold < CostsTable.tank_size_cost[GlobalVariables.tank_size_lvl0]:
				tank_size_btn_0.disabled = true
			elif gold >= CostsTable.tank_size_cost[GlobalVariables.tank_size_lvl0]:
				tank_size_btn_0.disabled = false
				
		if GlobalVariables.tank_size_lvl1 == CostsTable.tank1_size_cost.size()-1:
			tank_size_lbl_1.text = "Max"
			tank_size_btn_1.disabled = true
			tank_1_lvl.text = "[rainbow][wave]MAX"
		else:
			tank_1_lvl.text = "[i]Pond Size: %s" %[str(GlobalVariables.tank_size[GlobalVariables.tank_size_lvl1])]
			if gold < CostsTable.tank1_size_cost[GlobalVariables.tank_size_lvl1]:
				tank_size_btn_1.disabled = true
			elif gold >= CostsTable.tank1_size_cost[GlobalVariables.tank_size_lvl1]:
				tank_size_btn_1.disabled = false
				
		if GlobalVariables.tank_size_lvl2 == CostsTable.tank2_size_cost.size()-1:
			tank_size_lbl_2.text = "Max"
			tank_size_btn_2.disabled = true
			tank_2_lvl.text = "[rainbow][wave]MAX"
		else:
			tank_2_lvl.text = "[i]Pond Size: %s" %[str(GlobalVariables.tank_size[GlobalVariables.tank_size_lvl2])]
			if gold < CostsTable.tank2_size_cost[GlobalVariables.tank_size_lvl2]:
				tank_size_btn_2.disabled = true
			elif gold >= CostsTable.tank2_size_cost[GlobalVariables.tank_size_lvl2]:
				tank_size_btn_2.disabled = false
		



func _on_shewen_button_down() -> void:
	if GlobalVariables.gold_current >= CostsTable.snake_kiss_cost[GlobalVariables.kissing_lvl]:
		GlobalVariables.gold_current -= CostsTable.snake_kiss_cost[GlobalVariables.kissing_lvl]
		GlobalVariables.kissing_lvl += 1
		GlobalVariables.kissing_multiplier = CostsTable.snake_kiss_multiplier(GlobalVariables.kissing_lvl)
		
		if GlobalVariables.kissing_lvl == CostsTable.snake_kiss_cost.size()-1:
			koi_food_lbl.text = "Max"
			koi_food_btn.disabled = true
			#fish_food_lvl.text = "[rainbow][wave]MAX"
		else:
			koi_food_lbl.text = str(GlobalVariables.number_format(CostsTable.snake_kiss_cost[GlobalVariables.kissing_lvl]))+"¥"
			#fish_food_lvl.text = str(GlobalVariables.kissing_lvl)+"-->"+str(GlobalVariables.kissing_lvl+1)
	koifood_shader.set_shader_parameter("progress",float(GlobalVariables.kissing_lvl)/float(CostsTable.snake_kiss_cost.size()-1))

func _on_renshu_button_down() -> void:
	if GlobalVariables.gold_current >= CostsTable.visitors_cost[GlobalVariables.visitors_lvl]:
		GlobalVariables.gold_current -= CostsTable.visitors_cost[GlobalVariables.visitors_lvl]
		GlobalVariables.visitors_lvl += 1
		GlobalVariables.visitorsPerMin = CostsTable.visitors_count(GlobalVariables.visitors_lvl) 
		if GlobalVariables.visitors_lvl == CostsTable.visitors_cost.size()-1:
			renshu_lbl.text = "Max"
			renshu_btn.disabled = true
			#passive_income_lvl.text = "[rainbow][wave]MAX"
		else:
			renshu_lbl.text = str(GlobalVariables.number_format(CostsTable.visitors_cost[GlobalVariables.visitors_lvl]))+"¥"
			#passive_income_lvl.text = str(GlobalVariables.visitors_lvl)+"-->"+str(GlobalVariables.visitors_lvl+1)
	renshu_shader.set_shader_parameter("progress",float(GlobalVariables.visitors_lvl)/float(CostsTable.visitors_cost.size()-1))


#@onready var panel_container: PanelContainer = $"../CanvasLayer/upgrade_panel/PanelContainer"
var in_shop_panel:bool=false

@onready var pond_management: PondManager = $"../Pond_management"

@onready var underwater_decos: Node2D = $"../underwater_decos"



func _on_tank_size_btn_0_button_up() -> void:
	if GlobalVariables.gold_current >= CostsTable.tank_size_cost[GlobalVariables.tank_size_lvl0]:
		GlobalVariables.gold_current -= CostsTable.tank_size_cost[GlobalVariables.tank_size_lvl0]
		GlobalVariables.tank_size_lvl0 += 1
		if GlobalVariables.tank_size_lvl0 == CostsTable.tank_size_cost.size()-1:
			tank_size_lbl_0.text = "Max"
			tank_size_btn_0.disabled = true
			#tank_size_lvl.text = "[rainbow][wave]MAX"
		else:
			tank_size_lbl_0.text = str(GlobalVariables.number_format(CostsTable.tank_size_cost[GlobalVariables.tank_size_lvl0]))+"¥"
			
	tank0_shader.set_shader_parameter("progress",float(GlobalVariables.tank_size_lvl0)/float(CostsTable.tank_size_cost.size()-1))




func _on_tank_size_btn_1_button_up() -> void:
	if GlobalVariables.gold_current >= CostsTable.tank1_size_cost[GlobalVariables.tank_size_lvl1]:
		GlobalVariables.gold_current -= CostsTable.tank1_size_cost[GlobalVariables.tank_size_lvl1]
		GlobalVariables.tank_size_lvl1 += 1
		if GlobalVariables.tank_size_lvl1 > 0:
			pond_management.p_2_btn.disabled = false
		#GlobalVariables.snake_amount_limit = CostsTable.visitors_count(GlobalVariables.visitors_lvl) + GlobalVariables.basic_visitor_increase
		if GlobalVariables.tank_size_lvl1 == CostsTable.tank1_size_cost.size()-1:
			#sheliang_lbl_1.text = "[center]Max"
			tank_size_btn_1.disabled = true
			tank_size_lbl_1.text = "[rainbow][wave]MAX"
		else:
			tank_size_lbl_1.text = str(GlobalVariables.number_format(CostsTable.tank1_size_cost[GlobalVariables.tank_size_lvl1]))+"¥"
			#sheliang_lbl_1.text = str(GlobalVariables.tank_size_lvl1)+"-->"+str(GlobalVariables.tank_size_lvl1+1)
	tank1_shader.set_shader_parameter("progress",float(GlobalVariables.tank_size_lvl1)/float(CostsTable.tank1_size_cost.size()-1))


func _on_tank_size_btn_2_button_up() -> void:
	if GlobalVariables.gold_current >= CostsTable.tank2_size_cost[GlobalVariables.tank_size_lvl2]:
		GlobalVariables.gold_current -= CostsTable.tank2_size_cost[GlobalVariables.tank_size_lvl2]
		GlobalVariables.tank_size_lvl2 += 1
		if GlobalVariables.tank_size_lvl2 > 0:
			pond_management.p_3_btn.disabled = false
		#GlobalVariables.snake_amount_limit = CostsTable.visitors_count(GlobalVariables.visitors_lvl) + GlobalVariables.basic_visitor_increase
		if GlobalVariables.tank_size_lvl2 == CostsTable.tank2_size_cost.size()-1:
			#price_2.text = "[center]Max"
			tank_size_btn_2.disabled = true
			tank_size_lbl_2.text = "[rainbow][wave]MAX"
		else:
			tank_size_lbl_2.text = str(GlobalVariables.number_format(CostsTable.tank2_size_cost[GlobalVariables.tank_size_lvl2]))+"¥"
	tank2_shader.set_shader_parameter("progress",float(GlobalVariables.tank_size_lvl2)/float(CostsTable.tank2_size_cost.size()-1))


func _on_luck_btn_button_up() -> void:
	if GlobalVariables.gold_current >= CostsTable.luck_cost[GlobalVariables.luck_lvl]:
		GlobalVariables.gold_current -= CostsTable.luck_cost[GlobalVariables.luck_lvl]
		GlobalVariables.luck_lvl += 1

		if GlobalVariables.luck_lvl == CostsTable.luck_cost.size()-1:
			luck_lbl.text = "Max"
			luck_btn.disabled = true
			#fish_food_lvl.text = "[rainbow][wave]MAX"
		else:
			luck_lbl.text = str(GlobalVariables.number_format(CostsTable.luck_cost[GlobalVariables.luck_lvl]))+"¥"
			#fish_food_lvl.text = str(GlobalVariables.kissing_lvl)+"-->"+str(GlobalVariables.kissing_lvl+1)
	luck_shader.set_shader_parameter("progress",float(GlobalVariables.luck_lvl)/float(CostsTable.luck_cost.size()-1))
