class_name SnakeCard_old
extends PanelContainer

var fish_cards_box:FishCardBox

@onready var rarity_lbl: RichTextLabel = $base/rarity_lbl
@onready var fish_fin: Sprite2D = $base/visual/fish_fin
@onready var body: Line2D = $base/visual/body
@onready var snake_name_lbl: RichTextLabel = $base/snake_name_lbl
@onready var snake_region_lbl: RichTextLabel = $base/snake_region_lbl

#const SNAKE_CARD_MINED = preload("res://snake_card/snake_card_mined.tscn")


var main:GraphicKernel
var can_animate:bool
var original_points:Array
var snake_name:String


var clickable:bool
var mouse_in:bool
var resizable:bool=true

var snake_region
var snake_rarity
var snake_id:int = -100

var t = 0.0

var unlocked_clones:Node2D
var clone:SnakeCard_old
var is_clone:bool

var can_popout:bool = true

@onready var area_2d: Area2D = $Area2D

@export var area_code:int
@onready var new_background: Sprite2D = $NewBackground


func _ready() -> void:
	
	new_background.modulate = GlobalVariables.location_color[area_code]
	fish_cards_box = get_tree().get_first_node_in_group("fish_card_box")
	unlocked_clones = get_tree().get_first_node_in_group("card_clones")
	pivot_offset = size/2
	if !is_clone:
		original_points = body.points
	main = get_tree().get_first_node_in_group("main")
	if can_popout:
		clickable = false
		area_2d.visible = false
	
	#setup()

func setup() -> void:
	if GlobalVariables.snake_unlocked_register.find(snake_id)==-1 and can_popout:
		snake_name = "????"
	else:
		resign_name(snake_id)
		fish_fin.global_position = original_points[3]+body.global_position
		tail.global_position = original_points[10]+body.global_position
		body.default_color = Color("ffffff")
		body.texture = load("res://snake_textures/"+str(snake_id)+".png")
		tail.texture = load("res://snake_textures/"+str(snake_id)+"_3.png")
		fish_fin.texture = load("res://snake_textures/"+str(snake_id)+"_1.png")
		snake_name_lbl.text = "[center]"+"[b]"+"[font_size=18]"+snake_name
		var rarity_color_code:String
		match snake_rarity:
			"Common":
				rarity_color_code="[color=#FFEECC]"
				audio_stream_player_2d.stream = fish_cards_box.release_card_list.pick_random()
				#color_rect.self_modulate = Color("#CCFFEE")
			"Rare":
				rarity_color_code="[color=#CCFFEE]"
				audio_stream_player_2d.stream = fish_cards_box.R
				#color_rect.self_modulate = Color("#EECCFF")
			"Very Rare":
				rarity_color_code="[color=#EECCFF]"
				audio_stream_player_2d.stream = fish_cards_box.VR
				#color_rect.self_modulate = Color("#FFEECC")
			"Legendary":
				rarity_color_code="[color=Gold]"
				audio_stream_player_2d.stream = fish_cards_box.VR
		rarity_lbl.text = "[center]"+rarity_color_code+snake_rarity
		snake_region_lbl.text = "[center]"+"[i]"+"[font_size=18]"+ snake_region +"Pack"

func resign_name(id):
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



func _on_color_rect_mouse_entered() -> void:

	if !can_popout:
		pivot_offset = size/2
		z_index += 1000
		var new_tween = create_tween()
		new_tween.tween_property(self,"scale",Vector2.ONE*1.2,0.1)
		#can_animate = true
		t = 0.0
	
	#if !is_clone and can_popout:
		#if clone== null:
	#if resizable:
		#pivot_offset = size/2
		#z_index += 1000
		#var new_tween = create_tween()
		#new_tween.tween_property(self,"scale",Vector2.ONE*1.5,0.1)
		#can_animate = true
		#t = 0.0
			#var new_self_resizeble = SNAKE_CARD_MINED.instantiate()
			#var new_Tween = create_tween()
			#new_self_resizeble.area_code = area_code
			#new_self_resizeble.pivot_offset = size/2
			#new_self_resizeble.global_position = self.global_position
			#new_self_resizeble.z_index += 1000
			#unlocked_clones.add_child(new_self_resizeble)
			#new_Tween.tween_property(new_self_resizeble,"scale",Vector2.ONE*1.5,0.1)
			#new_self_resizeble.can_animate = false
			#new_self_resizeble.is_clone = true
			#new_self_resizeble.snake_id = snake_id
			#new_self_resizeble.setup()
			#new_self_resizeble.color_rect.visible = false
			#clone = new_self_resizeble
			#await new_Tween.finished
			#if is_instance_valid(new_self_resizeble):
				#new_self_resizeble.can_animate = true
			#new_self_resizeble.original_points = new_self_resizeble.body.points
#

func _on_color_rect_mouse_exited() -> void:
	if clone!= null:
		var new_Tween = create_tween()
		new_Tween.tween_property(clone,"scale",Vector2.ONE,0.1)
		clone.can_animate = false
		await new_Tween.finished
		if is_instance_valid(clone):
			clone.queue_free()
	if !can_popout:
		pivot_offset = size/2
		z_index -= 1000
		var new_tween = create_tween()
		new_tween.tween_property(self,"scale",Vector2.ONE,0.1)
		#body.points = original_points
		#fish_fin.global_position = original_points[3]+body.global_position
		#can_animate = false
		
	#clone = null
@onready var color_rect: ColorRect = $ColorRect


func _process(delta: float) -> void:
	if can_animate:
		animation(delta)

	if clickable and mouse_in and Input.is_action_just_pressed("left_mouse"):
		clicked()

@onready var tail: Sprite2D = $base/visual/tail
@onready var base: Control = $base
@onready var visual: Control = $base/visual


func animation(delta):
	t += delta
	for i in original_points.size():
		body.points[i].y = original_points[i].y+sin(-t*2.0+(body.points[i].x)/60.0)*(body.points[i].x-22.0)/25.0
	if is_clone:
		fish_fin.global_position = (body.points[3]*1.5+body.global_position)
		tail.global_position = (body.points[10]*1.5+body.global_position)
	else:
		fish_fin.global_position = (body.points[3]+body.global_position)
		tail.global_position = (body.points[10]+body.global_position)
	tail.rotation = ((body.points[10]-body.points[9]).angle()) - PI/2



@onready var timer_self_destruction: Timer = $Timer_self_destruction

#signal tutorial_final
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func clicked():
	if snake_id!=-100:
		main.spawn_snake(snake_id,0,0,-1)
		GlobalVariables.snake_count[snake_id]+=1
		
		audio_stream_player_2d.play()
		var tween = create_tween()
		tween.tween_property(self,"scale",Vector2.ZERO,0.1)
		await tween.finished
		timer_self_destruction.start()
		visible = false
		#fish_cards_box.fill_card_gap(self)
	
func _on_timer_self_destruction_timeout() -> void:
	queue_free()


func _on_area_2d_mouse_entered() -> void:
	mouse_in = true


func _on_area_2d_mouse_exited() -> void:
	mouse_in = false
