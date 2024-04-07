extends Node2D


func _on_timer_timeout():
	var tween_mod = get_tree().create_tween()
	tween_mod.tween_property(self, "modulate:a", 0, 2)
	tween_mod.tween_callback(queue_free)
	
	


func _on_area_2d_body_entered(body):
	if "Whatsapp" in body.name or "Fish" in body.name:
		Globals.score += 50
		body.queue_free()


