class_name Snake
extends Node2D

#const SNAKE_CARD_MINED = preload("res://snake_card/snake_card_mined.tscn")
var graphic_kernel:GraphicKernel

var movement_rotatation_angle:float = 0.4*PI
var movement_patern:int

var unique_id:int
#var self_rarity:String

var snake_body
var snake_eyes
var fish_fin
var fish_leg
var fish_tail
var fish_age:float = 0.0
var fish_quality:float = 0.0
var locked:bool=false

var eyes_color
var snake_scale:float

var width:float

var boundary:Vector2
const fixed_velocity:float = 80.0
var current_max_velocity :float= 0.0
var velocity:float = 80.0
var angular_v:float = 1
var dir_velo:Vector2
var current_length:int = 11
var length:int = 50
var adult_array:= [30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30]
var radius_array := []

var exp_max:float = 2000.0
var exp_current:float=0.0

var segment_pos:Array[float]
var segment_dir:Array[float]
var dir_actual:Vector2
var in_lerping:bool = false
#var step_size:float
var t := 0.0
var pre_velo

#var checking_register:bool=false

var snake_id:int = -1
var passive_income:float = 1
var snake_price:float = 1

var snake_name:String=""
var snake_rarity:String=""
var snake_region:String=""
var adult:bool = false

#var new_cards_container:HBoxContainer
var distance_array_in_range:Array


func load_name() -> void:
	snake_name=resign_name(snake_id)
	#print(resign_name(snake_id))

func _init(_boundary:Vector2,_id:int,_exp_current:float,_unique_id:int,_graphic_kernel:GraphicKernel,_fish_age:float,_fish_quality) -> void:
	graphic_kernel = _graphic_kernel
	unique_id = _unique_id
	snake_id = _id
	exp_current = _exp_current
	fish_age = _fish_age
	fish_quality = _fish_quality
	resign_name(snake_id)
	
	radius_array.resize(length)
	radius_array.fill(10.0)
	#var lengthf = float(length)
	#radius_array.insert(0,10)
	#step_size = 10.0/(float(length)-1)
	#for i in range(1,radius_array.size()):
		#radius_array.insert(i,10-i*step_size)
	segment_pos.resize(radius_array.size()*2)
	segment_pos.fill(0.0)
	segment_dir.resize(radius_array.size())
	segment_dir.fill(0.0)
	#print(segment_pos.size())
	var rand_dir = randf_range(-PI,PI)
	dir_velo = Vector2(cos(rand_dir),sin(rand_dir))
	dir_actual = dir_velo
	self.boundary = _boundary
	passive_income = calculate_income(snake_id)
	snake_price = round(86400.0*passive_income)
	movement_patern = randi_range(0,1)
	
	exp_max = calculate_grow_time(snake_id)
	
#func _ready() -> void:
	#new_cards_container = get_tree().get_first_node_in_group("new_found_cards")
	#
func snake_grow(delta):
	fish_age+=delta
	exp_current = clamp(exp_current,0,exp_max)
	snake_scale = (exp_current/exp_max + (fish_quality-105)/250)
	width = 70+150*snake_scale
	segment_length = 6+14*snake_scale 
	exp_current += delta
	
	if exp_current >= exp_max and !adult:
		adult = true
		adding_register()
		
func adding_register():
	if GlobalVariables.snake_unlocked_register.find(snake_id) == -1:
		GlobalVariables.snake_unlocked_register.append(snake_id)
		graphic_kernel.show_new_snake(snake_id)
	#else:
		#pass
	#checking_register = true
	
func snake_kiss_grow(amount):
	exp_current+=amount
	exp_current = clamp(exp_current,0,exp_max)

func resign_name(id):
	#Destinations.World.
	var current_snake_name:String=""
	var current_snake_rarity:String=""
	var current_snake_region:String=""
	for i in Destinations.World:
		for j in Destinations.World[i]:
			for k in Destinations.World[i][j]:
				if Destinations.World[i][j][k]["id"] == id:
					current_snake_name = k
					current_snake_rarity = Destinations.World[i][j][k]["rarity"]
					current_snake_region = Destinations.World[i][j][k]["region"]
					break
	snake_name = current_snake_name
	snake_rarity = current_snake_rarity
	snake_region = current_snake_region

func calculate_grow_time(_id):
	return CostsTable.snakes_income_database[_id]["grow_time"]

func calculate_income(_id):
	var factor = CostsTable.snakes_income_database[_id]["factor"]
	var current_income = factor/86400
	current_income *= fish_quality/100
	return current_income

var segment_length:float=20


func follow_prev_point():
	for i in range(1,radius_array.size()):
		var dir :Vector2 = Vector2(segment_pos[2*i],segment_pos[2*i+1]) - Vector2(segment_pos[2*(i-1)],segment_pos[2*(i-1)+1])
		if dir.length_squared()>(segment_length*segment_length):
			dir = dir.normalized()
			#segment_dir.insert(i,dir.angle())
			segment_pos[2*i] = dir.x * segment_length + segment_pos[2*(i-1)]
			segment_pos[2*i+1] = dir.y * segment_length + segment_pos[2*(i-1)+1]
		if i != radius_array.size()-1:
			var vec_0 = -Vector2(segment_pos[2*i],segment_pos[2*i+1]) + Vector2(segment_pos[2*(i-1)],segment_pos[2*(i-1)+1])
			var vec_1 = -Vector2(segment_pos[2*i],segment_pos[2*i+1]) + Vector2(segment_pos[2*(i+1)],segment_pos[2*(i+1)+1])
			var vec_2 = Vector2.ZERO
			var angle = vec_0.angle_to(vec_1)
			var degree_threshold = 4.5*PI/5
			if angle <= degree_threshold and angle >0:
				vec_2 = Vector2(vec_0.x*cos(degree_threshold)-vec_0.y*sin(degree_threshold),vec_0.x*sin(degree_threshold)+vec_0.y*cos(degree_threshold))
				segment_pos[2*(i+1)] = vec_2.x + segment_pos[2*i]
				segment_pos[2*(i+1)+1] = vec_2.y + segment_pos[2*i+1]
			elif angle >= -degree_threshold and angle<=0:
				vec_2 = Vector2(vec_0.x*cos(degree_threshold)+vec_0.y*sin(degree_threshold),-vec_0.x*sin(degree_threshold)+vec_0.y*cos(degree_threshold))
				segment_pos[2*(i+1)] = vec_2.x + segment_pos[2*i]
				segment_pos[2*(i+1)+1] = vec_2.y + segment_pos[2*i+1]
	
func random_movement(delta):
	current_max_velocity = fixed_velocity*(0.8+0.2*snake_scale)
	segment_pos[0] += dir_actual.x * velocity * delta
	segment_pos[1] += dir_actual.y * velocity * delta

	if !GlobalVariables.closed_boundary:
		boundary = GlobalVariables.boundary
		if abs(segment_pos[0])>=boundary.x/2 - radius_array[0] and !in_lerping:
			if segment_pos[0]>0:
				for i in segment_pos.size()/2.0:
					segment_pos[2*i]-=boundary.x
			else:
				for i in segment_pos.size()/2.0:
					segment_pos[2*i]+=boundary.x

		if abs(segment_pos[1])>=boundary.y/2 - radius_array[0] and !in_lerping:
			if segment_pos[1]>0:
				for i in segment_pos.size()/2.0:
					segment_pos[2*i+1]-=boundary.y
			else:
				for i in segment_pos.size()/2.0:
					segment_pos[2*i+1]+=boundary.y
				
	elif GlobalVariables.closed_boundary:
		boundary = GlobalVariables.boundary_closed
		if abs(segment_pos[0])>=boundary.x/2 - radius_array[0] and !in_lerping:
			var rand_dir
			velocity = randf_range(0.9*current_max_velocity,1.1*current_max_velocity)
			if segment_pos[0]>0:
				rand_dir = randf_range(PI/2,3*PI/2)
			else :
				rand_dir = randf_range(-PI/2,PI/2)
			dir_velo = Vector2(cos(rand_dir),sin(rand_dir))
			in_lerping = true
		if abs(segment_pos[1])>=boundary.y/2 - radius_array[0] and !in_lerping:
			var rand_dir 
			velocity = randf_range(0.75*current_max_velocity,1.25*current_max_velocity)
			if segment_pos[1]>0:
				rand_dir = randf_range(-PI,0)
			else:
				rand_dir = randf_range(0,PI)
			dir_velo = Vector2(cos(rand_dir),sin(rand_dir))
			in_lerping = true
		
	if in_lerping:
		var current_angle:float = dir_actual.angle()
		var ending_angle:float = dir_velo.angle()
		t += delta*0.5
		#dir_actual = dir_actual.lerp(dir_velo,t)
		var lerping_angle = (lerp_angle(current_angle,ending_angle,t))
		dir_actual = Vector2(cos(lerping_angle),sin(lerping_angle))
		
		if t >= 1:
			in_lerping = false
			t = 0


var cooldown = 1.0
var new_loop:bool = false
var new_dir:Vector2 = dir_actual
var new_t:float = 1.0


func physics_update(delta):
	#segment_length+=delta
	random_movement(delta)
	follow_prev_point()
	cooldown -= delta
	natural_movement(movement_patern,delta,new_loop)
	if cooldown <= 0:
		new_loop = true
		cooldown = randf_range(0.9,1.3) 
		movement_rotatation_angle = randf_range(0.1,0.2)*PI


func natural_movement(patern_index,delta,loop):
	if loop:
		match patern_index:
			0:
				var x_old = dir_actual.x
				var y_old = dir_actual.y
				new_dir.x = x_old * cos(movement_rotatation_angle) - y_old*sin(movement_rotatation_angle)
				new_dir.y = x_old * sin(movement_rotatation_angle) + y_old*cos(movement_rotatation_angle)
				movement_patern = 1
			1:
				var x_old = dir_actual.x
				var y_old = dir_actual.y
				new_dir.x = x_old * cos(-movement_rotatation_angle) - y_old*sin(-movement_rotatation_angle)
				new_dir.y = x_old * sin(-movement_rotatation_angle) + y_old*cos(-movement_rotatation_angle)
				movement_patern = 0
		new_t = 0.0
		new_loop = false
		new_dir = new_dir.normalized()
	else:
		if !in_lerping:
			if new_t<1:
				new_t+=delta*(3-snake_scale*2)
				var new_dir_angle:float=new_dir.angle()
				var original_angle:float=dir_actual.angle()
				#dir_actual = dir_actual.lerp(new_dir,new_t)
				var the_lerp_angle = lerp_angle(original_angle,new_dir_angle,new_t)
				dir_actual = Vector2(cos(the_lerp_angle),sin(the_lerp_angle))
			else:
				pass
		else:
			new_loop = true


func steering_away(other_snake):
	if !in_lerping:
		velocity = randf_range(0.75*current_max_velocity,1.25*current_max_velocity)
		var co_direction = (dir_actual+other_snake.dir_actual).normalized()
		var random_over_steering:float = randf_range(-PI/2,PI/2)
		var direction:Vector2
		direction.x = co_direction.x * cos(random_over_steering) - sin(random_over_steering) * co_direction.y
		direction.y = co_direction.x * sin(random_over_steering) + cos(random_over_steering) * co_direction.y
		dir_velo = direction
		in_lerping = true

func follow_click(clicked_pos):
	if !in_lerping:
		velocity = randf_range(0.75*current_max_velocity,1.25*current_max_velocity)
		var direction = (clicked_pos - Vector2(segment_pos[0],segment_pos[1])).normalized()
		dir_velo = direction
		in_lerping = true

var debug_avg_pos:Vector2
func cohesion(delta):
	if distance_array_in_range.size()!=0:
		var self_pos = Vector2(segment_pos[0],segment_pos[1])
		var avg_pos:Vector2 = Vector2.ZERO
		var count:int=0
		for i:Vector2 in distance_array_in_range:
			var reverse_dir:Vector2 = -dir_actual.normalized()
			if abs(reverse_dir.angle_to(i-self_pos))>= PI/6:
				avg_pos += i
				count+=1
		if count!=0:
			avg_pos = avg_pos/count
			debug_avg_pos = avg_pos

		var steering_dir:Vector2 =Vector2.ZERO
		steering_dir=(avg_pos - self_pos).normalized()
		if steering_dir!= Vector2.ZERO:
			if !in_lerping:
				dir_actual += steering_dir*delta*10
				dir_actual = dir_actual.normalized()
		#print(delta)
	distance_array_in_range=[]
