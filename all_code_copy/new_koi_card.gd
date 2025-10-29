class_name KoiCard
extends Control
@onready var sub_viewport: SubViewport = $new_koi_card_viewport/SubViewport

@onready var mouse_detection_area: ColorRect = $new_koi_card_viewport/Control/mouse_detection_area

#@onready var mouse_detection_area: ColorRect = $Control/mouse_detection_area
var angle_x_max:float = 0.3
var angle_y_max:float = 0.3

var perspective_shader:ShaderMaterial
var burning_shader:ShaderMaterial
var koi_burning_shader:ShaderMaterial

var tween_hover:Tween
var tween_rot:Tween
#@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $new_koi_card_viewport/AudioStreamPlayer2D


#orignal variables
var fish_cards_box:FishCardBox

@onready var rarity_lbl: RichTextLabel = $new_koi_card_viewport/SubViewport/PanelContainer/VBoxContainer/rarity_lbl
@onready var tail: Sprite2D = $new_koi_card_viewport/SubViewport/PanelContainer/VBoxContainer/space/tail
@onready var fish_fin: Sprite2D = $new_koi_card_viewport/SubViewport/PanelContainer/VBoxContainer/space/fish_fin
@onready var body: Line2D = $new_koi_card_viewport/SubViewport/PanelContainer/VBoxContainer/space/body
@onready var name_lbl: RichTextLabel = $new_koi_card_viewport/SubViewport/PanelContainer/VBoxContainer/name_lbl
@onready var region_lbl: RichTextLabel = $new_koi_card_viewport/SubViewport/PanelContainer/VBoxContainer/region_lbl

var main:GraphicKernel
var can_animate:bool
var original_points:Array
var koi_name:String
var clickable:bool

var koi_region
var koi_rarity
var koi_quality:float
var koi_id:int = -100
var mouse_in:bool

var t = 0.0
@onready var self_destruction: Timer = $new_koi_card_viewport/self_destruction
@onready var panel_container: PanelContainer = $new_koi_card_viewport/SubViewport/PanelContainer

@export var area_code:int

signal re_organize_cards

func _ready() -> void:
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	self.pivot_offset = size/2
	perspective_shader = $new_koi_card_viewport.material
	burning_shader = $new_koi_card_viewport/SubViewport/PanelContainer.material
	koi_burning_shader = $new_koi_card_viewport/SubViewport/PanelContainer/VBoxContainer/space/body.material

	fish_cards_box = get_tree().get_first_node_in_group("fish_card_box")
	main = get_tree().get_first_node_in_group("main")
	original_points = body.points
	if clickable:
		perspective_shader.set_shader_parameter("x_rot",5.0)


func _on_mouse_detection_area_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		
		var mouse_pos:Vector2 = get_local_mouse_position()
		#var diff:Vector2 = (position + size) - mouse_pos
		
		var lerp_val_x:float=remap(mouse_pos.x,0.0,size.x,0,1)
		var lerp_val_y:float=remap(mouse_pos.y,0.0,size.y,0,1)
		
		var rot_x:float = rad_to_deg(lerp_angle(-angle_x_max,angle_x_max,lerp_val_x))
		var rot_y:float = rad_to_deg(lerp_angle(angle_y_max,-angle_y_max,lerp_val_y))
		if clickable:
			perspective_shader.set_shader_parameter("x_rot",rot_y+5.0)
		else:
			perspective_shader.set_shader_parameter("x_rot",rot_y)
		perspective_shader.set_shader_parameter("y_rot",rot_x)
		


	
func _process(delta: float) -> void:
	if can_animate:
		animation(delta)
	if clickable and mouse_in and Input.is_action_just_pressed("left_mouse"):
		clicked()
	handle_shadow()
	if mouse_in:
		sub_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS

func _on_mouse_detection_area_mouse_entered() -> void:
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	can_animate = true
	mouse_in = true
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO).set_parallel(true)
	tween_hover.tween_property(self,"scale",Vector2(1.3,1.3),0.5)
	z_index += 1000
	#z_index += 4000


func _on_mouse_detection_area_mouse_exited() -> void:
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	z_index = 0
	can_animate = false
	mouse_in = false
	t = 0
	if tween_rot and tween_rot.is_running():
		tween_rot.kill()
	tween_rot = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).set_parallel(true)
	if clickable:
		tween_rot.tween_property(perspective_shader,"shader_parameter/x_rot",5.0,0.5)
	else :
		tween_rot.tween_property(perspective_shader,"shader_parameter/x_rot",0.0,0.5)
	tween_rot.tween_property(perspective_shader,"shader_parameter/y_rot",0.0,0.5)
	
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self,"scale",Vector2.ONE,0.55)

#@onready var visible_on_screen_enabler_2d: VisibleOnScreenEnabler2D = $VisibleOnScreenEnabler2D

func setup() -> void:
	if GlobalVariables.snake_unlocked_register.find(koi_id)==-1 and !clickable :
		koi_name = "????"
	else:
		resign_name(koi_id)
		fish_fin.global_position = original_points[3]+body.global_position
		tail.global_position = original_points[10]+body.global_position
		body.default_color = Color("ffffff")
		body.texture = load("res://snake_textures/"+str(koi_id)+".png")
		tail.texture = load("res://snake_textures/"+str(koi_id)+"_3.png")
		fish_fin.texture = load("res://snake_textures/"+str(koi_id)+"_1.png")
		name_lbl.text = "[center]"+"[b]"+"[font_size=18]"+koi_name
		var rarity_color_code:String
		match koi_rarity:
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
		rarity_lbl.text = "[center]"+rarity_color_code+koi_rarity
		if !clickable:
			region_lbl.text = "[center][i][font_size=16]Best Quality: " + GlobalVariables.remap_koi_quality(GlobalVariables.fish_highest_quality[koi_id])
		elif clickable:
			var rng = RandomNumberGenerator.new()
			rng.randomize()
	
			var base_quality = randfn(100.0, 20.0)
			var luck_bonus = GlobalVariables.get_luck_index() * 1.5 - 30.0
	
			var val = base_quality + luck_bonus 
			val = clamp(val, 10.0, 300.0) 
	
			koi_quality = val 
			region_lbl.text = "[center][i][font_size=16]Koi Quality: " + GlobalVariables.remap_koi_quality(koi_quality)
		#region_lbl.text
		#region_lbl.text = "[center]"+"[i]"+"[font_size=18]"+ koi_region +"Pack"

	burning_shader.set_shader_parameter("modulate",GlobalVariables.location_color[area_code])

func resign_name(id):
	var current_koi_name:String=""
	var current_koi_rarity:String=""
	var current_koi_region:String=""
	for i in Destinations.World:
		for j in Destinations.World[i]:
			for k in Destinations.World[i][j]:
				if Destinations.World[i][j][k]["id"] == id:
					current_koi_name = k
					current_koi_rarity = Destinations.World[i][j][k]["rarity"]
					current_koi_region = Destinations.World[i][j][k]["region"]
					break
	koi_name = current_koi_name
	koi_rarity = current_koi_rarity
	koi_region = current_koi_region

func animation(delta):
	t += delta
	for i in original_points.size():
		body.points[i].y = original_points[i].y+sin(-t*2.0+(body.points[i].x)/60.0)*(body.points[i].x-22.0)/25.0

		fish_fin.global_position = (body.points[3]+body.global_position)
		tail.global_position = (body.points[10]+body.global_position)
	tail.rotation = ((body.points[10]-body.points[9]).angle()) - PI/2

@onready var shadow: PanelContainer = $new_koi_card_viewport/shadow_pos/shadow


func clicked():
	if koi_id!=-100:
		clickable = false
		main.spawn_snake(koi_id,0,0,koi_quality)
		GlobalVariables.snake_count[koi_id]+=1
		audio_stream_player_2d.play()
		var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO).set_parallel(true)
		tween.tween_property(burning_shader,"shader_parameter/dissolve_value",0.0,0.5)
		tween.tween_property(koi_burning_shader,"shader_parameter/dissolve_value",0.0,0.5)
		tween.tween_property(tail,"modulate",Color(0,0,0,0),0.5)
		tween.tween_property(fish_fin,"modulate",Color(0,0,0,0),0.5)
		tween.tween_property(shadow,"modulate",Color(0,0,0,0),0.5)
		tween.tween_property(rarity_lbl,"modulate",Color(0,0,0,0),0.5)
		tween.tween_property(name_lbl,"modulate",Color(0,0,0,0),0.5)
		tween.tween_property(region_lbl,"modulate",Color(0,0,0,0),0.5)
		re_organize_cards.emit(self)
		await tween.finished
		self_destruction.start()
		visible = false
		
		


func _on_self_destruction_timeout() -> void:
	queue_free()


func handle_shadow()->void:
	var center:Vector2=get_viewport_rect().size/2.0
	var distance:float=global_position.x-center.x
	shadow.position.x=lerp(0.0,-sign(distance)*50.0,abs(distance/(center.x)))+10.0



@onready var new_koi_card_viewport: SubViewportContainer = $new_koi_card_viewport



func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	new_koi_card_viewport.visible = true
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	new_koi_card_viewport.visible = false
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
