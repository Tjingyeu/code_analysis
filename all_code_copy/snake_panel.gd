extends PanelContainer

#var adult:bool

var graphic_core:GraphicKernel
@onready var rarity: RichTextLabel = $VBoxContainer/rarity
@onready var snake_shape: Line2D = $VBoxContainer/PanelContainer/snake_shape
@onready var fish_fin: Sprite2D = $VBoxContainer/PanelContainer/FishFin

@onready var snake_name_lbl: RichTextLabel = $VBoxContainer/HBoxContainer/snake_name
@onready var lock_unlock: TextureButton = $VBoxContainer/HBoxContainer/lock_unlock
@onready var exp_bar: TextureProgressBar = $VBoxContainer/MarginContainer/exp
@onready var price: RichTextLabel = $VBoxContainer/HBoxContainer2/price
@onready var sell: TextureButton = $VBoxContainer/HBoxContainer2/sell
@onready var exp_lbl: RichTextLabel = $VBoxContainer/MarginContainer/exp_lbl

var being_sold:bool=false

var current_snake:Snake
var snake_unique_id:int = -1
var price_number:String
var original_points:Array
func _ready() -> void:
	graphic_core = get_tree().get_first_node_in_group("main")
	original_points = snake_shape.points
	
func set_up_panel(snake):
	current_snake = snake
	snake_unique_id = current_snake.unique_id
	var snake_name = current_snake.snake_name
	var snake_id = current_snake.snake_id
	if current_snake.adult:
		price_number = GlobalVariables.number_format(current_snake.snake_price)
	elif !current_snake.adult:
		price_number = GlobalVariables.number_format(current_snake.snake_price/5)
	var exp_max = current_snake.exp_max
	var exp_current = current_snake.exp_current
	
	if GlobalVariables.snake_unlocked_register.find(snake_id)==-1:
		snake_name = "????"
	var rarity_color_code:String
	match current_snake.snake_rarity:
		"Common":
			rarity_color_code="[color=#FFEECC]"
		"Rare":
			rarity_color_code="[color=#CCFFEE]"
		"Very Rare":
			rarity_color_code="[color=#EECCFF]"
	rarity.text = "[center]"+rarity_color_code+current_snake.snake_rarity
	snake_shape.texture = load("res://snake_textures/"+str(snake_id)+".png")
	tail.texture = load("res://snake_textures/"+str(snake_id)+"_3"+".png")
	fish_fin.texture = load("res://snake_textures/"+str(snake_id)+"_1"+".png")
	snake_name_lbl.text = "[center]"+rarity_color_code+snake_name
	exp_bar.max_value = exp_max
	exp_bar.value = exp_current
	price.set_text(" "+str(price_number)+"$"+"  ")
	
func _process(delta: float) -> void:
	refresh_exp()
	animation(delta)
	
func refresh_exp():
	if !being_sold:
		if current_snake == null:
			return
		else:
			var exp_current:float=current_snake.exp_current
			var exp_max:float=current_snake.exp_max
			exp_bar.max_value = exp_max
			exp_bar.value = exp_current
			exp_lbl.set_text("[center]"+str(round(exp_current))+"/"+str(exp_max))
	if current_snake.adult == true:
		set_up_panel(current_snake)

func _on_lock_unlock_button_down() -> void:
	if sell.disabled == true:
		sell.disabled = false
	elif sell.disabled == false:
		sell.disabled = true

#@onready var sell: TextureButton = $VBoxContainer/HBoxContainer2/sell

func _on_sell_button_down() -> void:
	sell.disabled = true
	var selling_value = -1
	var the_snake:Snake
	the_snake = current_snake
	being_sold = true
	if current_snake.adult:
		selling_value = float(current_snake.snake_price)
	elif !current_snake.adult:
		selling_value = float(current_snake.snake_price)/5
	GlobalVariables.gold_current += selling_value
	the_snake.snake_body.queue_free()
	the_snake.fish_fin.queue_free()
	the_snake.fish_tail.queue_free()
	graphic_core.snakes.erase(the_snake)
	graphic_core.sell_sfx()
	self.queue_free()
	
@onready var tail: Sprite2D = $VBoxContainer/PanelContainer/tail

var t:float
func animation(delta):
	t += delta
	for i in original_points.size():
		snake_shape.points[i].y = original_points[i].y+sin(-t*2.0+(snake_shape.points[i].x)/60.0)*(snake_shape.points[i].x-22.0)/25.0
	#snake_eyes.global_position = (snake_shape.points[1]+snake_shape.points[0])/2+snake_shape.global_position
	fish_fin.global_position = snake_shape.points[3]+snake_shape.global_position
	tail.global_position = snake_shape.points[10]+snake_shape.global_position
	tail.rotation = ((snake_shape.points[10]-snake_shape.points[9]).angle()) - PI/2
