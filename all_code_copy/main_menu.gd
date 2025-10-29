extends Node2D

const WATER_SURFACE_MAIN = preload("res://main/water_surface_main.tscn")

func _on_a_button_down() -> void:
	#new game
	get_tree().change_scene_to_packed(WATER_SURFACE_MAIN)


func _on_b_button_down() -> void:
	pass # Replace with function body.


func _on_c_button_down() -> void:
	get_tree().quit()


func _on_a_2_button_down() -> void:
	#continue
	get_tree().change_scene_to_packed(WATER_SURFACE_MAIN)

#@onready var butterfly_anime: AnimationPlayer = $ButterflySheet/butterfly_anime
@onready var butterfly_anime: AnimationPlayer = $Path2D/PathFollow2D/ButterflySheet/butterfly_anime
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var butterfly_sheet: Sprite2D = $Path2D/PathFollow2D/ButterflySheet

var butterfly_last_pos:Vector2
func _process(delta: float) -> void:
	var butterfly_current_pos:Vector2 = butterfly_sheet.global_position
	if butterfly_current_pos.x - butterfly_last_pos.x<0:
		butterfly_sheet.flip_h = false
	else:
		butterfly_sheet.flip_h = true
	path_follow_2d.progress += delta*100
	butterfly_last_pos = butterfly_current_pos
func _ready() -> void:
	butterfly_last_pos = butterfly_sheet.global_position
	butterfly_anime.play("butterfly_fly")
