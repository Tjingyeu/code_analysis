extends Node

const location_color:=[Color("#82b5d9"),Color("#b5d9a3"),Color("#d9b8ad"),Color("#888888"),Color("#6699cc"),Color("#bd555f"),Color("#733453"),Color("#d99f82"),Color("#597080"),Color("#546799"),Color("#6da18a"),Color("#433057"),Color("#c4736c"),Color("#464a73"),Color("#6da18a"),Color("#e6cca1"),Color("#8c3f52"),Color("#735f4b")]

var mouse_is_dragging:bool
var auto_hide:bool = false
var saved_time0:String
var saved_time1:String
var saved_time2:String

var master_volume:float = 1.0
var music_volume:float = 1.0
var water_volume:float = 1.0
var effects_volume:float =1.0

var current_snake_id:int = 0

var tutorial:bool = true
var location_count:=[]
var color_list:=["#d1b187",
"#c77b58",
"#ae5d40",
"#79444a",
"#4b3d44",
"#ba9158",
"#927441",
"#4d4539",
"#77743b",
"#b3a555",
"#d2c9a5",
"#8caba1",
"#4b726e",
"#574852",
"#847875",
"#ab9b8e"]

func get_food_Exp()->float:
	return float(kissing_lvl)+1.0
	
func get_luck_index() -> float:
	return luck_lvl * 2.0

#var snake_amount_limit:=[30,50,70,90,110,130,150,170]
var current_snake_amount:int

var snake_count:=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,]
var fish_highest_quality:=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,]

var gold_current:float=200.0
var starting_gold:float = 200.0

var visitors_lvl:int = 0
var kissing_lvl:int = 0
var luck_lvl:int = 0
var tank_size_lvl0:int = 0
var tank_size_lvl1:int = 0
var tank_size_lvl2:int = 0
var tank_size:=[30,40,50,60,70,80,90,100,110,120,130,140,150,160,170]

var pond_deco_id0:=[]
var pond_deco_pos0:=[]
var pond_deco_z0:=[]
var pond_deco_id1:=[]
var pond_deco_pos1:=[]
var pond_deco_z1:=[]
var pond_deco_id2:=[]
var pond_deco_pos2:=[]
var pond_deco_z2:=[]

var pond_udeco_id0:=[]
var pond_udeco_pos0:=[]
var pond_udeco_z0:=[]
var pond_udeco_id1:=[]
var pond_udeco_pos1:=[]
var pond_udeco_z1:=[]
var pond_udeco_id2:=[]
var pond_udeco_pos2:=[]
var pond_udeco_z2:=[]

var pond_sdeco_id0:=[]
var pond_sdeco_pos0:=[]
var pond_sdeco_z0:=[]
var pond_sdeco_id1:=[]
var pond_sdeco_pos1:=[]
var pond_sdeco_z1:=[]
var pond_sdeco_id2:=[]
var pond_sdeco_pos2:=[]
var pond_sdeco_z2:=[]

var pond_bed_index0:int = 0
var pond_surface_index0:int = 0
var pond_bed_index1:int = 0
var pond_surface_index1:int = 0
var pond_bed_index2:int = 0
var pond_surface_index2:int = 0
var shopping_list_bed:Array=[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]
var shopping_list_surface:=[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]

var snake_unlocked_register:=[]

var visitorsPerMin:float = 2
var kissing_multiplier:float = 1
var arm_strength:int = 1
var stamina:int = 10

var boundary:=Vector2(2300,1500)
var boundary_closed:=Vector2(1920,960)
var snake_amount:int
var closed_boundary:bool = true

var location_unlocking=[]
var unlocked_location=[]

var snakes_id_array0:=[]
var snakes_exp_array0:=[]
var snakes_age_array0:=[]
var snakes_quality_array0:=[]

var snakes_id_array1:=[]
var snakes_exp_array1:=[]
var snakes_age_array1:=[]
var snakes_quality_array1:=[]

var snakes_id_array2:=[]
var snakes_exp_array2:=[]
var snakes_age_array2:=[]
var snakes_quality_array2:=[]


var first_line_characters:=["Northern","Center","Eastern","Northern","Western","Eastern","Southern","North","West","Austrilia &","Sub-Saharan","South","Caribbean","Polynesia","South","Southeast","Melanesia","Micronesia"]
var second_line_characters:=["Europe","Asia","Europe","America","Europe","Asia","Europe","Africa","Asia","New Zealand","Africa","America","","","Asia","Asia","",""]


var multiplier_array:Array = [1,0]


var snake_kiss_exp_gain:float=5.0

func multiply_income(income):
	var m:float=0
	for i in multiplier_array:
		m += i
	return m*income

func number_format(number)->String:
	if number is String:
		return ("%.2f" %number)
	if number>=1000000000000000:
		var a = str("%.2f" %number)
		var length = a.length()-3
		var front = a.left(3)
		front = front.insert(1,".")
		var result = front+"e"+str(length-1)
		return result
	elif number>=1000000000000:
		var a = str("%.2f" %number)
		var length = a.length()-3
		var re = length%3
		if re == 0 :
			re = 3
		var front = a.left(re+2)
		front = front.insert(re,".")
		var result = front+"T"
		return result
	elif number>=1000000000:
		var a = str("%.2f" %number)
		var length = a.length()-3
		var re = length%3
		if re == 0 :
			re = 3
		var front = a.left(re+2)
		front = front.insert(re,".")
		var result = front+"B"
		return result
	elif number>=1000000:
		var a = str("%.2f" %number)
		var length = a.length()-3
		var re = length%3
		if re == 0 :
			re = 3
		var front = a.left(re+2)
		front = front.insert(re,".")
		var result = front+"M"
		return result
	elif number<1000:
		var a = str("%.2f" %number)
		return a
	else:
		var a = str("%.2f" %number)
		var length = a.length()-3
		var re = length%3
		if re == 0 :
			re = 3
		a = a.insert(re,",")
		return a

#func location_xp_need(lvl:int):
	#return lvl+2

#func location_lvlup_multiplier(lvl:int):
	#return float(lvl*location_upgrade_bonus)

func reset_values():
	# Saved times
	GlobalVariables.saved_time0 = Rsaved_time0
	GlobalVariables.saved_time1 = Rsaved_time1
	GlobalVariables.saved_time2 = Rsaved_time2

	# Snake
	GlobalVariables.current_snake_id = Rcurrent_snake_id
	GlobalVariables.snake_count = Rsnake_count
	GlobalVariables.snake_unlocked_register = Rsnake_unlocked_register
	GlobalVariables.snake_amount = Rsnake_amount
	GlobalVariables.snake_kiss_exp_gain = Rsnake_kiss_exp_gain

	# Tutorial
	GlobalVariables.tutorial = Rtutorial

	# Gold
	GlobalVariables.gold_current = Rgold_current
	GlobalVariables.starting_gold = Rstarting_gold

	# Levels
	GlobalVariables.visitors_lvl = Rvisitors_lvl
	GlobalVariables.kissing_lvl = Rkissing_lvl
	GlobalVariables.tank_size_lvl0 = Rtank_size_lvl0
	GlobalVariables.tank_size_lvl1 = Rtank_size_lvl1
	GlobalVariables.tank_size_lvl2 = Rtank_size_lvl2

	# Pond decorations - normal
	GlobalVariables.pond_deco_id0 = Rpond_deco_id0
	GlobalVariables.pond_deco_pos0 = Rpond_deco_pos0
	GlobalVariables.pond_deco_z0 = Rpond_deco_z0
	GlobalVariables.pond_deco_id1 = Rpond_deco_id1
	GlobalVariables.pond_deco_pos1 = Rpond_deco_pos1
	GlobalVariables.pond_deco_z1 = Rpond_deco_z1
	GlobalVariables.pond_deco_id2 = Rpond_deco_id2
	GlobalVariables.pond_deco_pos2 = Rpond_deco_pos2
	GlobalVariables.pond_deco_z2 = Rpond_deco_z2

	# Pond decorations - underwater
	GlobalVariables.pond_udeco_id0 = Rpond_udeco_id0
	GlobalVariables.pond_udeco_pos0 = Rpond_udeco_pos0
	GlobalVariables.pond_udeco_z0 = Rpond_udeco_z0
	GlobalVariables.pond_udeco_id1 = Rpond_udeco_id1
	GlobalVariables.pond_udeco_pos1 = Rpond_udeco_pos1
	GlobalVariables.pond_udeco_z1 = Rpond_udeco_z1
	GlobalVariables.pond_udeco_id2 = Rpond_udeco_id2
	GlobalVariables.pond_udeco_z2 = Rpond_udeco_z2

	# Pond decorations - surface
	GlobalVariables.pond_sdeco_id0 = Rpond_sdeco_id0
	GlobalVariables.pond_sdeco_pos0 = Rpond_sdeco_pos0
	GlobalVariables.pond_sdeco_z0 = Rpond_sdeco_z0
	GlobalVariables.pond_sdeco_id1 = Rpond_sdeco_id1
	GlobalVariables.pond_sdeco_pos1 = Rpond_sdeco_pos1
	GlobalVariables.pond_sdeco_z1 = Rpond_sdeco_z1
	GlobalVariables.pond_sdeco_id2 = Rpond_sdeco_id2
	GlobalVariables.pond_sdeco_pos2 = Rpond_sdeco_pos2
	GlobalVariables.pond_sdeco_z2 = Rpond_sdeco_z2

	# Pond indices
	GlobalVariables.pond_bed_index0 = Rpond_bed_index0
	GlobalVariables.pond_surface_index0 = Rpond_surface_index0
	GlobalVariables.pond_bed_index1 = Rpond_bed_index1
	GlobalVariables.pond_surface_index1 = Rpond_surface_index1
	GlobalVariables.pond_bed_index2 = Rpond_bed_index2
	GlobalVariables.pond_surface_index2 = Rpond_surface_index2

	# Shopping lists
	GlobalVariables.shopping_list_bed = Rshopping_list_bed
	GlobalVariables.shopping_list_surface = Rshopping_list_surface

	# Visitors / Kissing
	GlobalVariables.visitorsPerMin = RvisitorsPerMin
	GlobalVariables.kissing_multiplier = Rkissing_multiplier

	# Boundaries
	GlobalVariables.boundary = Rboundary
	GlobalVariables.boundary_closed = Rboundary_closed
	GlobalVariables.closed_boundary = Rclosed_boundary

	# Locations
	GlobalVariables.location_unlocking = Rlocation_unlocking
	GlobalVariables.unlocked_location = Runlocked_location

	# Snakes - arrays
	GlobalVariables.snakes_id_array0 = Rsnakes_id_array0
	GlobalVariables.snakes_exp_array0 = Rsnakes_exp_array0
	GlobalVariables.snakes_age_array0 = Rsnakes_age_array0

	GlobalVariables.snakes_id_array1 = Rsnakes_id_array1
	GlobalVariables.snakes_exp_array1 = Rsnakes_exp_array1
	GlobalVariables.snakes_age_array1 = Rsnakes_age_array1

	GlobalVariables.snakes_id_array2 = Rsnakes_id_array2
	GlobalVariables.snakes_exp_array2 = Rsnakes_exp_array2
	GlobalVariables.snakes_age_array2 = Rsnakes_age_array2

	# Multipliers
	GlobalVariables.multiplier_array = Rmultiplier_array


var Rsaved_time0:String
var Rsaved_time1:String
var Rsaved_time2:String

var Rcurrent_snake_id:int = 0
var Rtutorial:bool = true

var Rsnake_count := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

var Rgold_current:float = 200.0
var Rstarting_gold:float = 200.0

var Rvisitors_lvl:int = 0
var Rkissing_lvl:int = 0
var Rtank_size_lvl0:int = 0
var Rtank_size_lvl1:int = 0
var Rtank_size_lvl2:int = 0

# Pond decorations - normal
var Rpond_deco_id0 := []
var Rpond_deco_pos0 := []
var Rpond_deco_z0 := []
var Rpond_deco_id1 := []
var Rpond_deco_pos1 := []
var Rpond_deco_z1 := []
var Rpond_deco_id2 := []
var Rpond_deco_pos2 := []
var Rpond_deco_z2 := []

# Pond decorations - underwater
var Rpond_udeco_id0 := []
var Rpond_udeco_pos0 := []
var Rpond_udeco_z0 := []
var Rpond_udeco_id1 := []
var Rpond_udeco_pos1 := []
var Rpond_udeco_z1 := []
var Rpond_udeco_id2 := []
var Rpond_udeco_pos2 := []
var Rpond_udeco_z2 := []

# Pond decorations - surface
var Rpond_sdeco_id0 := []
var Rpond_sdeco_pos0 := []
var Rpond_sdeco_z0 := []
var Rpond_sdeco_id1 := []
var Rpond_sdeco_pos1 := []
var Rpond_sdeco_z1 := []
var Rpond_sdeco_id2 := []
var Rpond_sdeco_pos2 := []
var Rpond_sdeco_z2 := []

# Pond indices
var Rpond_bed_index0:int
var Rpond_surface_index0:int
var Rpond_bed_index1:int
var Rpond_surface_index1:int
var Rpond_bed_index2:int
var Rpond_surface_index2:int

# Shopping
var Rshopping_list_bed := [true,false,false,false,false,false,false,false,false,false,false]
var Rshopping_list_surface := [true,false,false,false,false,false,false,false,false,false,false]

# Snakes
var Rsnake_unlocked_register := []

# Visitors / kissing
var RvisitorsPerMin:float = 2
var Rkissing_multiplier:float = 1
var Rsnake_kiss_exp_gain:float = 5.0

# Boundaries
var Rboundary := Vector2(2300,1500)
var Rboundary_closed := Vector2(1920,960)
var Rsnake_amount:int
var Rclosed_boundary:bool = true

# Locations
var Rlocation_unlocking := []
var Runlocked_location := []

# Snakes - arrays
var Rsnakes_id_array0 := []
var Rsnakes_exp_array0 := []
var Rsnakes_age_array0 := []

var Rsnakes_id_array1 := []
var Rsnakes_exp_array1 := []
var Rsnakes_age_array1 := []

var Rsnakes_id_array2 := []
var Rsnakes_exp_array2 := []
var Rsnakes_age_array2 := []

# Multipliers
var Rmultiplier_array:Array = [1,0]

func remap_koi_quality(fish_quality:float)->String:
	var fish_quality_string:String
	if fish_quality>=165.0:
		fish_quality_string = "[rainbow]Dragon Incarnate!!"
	elif fish_quality>=150.0:
		fish_quality_string = "[color=#FF9800]Living Jewel!"
	elif fish_quality>=135.0:
		fish_quality_string = "[color=#9C27B0]Show-Winner!"
	elif fish_quality>=120.0:
		fish_quality_string = "[color=#3F51B5]Flawless Scales!"
	elif fish_quality>=110.0:
		fish_quality_string = "[color=#2196F3]Vibrant Specimen!"
	elif fish_quality>=95.0:
		fish_quality_string = "[color=#4CAF50]Standard Pond-Dweller"
	elif fish_quality>=85.0:
		fish_quality_string = "[color=#8BC34A]Hobbyist's Choise"
	elif fish_quality>=70.0:
		fish_quality_string = "[color=#E0E0E0]Just Some Carp"
	elif fish_quality>=55.0:
		fish_quality_string = "[color=#9E9E9E]Fish Stick Fodder"
	else:
		fish_quality_string = "[color=#6B4226]Pond Scum"
		
	return fish_quality_string
