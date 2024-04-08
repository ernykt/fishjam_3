extends RigidBody2D


@onready var timer = $DestroyTimer

func _ready():
	timer.start(1)

func _on_destroy_timer_timeout():
		var tween_mod = get_tree().create_tween()
		tween_mod.tween_property(self, "modulate:a", 0, 0.3)
		tween_mod.tween_callback(queue_free)


func _on_area_2d_body_entered(body):
		if "Fish" in body.name or "Whatsapp" in body.name:
			Globals.score -= 5
			body.queue_free()
