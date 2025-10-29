class_name Transition
extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal animiation_finished
@onready var rect_fade_in: TextureRect = $fade_in
@onready var rect_fade_out: TextureRect = $fade_out
@onready var wishing_well: Timer = $wishing_well

#signal scene_switch
signal start_game
signal quit_game
#signal switch_wishing_well
#signal back_to_main
@onready var timer: Timer = $Timer
@onready var main: Timer = $main


func fade_in():
	animation_player.play("fade_in")
	rect_fade_in.visible=true
	rect_fade_out.visible=false
func fade_out():
	animation_player.play("fade_out")
	
func new_fade_out():
	animation_player.play("new_fade_out")
	rect_fade_in.visible=false
	rect_fade_out.visible=true
	
func total_transition():
	animation_player.play("total_transition")
	timer.start()

func quit_game_transition():
	animation_player.play("total_transition")
	main.start()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animiation_finished.emit(anim_name)

func _on_timer_timeout() -> void:
	start_game.emit()

func _on_main_timeout() -> void:
	quit_game.emit()

func to_switch_pond():
	animation_player.play("total_transition")
	switch_pond.start()
	
@onready var switch_pond: Timer = $switch_pond

signal switch_koi_pond
func _on_switch_pond_timeout() -> void:
	switch_koi_pond.emit()
