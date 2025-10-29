extends GPUParticles2D


@onready var self_destruction: Timer = $self_destruction

func emit():
	emitting = true


func _on_self_destruction_timeout() -> void:
	queue_free()


func _on_finished() -> void:
	self_destruction.start()
