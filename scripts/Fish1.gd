extends CharacterBody2D

@onready var text_box_scene = preload("res://scenes/text_box.tscn")

var dialog_options: Array[String] = ["test", "eren", "doki", "amk neden böyle oluyor"]

var SPEED = 300.0
var text_box
var text_box_position: Vector2

var is_dialog_active = false
var can_advance_line = false

var random_text = randi_range(0, 3)

func _physics_process(delta):
	velocity = Vector2(1, 0) * SPEED
	move_and_collide(velocity * delta)
	if not is_dialog_active:
		start_dialog()

func start_dialog():
	if is_dialog_active:
		return
	
	_show_text_box()
	
	is_dialog_active = true
	
func _show_text_box():
	text_box = text_box_scene.instantiate()
	add_child(text_box)
	text_box.global_position = global_position
	text_box.display_text(dialog_options[random_text])
	

