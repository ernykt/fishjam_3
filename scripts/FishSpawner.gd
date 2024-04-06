extends Node2D
 
@onready var fishes = preload("res://scenes/fish_1.tscn")

func _ready():
	$Timer.start(randf_range(5,7))

func spawn_fish():
	var fish = fishes.instantiate()
	var Ylist = [96, 328, 536]
	fish.position = Vector2(0, Ylist.pick_random())
	add_child(fish, true)
	

func _on_timer_timeout():
	spawn_fish()
	$Timer.start(randf_range(5, 10))

