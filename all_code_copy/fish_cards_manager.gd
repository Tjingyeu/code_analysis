class_name FishCardBox
extends Control
@onready var card_placement: AudioStreamPlayer2D = $"../../Camera2D/card_placement"

var in_box_fish_count:int=0

#const SNAKE_CARD_MINED = preload("res://snake_card/snake_card_mined.tscn")
const NEW_KOI_CARD = preload("uid://cxcdbnfjgfgi0")

var ui_mode:int = 0
#@onready var cards_holder: HBoxContainer = $cards_holder

#@onready var cards_holder: Control = $cards_holder
@onready var fish_box: TextureRect = $fish_box
var fish_box_array:Array = []
var fish_box_visible:bool = false
@onready var cards_visual: Control = $fish_box/cards_visual
var fish_box_color_array:Array=[]
#var fish_i:int = 0
#var card_pos_array:Array
@onready var cards: Control = $"../cards"

var play_list:=[]
var release_card_list:=[]
const R = preload("res://main/sound_effects/r.ogg")
const VR = preload("res://main/sound_effects/vr.ogg")
const CARD_0201 = preload("res://main/sound_effects/card0201.mp3")
const CARD_0202 = preload("res://main/sound_effects/card0202.mp3")
const CARD_0203 = preload("res://main/sound_effects/card0203.mp3")
const CARD_SHOVE_1 = preload("res://main/sound_effects/card-shove-1.ogg")
const CARD_SHOVE_2 = preload("res://main/sound_effects/card-shove-2.ogg")
const CARD_SHOVE_3 = preload("res://main/sound_effects/card-shove-3.ogg")
const CARD_SHOVE_4 = preload("res://main/sound_effects/card-shove-4.ogg")
func _ready() -> void:
	release_card_list = [CARD_SHOVE_1,CARD_SHOVE_2,CARD_SHOVE_3,CARD_SHOVE_4]
	play_list = [CARD_0201,CARD_0202,CARD_0203]
	card_placement.stream = play_list.pick_random()
	#print(0%2)
	#fish_box_color_array.resize(cards_visual.get_children().size())
	for i in cards_visual.get_children():
		
		i.self_modulate = Color(1,1,1,0)

	ui_mode = 0
	#print(card_pos_array)


#func spawn_cards(koi_id):
	#var area_code:int = int(koi_id/6)
	#var new_card = NEW_KOI_CARD.instantiate()
	#new_card.area_code = area_code
	#new_card.koi_id = koi_id
	#new_card.clickable = true
	#new_card.position = Vector2(896,2320)
	##publish_cards(new_card)
#
	#new_card.setup()
	#
	

@onready var card_count: RichTextLabel = $fish_box/card_count
var time:float
var time_multiplier: float = 2.0
#var cards_in_hand:=[]
func _process(delta: float) -> void:
	
	time += delta
	for i in range(new_cards_holder.get_child_count()):
		var c: Control = new_cards_holder.get_child(i)
		var val: float = sin(i + (time * time_multiplier))
		#print("Child %d, sin(%d) = %f" % [i, i, val])
		c.position.y += val * sine_offset_mult

	card_count.text = "[center]x%s" %fish_box_array.size()
	
	#if fish_box_color_array.size()<= cards_visual.get_children().size():
	for i in fish_box_color_array.size():
		if i < cards_visual.get_children().size():
			cards_visual.get_child(i).self_modulate = fish_box_color_array[i]
	
	if fish_box_array.size()!=0:
		fish_box.visible = true
		if !fish_box_visible:
			fish_box_visible = true
			var new_Tween = create_tween()
			new_Tween.tween_property(fish_box,"modulate",Color(1,1,1,1),0.5)
	elif fish_box_array.size()==0:
		if fish_box_visible:
			fish_box_visible = false
			var new_Tween = create_tween()
			new_Tween.tween_property(fish_box,"modulate",Color(1,1,1,0),0.5)
			await new_Tween.finished
			fish_box.visible = false
	
	if cards.get_child_count()!=0:
		spawn_fish_button.visible = false
	else:
		spawn_fish_button.visible = true

@onready var spawn_fish_button: Button = $fish_box/spawn_fish_button

@onready var spawn_card_timer: Timer = $fish_box/spawn_fish_button/spawn_card_timer

signal tween_04

func _on_spawn_fish_button_button_down() -> void:
	if GlobalVariables.tutorial:
		tween_04.emit()
	spawn_fish_button.disabled = true
	draw_cards(fish_box_array)


#func _on_spawn_card_timer_timeout() -> void:
	#
	#if fish_i >=0:
		#spawn_cards(fish_box_array[fish_i])
		#fish_box_array.remove_at(fish_i)
		#fish_box_color_array[fish_i] = Color(1,1,1,0)
		#fish_i -= 1
		#spawn_card_timer.start()
	#else:
		#fish_box_color_array = []
		#in_box_fish_count = 0
		#spawn_fish_button.disabled = false
		#card_placement.playing = false



func _on_card_placement_finished() -> void:
	card_placement.stream = play_list.pick_random()
	#card_placement.play()

var draw_cards_tween:Tween
@onready var new_cards_holder: Control = $new_cards_holder
@onready var from_pos: Control = $from_pos
var card_offset_x: float = 90.0
var rot_max: float = PI*3.2 + PI
var anim_offset_y: float = 0.3
var sine_offset_mult: float = 0.0
func draw_cards(koi_ids: Array) -> void:
	if draw_cards_tween and draw_cards_tween.is_running():
		draw_cards_tween.kill()
	draw_cards_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	for i in range(koi_ids.size()):
		var instance: KoiCard = NEW_KOI_CARD.instantiate()
		new_cards_holder.add_child(instance)
		var area_code:int = int(koi_ids[i]/6)
		instance.global_position = from_pos.global_position
		instance.area_code = area_code
		instance.koi_id = koi_ids[i]
		instance.clickable = true
		instance.z_index = 4096
		instance.re_organize_cards.connect(re_organize_cards)
		instance.setup()
		fish_box_color_array[i] = Color(1,1,1,0)
		# -(instance.size / 2.0) to center the card
		var final_pos: Vector2 = -(instance.size / 2.0) - Vector2(card_offset_x * (koi_ids.size() - 1 - i), 0.0)
		final_pos.x += ((card_offset_x * (koi_ids.size()-1)) / 2.0)
		
		#print("Offset: ", float(i)/float(number-1))
		var rot_radians: float = 0.0
		if koi_ids.size() > 1:
			rot_radians = lerp_angle(-rot_max, rot_max, float(i)/float(koi_ids.size()-1))
		#print("Rot: ", rot_radians)
		#print("Card %d: , size: %s, pivot: %s" % [i, str(instance.size), str(instance.pivot_offset)])
		
		# Animate pos
		draw_cards_tween.parallel().tween_property(instance, "position", final_pos, 0.3 + (i * 0.075))
		draw_cards_tween.parallel().tween_property(instance, "rotation", rot_radians, 0.3 + (i * 0.075))
		
		card_placement.play()
	fish_box_array = []
	fish_box_color_array = []
	in_box_fish_count = 0
	spawn_fish_button.disabled = false
	draw_cards_tween.tween_callback(set_process.bind(true))
	draw_cards_tween.tween_property(self, "sine_offset_mult", anim_offset_y, 1.5).from(0.0)


var new_rot_max:float = 0.2*PI
var re_organize_tween:Tween
func re_organize_cards(card:KoiCard):
	var cards_in_hand = new_cards_holder.get_children()
	cards_in_hand.erase(card)
	#if re_organize_tween and re_organize_tween.is_running():
		#re_organize_tween.kill()
	re_organize_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	#var cards_in_hand = new_cards_holder.get_children()
	
	for i in cards_in_hand.size():
		var final_pos: Vector2 = -(cards_in_hand[i].size / 2.0) - Vector2(card_offset_x * (cards_in_hand.size() - 1 - i), 0.0)
		final_pos.x += ((card_offset_x * (cards_in_hand.size()-1)) / 2.0) 
		var rot_radians: float = 0.0
		if cards_in_hand.size() > 1:
			rot_radians = lerp_angle(-rot_max, rot_max, float(i)/float(cards_in_hand.size()-1))
		#var rot_radians: float = lerp_angle(-rot_max, rot_max, float(i)/float(cards_in_hand.size()-1))
		re_organize_tween.parallel().tween_property(cards_in_hand[i], "position", final_pos, 0.3 + (i * 0.075))
		re_organize_tween.parallel().tween_property(cards_in_hand[i], "rotation", rot_radians, 0.3 + (i * 0.075))
	re_organize_tween.tween_callback(set_process.bind(true))
	re_organize_tween.tween_property(self, "sine_offset_mult", anim_offset_y, 1.5).from(0.0)
