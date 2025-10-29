extends TileMapLayer

@onready var mining_scene_kernel: MiningKernel = $".."
@onready var under: TileMapLayer = $"../under"
@onready var surface: TileMapLayer = $"../surface"
@onready var game_over: Timer = $"../game_over"
#@onready var diamond_layer: TileMapLayer = $"../diamond_layer"


var snake_amount:int 
var available_cells:Array
var head_array:Array
var body_array:Array
var tail_array:Array
var color_array:Array
var head_rotation_array:Array
var body_rotation_array:Array
var tail_rotation_array:Array
var snakes_picked:Array
var snake_local_id_to_global_id:Array
var return_id:Array
var diamonds_found:Array
var snakes_exposure:Array
var won:bool

var diamond_position_array:Array

#var rocket_part_location:Vector2i
var final_levels:bool

enum TileTransform {
	ROTATE_0 = 0,
	ROTATE_90 = TileSetAtlasSource.TRANSFORM_TRANSPOSE | TileSetAtlasSource.TRANSFORM_FLIP_H,
	ROTATE_180 = TileSetAtlasSource.TRANSFORM_FLIP_H | TileSetAtlasSource.TRANSFORM_FLIP_V,
	ROTATE_270 = TileSetAtlasSource.TRANSFORM_TRANSPOSE | TileSetAtlasSource.TRANSFORM_FLIP_V,
}
#func spawn_rocket_parts():
	#update_available_cells()
	#rocket_part_location = Vector2i.ZERO
	#rocket_part_location = available_cells.pick_random()
	
#func find_rocket_parts():
	#pass
	#
#func spawn_diamonds():
	#diamond_position_array=[]
	#if !final_levels:
		#update_available_cells()
		#for i in available_cells:
			##print(mining_scene_kernel.location_index)
			##print(GlobalVariables.location_diamond_found[mining_scene_kernel.location_index]," ",GlobalVariables.location_diamond_amount[mining_scene_kernel.location_index])
			#if randf_range(0,100)<GlobalVariables.chance_diamond_spawn_per_tile and GlobalVariables.location_diamond_found[mining_scene_kernel.location_index]<GlobalVariables.location_diamond_amount[mining_scene_kernel.location_index]:
				#diamond_position_array.append(i)
	#if diamond_position_array!=[]:
		#for i in diamond_position_array:
			#diamond_layer.set_cell(i,0,Vector2i(0,0))
	#diamonds_found.resize(diamond_position_array.size())
			

func on_spawn_snakes(location):
	reset()
	won = false
	return_id.resize(snake_amount)
	return_id.fill(null)
	snakes_exposure.resize(snake_amount)
	snakes_exposure.fill([])
	color_array.resize(snake_amount)
	color_array.fill(0)
	snake_local_id_to_global_id.resize(snake_amount)
	snake_local_id_to_global_id.fill(0)
	head_rotation_array.resize(snake_amount)
	body_rotation_array.resize(snake_amount)
	tail_rotation_array.resize(snake_amount)
	head_array.resize(snake_amount)
	head_array.fill(Vector2i.ZERO)
	body_array.resize(snake_amount)
	body_array.fill(Vector2i.ZERO)
	tail_array.resize(snake_amount)
	tail_array.fill(Vector2i.ZERO)


	#for i in snake_amount:
		#snakes_picked.append(Destinations.World[location][keys_list[i]])
	#for j in snakes_picked.size():
		#spawn_snakes(j,snakes_picked[j])
	
	for j in snake_amount:
		var rarity_indicator:String
		var randomf = randf()
		if randomf<=0.89:
			rarity_indicator = "c"
		elif randomf>0.89 and randomf<=0.99:
			rarity_indicator = "r"
		elif randomf>0.99:
			rarity_indicator = "vr"
		var keys_list :Array= Destinations.World[location][rarity_indicator].keys()
		keys_list.shuffle()
		snakes_picked.append(Destinations.World[location][rarity_indicator][keys_list[0]])
	for j in snakes_picked.size():
		spawn_snakes(j,snakes_picked[j])
	
func update_available_cells():
	available_cells.clear()
	for i in under.get_used_cells():
		if surface.get_used_cells().has(i):
			available_cells.append(i)
	for i in diamond_position_array:
		if available_cells.has(i):
			available_cells.erase(i)


func spawn_snakes(id,snake_ref):
	var possible_cells:Array
	update_available_cells()
	for i in get_used_cells():
		if available_cells.has(i):
			available_cells.erase(i)
	head_array[id] = available_cells.pick_random()
	available_cells.erase(head_array[id])
	for x in [-1,1]:
		if available_cells.has(head_array[id]+Vector2i(x,0)):
			possible_cells.append(head_array[id]+Vector2i(x,0))
	for y in [-1,1]:
		if available_cells.has(head_array[id]+Vector2i(0,y)):
			possible_cells.append(head_array[id]+Vector2i(0,y))
	if possible_cells != []:
		body_array[id]=possible_cells.pick_random()
		available_cells.erase(body_array[id])
	else:
		spawn_snakes(id,snake_ref)
		
	possible_cells.clear()
	for x in [-1,1]:
		if available_cells.has(body_array[id]+Vector2i(x,0)):
			possible_cells.append(body_array[id]+Vector2i(x,0))
	for y in [-1,1]:
		if available_cells.has(body_array[id]+Vector2i(0,y)):
			possible_cells.append(body_array[id]+Vector2i(0,y))
	if possible_cells != []:
		tail_array[id]=possible_cells.pick_random()
		available_cells.erase(tail_array[id])
	else:
		spawn_snakes(id,snake_ref)


	snakes_exposure[id] = [false,false,false,true]
	color_array[id]=snake_ref["snake_mining_altas"]
	match snake_ref["rarity"]:
		"Common":
			color_array[id] = randi_range(1,3)
		"Rare":
			color_array[id] = randi_range(4,6)
		"Very Rare":
			color_array[id] = randi_range(7,9)
	
	snake_local_id_to_global_id[id]=snake_ref["id"]
	
	
	set_cell(head_array[id],1,Vector2i(0,10))

	set_cell(body_array[id],1,Vector2i(0,10))

	set_cell(tail_array[id],1,Vector2i(0,10))
	
func show_snake():
	var exposed_cells = under.get_used_cells()
	for i in surface.get_used_cells():
		if exposed_cells.has(i):
			exposed_cells.erase(i)
	for i in snake_amount:
		snake_move(i)
	for j in snakes_exposure:
		j[0]=false
		j[1]=false
		j[2]=false
	for k in exposed_cells.size():
		if head_array.has(exposed_cells[k]):
			snakes_exposure[head_array.find(exposed_cells[k])][0] = true
			set_cell(exposed_cells[k],1,Vector2i(0,color_array[head_array.find(exposed_cells[k])]),head_rotation_array[head_array.find(exposed_cells[k])])

		
		if body_array.has(exposed_cells[k]):
			snakes_exposure[body_array.find(exposed_cells[k])][1] = true
			set_cell(exposed_cells[k],1,Vector2i(body_rotation_array[body_array.find(exposed_cells[k])],color_array[body_array.find(exposed_cells[k])]))

			
		if tail_array.has(exposed_cells[k]):
			snakes_exposure[tail_array.find(exposed_cells[k])][2] = true
			set_cell(exposed_cells[k],1,Vector2i(7,color_array[tail_array.find(exposed_cells[k])]),tail_rotation_array[tail_array.find(exposed_cells[k])])
		

		
	for i in snakes_exposure.size():
		if snakes_exposure[i][0] and snakes_exposure[i][1] and snakes_exposure[i][2]:
			snakes_exposure[i][3]=false
			return_id[i]=snake_local_id_to_global_id[i]

	var level_complete:bool =true
	for i in return_id:
		if i == null:
			level_complete = false
	if level_complete:
		game_over.start()
		mining_scene_kernel.scene_start = false
		won = true

func snake_move(id):
	if snakes_exposure[id][3]==true:
		var possible_cells:Array
		update_available_cells()
		for i in get_used_cells():
			if available_cells.has(i):
				available_cells.erase(i)
		for x in [-1,1]:
				if available_cells.has(head_array[id]+Vector2i(x,0)):
					possible_cells.append(head_array[id]+Vector2i(x,0))
		for y in [-1,1]:
				if available_cells.has(head_array[id]+Vector2i(0,y)):
					possible_cells.append(head_array[id]+Vector2i(0,y))
		if possible_cells != []:
			set_cell(tail_array[id],-1)
			tail_array[id] = body_array[id]
			set_cell(tail_array[id],1,Vector2i(0,10))
			body_array[id] = head_array[id]
			set_cell(body_array[id],1,Vector2i(0,10))
			head_array[id] = possible_cells.pick_random()
			set_cell(head_array[id],1,Vector2i(0,10))
		
		var rotation_index = body_array[id]-tail_array[id]
		tail_rotation_array[id] = match_rotation(rotation_index)
		rotation_index = head_array[id]-body_array[id]
		head_rotation_array[id] = match_rotation(rotation_index)
		rotation_index = head_array[id]-tail_array[id]
		var body_to_head_index = head_array[id]-body_array[id]
		body_rotation_array[id] = body_rotation(rotation_index,body_to_head_index)
		
	

func body_rotation(rotation_index,body_head_index):
	match rotation_index:
		Vector2i(-2,0):
			return 1
		Vector2i(-1,-1):
			if body_head_index == Vector2i(-1,0):
				return 3
			else :
				return 5
		Vector2i(-1,1):
			if body_head_index == Vector2i(0,1):
				return 4
			else:
				return 6
		Vector2i(1,1):
			if body_head_index == Vector2i(1,0):
				return 5
			else:
				return 3
		Vector2i(1,-1):
			if body_head_index == Vector2i(0,-1):
				return 6
			else:
				return 4
		Vector2i(2,0):
			return 1
		Vector2i(0,-2):
			return 2
		Vector2i(0,2):
			return 2
		
func match_rotation(rotation_index):
	match rotation_index:
		Vector2i(-1,0):
			return TileTransform.ROTATE_0
		Vector2i(1,0):
			return TileTransform.ROTATE_180
		Vector2i(0,-1):
			return TileTransform.ROTATE_90
		Vector2i(0,1):
			return TileTransform.ROTATE_270

func reset():
	available_cells = []
	snakes_picked = []
	diamonds_found = []

	
