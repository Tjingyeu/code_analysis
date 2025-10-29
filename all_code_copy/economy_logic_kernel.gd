extends Node2D

var main:GraphicKernel
#@onready var buff_gain_visitor_from_snakes: GainVisitorFromSnake = $"../buffs/buff_gain_visitor_from_snakes"
@onready var graphic_logic_kernel: Node2D = $".."
#@onready var vc: Label = $"../CanvasLayer/PanelContainer/MarginContainer/VBoxContainer/vc"
@onready var tp: RichTextLabel = $"../CanvasLayer/PanelContainer/MarginContainer/VBoxContainer/tp"
@onready var gpm: RichTextLabel = $"../CanvasLayer/PanelContainer/MarginContainer/VBoxContainer/gpm"
@onready var gold: Label = $"../CanvasLayer/TextureRect/HBoxContainer/MarginContainer/Gold"
#@onready var diamond: Label = $"../CanvasLayer/TextureRect/HBoxContainer/MarginContainer3/diamond"

var actual_visitor_count:=0.0

func _ready() -> void:
	main=get_tree().get_first_node_in_group("main")
	
func _on_graphic_logic_kernel_snake_kiss(p1,p2) -> void:
	p1.exp_current += GlobalVariables.snake_kiss_exp_gain
	p2.exp_current += GlobalVariables.snake_kiss_exp_gain

func _process(delta: float) -> void:
	var gpv := 0.0
	for i in graphic_logic_kernel.snakes:
		gpv+=i.passive_income
	
	actual_visitor_count = GlobalVariables.visitorsPerMin 
	
	GlobalVariables.gold_current += (GlobalVariables.visitorsPerMin/60*gpv*delta)
	
	match main.local_pond_index:
		0:
			tp.text = str(graphic_logic_kernel.snakes.size())+"/"+str(GlobalVariables.tank_size[GlobalVariables.tank_size_lvl0])
		1:
			tp.text = str(graphic_logic_kernel.snakes.size())+"/"+str(GlobalVariables.tank_size[GlobalVariables.tank_size_lvl1])
		2:
			tp.text = str(graphic_logic_kernel.snakes.size())+"/"+str(GlobalVariables.tank_size[GlobalVariables.tank_size_lvl2])
	var new_gpv = gpv*GlobalVariables.visitorsPerMin
	gpm.text = str(GlobalVariables.number_format(new_gpv)," ","¥/Min")
	
	if GlobalVariables.mouse_is_dragging:
		tp.text = "[rainbow][wave]Drag to Here"
		gpm.text = "[rainbow][wave]To Sell"
	#print(str(GlobalVariables.number_format(GlobalVariables.gold_current))+" "+"$")
	gold.text = str(GlobalVariables.number_format(GlobalVariables.gold_current))+" "+"¥"
	#diamond.text = str(GlobalVariables.number_format(GlobalVariables.diamonds_current)+" "+"*")
