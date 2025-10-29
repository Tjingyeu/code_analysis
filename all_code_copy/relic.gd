extends MarginContainer

var relic_index:int=-1
var relic_level:int = 0
var texture_path:String=""
@onready var texture_rect: TextureRect = $TextureRect

func _ready() -> void:

	if relic_index==-1:
		texture_path = ""
	else:
		texture_path = "res://relics_textures/"+str(relic_index)+".png"
	if load(texture_path)==null:
		texture_path = "res://icon.svg"
	texture_rect.texture = load(texture_path)
	print(texture_path)
