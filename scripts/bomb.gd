extends RigidBody2D

func ready():
	$AnimatedSprite2D.flip_h = true

func _on_area_2d_body_entered(body):
	if "Whatsapp" in body.name or "Fish" in body.name:
		Globals.score += 50
		$AnimatedSprite2D.play("explode")
		body.queue_free()
		linear_velocity = Vector2.ZERO

func _on_animated_sprite_2d_animation_finished():
	self.queue_free()
