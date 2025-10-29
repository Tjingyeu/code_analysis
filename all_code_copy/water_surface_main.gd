class_name GraphicKernel
extends Node2D
var snakes :=[]

var local_pond_index:int

@onready var movement_tween:Tween
@onready var alpha_tween:Tween
var Delta:float

@onready var menu: Menu = $CanvasLayer/menu

var bubble_sound:AudioStreamPlayer2D
const ONE_DAY_WITH_YOU_378373 = preload("res://main/bgms/one-day-with-you-378373.mp3")
const SLOW_DAYS_GENTLE_WAYS_380498 = preload("res://main/bgms/slow-days-gentle-ways-380498.mp3")
const ALONE_IN_THE_WOODS_358263 = preload("res://main/bgms/alone-in-the-woods-358263.mp3")
const ONSEN_RYOKAN_363196 = preload("res://main/bgms/onsen-ryokan-363196.mp3")
const PATH_IN_THE_WOODS_GENTLE_GUITAR_419728 = preload("res://main/bgms/path-in-the-woods-gentle-guitar-419728.mp3")


var bgm_list = [
ONE_DAY_WITH_YOU_378373,
SLOW_DAYS_GENTLE_WAYS_380498,
ALONE_IN_THE_WOODS_358263,
ONSEN_RYOKAN_363196,
PATH_IN_THE_WOODS_GENTLE_GUITAR_419728
]

const FOREST_AMBIENCE_296528 = preload("uid://dj15u6qm077op")
const FOREST_ATMOSPHERE_005_LOCALIZATION_POLAND_329747 = preload("uid://pme2rjgdsnpp")
const THE_VOICES_OF_BIRDS_IN_THE_FOREST_7715 = preload("uid://c6pque47wnkc2")

var bird_list=[FOREST_AMBIENCE_296528,FOREST_ATMOSPHERE_005_LOCALIZATION_POLAND_329747,THE_VOICES_OF_BIRDS_IN_THE_FOREST_7715]

#@onready var decorations: Control = $CanvasLayer/decorations
#@onready var underwater_decos: Node2D = $underwater_decos
#@onready var under_water_decos: Control = $under_water_decos
@onready var underwater_decos: Node2D = $underwater_decos

@onready var surface_deco: Node2D = $CanvasLayer/surface_deco

@onready var camera_2d: Camera2D = $Camera2D
#@onready var menu: PanelContainer = $CanvasLayer/menu
#const MAIN_MENU = preload("res://main_menu/main_menu.tscn")
var texture:Texture2D=preload("res://icon.svg")
@onready var line_render: Node2D = $line_render
@onready var snake_eyes: Node2D = $snake_eyes
@onready var fish_fins: Node2D = $fish_fins
@onready var fish_tails: Node2D = $fish_tails
@onready var fish_leg_fins: Node2D = $fish_leg_fins

@onready var upgrade_panel: Control = $CanvasLayer/upgrade_panel
@onready var upgrade_background: ColorRect = $CanvasLayer/upgrade_background


@onready var world_map: Control = $CanvasLayer/world_map
@onready var upgrade_logic_kernel: UpdateLogic = $Upgrade_logic_kernel

const WIDTH_CURVE = preload("res://main/width_curve.tres")
const SNAKE_EYES = preload("res://main/snake_eyes.png")
const FISH_FIN = preload("res://main/fish_fin.png")
const FISH_FIN_LEG = preload("res://main/fish_fin-leg.png")
const FISH_FIN_TAIL = preload("res://main/fish_fin-tail.png")
@onready var gold: Label = $CanvasLayer/TextureRect/HBoxContainer/MarginContainer/Gold
@onready var travel_logic_kernel: TravelKernel = $Travel_logic_kernel

var can_click_screen:bool
var click_not_in_cooldown:bool = true
@onready var canvas_layer: CanvasLayer = $CanvasLayer

@onready var opening: ColorRect = $opening


var save_and_load:SaveAndLoad
var index_list = [0,1,2,3,4]

const COIN = preload("res://main/sound_effects/coin.mp3")
@onready var sell_effect: AudioStreamPlayer2D = $Camera2D/sell_effect



func sell_sfx():
	sell_effect.play()

func remix_bgm_list():
	randomize()
	index_list.shuffle()
	for i in index_list:
		bgm.stream = bgm_list[i]
		bgm.play()
		await bgm.finished
	remix_bgm_list()
	
@onready var bird_sound: AudioStreamPlayer2D = $Camera2D/bird_sound

func remix_bird_list():
	randomize()
	bird_list.shuffle()
	for i in bird_list:
		bird_sound.stream = i
		bird_sound.play()
		await bird_sound.finished
	remix_bird_list()
	

func _ready() -> void:
	bubble_sound = get_tree().get_first_node_in_group("bubble")
	#canvas_layer.visible = false
	save_and_load = SaveAndLoad.new()
	water_shader_material = water_shader.material
	restore_saved_game()
	upgrade_logic_kernel.start_game()
	travel_logic_kernel.start_game()
	menu.start_game()
	set_bed(GlobalVariables.pond_bed_index0)
	set_surface(GlobalVariables.pond_surface_index0)
	TranslationServer.set_locale("en")
	remix_bgm_list()
	remix_bird_list()
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(opening,"color",Color(0,0,0,0),8.0)
	movement_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	alpha_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	
	explore_button.pivot_offset = explore_button.size/2
	upgrade_button.pivot_offset = upgrade_button.size/2
	koi_button.pivot_offset = koi_button.size/2
	closing_btn.pivot_offset = closing_btn.size/2
	closing_btn_w.pivot_offset = closing_btn_w.size/2
	GlobalVariables.location_count.resize(18)

func game_end():
	camera_2d.global_position = Vector2(1920.0+1920.0/2.0,+1088.0/2.0)
	canvas_layer.visible = false

func game_start():
	camera_2d.global_position = Vector2.ZERO
	canvas_layer.visible = true


@onready var pondbed_manager: PondBedManager = $pondbed_manager
@onready var reflection_manager: ReflectionManager = $reflection_manager

func restore_saved_game():
	var save:SaveAndLoad = SaveAndLoad.load_game()
	if save != null:
		GlobalVariables.location_count = save.location_count
		GlobalVariables.master_volume =save.master_volume
		GlobalVariables.music_volume =save.music_volume
		GlobalVariables.water_volume = save.water_volume
		GlobalVariables.effects_volume = save.effects_volume
		GlobalVariables.saved_time0 = save.savedTime0
		GlobalVariables.saved_time1 = save.savedTime1
		GlobalVariables.saved_time2 = save.savedTime2
		GlobalVariables.snake_unlocked_register = save.snake_register_array
		GlobalVariables.snake_count = save.snake_count
		GlobalVariables.fish_highest_quality = save.highest_quality_array
		GlobalVariables.gold_current=save.gold_current
		GlobalVariables.visitors_lvl=save.visitors_lvl
		GlobalVariables.kissing_lvl=save.kissing_lvl
		GlobalVariables.luck_lvl = save.luck_lvl
		GlobalVariables.location_unlocking=save.location_unlocking
		GlobalVariables.unlocked_location=save.unlocked_location
		GlobalVariables.snakes_id_array0=save.snakes_id_array0
		GlobalVariables.snakes_exp_array0=save.snakes_exp_array0
		GlobalVariables.snakes_age_array0=save.snakes_age_array0
		GlobalVariables.snakes_quality_array0=save.snakes_quality_array0
		GlobalVariables.tank_size_lvl0 = save.tank_size_lvl0
		GlobalVariables.tank_size_lvl1 = save.tank_size_lvl1
		GlobalVariables.tank_size_lvl2 = save.tank_size_lvl2
		GlobalVariables.pond_bed_index0 = save.pond_bed_index0
		GlobalVariables.pond_bed_index1 = save.pond_bed_index1
		GlobalVariables.pond_bed_index2 = save.pond_bed_index2
		GlobalVariables.pond_deco_id0 = save.pond_deco_id0
		GlobalVariables.pond_deco_id1 = save.pond_deco_id1
		GlobalVariables.pond_deco_id2 = save.pond_deco_id2
		GlobalVariables.pond_deco_pos0 = save.pond_deco_pos0
		GlobalVariables.pond_deco_pos1 = save.pond_deco_pos1
		GlobalVariables.pond_deco_pos2 = save.pond_deco_pos2
		GlobalVariables.pond_deco_z0 = save.pond_deco_z0
		GlobalVariables.pond_deco_z1 = save.pond_deco_z1
		GlobalVariables.pond_deco_z2 = save.pond_deco_z2
		GlobalVariables.pond_udeco_id0 = save.pond_udeco_id0
		GlobalVariables.pond_udeco_id1 = save.pond_udeco_id1
		GlobalVariables.pond_udeco_id2 = save.pond_udeco_id2
		GlobalVariables.pond_udeco_pos0 = save.pond_udeco_pos0
		GlobalVariables.pond_udeco_pos1 = save.pond_udeco_pos1
		GlobalVariables.pond_udeco_pos2 = save.pond_udeco_pos2
		GlobalVariables.pond_udeco_z0 = save.pond_udeco_z0
		GlobalVariables.pond_udeco_z1 = save.pond_udeco_z1
		GlobalVariables.pond_udeco_z2 = save.pond_udeco_z2
		GlobalVariables.pond_sdeco_id0 = save.pond_sdeco_id0
		GlobalVariables.pond_sdeco_id1 = save.pond_sdeco_id1
		GlobalVariables.pond_sdeco_id2 = save.pond_sdeco_id2
		GlobalVariables.pond_sdeco_pos0 = save.pond_sdeco_pos0
		GlobalVariables.pond_sdeco_pos1 = save.pond_sdeco_pos1
		GlobalVariables.pond_sdeco_pos2 = save.pond_sdeco_pos2
		GlobalVariables.pond_sdeco_z0 = save.pond_sdeco_z0
		GlobalVariables.pond_sdeco_z1 = save.pond_sdeco_z1
		GlobalVariables.pond_sdeco_z2 = save.pond_sdeco_z2
		GlobalVariables.pond_surface_index0 = save.pond_surface_index0
		GlobalVariables.pond_surface_index1 = save.pond_surface_index1
		GlobalVariables.pond_surface_index2 = save.pond_surface_index2
		GlobalVariables.shopping_list_bed = save.shopping_list_bed
		GlobalVariables.shopping_list_surface = save.shopping_list_surface
		GlobalVariables.tutorial = save.tutorial
		for i in GlobalVariables.snakes_id_array0.size():
			spawn_snake(GlobalVariables.snakes_id_array0[i],GlobalVariables.snakes_exp_array0[i],GlobalVariables.snakes_age_array0[i],GlobalVariables.snakes_quality_array0[i])
		#for i in GlobalVariables.pond_deco_id0.size():
			#spawn_deco(GlobalVariables.pond_deco_id0[i],GlobalVariables.pond_deco_pos0[i],GlobalVariables.pond_deco_z0[i])
		for i in GlobalVariables.pond_udeco_id0.size():
			spawn_udeco(GlobalVariables.pond_udeco_id0[i],GlobalVariables.pond_udeco_pos0[i],GlobalVariables.pond_udeco_z0[i])
		for i in GlobalVariables.pond_sdeco_id0.size():
			spawn_sdeco(GlobalVariables.pond_sdeco_id0[i],GlobalVariables.pond_sdeco_pos0[i],GlobalVariables.pond_sdeco_z0[i])
		
		#pondbed_manager.bed_purchase_button(0)
		#reflection_manager.reflection_purchase_button(0)
		pondbed_manager.bed_purchase_button(GlobalVariables.pond_bed_index0)
		reflection_manager.reflection_purchase_button(GlobalVariables.pond_surface_index0)
		GlobalVariables.visitorsPerMin = CostsTable.visitors_count(GlobalVariables.visitors_lvl)
		GlobalVariables.kissing_multiplier = CostsTable.snake_kiss_multiplier(GlobalVariables.kissing_lvl)
		
	idle_benefit(calculate_idle(GlobalVariables.saved_time0))


func idle_benefit(idle_total:float):
	var gpv:float = 0.0
	var multiplier:float = 0.0
	for i in snakes:
		gpv+=i.passive_income
	GlobalVariables.gold_current += idle_total*1/60*GlobalVariables.visitorsPerMin*gpv*Delta*(1+multiplier)
	for i in snakes:
		i.exp_current += idle_total
		i.fish_age += idle_total

func revert_idle_time(fish_age:float) -> String:
	var centuries:int = 0
	var years:int =0 
	var months:int=0
	var days:int=0
	var hours:int=0
	var minutes:int=0
	
	var idle_time:String

	var input:float = fish_age
	if input/3155692600.0>=1.0:
		while input>=3155692600.0:
			input -= 3155692600.0
			centuries+=1
	if input/31556926.0>=1.0:
		while input>=31556926.0:
			input -= 31556926.0
			years += 1
	if input/2592000.0>=1.0:
		while input>=2592000.0:
			input -= 2592000.0
			months+=1
	if input/86400.0>=1.0:
		while input>=86400.0:
			input -= 86400.0
			days += 1
	if input/3600.0>=1.0:
		while input >= 3600.0:
			input -= 3600.0
			hours += 1
	if input/60.0>=1.0:
		while input >= 60.0:
			input -= 60.0
			minutes += 1
			
	if centuries!=0:
		idle_time = str(centuries) + " century "
	if years != 0:
		idle_time = idle_time + str(years)+" year(s) "
	if months != 0:
		idle_time = idle_time + str(months)+" month(s) "
	if days != 0:
		idle_time = idle_time + str(days)+" day(s) "
	if hours != 0:
		idle_time = idle_time + str(hours)+" hour(s) "
	if minutes!=0:
		idle_time = idle_time + str(minutes)+" minute(s) "
	if idle_time != "":
		return idle_time 
	else:
		return "Just Born"

func calculate_idle(idle_time:String):
	var idle_total:float
	var second_flt:float
	var min_flt:float
	var hour_flt:float
	var day_flt:float
	var month_flt:float
	var year_flt:float
	
	var n_second_flt:float
	var n_min_flt:float
	var n_hour_flt:float
	var n_day_flt:float
	var n_month_flt:float
	var n_year_flt:float

	
	second_flt = float(idle_time.right(2))
	min_flt = float(idle_time.right(5).left(2))
	hour_flt = float(idle_time.right(8).left(2))
	day_flt = float(idle_time.left(10).right(2))
	month_flt = float(idle_time.left(7).right(2))
	year_flt = float(idle_time.left(4))
	
	var current_time = Time.get_datetime_string_from_system(true,true)
	
	n_second_flt = float(current_time.right(2))
	n_min_flt = float(current_time.right(5).left(2))
	n_hour_flt = float(current_time.right(8).left(2))
	n_day_flt = float(current_time.left(10).right(2))
	n_month_flt = float(current_time.left(7).right(2))
	n_year_flt = float(current_time.left(4))
	
	idle_total = (n_year_flt-year_flt)*3.154e7 + (n_month_flt-month_flt)*2.628e6 + (n_day_flt-day_flt)*86400 + (n_hour_flt-hour_flt)*3600 + (n_min_flt-min_flt)*60 + (n_second_flt-second_flt)
	return idle_total

func switch_pond(to_pond_index:int):
	var save:SaveAndLoad = SaveAndLoad.load_game()
	match to_pond_index:
		0:
			var local_idle_time = GlobalVariables.saved_time0
			GlobalVariables.snakes_id_array0=save.snakes_id_array0
			GlobalVariables.snakes_exp_array0=save.snakes_exp_array0
			GlobalVariables.snakes_age_array0=save.snakes_age_array0
			GlobalVariables.snakes_quality_array0=save.snakes_quality_array0
			GlobalVariables.pond_udeco_id0=save.pond_udeco_id0
			GlobalVariables.pond_udeco_pos0=save.pond_udeco_pos0
			GlobalVariables.pond_udeco_z0=save.pond_udeco_z0
			GlobalVariables.pond_sdeco_id0=save.pond_sdeco_id0
			GlobalVariables.pond_sdeco_pos0=save.pond_sdeco_pos0
			GlobalVariables.pond_sdeco_z0=save.pond_sdeco_z0
			GlobalVariables.pond_bed_index0 = save.pond_bed_index0
			GlobalVariables.pond_surface_index0 = save.pond_surface_index0
			set_bed(GlobalVariables.pond_bed_index0)
			set_surface(GlobalVariables.pond_surface_index0)
			for i in GlobalVariables.snakes_id_array0.size():
				spawn_snake(GlobalVariables.snakes_id_array0[i],GlobalVariables.snakes_exp_array0[i],GlobalVariables.snakes_age_array0[i],GlobalVariables.snakes_quality_array0[i])
			for i in GlobalVariables.pond_sdeco_id0.size():
				spawn_sdeco(GlobalVariables.pond_sdeco_id0[i],GlobalVariables.pond_sdeco_pos0[i],GlobalVariables.pond_sdeco_z0[i])
			for i in GlobalVariables.pond_udeco_id0.size():
				spawn_udeco(GlobalVariables.pond_udeco_id0[i],GlobalVariables.pond_udeco_pos0[i],GlobalVariables.pond_udeco_z0[i])
			idle_benefit(calculate_idle(local_idle_time))
		1:
			var local_idle_time = GlobalVariables.saved_time1
			GlobalVariables.snakes_id_array1=save.snakes_id_array1
			GlobalVariables.snakes_exp_array1=save.snakes_exp_array1
			GlobalVariables.snakes_age_array1=save.snakes_age_array1
			GlobalVariables.snakes_quality_array1=save.snakes_quality_array1
			GlobalVariables.pond_udeco_id1=save.pond_udeco_id1
			GlobalVariables.pond_udeco_pos1=save.pond_udeco_pos1
			GlobalVariables.pond_udeco_z1=save.pond_udeco_z1
			GlobalVariables.pond_sdeco_id1=save.pond_sdeco_id1
			GlobalVariables.pond_sdeco_pos1=save.pond_sdeco_pos1
			GlobalVariables.pond_sdeco_z1=save.pond_sdeco_z1
			GlobalVariables.pond_bed_index1 = save.pond_bed_index1
			GlobalVariables.pond_surface_index1 = save.pond_surface_index1
			set_bed(GlobalVariables.pond_bed_index1)
			set_surface(GlobalVariables.pond_surface_index1)
			for i in GlobalVariables.snakes_id_array1.size():
				spawn_snake(GlobalVariables.snakes_id_array1[i],GlobalVariables.snakes_exp_array1[i],GlobalVariables.snakes_age_array1[i],GlobalVariables.snakes_quality_array1[i])
			#for i in GlobalVariables.pond_deco_id1.size():
				#spawn_deco(GlobalVariables.pond_deco_id1[i],GlobalVariables.pond_deco_pos1[i],GlobalVariables.pond_deco_z1[i])
			for i in GlobalVariables.pond_sdeco_id1.size():
				spawn_sdeco(GlobalVariables.pond_sdeco_id1[i],GlobalVariables.pond_sdeco_pos1[i],GlobalVariables.pond_sdeco_z1[i])
			for i in GlobalVariables.pond_udeco_id1.size():
				spawn_udeco(GlobalVariables.pond_udeco_id1[i],GlobalVariables.pond_udeco_pos1[i],GlobalVariables.pond_udeco_z1[i])
			idle_benefit(calculate_idle(local_idle_time))
		2:
			var local_idle_time = GlobalVariables.saved_time2
			GlobalVariables.snakes_id_array2=save.snakes_id_array2
			GlobalVariables.snakes_exp_array2=save.snakes_exp_array2
			GlobalVariables.snakes_age_array2=save.snakes_age_array2
			GlobalVariables.snakes_quality_array2=save.snakes_quality_array2
			GlobalVariables.pond_udeco_id2=save.pond_udeco_id2
			GlobalVariables.pond_udeco_pos2=save.pond_udeco_pos2
			GlobalVariables.pond_udeco_z2=save.pond_udeco_z2
			GlobalVariables.pond_sdeco_id2=save.pond_sdeco_id2
			GlobalVariables.pond_sdeco_pos2=save.pond_sdeco_pos2
			GlobalVariables.pond_sdeco_z2=save.pond_sdeco_z2
			GlobalVariables.pond_bed_index2 = save.pond_bed_index2
			GlobalVariables.pond_surface_index2 = save.pond_surface_index2
			set_bed(GlobalVariables.pond_bed_index2)
			set_surface(GlobalVariables.pond_surface_index2)
			for i in GlobalVariables.snakes_id_array2.size():
				spawn_snake(GlobalVariables.snakes_id_array2[i],GlobalVariables.snakes_exp_array2[i],GlobalVariables.snakes_age_array2[i],GlobalVariables.snakes_quality_array2[i])
			for i in GlobalVariables.pond_sdeco_id2.size():
				spawn_sdeco(GlobalVariables.pond_sdeco_id2[i],GlobalVariables.pond_sdeco_pos2[i],GlobalVariables.pond_sdeco_z2[i])
			for i in GlobalVariables.pond_udeco_id2.size():
				spawn_udeco(GlobalVariables.pond_udeco_id2[i],GlobalVariables.pond_udeco_pos2[i],GlobalVariables.pond_udeco_z2[i])
			idle_benefit(calculate_idle(local_idle_time))
	local_pond_index = to_pond_index





#func spawn_deco(id:int,pos:Vector2,z:int):
	#var deco = load("res://decos/"+str(id)+"/"+str(id)+".tscn")
	#var new_deco = deco.instantiate()
	#decorations.add_child(new_deco)
	#new_deco.global_position = pos
	#new_deco.z_index = z
	
func spawn_udeco(id:int,pos:Vector2,z:int):
	var path = "res://decos/"+str(id)+"/"+str(id)+".tscn"
	var deco:PackedScene = load(path)
	var new_deco = deco.instantiate()
	underwater_decos.add_child(new_deco)
	new_deco.global_position = pos
	new_deco.z_index = z
	new_deco.outline_shader.set_shader_parameter("outline_size",0.0)
	
func spawn_sdeco(id:int,pos:Vector2,z:int):
	var path = "res://decos/"+str(id)+"/"+str(id)+".tscn"
	var deco:PackedScene = load(path)
	var new_deco = deco.instantiate()
	surface_deco.add_child(new_deco)
	new_deco.global_position = pos
	new_deco.z_index = z
	new_deco.outline_shader.set_shader_parameter("outline_size",0.0)
#@onready var water_shader: ColorRect = $CanvasLayer/SubViewportContainer/SubViewport/water_shader

@onready var water_shader: ColorRect = $CanvasLayer/water_shader
var water_shader_material:ShaderMaterial 
@onready var under_water: Sprite2D = $under_water

func set_bed(bed_int:int):
	match local_pond_index:
		0:
			GlobalVariables.pond_bed_index0 = bed_int
		1:
			GlobalVariables.pond_bed_index1 = bed_int
		2:
			GlobalVariables.pond_bed_index2 = bed_int

	under_water.texture = load("res://underwater_textures/"+str(bed_int)+".png")

func set_surface(surface_int:int):
	match local_pond_index:
		0:
			GlobalVariables.pond_surface_index0 = surface_int
		1:
			GlobalVariables.pond_surface_index1 = surface_int
		2:
			GlobalVariables.pond_surface_index2 = surface_int
	var cubemap = load("res://reflection/"+str(surface_int)+".png")
	water_shader_material.set_shader_parameter("iChannel2",cubemap)
#
#func reflection_follow_mouse()->void:
	#var mouse_pos:Vector2 = get_local_mouse_position()
	#var eye_vector_x = mouse_pos.x*0.01/960.0
	#var eye_vector_y = -mouse_pos.y*0.01/544.0
	#water_shader_material.set_shader_parameter("eye_offset",Vector2(eye_vector_x,eye_vector_y))
	##return Vector2(eye_vector_x,eye_vector_y)

func spawn_snake(id:int,exp_current:float,fish_age:float,fish_quality:float):
	var unique_id = GlobalVariables.current_snake_id
	var itself = Snake.new(GlobalVariables.boundary,id,exp_current,unique_id,self,fish_age,fish_quality)
	if GlobalVariables.fish_highest_quality[id] >= fish_quality:pass
	else:GlobalVariables.fish_highest_quality[id] = fish_quality
	GlobalVariables.current_snake_id += 1
	snakes.append(itself)
	var new_body = Line2D.new()
	var new_fin = Sprite2D.new()
	var new_tail = Sprite2D.new()
	
	
	var random_pos = Vector2(randf_range(-960,960),randf_range(-544,544))
	for i in itself.segment_pos.size()/2:
		itself.segment_pos[i*2] = random_pos.x
	for i in itself.segment_pos.size()/2:
		itself.segment_pos[i*2+1]=random_pos.y
	
	#new_body.global_position = random_pos
	new_body.width_curve = WIDTH_CURVE
	new_body.self_modulate = Color(1,1,1,1)
	new_body.z_index = unique_id
	new_body.texture = load("res://snake_textures/"+str(id)+".png")
	new_body.texture_mode = CanvasItem.TEXTURE_REPEAT_ENABLED
	new_body.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	new_body.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	
	
	new_fin.texture = load("res://snake_textures/"+str(id)+"_1"+".png")
	new_fin.scale = Vector2(0.6,0.6)
	new_fin.z_index = unique_id
	
	
	new_tail.texture = load("res://snake_textures/"+str(id)+"_3"+".png")
	new_tail.scale = Vector2(0.6,0.6)
	new_tail.z_index = unique_id
	
	itself.snake_body = new_body
	#itself.snake_eyes = new_eyes
	itself.fish_fin = new_fin
	#itself.fish_leg = new_leg_fin
	itself.fish_tail = new_tail
	
	new_fin.visible = false
	new_tail.visible = false
	
	
	line_render.add_child(new_body)
	fish_fins.add_child(new_fin)
	fish_tails.add_child(new_tail)

@onready var fps: Label = $CanvasLayer/fps

func _process(delta: float) -> void:
	#reflection_follow_mouse()
	var mouse_vec2:Vector2 = get_global_mouse_position()
	var viewport_size_05 = get_viewport_rect().size/2
	if abs(mouse_vec2.x)<= viewport_size_05.x :
		if abs(mouse_vec2.y)<=viewport_size_05.y:
			can_click_screen = true
		else:
			can_click_screen = false
	else:
		can_click_screen = false
	fps.text = str(round(Engine.get_frames_per_second()))
	Delta = delta
	for i:Snake in snakes:
			i.physics_update(delta)
			i.snake_grow(delta)
	
	check_distance(delta)
	on_rendering()
	#click_screen()
	put_food()
	#queue_redraw()

#var rotation_current_index:float

func on_rendering():
	for i in snakes.size():
		line_render.get_child(i).clear_points()
		
		fish_fins.get_child(i).global_position = Vector2(snakes[i].segment_pos[6],snakes[i].segment_pos[7])*(0.5)+Vector2(snakes[i].segment_pos[4],snakes[i].segment_pos[5])*(0.5)
		fish_fins.get_child(i).rotation = (Vector2(snakes[i].segment_pos[2],snakes[i].segment_pos[3]) - Vector2(snakes[i].segment_pos[4],snakes[i].segment_pos[5])).angle()+PI/2
		fish_fins.get_child(i).scale = Vector2.ONE*0.1+snakes[i].snake_scale*Vector2.ONE*0.28
		
		var segment_pos_length:int = snakes[i].current_length*2
		fish_tails.get_child(i).global_position = Vector2(snakes[i].segment_pos[segment_pos_length-2],snakes[i].segment_pos[segment_pos_length-1])
		var angle_1 = abs(Vector2(snakes[i].segment_pos[segment_pos_length-4],snakes[i].segment_pos[segment_pos_length-5]) - Vector2(snakes[i].segment_pos[segment_pos_length-2],snakes[i].segment_pos[segment_pos_length-3])).angle()
		var angle_2 = abs(Vector2(snakes[i].segment_pos[segment_pos_length-2],snakes[i].segment_pos[segment_pos_length-3]) - Vector2(snakes[i].segment_pos[segment_pos_length],snakes[i].segment_pos[segment_pos_length-1])).angle()
		var rotation_index:float = angle_1-angle_2
		#if i==0:
			#print(rotation_index)
		#rotation_index = clamp(rotation_index,-0.5,0.5)
		#rotation_index*=pow(abs(rotation_index),0.15)
		rotation_index = clamp(rotation_index,0.10,1)
		fish_tails.get_child(i).scale = (Vector2.ONE*0.20+snakes[i].snake_scale*Vector2.ONE*0.30)*Vector2(rotation_index,1)*Vector2(1.2,1.0)
		fish_tails.get_child(i).rotation = (Vector2(snakes[i].segment_pos[segment_pos_length-4],snakes[i].segment_pos[segment_pos_length-3]) - Vector2(snakes[i].segment_pos[segment_pos_length-2],snakes[i].segment_pos[segment_pos_length-1])).angle()+PI/2
		
		#var fish_leg_pos:int = int(floor(snakes[i].current_length/2))
		#fish_leg_fins.get_child(i).global_position = (0.3*Vector2(snakes[i].segment_pos[fish_leg_pos*2],snakes[i].segment_pos[fish_leg_pos*2+1])+0.7*Vector2(snakes[i].segment_pos[fish_leg_pos*2-2],snakes[i].segment_pos[fish_leg_pos*2-1]))
		#fish_leg_fins.get_child(i).rotation = (Vector2(snakes[i].segment_pos[segment_pos_length-4],snakes[i].segment_pos[segment_pos_length-3]) - Vector2(snakes[i].segment_pos[segment_pos_length-2],snakes[i].segment_pos[segment_pos_length-1])).angle()+PI/2
		 ##(Vector2(snakes[i].segment_pos[fish_leg_pos-2],snakes[i].segment_pos[fish_leg_pos-1]) - Vector2(snakes[i].segment_pos[fish_leg_pos],snakes[i].segment_pos[fish_leg_pos+1])).angle()+PI/2
		#fish_leg_fins.get_child(i).scale = Vector2.ONE*0.25+snakes[i].snake_scale*Vector2.ONE*0.25
		fish_tails.get_child(i).visible = true
		fish_fins.get_child(i).visible = true
		for j in snakes[i].current_length:
			#snakes[i].segment_pos.resize(snakes[i].current_length*2)
			line_render.get_child(i).add_point(Vector2(snakes[i].segment_pos[2*j],snakes[i].segment_pos[2*j+1]))
			line_render.get_child(i).width = snakes[i].width
		
func check_distance(delta):
	var distance_array:=[]
	for j in snakes.size():
		snakes[j].cohesion(delta)
		for k in range(j+1,snakes.size()):
			var j_snake_pos = Vector2(snakes[j].segment_pos[0],snakes[j].segment_pos[1])
			var k_snake_pos = Vector2(snakes[k].segment_pos[0],snakes[k].segment_pos[1])
			
			var distance = j_snake_pos.distance_to(k_snake_pos)
			
			if distance<=250:
				distance_array.append([snakes[j],snakes[k]])
				
			if distance<=300:
				var reverse_dir:Vector2
				reverse_dir = -snakes[k].dir_actual.normalized()
				if abs(reverse_dir.angle_to(-k_snake_pos+j_snake_pos))>=PI/6:
					snakes[j].dir_actual += (2/distance)*snakes[k].dir_actual*snakes[j].snake_scale
					snakes[j].dir_actual = snakes[j].dir_actual.normalized()
				reverse_dir = -snakes[j].dir_actual.normalized()
				if abs(reverse_dir.angle_to(-j_snake_pos+k_snake_pos))>=PI/6:
					snakes[k].dir_actual += (2/distance)*snakes[j].dir_actual*snakes[k].snake_scale
					snakes[k].dir_actual = snakes[k].dir_actual.normalized()
			
			
			
			if distance<=20:
				snakes[j].steering_away(snakes[k])
				snakes[k].steering_away(snakes[j])

		#for i in range(snakes[j].radius_array.size()-1,-1,-1):
			#draw_set_transform(Vector2(snakes[j].segment_pos[2*i],snakes[j].segment_pos[2*i+1])-Vector2(64,64),snakes[j].segment_dir[i])
			#draw_texture(texture,Vector2.ZERO)
			#draw_circle(Vector2(snakes[j].segment_pos[2*i],snakes[j].segment_pos[2*i+1]),snakes[j].radius_array[i],Color.DEEP_SKY_BLUE,false)
			#draw_line(Vector2(snakes[j].segment_pos[2*i],snakes[j].segment_pos[2*i+1]),Vector2(snakes[j].segment_pos[2*i],snakes[j].segment_pos[2*i+1])-snakes[j].segment_dir[i]*snakes[j].radius_array[i],Color.RED)
	for i in distance_array:
		i[0].distance_array_in_range.append(Vector2(i[1].segment_pos[0],i[1].segment_pos[1]))
		i[1].distance_array_in_range.append(Vector2(i[0].segment_pos[0],i[0].segment_pos[1]))
	
#func _draw() -> void:
	#draw_circle(Vector2(snakes[0].segment_pos[0],snakes[0].segment_pos[1]),400,Color.RED,false,5)
	#draw_circle(Vector2(snakes[0].segment_pos[0],snakes[0].segment_pos[1]),10,Color.RED,true)
	#draw_line(Vector2(snakes[0].segment_pos[0],snakes[0].segment_pos[1]),(snakes[0].dir_actual*100+Vector2(snakes[0].segment_pos[0],snakes[0].segment_pos[1])),Color.YELLOW)
	#draw_circle(snakes[0].debug_avg_pos,10,Color.YELLOW,true)
	#draw_circle(Vector2(snakes[0].segment_pos[0],snakes[0].segment_pos[1]),300,Color.RED,false,5)

#func click_screen(pos:Vector2):
	##if can_click_screen:
		##if Input.is_action_just_pressed("left_mouse"):
			#for i in snakes:
				#i.follow_click(pos)

#const WATER_SPLASH = preload("res://fish_food/189504__vacekh__water-splash.wav")
@onready var fish_food: Node2D = $fish_food
const FISH_FOOD = preload("res://fish_food/fish_food.tscn")
@onready var anti_autoclick: Timer = $anti_autoclick

func put_food():
	if can_click_screen and click_not_in_cooldown:
		if Input.is_action_just_pressed("right_mouse"):
			click_not_in_cooldown = false
			anti_autoclick.start()
			var new_food = FISH_FOOD.instantiate()
			new_food.global_position = get_global_mouse_position()
			fish_food.add_child(new_food)
			


#func _on_color_rect_mouse_entered() -> void:
	#can_click_screen = true
#
#
#func _on_color_rect_mouse_exited() -> void:
	#can_click_screen = false


func _on_upgrade_button_button_down() -> void:
	upgrade_logic_kernel.refresh_shaders()
	var tween = create_tween()
	tween.tween_property(upgrade_button,"scale",Vector2(0.95,0.97),0.1)
	buttons_effect.play()
	upgrade_logic_kernel.in_shop_panel = false
	tween_upgrade_background(false)
	show_upgrade()


func _on_closing_button_down() -> void:
	buttons_effect.play()
	tween_upgrade_background(true)
	hide_world_map()



signal tween_01_btn
@onready var buttons_effect: AudioStreamPlayer2D = $Camera2D/buttons_effect

func _on_explore_button_button_down() -> void:
	var tween = create_tween()
	tween.tween_property(explore_button,"scale",Vector2(0.95,0.97),0.1)
	buttons_effect.play()
	if GlobalVariables.tutorial:
		tween_01_btn.emit()
	tween_upgrade_background(false)
	show_world_map()

signal tween_03
func _on_closing_w_button_down() -> void:
	var tween = create_tween()
	tween.tween_property(closing_btn,"scale",Vector2(0.9,0.9),0.1)
	buttons_effect.play()
	if GlobalVariables.tutorial:
		tween_03.emit()
	tween_upgrade_background(true)
	hide_world_map()

func on_trip_over():
	travel_logic_kernel.return_back_to_main()


func to_save_game():
	GlobalVariables.master_volume = menu.master.value
	GlobalVariables.music_volume = menu.bgm.value
	GlobalVariables.water_volume = menu.sfx.value
	GlobalVariables.effects_volume = menu.effects.value
	
	match local_pond_index:
		0:
			GlobalVariables.saved_time0 = Time.get_datetime_string_from_system(true,true)
			GlobalVariables.snakes_id_array0 = []
			GlobalVariables.snakes_exp_array0 = []
			GlobalVariables.snakes_age_array0 = []
			GlobalVariables.snakes_quality_array0 = []
			GlobalVariables.pond_udeco_id0=[]
			GlobalVariables.pond_udeco_pos0=[]
			GlobalVariables.pond_udeco_z0=[]
			GlobalVariables.pond_sdeco_id0=[]
			GlobalVariables.pond_sdeco_pos0=[]
			GlobalVariables.pond_sdeco_z0=[]
			
			for i in surface_deco.get_children():
				if is_instance_valid(i):
					GlobalVariables.pond_sdeco_id0.append(i.item_id)
					GlobalVariables.pond_sdeco_pos0.append(i.global_position)
					GlobalVariables.pond_sdeco_z0.append(i.z_index)
			for i in underwater_decos.get_children():
				if is_instance_valid(i):
					GlobalVariables.pond_udeco_id0.append(i.item_id)
					GlobalVariables.pond_udeco_pos0.append(i.global_position)
					GlobalVariables.pond_udeco_z0.append(i.z_index)
			for i in snakes:
				if is_instance_valid(i):
					GlobalVariables.snakes_id_array0.append(i.snake_id)
					GlobalVariables.snakes_exp_array0.append(i.exp_current)
					GlobalVariables.snakes_age_array0.append(i.fish_age)
					GlobalVariables.snakes_quality_array0.append(i.fish_quality)

		1:
			GlobalVariables.saved_time1 = Time.get_datetime_string_from_system(true,true)
			GlobalVariables.snakes_id_array1 = []
			GlobalVariables.snakes_exp_array1 = []
			GlobalVariables.snakes_age_array1 = []
			GlobalVariables.snakes_quality_array1 = []
			GlobalVariables.pond_sdeco_id1=[]
			GlobalVariables.pond_sdeco_pos1=[]
			GlobalVariables.pond_sdeco_z1=[]
			GlobalVariables.pond_udeco_id1=[]
			GlobalVariables.pond_udeco_pos1=[]
			GlobalVariables.pond_udeco_z1=[]
			for i in surface_deco.get_children():
				if is_instance_valid(i):
					GlobalVariables.pond_sdeco_id1.append(i.item_id)
					GlobalVariables.pond_sdeco_pos1.append(i.global_position)
					GlobalVariables.pond_sdeco_z1.append(i.z_index)
			for i in underwater_decos.get_children():
				if is_instance_valid(i):
					GlobalVariables.pond_udeco_id1.append(i.item_id)
					GlobalVariables.pond_udeco_pos1.append(i.global_position)
					GlobalVariables.pond_udeco_z1.append(i.z_index)
			for i in snakes:
				if is_instance_valid(i):
					GlobalVariables.snakes_id_array1.append(i.snake_id)
					GlobalVariables.snakes_exp_array1.append(i.exp_current)
					GlobalVariables.snakes_age_array1.append(i.fish_age)
					GlobalVariables.snakes_quality_array1.append(i.fish_quality)

		2:
			GlobalVariables.saved_time2 = Time.get_datetime_string_from_system(true,true)
			GlobalVariables.snakes_id_array2 = []
			GlobalVariables.snakes_exp_array2 = []
			GlobalVariables.snakes_age_array2 = []
			GlobalVariables.snakes_quality_array2 = []
			GlobalVariables.pond_sdeco_id2=[]
			GlobalVariables.pond_sdeco_pos2=[]
			GlobalVariables.pond_sdeco_z2=[]
			GlobalVariables.pond_udeco_id2=[]
			GlobalVariables.pond_udeco_pos2=[]
			GlobalVariables.pond_udeco_z2=[]
			for i in surface_deco.get_children():
				if is_instance_valid(i):
					GlobalVariables.pond_sdeco_id2.append(i.item_id)
					GlobalVariables.pond_sdeco_pos2.append(i.global_position)
					GlobalVariables.pond_sdeco_z2.append(i.z_index)
			for i in underwater_decos.get_children():
				if is_instance_valid(i):
					GlobalVariables.pond_udeco_id2.append(i.item_id)
					GlobalVariables.pond_udeco_pos2.append(i.global_position)
					GlobalVariables.pond_udeco_z2.append(i.z_index)
			for i in snakes:
				if is_instance_valid(i):
					GlobalVariables.snakes_id_array2.append(i.snake_id)
					GlobalVariables.snakes_exp_array2.append(i.exp_current)
					GlobalVariables.snakes_age_array2.append(i.fish_age)
					GlobalVariables.snakes_quality_array2.append(i.fish_quality)
	save_and_load.save_game(local_pond_index)


func _on_timer_timeout() -> void:
	to_save_game()


func _on_texture_button_2_button_down() -> void:
	buttons_effect.play()
	tween_upgrade_background(false)
	show_menu()


func _on_resume_button_button_down() -> void:
	buttons_effect.play()
	tween_upgrade_background(true)
	hide_menu()

#
#func _on_quit_button_button_down() -> void:
	#to_save_game()
	#get_tree().change_scene_to_packed(MAIN_MENU)

#const SNAKE_CARD_MINED = preload("res://snake_card/snake_card_mined.tscn")
#@onready var new_found_fish_base: Control = $CanvasLayer/new_found_fish_base
const NEW_FOUND_FISH_BASE = preload("res://new_found_fish/new_found_fish_base.tscn")
@onready var new_found_base: Control = $CanvasLayer/new_found_base

func show_new_snake(id):
	var new_fish_card = NEW_FOUND_FISH_BASE.instantiate()
	new_fish_card.snake_id = id
	new_found_base.add_child(new_fish_card)
	

#@onready var rocket_panel: Control = $CanvasLayer/rocket_panel
#func _on_tech_button_button_down() -> void:
	#print("ye")
	#var tween = create_tween()
	#upgrade_background.visible = true
	#tween.tween_property(rocket_panel,"global_position",Vector2(450,128),0.1)


#func _on_closing_rocket_button_down() -> void:
	#var tween = create_tween()
	#upgrade_background.visible = false
	#tween.tween_property(rocket_panel,"global_position",Vector2(450,1358),0.1)

@onready var bgm: AudioStreamPlayer2D = $Camera2D/bgm
@onready var water_sound: AudioStreamPlayer2D = $Camera2D/water_sound

func _on_bgm_finished() -> void:
	bgm.play()


func _on_water_sound_finished() -> void:
	water_sound.play()


func _on_button_button_down() -> void:
	GlobalVariables.gold_current+=5e20



@onready var earth_anim_player: AnimationPlayer = $CanvasLayer/exploration/earth_anim_player

#func _on_exploration_mouse_entered() -> void:
	#earth_anim_player.play("cloud_clear")
#
#
#func _on_exploration_mouse_exited() -> void:
	#earth_anim_player.play_backwards("cloud_clear")


func _on_button_2_button_down() -> void:
	GlobalVariables.gold_current = 0


@onready var pond_panel: PanelContainer = $CanvasLayer/TextureRect2/pond_panel
var panel_folded:bool = true
func _on_pond_btn_button_down() -> void:
	buttons_effect.play()
	if !panel_folded:
		fold_pond_panel()
	elif panel_folded:
		movement_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		alpha_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		movement_tween.tween_property(pond_panel,"position",Vector2(-184,69),0.5)
		alpha_tween.tween_property(pond_panel,"modulate",Color(1,1,1,1),0.5)
		panel_folded = false

func fold_pond_panel():
	movement_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	alpha_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	movement_tween.tween_property(pond_panel,"position",Vector2(-184,-120),0.5)
	alpha_tween.tween_property(pond_panel,"modulate",Color(1,1,1,0),0.5)
	panel_folded = true
func tween_upgrade_background(out:bool):
	if !out:
		upgrade_background.visible = true
		var tween = create_tween()
		tween.tween_property(upgrade_background,"self_modulate",Color(0.0,0.0,0.0,0.35),1)
	if out:
		var tween = create_tween()
		tween.tween_property(upgrade_background,"self_modulate",Color(0.0,0.0,0.0,0.0),0.5)
		await tween.finished
		upgrade_background.visible = false
#func tween_world_map
		

@onready var texture_rect: TextureRect = $CanvasLayer/TextureRect
@onready var texture_rect_2: TextureRect = $CanvasLayer/TextureRect2
@onready var panel_container: PanelContainer = $CanvasLayer/PanelContainer

signal ui_ready
@onready var autohide: Timer = $auto_hide_ui/autohide

func show_ui():
	
	var tween_0 = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween_0.tween_property(texture_rect,"position",Vector2(0,4),0.2)
	#tween_0.tween_property(texture_rect,"modulate",Color(1,1,1,1),0.1)
	
	#var tween_1 = create_tween()
	tween_0.tween_property(texture_rect_2,"position",Vector2(472,-1),0.2)
	#tween_0.tween_property(texture_rect_2,"modulate",Color(1,1,1,1),0.1)
	
	#var tween_2 = create_tween()
	tween_0.tween_property(panel_container,"position",Vector2(0,0),0.2)
	#tween_0.tween_property(panel_container,"modulate",Color(1,1,1,1),0.1)
	await tween_0.finished
	ui_ready.emit()
	GlobalVariables.auto_hide = true
	autohide.start()

func show_world_map():
	world_map.visible = true
	var tween_visual = create_tween()
	var tween_pos = create_tween()
	tween_visual.tween_property(world_map,"modulate",Color(1,1,1,1),0.25)
	tween_pos.tween_property(world_map,"position",Vector2(464,256),0.25)
	
func hide_world_map():
	var tween_visual = create_tween()
	var tween_pos = create_tween()
	tween_visual.tween_property(world_map,"modulate",Color(1,1,1,0),0.25)
	tween_pos.tween_property(world_map,"position",Vector2(464,200),0.25)
	await tween_pos.finished
	world_map.visible = false

func show_upgrade():
	upgrade_panel.visible = true
	var tween_visual = create_tween()
	var tween_pos = create_tween()
	tween_visual.tween_property(upgrade_panel,"modulate",Color(1,1,1,1),0.25)
	tween_pos.tween_property(upgrade_panel,"position",Vector2(464,256),0.25)
	
func hide_upgrade():
	var tween_visual = create_tween()
	var tween_pos = create_tween()
	tween_visual.tween_property(upgrade_panel,"modulate",Color(1,1,1,0),0.25)
	tween_pos.tween_property(upgrade_panel,"position",Vector2(464,200),0.25)
	await tween_pos.finished
	upgrade_panel.visible = false

func show_menu():
	menu.visible = true
	var tween_visual = create_tween()
	var tween_pos = create_tween()
	tween_visual.tween_property(menu,"modulate",Color(1,1,1,1),0.25)
	tween_pos.tween_property(menu,"position",Vector2(755,306),0.25)

func hide_menu():
	var tween_visual = create_tween()
	var tween_pos = create_tween()
	tween_visual.tween_property(menu,"modulate",Color(1,1,1,0),0.25)
	tween_pos.tween_property(menu,"position",Vector2(755,250),0.25)
	await tween_pos.finished
	menu.visible = false

#@onready var new_main_menu: Node2D = $new_main_menu
@onready var new_main_menu: Control = $CanvasLayer/new_main_menu

#func _on_starttimer_timeout() -> void:
#
	#new_main_menu.tween_light()
	#


func _on_h_slider_value_changed(value: float) -> void:
	camera_2d.zoom = Vector2(value,value)


func _on_anti_autoclick_timeout() -> void:
	click_not_in_cooldown = true


@onready var explore_button: TextureButton = $CanvasLayer/TextureRect/HBoxContainer/MarginContainer2/ExploreButton

func _on_explore_button_mouse_entered() -> void:
	bubble_sound.play()
	var tween = create_tween()
	tween.tween_property(explore_button,"scale",Vector2(1.05,1.1),0.3).set_trans(Tween.TRANS_SINE)
	#await tween.finished
	


func _on_explore_button_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(explore_button,"scale",Vector2(1.0,1.0),0.3).set_trans(Tween.TRANS_SINE)


@onready var upgrade_button: TextureButton = $CanvasLayer/TextureRect/HBoxContainer/MarginContainer5/UpgradeButton

func _on_upgrade_button_mouse_entered() -> void:
	bubble_sound.play()
	var tween = create_tween()
	tween.tween_property(upgrade_button,"scale",Vector2(1.05,1.1),0.3).set_trans(Tween.TRANS_SINE)
	#await tween.finished
	

func _on_upgrade_button_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(upgrade_button,"scale",Vector2(1.0,1.0),0.3).set_trans(Tween.TRANS_SINE)

@onready var koi_button: TextureButton = $CanvasLayer/TextureRect/HBoxContainer/MarginContainer4/KoiButton

func _on_snakes_button_mouse_entered() -> void:
	bubble_sound.play()
	var tween = create_tween()
	tween.tween_property(koi_button,"scale",Vector2(1.05,1.1),0.3).set_trans(Tween.TRANS_SINE)
	await tween.finished
	#bubble_sound.play()
	
func _on_snakes_button_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(koi_button,"scale",Vector2(1.0,1.0),0.3).set_trans(Tween.TRANS_SINE)

@onready var closing_btn: Button = $CanvasLayer/world_map/closing_btn

func _on_closing_btn_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property(closing_btn,"scale",Vector2(1.1,1.1),0.3).set_trans(Tween.TRANS_SINE)

func _on_closing_btn_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(closing_btn,"scale",Vector2(1.0,1.0),0.3).set_trans(Tween.TRANS_SINE)


func _on_closing_btn_button_up() -> void:
	var tween = create_tween()
	tween.tween_property(closing_btn_w,"scale",Vector2(0.9,0.9),0.1)
	buttons_effect.play()
	tween_upgrade_background(true)
	hide_upgrade()

@onready var closing_btn_w: Button = $CanvasLayer/upgrade_panel/closing_btn_w

func _on_closing_btn_w_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property(closing_btn_w,"scale",Vector2(1.1,1.1),0.3).set_trans(Tween.TRANS_SINE)


func _on_closing_btn_w_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(closing_btn_w,"scale",Vector2(1.0,1.0),0.3).set_trans(Tween.TRANS_SINE)
