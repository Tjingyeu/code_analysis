extends Node2D

@onready var tutorial_anim: AnimationPlayer = $Tutorial/tutorial_anim
@onready var tutorial_base: Node2D = $"."
@onready var tutorial: Sprite2D = $Tutorial

func _ready() -> void:
	tutorial.self_modulate = Color(1,1,1,0)

func start() -> void:
	if GlobalVariables.tutorial:
		
		tutorial_base.visible = true
		tutorial_anim.play("tutorial")
		var tween = create_tween()
		tween.tween_property(tutorial,"self_modulate",Color(1,1,1,1),2)
	else:
		tutorial_base.visible = false
	


func _on_graphic_logic_kernel_ui_ready() -> void:
	start()

func tween_01():
	var final_pos:Vector2 = Vector2(446,567)
	var tween = create_tween()
	tween.tween_property(tutorial_base,"position",final_pos,1)
	
func tween_02():
	var final_pos:Vector2 = Vector2(1612,395)
	var tween = create_tween()
	tween.tween_property(tutorial_base,"position",final_pos,1)
	
func tween_03():
	var final_pos:Vector2 = Vector2(955,1000)
	var tween = create_tween()
	tween.tween_property(tutorial_base,"position",final_pos,1)

func tween_04():
	var final_pos:Vector2 = Vector2(955,650)
	var tween = create_tween()
	tween.tween_property(tutorial_base,"position",final_pos,1)
	await tween.finished
	var new_tween = create_tween()
	new_tween.tween_property(tutorial_base,"modulate",Color(1,1,1,0),4)
	await new_tween.finished
	GlobalVariables.tutorial = false
func _on_graphic_logic_kernel_tween_01_btn() -> void:
	tween_01()


func _on_travel_logic_kernel_tween_02_btn() -> void:
	tween_02()


func _on_graphic_logic_kernel_tween_03() -> void:
	tween_03()


func _on_fish_cards_tween_04() -> void:
	tween_04()
