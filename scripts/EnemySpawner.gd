extends Node2D
@onready var enemy = preload("res://scenes/enemy.tscn")

func spawn_enemy():
	var e = enemy.instantiate()
	var Ylist = [96, 328, 536]
	e.position = Vector2(1400, Ylist.pick_random())
	add_child(e)


func _on_timer_timeout():
	spawn_enemy()
	
