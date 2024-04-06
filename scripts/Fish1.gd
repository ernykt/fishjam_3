extends CharacterBody2D

@onready var text_box_scene = preload("res://scenes/text_box.tscn")
@onready var progress_bar = $TextureProgressBar

var dialog_options: Array[String] = ["test", "eren", "doki", "neden böyle oluyor"]

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
	



func _on_progress_timer_timeout():
	progress_bar.value -= 10
	if progress_bar.value <= 0:
		var tween_mod = get_tree().create_tween()
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0, 25), 0.3)
		tween_mod.tween_property(self, "modulate:a", 0, 0.3)
		tween_mod.tween_callback(queue_free)
