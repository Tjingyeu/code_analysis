class_name techButton
extends TextureButton

@onready var panel: Panel = $Panel
@onready var label: Label = $MarginContainer/Label
@onready var line_2d: Line2D = $Line2D

@export var relics_pos:int
@export var cost:=1
@export var max_level:=3
#var root:bool=false

var level:int = 0:
	set(value):
		level = value
		label.text = str(level)+"/"+str(max_level)

func _ready() -> void:
	visible = false
	label.text = str(level)+"/"+str(max_level)
	if get_parent() is techButton:
		line_2d.add_point(global_position + size/2)
		line_2d.add_point(get_parent().global_position + size/2)
		#if get_parent().root == true:
			#visible = true
	else:
		disabled = false
		visible = true
		#root = true
	
func refresh_button():
	if GlobalVariables.diamonds_can_spend >= cost:
		self.disabled = false
	else:
		self.disabled = true
		

func _on_button_down() -> void:
	if GlobalVariables.diamonds_can_spend >= cost and level<max_level:
		GlobalVariables.diamonds_can_spend -= cost
	else:
		return
	refresh_button()
	level = min(level+1,max_level)
	panel.show_behind_parent = true
	GlobalVariables.relics_levels[relics_pos] = level
	for i in get_children():
		if i is techButton:
			i.line_2d.default_color = Color.LIGHT_GREEN
			i.disabled = false
			i.visible = true
	print(GlobalVariables.relics_levels)
	print(GlobalVariables.diamonds_can_spend)
	
