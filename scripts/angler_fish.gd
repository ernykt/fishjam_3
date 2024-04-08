extends CharacterBody2D
const BOMB = preload("res://scenes/bomb.tscn")
var health = 1000
const SPEED = 300.0


func _physics_process(delta):
	velocity = SPEED * Vector2.RIGHT

	move_and_collide(velocity * delta)

	if health <= 0:
		var tween_mod = get_tree().create_tween()
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0, 25), 0.3)
		tween_mod.tween_property(self, "modulate:a", 0, 0.3)
		tween_mod.tween_callback(queue_free)
