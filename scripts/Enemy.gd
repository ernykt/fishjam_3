extends CharacterBody2D

var hungry = true
var in_position = false
const SPEED = 300.0

func _physics_process(delta):
	if position.x > 1100 and not in_position:
		velocity = Vector2(-1, 0) * SPEED
	
	elif position.x <= 1000 or hungry: 
		velocity = Vector2.ZERO
		hungry = false
		in_position = true
		$Timer.start()
		
	move_and_collide(velocity * delta)



func _on_area_2d_body_entered(body):
	if "Fish" in body.name:
		body.queue_free()
		var tween_mod = get_tree().create_tween()
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0, 25), 0.3)
		tween_mod.tween_property(self, "modulate:a", 0, 0.3)
		tween_mod.tween_callback(queue_free)


func _on_timer_timeout():
	$CollisionShape2D.disabled = true
	velocity = Vector2(1, 0) * SPEED
	
