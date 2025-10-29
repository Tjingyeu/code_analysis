extends Control
@onready var close_btn: TextureButton = $close_btn
@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var new_found_fish_base: Control = $"."

var snake_id:int = 10

func _ready() -> void:
	#new_found_fish_base.position = Vector2(0,0)

	scale = Vector2(0,1)
	setup()
	var new_tween = create_tween()
	new_tween = new_tween.tween_property(self,"scale",Vector2.ONE,0.3)
	original_points = body.points
	
	
	fin.global_position = original_points[3]+body.global_position
	tail.global_position = original_points[10]+body.global_position
	body.default_color = Color("ffffff")
	body.texture = load("res://snake_textures/"+str(snake_id)+".png")
	tail.texture = load("res://snake_textures/"+str(snake_id)+"_3.png")
	fin.texture = load("res://snake_textures/"+str(snake_id)+"_1.png")
	name_lbl.text = "[center]"+"[font_size=20]"+fish_name
	var rarity_color_code:String
	match fish_rarity:
		"Common":
			rarity_color_code="[color=#FFEECC]"
			#color_rect.self_modulate = Color("#CCFFEE")
		"Rare":
			rarity_color_code="[color=#CCFFEE]"
			#color_rect.self_modulate = Color("#EECCFF")
		"Very Rare":
			rarity_color_code="[color=#EECCFF]"
			#color_rect.self_modulate = Color("#FFEECC")
	rarity_lbl.text = "[center]"+rarity_color_code+fish_rarity
	
	#new_tween.finished.connect(play_flip_card_animation)

	
#func play_flip_card_animation():
	#animation_player.play("card_flip")
	
@onready var firework_emitter: GPUParticles2D = $firework_emitter
@onready var rarity_lbl: RichTextLabel = $PanelContainer/base/rarity_lbl
@onready var name_lbl: RichTextLabel = $PanelContainer/base/name_lbl

func setup():
	firework_emitter.global_position = global_position + Vector2(0,269)
	resign_name(snake_id)
	


func _on_close_btn_button_down() -> void:
	var new_tween = create_tween()
	new_tween = new_tween.tween_property(self,"scale",Vector2(0,0),0.3)
	self_destruct_timer.start()
	firework_emitter.emitting = false

@onready var self_destruct_timer: Timer = $self_destruct_timer

#func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	#card_back.visible = false


func _on_self_destruct_timer_timeout() -> void:
	queue_free()



@onready var fin: Sprite2D = $PanelContainer/base/fin
@onready var tail: Sprite2D = $PanelContainer/base/tail
@onready var body: Line2D = $PanelContainer/base/body

var original_points:Array
var t:float
func animation(delta):
	t += delta
	for i in original_points.size():
		body.points[i].y = original_points[i].y+sin(-t*2.0+(body.points[i].x)/60.0)*(body.points[i].x-22.0)/25.0
	fin.global_position = body.points[3]+body.global_position
	tail.global_position = body.points[10]+body.global_position
	tail.rotation = ((body.points[10]-body.points[9]).angle()) - PI/2


func _process(delta: float) -> void:
	animation(delta)

var fish_name:String
var fish_rarity:String
var fish_region:String
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
	fish_name = current_snake_name
	fish_rarity = current_snake_rarity
	fish_region = current_snake_region
