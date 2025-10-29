class_name SaveAndLoad
extends Resource

const save_path:="user://koi_save.tres"

@export var savedTime0:String
@export var savedTime1:String
@export var savedTime2:String
@export var gold_current:float=0.0
@export var visitors_lvl:int = 0
@export var kissing_lvl:int = 0
@export var luck_lvl:int = 0 
@export var location_unlocking=[]
@export var unlocked_location=[]


@export var snake_register_array:=[]
@export var highest_quality_array:=[]
@export var tutorial:bool



@export var location_count:=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]


@export var shopping_list_bed:=[]
@export var shopping_list_surface:=[]

@export var tank_size_lvl0:int = 0
@export var snakes_id_array0:=[]
@export var snakes_exp_array0:=[]
@export var snakes_age_array0:=[]
@export var snakes_quality_array0:=[]
@export var pond_deco_id0:=[]
@export var pond_deco_pos0:=[]
@export var pond_deco_z0:=[]
@export var pond_udeco_id0:=[]
@export var pond_udeco_pos0:=[]
@export var pond_udeco_z0:=[]
@export var pond_sdeco_id0:=[]
@export var pond_sdeco_pos0:=[]
@export var pond_sdeco_z0:=[]
@export var pond_bed_index0:int=0
@export var pond_surface_index0:int=0

@export var tank_size_lvl1:=0
@export var snakes_id_array1 :=[]
@export var snakes_exp_array1:=[]
@export var snakes_age_array1:=[]
@export var snakes_quality_array1:=[]
@export var pond_deco_id1:=[]
@export var pond_deco_pos1:=[]
@export var pond_deco_z1:=[]
@export var pond_udeco_id1:=[]
@export var pond_udeco_pos1:=[]
@export var pond_udeco_z1:=[]
@export var pond_sdeco_id1:=[]
@export var pond_sdeco_pos1:=[]
@export var pond_sdeco_z1:=[]
@export var pond_bed_index1:int=0
@export var pond_surface_index1:int=0

@export var tank_size_lvl2:=0
@export var snakes_id_array2:=[]
@export var snakes_exp_array2:=[]
@export var snakes_age_array2:=[]
@export var snakes_quality_array2:=[]
@export var pond_deco_id2:=[]
@export var pond_deco_pos2:=[]
@export var pond_deco_z2:=[]
@export var pond_udeco_id2:=[]
@export var pond_udeco_pos2:=[]
@export var pond_udeco_z2:=[]
@export var pond_sdeco_id2:=[]
@export var pond_sdeco_pos2:=[]
@export var pond_sdeco_z2:=[]
@export var pond_bed_index2:int=0
@export var pond_surface_index2:int=0

@export var snake_count:=[]

#menu
@export var master_volume:float
@export var music_volume:float
@export var water_volume:float
@export var effects_volume:float
func save_game(pond_index:int):
	#menu
	location_count = GlobalVariables.location_count
	master_volume = GlobalVariables.master_volume
	music_volume = GlobalVariables.music_volume
	water_volume = GlobalVariables.water_volume
	effects_volume = GlobalVariables.effects_volume
	
	#common data
	tutorial = GlobalVariables.tutorial
	gold_current = GlobalVariables.gold_current
	visitors_lvl = GlobalVariables.visitors_lvl
	kissing_lvl = GlobalVariables.kissing_lvl
	luck_lvl = GlobalVariables.luck_lvl
	location_unlocking = GlobalVariables.location_unlocking
	unlocked_location = GlobalVariables.unlocked_location
	snake_register_array = GlobalVariables.snake_unlocked_register
	highest_quality_array = GlobalVariables.fish_highest_quality
	snake_count = GlobalVariables.snake_count
	
	shopping_list_bed = GlobalVariables.shopping_list_bed
	shopping_list_surface = GlobalVariables.shopping_list_surface
	
	tank_size_lvl0 = GlobalVariables.tank_size_lvl0
	tank_size_lvl1 = GlobalVariables.tank_size_lvl1
	tank_size_lvl2 = GlobalVariables.tank_size_lvl2
	var last_save = load_game()
	match pond_index:
		0:
			savedTime0 = GlobalVariables.saved_time0
			snakes_id_array0 = GlobalVariables.snakes_id_array0
			snakes_exp_array0 = GlobalVariables.snakes_exp_array0
			snakes_age_array0 = GlobalVariables.snakes_age_array0
			snakes_quality_array0 = GlobalVariables.snakes_quality_array0
			pond_sdeco_id0 = GlobalVariables.pond_sdeco_id0
			pond_sdeco_pos0 = GlobalVariables.pond_sdeco_pos0
			pond_sdeco_z0 = GlobalVariables.pond_sdeco_z0
			pond_udeco_id0 = GlobalVariables.pond_udeco_id0
			pond_udeco_pos0 = GlobalVariables.pond_udeco_pos0
			pond_udeco_z0 = GlobalVariables.pond_udeco_z0
			pond_bed_index0=GlobalVariables.pond_bed_index0
			pond_surface_index0=GlobalVariables.pond_surface_index0
			
			if last_save != null:
				savedTime1 = last_save.savedTime1
				snakes_id_array1 = last_save.snakes_id_array1
				snakes_exp_array1 = last_save.snakes_exp_array1
				snakes_age_array1 = last_save.snakes_age_array1
				snakes_quality_array1 = last_save.snakes_quality_array1
				pond_sdeco_id1 = last_save.pond_sdeco_id1
				pond_sdeco_pos1 = last_save.pond_sdeco_pos1
				pond_sdeco_z1 = last_save.pond_sdeco_z1
				pond_udeco_id1 = last_save.pond_udeco_id1
				pond_udeco_pos1 = last_save.pond_udeco_pos1
				pond_udeco_z1 = last_save.pond_udeco_z1
				pond_bed_index1=last_save.pond_bed_index1
				pond_surface_index1=last_save.pond_surface_index1
				
				savedTime2 = last_save.savedTime2
				snakes_id_array2 = last_save.snakes_id_array2
				snakes_exp_array2 = last_save.snakes_exp_array2
				snakes_age_array2 = last_save.snakes_age_array2
				snakes_quality_array2 = last_save.snakes_quality_array2
				pond_sdeco_id2 = last_save.pond_sdeco_id2
				pond_sdeco_pos2 = last_save.pond_sdeco_pos2
				pond_sdeco_z2 = last_save.pond_sdeco_z2
				pond_udeco_id2 = last_save.pond_udeco_id2
				pond_udeco_pos2 = last_save.pond_udeco_pos2
				pond_udeco_z2 = last_save.pond_udeco_z2
				pond_bed_index2=last_save.pond_bed_index2
				pond_surface_index2=last_save.pond_surface_index2

		1:
			savedTime1 = GlobalVariables.saved_time1
			snakes_id_array1 = GlobalVariables.snakes_id_array1
			snakes_exp_array1 = GlobalVariables.snakes_exp_array1
			snakes_age_array1 = GlobalVariables.snakes_age_array1
			snakes_quality_array1 = GlobalVariables.snakes_quality_array1
			pond_sdeco_id1 = GlobalVariables.pond_sdeco_id1
			pond_sdeco_pos1 = GlobalVariables.pond_sdeco_pos1
			pond_sdeco_z1 = GlobalVariables.pond_sdeco_z1
			pond_udeco_id1 = GlobalVariables.pond_udeco_id1
			pond_udeco_pos1 = GlobalVariables.pond_udeco_pos1
			pond_udeco_z1 = GlobalVariables.pond_udeco_z1
			pond_bed_index1=GlobalVariables.pond_bed_index1
			pond_surface_index1=GlobalVariables.pond_surface_index1
			
			if last_save != null:
				savedTime0 = last_save.savedTime0
				snakes_id_array0 = last_save.snakes_id_array0
				snakes_exp_array0 = last_save.snakes_exp_array0
				snakes_age_array0 = last_save.snakes_age_array0
				snakes_quality_array0 = last_save.snakes_quality_array0
				pond_sdeco_id0 = last_save.pond_sdeco_id0
				pond_sdeco_pos0 = last_save.pond_sdeco_pos0
				pond_sdeco_z0 = last_save.pond_sdeco_z0
				pond_udeco_id0 = last_save.pond_udeco_id0
				pond_udeco_pos0 = last_save.pond_udeco_pos0
				pond_udeco_z0 = last_save.pond_udeco_z0
				pond_bed_index0=last_save.pond_bed_index0
				pond_surface_index0=last_save.pond_surface_index0
				
				savedTime2 = last_save.savedTime2
				snakes_id_array2 = last_save.snakes_id_array2
				snakes_exp_array2 = last_save.snakes_exp_array2
				snakes_age_array2 = last_save.snakes_age_array2
				snakes_quality_array2 = last_save.snakes_quality_array2
				pond_sdeco_id2 = last_save.pond_sdeco_id2
				pond_sdeco_pos2 = last_save.pond_sdeco_pos2
				pond_sdeco_z2 = last_save.pond_sdeco_z2
				pond_udeco_id2 = last_save.pond_udeco_id2
				pond_udeco_pos2 = last_save.pond_udeco_pos2
				pond_udeco_z2 = last_save.pond_udeco_z2
				pond_bed_index2=last_save.pond_bed_index2
				pond_surface_index2=last_save.pond_surface_index2

		2:
			savedTime2 = GlobalVariables.saved_time2
			snakes_id_array2 = GlobalVariables.snakes_id_array2
			snakes_exp_array2 = GlobalVariables.snakes_exp_array2
			snakes_age_array2 = GlobalVariables.snakes_age_array2
			snakes_quality_array2 = GlobalVariables.snakes_quality_array2
			pond_sdeco_id2 = GlobalVariables.pond_sdeco_id2
			pond_sdeco_pos2 = GlobalVariables.pond_sdeco_pos2
			pond_sdeco_z2 = GlobalVariables.pond_sdeco_z2
			pond_udeco_id2 = GlobalVariables.pond_udeco_id2
			pond_udeco_pos2 = GlobalVariables.pond_udeco_pos2
			pond_udeco_z2 = GlobalVariables.pond_udeco_z2
			pond_bed_index2=GlobalVariables.pond_bed_index2
			pond_surface_index2=GlobalVariables.pond_surface_index2
			
			if last_save != null:
				savedTime0 = last_save.savedTime0
				snakes_id_array0 = last_save.snakes_id_array0
				snakes_exp_array0 = last_save.snakes_exp_array0
				snakes_age_array0 = last_save.snakes_age_array0
				snakes_quality_array0 = last_save.snakes_quality_array0
				pond_sdeco_id0 = last_save.pond_sdeco_id0
				pond_sdeco_pos0 = last_save.pond_sdeco_pos0
				pond_sdeco_z0 = last_save.pond_sdeco_z0
				pond_udeco_id0 = last_save.pond_udeco_id0
				pond_udeco_pos0 = last_save.pond_udeco_pos0
				pond_udeco_z0 = last_save.pond_udeco_z0
				pond_bed_index0=last_save.pond_bed_index0
				pond_surface_index0=last_save.pond_surface_index0
				
				savedTime1 = last_save.savedTime1
				snakes_id_array1 = last_save.snakes_id_array1
				snakes_exp_array1 = last_save.snakes_exp_array1
				snakes_age_array1 = last_save.snakes_age_array1
				snakes_quality_array1 = last_save.snakes_quality_array1
				pond_sdeco_id1 = last_save.pond_sdeco_id1
				pond_sdeco_pos1 = last_save.pond_sdeco_pos1
				pond_sdeco_z1 = last_save.pond_sdeco_z1
				pond_udeco_id1 = last_save.pond_udeco_id1
				pond_udeco_pos1 = last_save.pond_udeco_pos1
				pond_udeco_z1 = last_save.pond_udeco_z1
				pond_bed_index1=last_save.pond_bed_index1
				pond_surface_index1=last_save.pond_surface_index1

	ResourceSaver.save(self,save_path)

static func load_game():
	if ResourceLoader.exists(save_path):
		return load(save_path)
	else:
		print("no file found")
		return null

static func erase_save():
	if ResourceLoader.exists(save_path):
		DirAccess.remove_absolute(save_path)
		
	
