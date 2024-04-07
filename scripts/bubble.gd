extends AnimatedSprite2D

var SPEED = 300

var random = randf_range(150, 300)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= random * delta

func _on_animation_finished():
	queue_free()
