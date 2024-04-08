extends Node2D
 
@onready var fishes = preload("res://scenes/fish_1.tscn")
@onready var whatsapp_shark = preload("res://scenes/whatsapp_shark.tscn")
@onready var mobs = [fishes, whatsapp_shark]
	
func spawn_fish():
	var fish = mobs.pick_random().instantiate()
	var Ylist = [96, 328, 536]
	fish.position = Vector2(randi_range(0, -300), Ylist.pick_random())
	add_child(fish, true)
	
func _on_timer_timeout():
	if not Globals.boss_active:
		spawn_fish()
		$Timer.start(randf_range(1, 3))

