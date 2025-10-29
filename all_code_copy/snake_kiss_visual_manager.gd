extends Node2D


const SNAKE_KISS_PARTICLES = preload("res://snake_kiss/snake_kiss_particles.tscn")


	
func spawn_particles(pos:Vector2):
		#var new_color = Color(randf_range(0.7,1),randf_range(0.7,1),randf_range(0.7,1),1)
		var new_color = Color.from_hsv(randf_range(0.0,1.0),0.9,1.0,1.0)
		var new_snake_visual = SNAKE_KISS_PARTICLES.instantiate()
		new_snake_visual.global_position = pos
		new_snake_visual.self_modulate = new_color
		self.add_child(new_snake_visual)
		new_snake_visual.emit()


func _on_graphic_logic_kernel_snake_kiss_pos(pos) -> void:
	spawn_particles(pos)
