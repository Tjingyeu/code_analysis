extends PanelContainer

class_name KoiPanel

var graphic_core:GraphicKernel


var can_sell:bool = true
@onready var rarity: RichTextLabel = $koi_panel/MarginContainer/Panel/rarity
@onready var tail: Sprite2D = $koi_panel/MarginContainer/Panel/fish_body/tail
@onready var fish_fin: Sprite2D = $koi_panel/MarginContainer/Panel/fish_body/FishFin
@onready var snake_shape: Line2D = $koi_panel/MarginContainer/Panel/fish_body/snake_shape
@onready var fish_age: RichTextLabel = $koi_panel/MarginContainer/Panel/fish_age
@onready var exp_bar: ProgressBar = $koi_panel/MarginContainer/Panel/progressPanel/exp_bar
@onready var exp_lbl: RichTextLabel = $koi_panel/MarginContainer/Panel/progressPanel/exp_bar/exp_lbl
@onready var lock_btn: Button = $koi_panel/MarginContainer/Panel/lock_btn
@onready var sell_btn: Button = $koi_panel/MarginContainer/Panel/sell_btn
@onready var name_n_price: RichTextLabel = $koi_panel/MarginContainer/Panel/name_n_price

var fish_age_float:float = 0.0
var fish_quality:float = 0.0
var fish_quality_string:String=""

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
	can_sell = !current_snake.locked
	fish_quality = current_snake.fish_quality
	snake_unique_id = current_snake.unique_id
	var snake_name = current_snake.snake_name
	var snake_id = current_snake.snake_id
	if current_snake.adult:
		price_number = GlobalVariables.number_format(current_snake.snake_price*fish_quality/100)
	elif !current_snake.adult:
		price_number = GlobalVariables.number_format(current_snake.snake_price*fish_quality/500)
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
		"Legendary":
			rarity_color_code="[rainbow]"
	rarity.text = "[center]"+rarity_color_code+current_snake.snake_rarity
	snake_shape.texture = load("res://snake_textures/"+str(snake_id)+".png")
	tail.texture = load("res://snake_textures/"+str(snake_id)+"_3"+".png")
	fish_fin.texture = load("res://snake_textures/"+str(snake_id)+"_1"+".png")
	exp_bar.max_value = exp_max
	exp_bar.value = exp_current
	name_n_price.text = "[center][i][b]"+rarity_color_code+snake_name+"-"+str(price_number)+"$"
	fish_quality_string = GlobalVariables.remap_koi_quality(fish_quality)
	if can_sell:
		lock.frame = 1
		shadow_lock.frame = 1
		sell_btn.disabled = false
		#current_snake.locked = false
	elif !can_sell:
		lock.frame = 0
		shadow_lock.frame = 0
		sell_btn.disabled = true
		#current_snake.locked = true
	
func _process(delta: float) -> void:
	refresh_exp()
	animation(delta)
	
func refresh_exp():
	if current_snake != null:
		fish_age_float = current_snake.fish_age
		fish_quality = current_snake.fish_quality
	if !being_sold:
		if current_snake == null:
			return
		else:
			var exp_current:float=current_snake.exp_current
			var exp_max:float=current_snake.exp_max
			exp_bar.max_value = exp_max
			exp_bar.value = exp_current
			fish_age.text = "[center][i][b][font_size=12]Fish Age: " + graphic_core.revert_idle_time(fish_age_float) +" - quality: "+fish_quality_string
			#str(round(fish_quality))
			exp_lbl.set_text("[center]"+str(round(exp_current))+"/"+str(exp_max))
	if current_snake.adult == true:
		set_up_panel(current_snake)

@onready var lock: Sprite2D = $koi_panel/MarginContainer/Panel/lock_btn/Lock
@onready var shadow_lock: Sprite2D = $koi_panel/MarginContainer/Panel/lock_btn/Lock/ShadowLock

func _on_lock_unlock_button_down() -> void:
	if can_sell:
		sell_btn.disabled = true
		can_sell = false
		lock.frame = 0
		shadow_lock.frame = 0
		current_snake.locked = true
	elif !can_sell:
		sell_btn.disabled = false
		can_sell = true
		lock.frame = 1
		shadow_lock.frame = 1
		current_snake.locked = false
	

#@onready var sell: TextureButton = $VBoxContainer/HBoxContainer2/sell

func _on_sell_button_down() -> void:
	sell_btn.disabled = true
	var selling_value = -1
	var the_snake:Snake
	the_snake = current_snake
	being_sold = true
	if current_snake.adult:
		selling_value = float(current_snake.snake_price)*fish_quality/100
	elif !current_snake.adult:
		selling_value = float(current_snake.snake_price)*fish_quality/500
	GlobalVariables.gold_current += selling_value
	the_snake.snake_body.queue_free()
	the_snake.fish_fin.queue_free()
	the_snake.fish_tail.queue_free()
	graphic_core.snakes.erase(the_snake)
	graphic_core.sell_sfx()
	self.queue_free()
	

var t:float
func animation(delta):
	t += delta
	for i in original_points.size():
		snake_shape.points[i].y = original_points[i].y+sin(-t*2.0+(snake_shape.points[i].x)/60.0)*(snake_shape.points[i].x-22.0)/25.0
	#snake_eyes.global_position = (snake_shape.points[1]+snake_shape.points[0])/2+snake_shape.global_position
	fish_fin.global_position = snake_shape.points[3]+snake_shape.global_position
	tail.global_position = snake_shape.points[10]+snake_shape.global_position
	tail.rotation = ((snake_shape.points[10]-snake_shape.points[9]).angle()) - PI/2
