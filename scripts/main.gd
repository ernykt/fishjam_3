extends Node2D

@onready var score_text = $Score
@onready var minigame = preload("res://scenes/mini_game.tscn")

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
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
