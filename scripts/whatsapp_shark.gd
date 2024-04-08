extends CharacterBody2D

@onready var timer = $PatienceTimer
@onready var patience_bar = $TextureProgressBar
@onready var text_box_scene = preload("res://scenes/text_box.tscn")

var text_box
var SPEED = 300.0
var has_eaten = false
var is_dialog_active = false
var dialog_options = ["was ist app", "wassup", "WAZZUP !"]

func start_dialog():
	if is_dialog_active:
		return
	
	_show_text_box()
	
	is_dialog_active = true
	
func _show_text_box():
	text_box = text_box_scene.instantiate()
	add_child(text_box)
	text_box.global_position.x = global_position.x
	text_box.global_position.y = global_position.y - 24
	text_box.display_text(dialog_options.pick_random())

func _on_area_2d_body_entered(body):
	if "Enemy" in body.name:
		Globals.score -= 100
		$WhatsappSprite.play("attack")
		var tween_mod = get_tree().create_tween()
		var tween = get_tree().create_tween()
		tween.tween_property(body, "position", body.position - Vector2(0, 25), 1)
		tween_mod.tween_property(body, "modulate:a", 0, 1)
		tween_mod.tween_callback(body.queue_free)

func _physics_process(delta):
	velocity = Vector2(1, 0) * SPEED
	move_and_collide(velocity * delta)
	if position.x > 1300:
		self.queue_free()
	if not is_dialog_active:
		start_dialog()

func _on_whatsapp_sprite_animation_changed():
	has_eaten = true

func _on_whatsapp_sprite_animation_finished():
	if has_eaten:
		$WhatsappSprite.play("default")

func _on_patience_timer_timeout():
	patience_bar.value -= 10
	if patience_bar.value <= 0:
		var tween_mod = get_tree().create_tween()
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0, 25), 0.3)
		tween_mod.tween_property(self, "modulate:a", 0, 0.3)
		tween_mod.tween_callback(queue_free)
