extends Node2D

@onready var score_text = $Score

func _process(_delta):
	score_text.text = str(Globals.score)
