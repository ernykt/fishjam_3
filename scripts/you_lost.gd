extends Control

@onready var score = $Score

func _ready():
	$Score.text = ""

func _process(delta):
	$Score.text = "score: " + str(Globals.score)

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_quit_pressed():
	get_tree().quit()
