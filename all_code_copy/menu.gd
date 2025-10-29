class_name Menu
extends PanelContainer

@onready var menu: PanelContainer = $"."
@onready var upgrade_background: ColorRect = $"../upgrade_background"
@onready var graphic_logic_kernel: GraphicKernel = $"../.."
@onready var delete_sure: Control = $"../delete_sure"

func _on_resume_button_down() -> void:
	graphic_logic_kernel._on_resume_button_button_down()

@onready var master: HSlider = $VBoxContainer/HBoxContainer/MarginContainer/Master
@onready var bgm: HSlider = $VBoxContainer/HBoxContainer2/MarginContainer/BGM
@onready var sfx: HSlider = $VBoxContainer/HBoxContainer6/MarginContainer/SFX
@onready var effects: HSlider = $VBoxContainer/HBoxContainer9/MarginContainer/Effects


@onready var borderless: CheckButton = $VBoxContainer/HBoxContainer7/MarginContainer/Borderless


#@export var bus_name: String
var bus_index_master:int
var bus_index_bgm:int
var bus_index_water:int
var bus_index_effects:int

func _ready() -> void:
	bus_index_master = AudioServer.get_bus_index("Master")
	bus_index_bgm = AudioServer.get_bus_index("bgm")
	bus_index_water = AudioServer.get_bus_index("water")
	bus_index_effects = AudioServer.get_bus_index("effects")

func start_game():
	master.value = GlobalVariables.master_volume
	bgm.value = GlobalVariables.music_volume
	sfx.value = GlobalVariables.water_volume
	effects.value = GlobalVariables.effects_volume
	#_on_master_value_changed(GlobalVariables.master_volume)
	#_on_bgm_value_changed(GlobalVariables.music_volume)
	#_on_sfx_value_changed(GlobalVariables.water_volume)
	#_on_effects_value_changed(GlobalVariables.effects_volume)

func _on_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(bus_index_master,value)


func _on_bgm_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(bus_index_bgm,value)
	#GlobalVariables.master_volume = value

func _on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(bus_index_water,value)
	#GlobalVariables.water_volume = value

func _on_borderless_toggled(toggled_on: bool) -> void:
	if toggled_on:
		GlobalVariables.closed_boundary = false
	elif !toggled_on:
		GlobalVariables.closed_boundary = true

@onready var transition: Transition = $"../../Camera2D/CanvasLayer/transition"

func _on_quit_button_button_up() -> void:
	get_tree().quit()


func _on_reset_data_pressed() -> void:
	delete_sure.visible = true
	var tween = create_tween()
	tween.tween_property(delete_sure,"modulate",Color(1,1,1,1),0.3)
	menu.visible = false


func _on_effects_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(bus_index_effects,value)
	#GlobalVariables.effects_volume = value


func _on_transition_quit_game() -> void:
	graphic_logic_kernel.game_end()


func _on_close_button_down() -> void:
	var tween = create_tween()
	tween.tween_property(delete_sure,"modulate",Color(1,1,1,0),0.3)
	await tween.finished
	delete_sure.visible = false
	menu.visible = true

@onready var snakes_list_manager: Node2D = $"../../Snakes_list_manager"
func _on_unlock_sure_button_down() -> void:
	snakes_list_manager.sell_all()
	GlobalVariables.gold_current = GlobalVariables.starting_gold
	SaveAndLoad.erase_save()
	GlobalVariables.reset_values()
	get_tree().reload_current_scene()
