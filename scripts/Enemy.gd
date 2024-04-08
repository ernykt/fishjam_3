extends CharacterBody2D

var hungry = true
var in_position = false
const SPEED = 300.0

func _ready():
	$Sprite2D.flip_h = true

func _physics_process(delta):
	if position.x > 900 and not in_position:
		velocity = Vector2.LEFT * SPEED
	if Globals.boss_active:
		self.queue_free()
	
	elif position.x <= 500 or hungry: 
		velocity = Vector2.ZERO
		hungry = false
		in_position = true
		$Timer.start()
		
	move_and_collide(velocity * delta)

func _on_area_2d_body_entered(body):
	if "Fish" in body.name:
		Globals.score += 75
		$Sprite2D.play("attack")
		body.queue_free()
		var tween_mod = get_tree().create_tween()
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0, 25), 1)
		tween_mod.tween_property(self, "modulate:a", 0, 1)
		tween_mod.tween_callback(queue_free)

func _on_timer_timeout():
	$CollisionShape2D.disabled = true
	velocity = Vector2(1, 0) * SPEED
	$Sprite2D.flip_h = false
	var tween_mod = get_tree().create_tween()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position - Vector2(0, 25), 1)
	tween_mod.tween_property(self, "modulate:a", 0, 1)
	tween_mod.tween_callback(queue_free)
