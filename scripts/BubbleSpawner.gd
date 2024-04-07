extends Node2D

@onready var bubble = preload("res://scenes/bubble.tscn")


func _on_timer_timeout():
	var bubble_scene = bubble.instantiate()
	bubble_scene.position.x = randi_range(50, 1100)
	bubble_scene.position.y = 600
	get_tree().root.add_child(bubble_scene)
	
