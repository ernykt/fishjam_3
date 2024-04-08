extends Node2D

@onready var score_text = $Score
@onready var minigame = preload("res://scenes/mini_game.tscn")
@onready var angler_fish = preload("res://scenes/angler_fish.tscn")

var angler_scene

func _ready():
	Globals.connect("broken",start_minigame)

func _process(_delta):
	score_text.text = "score: " + str(Globals.score)
	$TimeLabel.text = "Time: " + str(int($TimeRemaining.time_left))
func start_minigame(pos):
	var minigame_scene = minigame.instantiate()
	minigame_scene.position.x = pos.x
	minigame_scene.position.y = pos.y + 24
	add_child(minigame_scene)

func _on_time_remaining_timeout():
	Globals.boss_active = true
	spawn_boss()
	
func spawn_boss():
	angler_scene = angler_fish.instantiate()
	angler_scene.position = Vector2(-500, 324)
	add_child(angler_scene)

func _on_area_2d_body_entered(body):
	if "Angler" in body.name:
		body.queue_free()
