class_name SnakeUnlocked
extends Control

var graphic_core:GraphicKernel

@onready var grid_container: GridContainer = $ScrollContainer/MarginContainer/GridContainer
#@onready var grid_container: GridContainer = $PanelContainer/ScrollContainer/MarginContainer/GridContainer


@onready var timer: Timer = $Timer

var all_children_containers

var original_pos:Vector2

func _ready() -> void:
	graphic_core = get_tree().get_first_node_in_group("main")
	original_pos = global_position
	all_children_containers = grid_container.get_children()
	for i:KoiCard in all_children_containers:
		i.sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	#for i in all_children_containers:
		#i.resizable = false

func _on_timer_timeout() -> void:
	refresh_the_list()

func refresh_the_list():
	for i in all_children_containers.size():
		all_children_containers[i].koi_id = i
		all_children_containers[i].area_code = int(i/6)
		all_children_containers[i].sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
		all_children_containers[i].setup()
	timer.start()

@onready var buttons_effect: AudioStreamPlayer2D = $"../../Camera2D/buttons_effect"

func _on_closing_unlock_button_down() -> void:
	buttons_effect.play()
	hide_unlocked_list()
	timer.stop()
	graphic_core.tween_upgrade_background(true)
	

func show_unlocked_list():
	self.visible = true
	var tween_visual = create_tween()
	var tween_pos = create_tween()
	tween_visual.tween_property(self,"modulate",Color(1,1,1,1),0.25)
	tween_pos.tween_property(self,"position",Vector2(0,60),0.25)
	
func hide_unlocked_list():
	var tween_visual = create_tween()
	var tween_pos = create_tween()
	tween_visual.tween_property(self,"modulate",Color(1,1,1,0),0.25)
	tween_pos.tween_property(self,"position",Vector2(0,4),0.25)
	await tween_pos.finished
	self.visible = false
