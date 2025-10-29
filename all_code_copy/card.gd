extends Sprite2D

var direction = Vector2.DOWN
var speed = 15.0
var dest:Vector2 = Vector2(720,720)

var snake_id:int

var card_box:FishCardBox

var color:Color

var one_time:bool
func _ready() -> void:
	card_box = get_tree().get_first_node_in_group("fish_card_box")
	direction = direction.rotated(randf_range(-PI/2,PI/2))
func _physics_process(delta: float) -> void:
	position += direction*speed
	direction = lerp(direction,global_position.direction_to(dest),delta*2)
	if global_position.distance_squared_to(dest)<= 2500:
		if !one_time:
			one_time = true
			card_box.fish_box_array.append(snake_id)
			card_box.fish_box_color_array.append(color)
			var tween = create_tween()
			tween.tween_property(self,"self_modulate",Color(1,1,1,0),0.2)
			await tween.finished
			queue_free()
