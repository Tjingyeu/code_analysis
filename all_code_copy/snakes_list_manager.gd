
extends Node2D

enum SnakeFilter {
	ALL=0,
	ADULT=1,
	CHILDREN=2
}

enum KoiTierFilter {
	ALL=0,
	COMMON=1,
	RARE=2,
	VERYRARE=3,
	LEGENDARY=4,
}

var current_filter_key
var current_tier_key

#@onready var snake_filter: TextureButton = $"../CanvasLayer/Snakes_list/SnakeFilter"
#@onready var snake_filter_lbl: Label = $"../CanvasLayer/Snakes_list/SnakeFilter/snakeFilter_lbl"

@onready var koi_filter: Button = $"../CanvasLayer/Snakes_list/koiFilter"
@onready var koi_filter_lbl: RichTextLabel = $"../CanvasLayer/Snakes_list/koiFilter/koiFilter_lbl"


@onready var graphic_logic_kernel: GraphicKernel = $".."
@onready var snakes_list: Control = $"../CanvasLayer/Snakes_list"
var origin:Vector2
#@onready var grid_container: GridContainer = $"../CanvasLayer/Snakes_list/PanelContainer/GridContainer"
const SNAKE_PANEL = preload("res://koi_panel/koi_panel.tscn")
#@onready var grid_container: GridContainer = $"../CanvasLayer/Snakes_list/PanelContainer/ScrollContainer/GridContainer"
@onready var grid_container: GridContainer = $"../CanvasLayer/Snakes_list/PanelContainer/MarginContainer/ScrollContainer/GridContainer"

func _ready() -> void:
	origin = snakes_list.global_position
	current_filter_key = SnakeFilter.ALL
	current_tier_key = KoiTierFilter.ALL
	koi_filter_lbl.text = "[center][b][font_size=32]Current Filter: ALL"
	tier_filter_lbl.text = "[center][b][font_size=32]Tier: ALL"
@onready var koi_button: TextureButton = $"../CanvasLayer/TextureRect/HBoxContainer/MarginContainer4/KoiButton"

func _on_snakes_button_button_down() -> void:
	var tween = create_tween()
	tween.tween_property(koi_button,"scale",Vector2(0.95,0.97),0.1)
	buttons_effect.play()
	#var new_tween = create_tween()
	#new_tween.tween_property(snakes_list,"global_position",Vector2(960,544),0.1)
	refresh_the_list(current_filter_key,current_tier_key)
	show_fish_list()
	graphic_logic_kernel.tween_upgrade_background(false)
	
	
func show_fish_list():
	snakes_list.visible = true
	var tween_visual = create_tween()
	var tween_pos = create_tween()
	tween_visual.tween_property(snakes_list,"modulate",Color(1,1,1,1),0.25)
	tween_pos.tween_property(snakes_list,"position",Vector2(960,600),0.25)
	
func hide_fish_list():
	var tween_visual = create_tween()
	var tween_pos = create_tween()
	tween_visual.tween_property(snakes_list,"modulate",Color(1,1,1,0),0.25)
	tween_pos.tween_property(snakes_list,"position",Vector2(960,544),0.25)
	await tween_pos.finished
	snakes_list.visible = false
	
func refresh_the_list(switch,tier):
	for i in grid_container.get_children():
		i.queue_free()
	match switch:
		0:
			match tier:
				0:
					for i in graphic_logic_kernel.snakes.size():
						var new_snake_panel = SNAKE_PANEL.instantiate()
						grid_container.add_child(new_snake_panel)
						new_snake_panel.set_up_panel(graphic_logic_kernel.snakes[i])
				1:
					for i in graphic_logic_kernel.snakes.size():
						if graphic_logic_kernel.snakes[i].snake_rarity == "Common":
							var new_snake_panel = SNAKE_PANEL.instantiate()
							grid_container.add_child(new_snake_panel)
							new_snake_panel.set_up_panel(graphic_logic_kernel.snakes[i])
				2:
					for i in graphic_logic_kernel.snakes.size():
						if graphic_logic_kernel.snakes[i].snake_rarity == "Rare":
							var new_snake_panel = SNAKE_PANEL.instantiate()
							grid_container.add_child(new_snake_panel)
							new_snake_panel.set_up_panel(graphic_logic_kernel.snakes[i])
				3:
					for i in graphic_logic_kernel.snakes.size():
						if graphic_logic_kernel.snakes[i].snake_rarity == "Very Rare":
							var new_snake_panel = SNAKE_PANEL.instantiate()
							grid_container.add_child(new_snake_panel)
							new_snake_panel.set_up_panel(graphic_logic_kernel.snakes[i])
				4:
					for i in graphic_logic_kernel.snakes.size():
						if graphic_logic_kernel.snakes[i].snake_rarity == "Legendary":
							var new_snake_panel = SNAKE_PANEL.instantiate()
							grid_container.add_child(new_snake_panel)
							new_snake_panel.set_up_panel(graphic_logic_kernel.snakes[i])
		1:
			match tier:
				0:
					for i in graphic_logic_kernel.snakes.size():
						if graphic_logic_kernel.snakes[i].adult:
							var new_snake_panel = SNAKE_PANEL.instantiate()
							grid_container.add_child(new_snake_panel)
							new_snake_panel.set_up_panel(graphic_logic_kernel.snakes[i])
				1:
					for i in graphic_logic_kernel.snakes.size():
						if graphic_logic_kernel.snakes[i].adult and graphic_logic_kernel.snakes[i].snake_rarity == "Common":
							var new_snake_panel = SNAKE_PANEL.instantiate()
							grid_container.add_child(new_snake_panel)
							new_snake_panel.set_up_panel(graphic_logic_kernel.snakes[i])
				2:
					for i in graphic_logic_kernel.snakes.size():
						if graphic_logic_kernel.snakes[i].adult and graphic_logic_kernel.snakes[i].snake_rarity == "Rare":
							var new_snake_panel = SNAKE_PANEL.instantiate()
							grid_container.add_child(new_snake_panel)
							new_snake_panel.set_up_panel(graphic_logic_kernel.snakes[i])
				3:
					for i in graphic_logic_kernel.snakes.size():
						if graphic_logic_kernel.snakes[i].adult and graphic_logic_kernel.snakes[i].snake_rarity == "Very Rare":
							var new_snake_panel = SNAKE_PANEL.instantiate()
							grid_container.add_child(new_snake_panel)
							new_snake_panel.set_up_panel(graphic_logic_kernel.snakes[i])
				4:
					for i in graphic_logic_kernel.snakes.size():
						if graphic_logic_kernel.snakes[i].adult and graphic_logic_kernel.snakes[i].snake_rarity == "Legendary":
							var new_snake_panel = SNAKE_PANEL.instantiate()
							grid_container.add_child(new_snake_panel)
							new_snake_panel.set_up_panel(graphic_logic_kernel.snakes[i])
		2:
			match tier:
				0:
					for i in graphic_logic_kernel.snakes.size():
						if !graphic_logic_kernel.snakes[i].adult:
							var new_snake_panel = SNAKE_PANEL.instantiate()
							grid_container.add_child(new_snake_panel)
							new_snake_panel.set_up_panel(graphic_logic_kernel.snakes[i])
				1:
					for i in graphic_logic_kernel.snakes.size():
						if !graphic_logic_kernel.snakes[i].adult and graphic_logic_kernel.snakes[i].snake_rarity == "Common":
							var new_snake_panel = SNAKE_PANEL.instantiate()
							grid_container.add_child(new_snake_panel)
							new_snake_panel.set_up_panel(graphic_logic_kernel.snakes[i])
				2:
					for i in graphic_logic_kernel.snakes.size():
						if !graphic_logic_kernel.snakes[i].adult and graphic_logic_kernel.snakes[i].snake_rarity == "Rare":
							var new_snake_panel = SNAKE_PANEL.instantiate()
							grid_container.add_child(new_snake_panel)
							new_snake_panel.set_up_panel(graphic_logic_kernel.snakes[i])
				3:
					for i in graphic_logic_kernel.snakes.size():
						if !graphic_logic_kernel.snakes[i].adult and graphic_logic_kernel.snakes[i].snake_rarity == "Very Rare":
							var new_snake_panel = SNAKE_PANEL.instantiate()
							grid_container.add_child(new_snake_panel)
							new_snake_panel.set_up_panel(graphic_logic_kernel.snakes[i])
				4:
					for i in graphic_logic_kernel.snakes.size():
						if !graphic_logic_kernel.snakes[i].adult and graphic_logic_kernel.snakes[i].snake_rarity == "Legendary":
							var new_snake_panel = SNAKE_PANEL.instantiate()
							grid_container.add_child(new_snake_panel)
							new_snake_panel.set_up_panel(graphic_logic_kernel.snakes[i])



func _on_closing_button_down() -> void:
	#var new_tween = create_tween()
	#new_tween.tween_property(snakes_list,"global_position",origin,0.1)
	buttons_effect.play()
	hide_fish_list()
	graphic_logic_kernel.tween_upgrade_background(true)

#@onready var koi_filter_lbl: RichTextLabel = $"../CanvasLayer/Snakes_list/koiFilter/koiFilter_lbl"
func _on_snake_filter_button_down() -> void:
	if current_filter_key == SnakeFilter.ALL:
		current_filter_key = SnakeFilter.ADULT
		koi_filter_lbl.text = "[center][b][font_size=32]Current Filter: ADULT"
	elif current_filter_key == SnakeFilter.ADULT:
		current_filter_key = SnakeFilter.CHILDREN
		koi_filter_lbl.text = "[center][b][font_size=32]Current Filter: BABY"
	elif current_filter_key == SnakeFilter.CHILDREN:
		current_filter_key = SnakeFilter.ALL
		koi_filter_lbl.text = "[center][b][font_size=32]Current Filter: ALL"
	refresh_the_list(current_filter_key,current_tier_key)

@onready var tier_filter_lbl: RichTextLabel = $"../CanvasLayer/Snakes_list/koiFilter2/tierFilter_lbl"

func _on_sell_all_button_down() -> void:
	for i:KoiPanel in grid_container.get_children():
		for j in graphic_logic_kernel.snakes:
			if i.snake_unique_id == j.unique_id and i.can_sell == true and j.adult == true:
				i._on_sell_button_down()
				
func sell_all():
	for i:KoiPanel in grid_container.get_children():
		for j in graphic_logic_kernel.snakes:
			if i.snake_unique_id == j.unique_id:
				i._on_sell_button_down()
	print("sold_all")


@onready var snake_unlock_list: SnakeUnlocked = $"../CanvasLayer/Snake_unlock_list"

@onready var buttons_effect: AudioStreamPlayer2D = $"../Camera2D/buttons_effect"
func _on_texture_button_2_button_down() -> void:
	buttons_effect.play()
	snake_unlock_list.show_unlocked_list()
	snake_unlock_list.refresh_the_list()
	graphic_logic_kernel.tween_upgrade_background(false)


func _on_koi_filter_2_button_up() -> void:
	if current_tier_key == KoiTierFilter.ALL:
		current_tier_key = KoiTierFilter.COMMON
		tier_filter_lbl.text = "[center][b][font_size=32]Tier: COMMON"
	elif current_tier_key == KoiTierFilter.COMMON:
		current_tier_key = KoiTierFilter.RARE
		tier_filter_lbl.text = "[center][b][font_size=32]Tier: RARE"
	elif current_tier_key == KoiTierFilter.RARE:
		current_tier_key = KoiTierFilter.VERYRARE
		tier_filter_lbl.text = "[center][b][font_size=32]Tier: VERY RARE"
	elif current_tier_key == KoiTierFilter.VERYRARE:
		current_tier_key = KoiTierFilter.LEGENDARY
		tier_filter_lbl.text = "[center][b][font_size=32]Tier: [rainbow]LEGENDARY"
	elif current_tier_key == KoiTierFilter.LEGENDARY:
		current_tier_key = KoiTierFilter.ALL
		tier_filter_lbl.text = "[center][b][font_size=32]Tier: ALL"

	refresh_the_list(current_filter_key,current_tier_key)
