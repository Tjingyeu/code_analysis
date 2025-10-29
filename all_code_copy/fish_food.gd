class_name FishFood
extends Node2D


@onready var fish_food_texture: Sprite2D = $fish_food_texture
@onready var self_destruct: Timer = $self_destruct
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var snakes_array:Array
var fish_near:bool
#var food_disappearing:bool
var fish_food_particles_node:Node2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var bubble_sound_time:int = 0

func _ready() -> void:
	fish_food_particles_node = get_tree().get_first_node_in_group("fish_food_particles")
	timer.start()
	animation_player.play("floating")
	audio_stream_player_2d.play()


func _process(delta: float) -> void:
	got_eaten(delta)

func _on_timer_timeout() -> void:
	var new_tween = create_tween()
	new_tween.tween_property(fish_food_texture,"self_modulate",Color(1,1,1,0),2.0)
	var new_tween_1 = create_tween()
	new_tween_1.tween_property(fish_food_texture,"scale",Vector2.ZERO,1.0)
	

const FISH_FOOD_PARTICLE = preload("res://fish_food/fish_food_particle.tscn")

func got_eaten(delta):
	for i in snakes_array:
		if global_position.distance_squared_to(Vector2(i.segment_pos[0],i.segment_pos[1]))<=400:
			_on_timer_timeout()
			self_destruct.start()
			if !fish_near:
				var new_particle = FISH_FOOD_PARTICLE.instantiate()
				new_particle.global_position = global_position
				fish_food_particles_node.add_child(new_particle)
				fish_near = true
				keep_playing_bubble()
		if global_position.distance_squared_to(Vector2(i.segment_pos[0],i.segment_pos[1]))<=2500 and fish_near:
			i.exp_current += GlobalVariables.get_food_Exp()*delta

func _on_self_destruct_timeout() -> void:
	
	queue_free()

@onready var bubble_low: AudioStreamPlayer2D = $bubble_low
@onready var bubble_medium: AudioStreamPlayer2D = $bubble_medium
@onready var bubble_high: AudioStreamPlayer2D = $bubble_high

func keep_playing_bubble():
	if bubble_sound_time<=10:
		var randomi = randi_range(0,2)
		match randomi:
			0:
				bubble_low.play()
			1:
				bubble_medium.play()
			2:
				bubble_high.play()
		bubble_sound_time+=1

func _on_bubble_low_finished() -> void:
	keep_playing_bubble()


func _on_bubble_medium_finished() -> void:
	keep_playing_bubble()


func _on_bubble_high_finished() -> void:
	keep_playing_bubble()
