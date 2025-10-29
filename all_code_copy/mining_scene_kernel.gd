#class_name MiningKernel
#extends Node2D
#var main:GraphicKernel
#@onready var panel_container_animation: PanelContainer = $Control/PanelContainer_animation
#@onready var control: Control = $Control
#@onready var game_over: Timer = $game_over
##@onready var new_snake_label: Label = $Control/PanelContainer/VBoxContainer/MarginContainer/newSnakeLabel
#
#
#var clicked_pos:Vector2
#@onready var under: TileMapLayer = $under
#@onready var surface: TileMapLayer = $surface
#@onready var snake_layer_kernel: TileMapLayer = $snake_layer_kernel
#@onready var under_background: TileMapLayer = $under_background
#
#@onready var replay: TextureButton = $Control/replay
#
##const SNAKE_CARD_MINED = preload("res://snake_card/snake_card_mined.tscn")
#
#var dig_power:int = 1
#var stamina:int = 10
#var max_stamina:int
##@onready var stamina_bar: TextureProgressBar = $Control2/stamina_bar
#@onready var stamina_bar: TextureProgressBar = $CanvasLayer/stamina_bar
#
#
#var snake_amount:int
#var location:String = "N.EU"
#var starting_position:Vector2i = Vector2i(13,5)
#var ending_position:Vector2i = Vector2i(16,8)
#
#var line_length:int
#
#var scene_start:bool
#var background_starting_position:Vector2i
#var background_ending_position:Vector2i
#
#var under_ground_tile_coord:Vector2i = Vector2i(11,1)
#
#var hp_array:Array
#var snakes_array:Array
#var surface_coord_array:Array
#
#
#var defaut_gameover_container_size:Vector2
#var defaut_gameover_container_position:Vector2
#
##var snakes_order:int
#
#var tile_hp:int
#var returnid:Array
#
#var location_index:int = 0
#
##var game_in_pause:bool
#@onready var game_over_panel: PanelContainer = $CanvasLayer/game_over_panel
#
#func _ready() -> void:
	#main = get_tree().get_first_node_in_group("main")
	#defaut_gameover_container_size = panel_container_animation.size
	#defaut_gameover_container_position = panel_container_animation.position
	#game_over_panel.visible = false
	#stamina_bar.visible = false
#
#
#func level_finished() -> void:
	#control.visible = true
	#var tween = create_tween()
	#var tween2 = create_tween()
	#tween.tween_property(panel_container_animation,"size",Vector2(900,560),0.2)
	#tween2.tween_property(panel_container_animation,"position",Vector2(480,240),0.2)
#
#func start_scene() -> void:
	#max_stamina = stamina
	#stamina_bar.max_value = max_stamina
	#stamina_bar.value = stamina
	#snake_layer_kernel.snake_amount = snake_amount
	#for x in range(starting_position.x,ending_position.x+1):
		#for y in range(starting_position.y,ending_position.y+1):
			#surface_coord_array.append(Vector2i(x,y))
	#
	#line_length = ending_position.y-starting_position.y+1
	#control.visible = false
	#background_starting_position = starting_position - Vector2i.ONE
	#background_ending_position = ending_position + Vector2i.ONE
	#var i = 0
	#for x in range(starting_position.x,ending_position.x+1):
		#for y in range(starting_position.y,ending_position.y+1):
			#var rng := randi_range(0,2)
			#var rng_coor:=Vector2i(rng,0)
			#var atlas_coor:=Vector2i(5,0)
			#atlas_coor = atlas_coor+rng_coor
			#surface.set_cell(Vector2i(x,y),0,atlas_coor)
			#under.set_cell(Vector2i(x,y),0,under_ground_tile_coord)
			#hp_array.insert(i,tile_hp)
			#i +=1
	#for x in range(background_starting_position.x,background_ending_position.x+1):
		#for y in range(background_starting_position.y,background_ending_position.y+1):
			#under_background.set_cell(Vector2i(x,y),0,under_ground_tile_coord)
	#snake_layer_kernel.on_spawn_snakes(location)
	#scene_start = true
#
#func _process(_delta: float) -> void:
	#get_input_and_dig()
	#check_replay_ability()
	#
#func check_replay_ability():
	#if main.snakes.size()>=GlobalVariables.tank_size[GlobalVariables.tank_size_lvl]:
		#replay.disabled = true
	#elif main.snakes.size()<GlobalVariables.tank_size[GlobalVariables.tank_size_lvl]:
		#replay.disabled = false
		#if GlobalVariables.gold_current >= CostsTable.unlocking_cost[location_index]:
			#replay.disabled=false
		#else:
			#replay.disabled=true
#
#func get_input_and_dig():
	#if scene_start:
		#if Input.is_action_just_pressed("left_mouse"):
			#clicked_pos = get_local_mouse_position()
			#var to_map_pos:= surface.local_to_map(clicked_pos)
			#var id = surface_coord_array.find(to_map_pos)
			#if stamina>0:
				#if id != -1 and hp_array[id]>0:
					#stamina -= 1
					#spawn_mining_particles()
					#stamina_bar.value = stamina
					#if stamina == 0 and !snake_layer_kernel.won:
						#game_over.start()
						#scene_start = false
						#print("you are out of stamina")
#
					#match GlobalVariables.knives_lvl:
						#0:
							#hp_array[id]-=dig_power
						#1:
							#var pos = id%line_length
							#if pos == 0:
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=1
							#elif pos == line_length-1:
								#if id - 1>=0:
									#hp_array[id-1]-=1
							#else:
								#if id - 1>=0:
									#hp_array[id-1]-=1
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=1
							#hp_array[id]-=dig_power
						#2:
							#var pos = id%line_length
							#if pos == 0:
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=1
							#elif pos == line_length-1:
								#if id - 1>=0:
									#hp_array[id-1]-=1
							#else:
								#if id - 1>=0:
									#hp_array[id-1]-=1
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=1
							#hp_array[id]-=dig_power
							#if id + line_length<hp_array.size():
								#hp_array[id+line_length]-=1
							#if id - line_length>=0:
								#hp_array[id-line_length]-=1
						#3:
							#var pos = id%line_length
							#if pos == 0:
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=1
								#if id + line_length + 1 < hp_array.size():
									#hp_array[id + line_length + 1]-=1
							#elif pos == line_length-1:
								#if id - 1>=0:
									#hp_array[id-1]-=1
								#if id - line_length - 1 >= 0 :
									#hp_array[id - line_length - 1]-=1
							#else:
								#if id - 1>=0:
									#hp_array[id-1]-=1
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=1
								#if id - line_length + 1 >= 0:
									#hp_array[id - line_length - 1]-=1
								#if id + line_length + 1 < hp_array.size():
									#hp_array[id + line_length + 1]-=1
							#hp_array[id]-=dig_power
							#if id + line_length<hp_array.size():
								#hp_array[id+line_length]-=1
							#if id - line_length>=0:
								#hp_array[id-line_length]-=1
						#4:
							#var pos = id%line_length
							#if pos == 0:
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=1
								#if id + line_length + 1 < hp_array.size():
									#hp_array[id + line_length + 1]-=1
								#if id - line_length + 1 >=0:
									#hp_array[id - line_length + 1]-=1
#
							#elif pos == line_length-1:
								#if id - 1>=0:
									#hp_array[id-1]-=1
								#if id - line_length - 1 >= 0 :
									#hp_array[id - line_length - 1]-=1
								#if id + line_length - 1 < hp_array.size():
									#hp_array[id + line_length - 1]-=1
								#
							#else:
								#if id - 1>=0:
									#hp_array[id-1]-=1
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=1
								#if id - line_length - 1 >= 0:
									#hp_array[id - line_length - 1]-=1
								#if id + line_length + 1 < hp_array.size():
									#hp_array[id + line_length + 1]-=1
								##print(id + line_length - 1,hp_array.size())
								#if id + line_length - 1 < hp_array.size():
									#hp_array[id + line_length - 1]-=1
								#if id - line_length + 1 >=0:
									#hp_array[id - line_length + 1]-=1
							#hp_array[id]-=dig_power
							#if id + line_length<hp_array.size():
								#hp_array[id+line_length]-=1
							#if id - line_length>=0:
								#hp_array[id-line_length]-=1
						#5:
							#var pos = id%line_length
							#if pos == 0:
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=2
								#if id + line_length + 1 < hp_array.size():
									#hp_array[id + line_length + 1]-=1
								#if id - line_length + 1 >=0:
									#hp_array[id - line_length + 1]-=1
#
							#elif pos == line_length-1:
								#if id - 1>=0:
									#hp_array[id-1]-=2
								#if id - line_length - 1 >= 0 :
									#hp_array[id - line_length - 1]-=1
								#if id + line_length - 1 < hp_array.size():
									#hp_array[id + line_length - 1]-=1
								#
							#else:
								#if id - 1>=0:
									#hp_array[id-1]-=2
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=2
								#if id - line_length - 1 >= 0:
									#hp_array[id - line_length - 1]-=1
								#if id + line_length + 1 < hp_array.size():
									#hp_array[id + line_length + 1]-=1
								##print(id + line_length - 1,hp_array.size())
								#if id + line_length - 1 < hp_array.size():
									#hp_array[id + line_length - 1]-=1
								#if id - line_length + 1 >=0:
									#hp_array[id - line_length + 1]-=1
							#hp_array[id]-=dig_power
							#if id + line_length<hp_array.size():
								#hp_array[id+line_length]-=1
							#if id - line_length>=0:
								#hp_array[id-line_length]-=1
						#6:
							#var pos = id%line_length
							#if pos == 0:
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=2
								#if id + line_length + 1 < hp_array.size():
									#hp_array[id + line_length + 1]-=1
								#if id - line_length + 1 >=0:
									#hp_array[id - line_length + 1]-=1
#
							#elif pos == line_length-1:
								#if id - 1>=0:
									#hp_array[id-1]-=2
								#if id - line_length - 1 >= 0 :
									#hp_array[id - line_length - 1]-=1
								#if id + line_length - 1 < hp_array.size():
									#hp_array[id + line_length - 1]-=1
								#
							#else:
								#if id - 1>=0:
									#hp_array[id-1]-=2
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=2
								#if id - line_length - 1 >= 0:
									#hp_array[id - line_length - 1]-=1
								#if id + line_length + 1 < hp_array.size():
									#hp_array[id + line_length + 1]-=1
								##print(id + line_length - 1,hp_array.size())
								#if id + line_length - 1 < hp_array.size():
									#hp_array[id + line_length - 1]-=1
								#if id - line_length + 1 >=0:
									#hp_array[id - line_length + 1]-=1
							#hp_array[id]-=dig_power
							#if id + line_length<hp_array.size():
								#hp_array[id+line_length]-=2
							#if id - line_length>=0:
								#hp_array[id-line_length]-=2
						#7:
							#var pos = id%line_length
							#if pos == 0:
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=2
								#if id + line_length + 1 < hp_array.size():
									#hp_array[id + line_length + 1]-=2
								#if id - line_length + 1 >=0:
									#hp_array[id - line_length + 1]-=1
#
							#elif pos == line_length-1:
								#if id - 1>=0:
									#hp_array[id-1]-=2
								#if id - line_length - 1 >= 0 :
									#hp_array[id - line_length - 1]-=2
								#if id + line_length - 1 < hp_array.size():
									#hp_array[id + line_length - 1]-=1
								#
							#else:
								#if id - 1>=0:
									#hp_array[id-1]-=2
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=2
								#if id - line_length - 1 >= 0:
									#hp_array[id - line_length - 1]-=2
								#if id + line_length + 1 < hp_array.size():
									#hp_array[id + line_length + 1]-=2
								##print(id + line_length - 1,hp_array.size())
								#if id + line_length - 1 < hp_array.size():
									#hp_array[id + line_length - 1]-=1
								#if id - line_length + 1 >=0:
									#hp_array[id - line_length + 1]-=1
							#hp_array[id]-=dig_power
							#if id + line_length<hp_array.size():
								#hp_array[id+line_length]-=2
							#if id - line_length>=0:
								#hp_array[id-line_length]-=2
						#8:
							#var pos = id%line_length
							#if pos == 0:
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=2
								#if id + line_length + 1 < hp_array.size():
									#hp_array[id + line_length + 1]-=2
								#if id - line_length + 1 >=0:
									#hp_array[id - line_length + 1]-=2
#
							#elif pos == line_length-1:
								#if id - 1>=0:
									#hp_array[id-1]-=2
								#if id - line_length - 1 >= 0 :
									#hp_array[id - line_length - 1]-=2
								#if id + line_length - 1 < hp_array.size():
									#hp_array[id + line_length - 1]-=2
								#
							#else:
								#if id - 1>=0:
									#hp_array[id-1]-=2
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=2
								#if id - line_length - 1 >= 0:
									#hp_array[id - line_length - 1]-=2
								#if id + line_length + 1 < hp_array.size():
									#hp_array[id + line_length + 1]-=2
								##print(id + line_length - 1,hp_array.size())
								#if id + line_length - 1 < hp_array.size():
									#hp_array[id + line_length - 1]-=2
								#if id - line_length + 1 >=0:
									#hp_array[id - line_length + 1]-=2
							#hp_array[id]-=dig_power
							#if id + line_length<hp_array.size():
								#hp_array[id+line_length]-=2
							#if id - line_length>=0:
								#hp_array[id-line_length]-=2
						#9:
							#var pos = id%line_length
							#if pos == 0:
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=3
								#if id + line_length + 1 < hp_array.size():
									#hp_array[id + line_length + 1]-=2
								#if id - line_length + 1 >=0:
									#hp_array[id - line_length + 1]-=2
#
							#elif pos == line_length-1:
								#if id - 1>=0:
									#hp_array[id-1]-=3
								#if id - line_length - 1 >= 0 :
									#hp_array[id - line_length - 1]-=2
								#if id + line_length - 1 < hp_array.size():
									#hp_array[id + line_length - 1]-=2
								#
							#else:
								#if id - 1>=0:
									#hp_array[id-1]-=3
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=3
								#if id - line_length - 1 >= 0:
									#hp_array[id - line_length - 1]-=2
								#if id + line_length + 1 < hp_array.size():
									#hp_array[id + line_length + 1]-=2
								##print(id + line_length - 1,hp_array.size())
								#if id + line_length - 1 < hp_array.size():
									#hp_array[id + line_length - 1]-=2
								#if id - line_length + 1 >=0:
									#hp_array[id - line_length + 1]-=2
							#hp_array[id]-=dig_power
							#if id + line_length<hp_array.size():
								#hp_array[id+line_length]-=2
							#if id - line_length>=0:
								#hp_array[id-line_length]-=2
						#10:
							#var pos = id%line_length
							#if pos == 0:
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=3
								#if id + line_length + 1 < hp_array.size():
									#hp_array[id + line_length + 1]-=2
								#if id - line_length + 1 >=0:
									#hp_array[id - line_length + 1]-=2
#
							#elif pos == line_length-1:
								#if id - 1>=0:
									#hp_array[id-1]-=3
								#if id - line_length - 1 >= 0 :
									#hp_array[id - line_length - 1]-=2
								#if id + line_length - 1 < hp_array.size():
									#hp_array[id + line_length - 1]-=2
								#
							#else:
								#if id - 1>=0:
									#hp_array[id-1]-=3
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=3
								#if id - line_length - 1 >= 0:
									#hp_array[id - line_length - 1]-=2
								#if id + line_length + 1 < hp_array.size():
									#hp_array[id + line_length + 1]-=2
								##print(id + line_length - 1,hp_array.size())
								#if id + line_length - 1 < hp_array.size():
									#hp_array[id + line_length - 1]-=2
								#if id - line_length + 1 >=0:
									#hp_array[id - line_length + 1]-=2
							#hp_array[id]-=dig_power
							#if id + line_length<hp_array.size():
								#hp_array[id+line_length]-=3
							#if id - line_length>=0:
								#hp_array[id-line_length]-=3
						#11:
							#var pos = id%line_length
							#if pos == 0:
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=3
								#if id + line_length + 1 < hp_array.size():
									#hp_array[id + line_length + 1]-=3
								#if id - line_length + 1 >=0:
									#hp_array[id - line_length + 1]-=2
#
							#elif pos == line_length-1:
								#if id - 1>=0:
									#hp_array[id-1]-=3
								#if id - line_length - 1 >= 0 :
									#hp_array[id - line_length - 1]-=3
								#if id + line_length - 1 < hp_array.size():
									#hp_array[id + line_length - 1]-=2
								#
							#else:
								#if id - 1>=0:
									#hp_array[id-1]-=3
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=3
								#if id - line_length - 1 >= 0:
									#hp_array[id - line_length - 1]-=3
								#if id + line_length + 1 < hp_array.size():
									#hp_array[id + line_length + 1]-=3
								##print(id + line_length - 1,hp_array.size())
								#if id + line_length - 1 < hp_array.size():
									#hp_array[id + line_length - 1]-=2
								#if id - line_length + 1 >=0:
									#hp_array[id - line_length + 1]-=2
							#hp_array[id]-=dig_power
							#if id + line_length<hp_array.size():
								#hp_array[id+line_length]-=3
							#if id - line_length>=0:
								#hp_array[id-line_length]-=3
						#12:
							#var pos = id%line_length
							#if pos == 0:
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=3
								#if id + line_length + 1 < hp_array.size():
									#hp_array[id + line_length + 1]-=3
								#if id - line_length + 1 >=0:
									#hp_array[id - line_length + 1]-=3
#
							#elif pos == line_length-1:
								#if id - 1>=0:
									#hp_array[id-1]-=3
								#if id - line_length - 1 >= 0 :
									#hp_array[id - line_length - 1]-=3
								#if id + line_length - 1 < hp_array.size():
									#hp_array[id + line_length - 1]-=3
								#
							#else:
								#if id - 1>=0:
									#hp_array[id-1]-=3
								#if id + 1<hp_array.size():
									#hp_array[id+1]-=3
								#if id - line_length - 1 >= 0:
									#hp_array[id - line_length - 1]-=3
								#if id + line_length + 1 < hp_array.size():
									#hp_array[id + line_length + 1]-=3
								##print(id + line_length - 1,hp_array.size())
								#if id + line_length - 1 < hp_array.size():
									#hp_array[id + line_length - 1]-=3
								#if id - line_length + 1 >=0:
									#hp_array[id - line_length + 1]-=3
							#hp_array[id]-=dig_power
							#if id + line_length<hp_array.size():
								#hp_array[id+line_length]-=3
							#if id - line_length>=0:
								#hp_array[id-line_length]-=3
					#for i in hp_array.size():
						#if hp_array[i] <= 0:
							#if i >=0 and i < surface_coord_array.size():
								#surface.set_cell(surface_coord_array[i],-1)
					#snake_layer_kernel.show_snake()
#
#func reset():
	##game_over_panel.visible = true
	##stamina_bar.visible = true
	#for i in under.get_used_cells():
		#under.set_cell(i,-1)
	#for i in snake_layer_kernel.get_used_cells():
		#snake_layer_kernel.set_cell(i,-1)
	#for i in surface.get_used_cells():
		#surface.set_cell(i,-1)
	#for i in under_background.get_used_cells():
		#under_background.set_cell(i,-1)
	#returnid = []
	#surface_coord_array = []
	#
#func level_finished_reset():
	#panel_container_animation.size = defaut_gameover_container_size
	#panel_container_animation.position = defaut_gameover_container_position
	#
#@onready var card_box: HBoxContainer = $CanvasLayer/game_over_panel/VBoxContainer/card_box
#@onready var nothing_caught: RichTextLabel = $Control/PanelContainer_animation/nothing_caught
#
#func _on_timer_timeout() -> void:
	#level_finished()
	#var lvl_up_returnid:Array
	#for i in snake_layer_kernel.return_id:
		#if i != null:
			#returnid.append(i)
	#var xp_count = returnid.size()
	#GlobalVariables.location_xp[location_index]+=xp_count
	#location_lvlup()
	#lvl_up_returnid.assign(returnid)
#
	#if lvl_up_returnid != []:
		#for l in lvl_up_returnid:
			#main.spawn_snake(l,0)
			#GlobalVariables.snake_count[l] += 1
	#if returnid!=[]:
		#for i in returnid:
			#var new_card = SNAKE_CARD_MINED.instantiate()
			#new_card.snake_id = i
			#card_box.add_child(new_card)
			#new_card.setup()
		#nothing_caught.text = "[center]"+"[wave]"+"Here's your catch..."
	#else:
		#nothing_caught.text = "[center]"+"[wave]"+"you didn't catch anything..."
#
#func location_lvlup():
	#if GlobalVariables.location_xp[location_index]>= GlobalVariables.location_xp_need(GlobalVariables.location_lvl[location_index]):
		#GlobalVariables.location_xp[location_index]-=GlobalVariables.location_xp_need(GlobalVariables.location_lvl[location_index])
		#GlobalVariables.location_lvl[location_index]+=1
		#location_lvlup()
	#else:
		#pass
#
#func _on_texture_button_button_down() -> void:
	#for i in card_box.get_children():
		#i.queue_free()
	#return_to_main()
	#
#func return_to_main():
	#main.on_trip_over()
	#snake_layer_kernel.reset()
	#game_over_panel.visible = false
	#stamina_bar.visible = false
#
#
#func _on_replay_button_down() -> void:
	#for i in card_box.get_children():
		#i.queue_free()
	#
	#GlobalVariables.gold_current -= CostsTable.unlocking_cost[MiningSceneSettings.world[location]["location_index"]]
	##transition.total_transition()
	##transition.visible = true
	##transition.global_position = get_global_mouse_position()
	#reset()
	#location = location
	#stamina = GlobalVariables.stamina 
	#dig_power = GlobalVariables.arm_strength 
	#starting_position = MiningSceneSettings.world[location]["starting_position"]
	#ending_position = MiningSceneSettings.world[location]["ending_position"]
	#snake_amount = MiningSceneSettings.world[location]["snake_amount"]
	#tile_hp = MiningSceneSettings.world[location]["tile_hp"]
	#location_index = MiningSceneSettings.world[location]["location_index"]
	#game_restart.start()
#
#@onready var game_restart: Timer = $game_restart
#
#func _on_game_restart_timeout() -> void:
	#start_scene()
#
#const MINING_PARTICLES = preload("res://mining_particles/mining_particles.tscn")
#@onready var mining_particles: Node2D = $mining_particles
#func spawn_mining_particles():
	#var new_particle = MINING_PARTICLES.instantiate()
	#new_particle.position = get_local_mouse_position()
	#mining_particles.add_child(new_particle)
	#new_particle.emit()
