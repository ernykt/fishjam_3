extends Node2D

@onready var squid = preload("res://scenes/squid.tscn")
var exposition = [-100, 1200]
func _on_timer_timeout():
	var squid_scene = squid.instantiate()
	squid_scene.position.y = randi_range(50, 600)
	squid_scene.position.x = exposition.pick_random()
	get_tree().root.add_child(squid_scene)
	
