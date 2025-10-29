extends GPUParticles2D
@onready var snake_kiss_particles: GPUParticles2D = $"."
@onready var queue_free_timer: Timer = $queue_free_timer


func emit():
	snake_kiss_particles.emitting = true


func _on_finished() -> void:
	queue_free_timer.start()


func _on_queue_free_timer_timeout() -> void:
	queue_free()
