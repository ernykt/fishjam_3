extends CharacterBody2D

@onready var door_timer = $DoorCollisionTimer
@onready var missile = preload("res://scenes/bomb.tscn")
@onready var minigame = preload("res://scenes/mini_game.tscn")
@onready var spark = preload("res://scenes/sparks.tscn")
@onready var own_button = $Button
@onready var laser_scene = preload("res://scenes/laser.tscn")
@onready var laser_cooldown = $LaserButton/LaserButtonCooldown

var can_rotate = true
var in_position = false
var disable_collision = false
var on_cooldown = false
var is_broken = false
var laser_on_cooldown = false
var chance_to_break
var sparks_scene
var timer : Timer

func _ready():
	Globals.connect("punishment", apply_punishment)
	Globals.connect("success", no_punishment)
	timer = Timer.new()
	timer.one_shot = true
	add_child(timer)

func _process(delta):
	if chance_to_break == 5:
		spark_generator()
		print("broken")
		chance_to_break = -1
		own_button.disabled = true
		is_broken = true
		Globals.emit_signal("broken",position)
	if not is_broken:
		if not can_rotate:
			$DoorSprite.rotation -= 1.5 * delta
		if $DoorSprite.rotation_degrees < -90:
			can_rotate = true
			in_position = true
			if not disable_collision:
				disable_collision = true
				$DoorShape.disabled = true
		if can_rotate and in_position and timer.is_stopped():
			$DoorSprite.rotation += 1.5 * delta
			disable_collision = false
			$DoorShape.disabled = false
		if $DoorSprite.rotation_degrees >= 0:
			in_position = false
			own_button.disabled = false
		if on_cooldown:
			$Button3.text = str(int($Button3/BombCooldown.time_left))
		if laser_on_cooldown:
			$LaserButton.text = str(int($LaserButton/LaserButtonCooldown.time_left))
		if not laser_on_cooldown:
			$LaserButton.text = ""
			
func spark_generator():
	sparks_scene = spark.instantiate()
	sparks_scene.position.x = global_position.x - 800
	sparks_scene.position.y = global_position.y - 24
	add_child(sparks_scene)
		
func _on_detect_fish_body_entered(body):
	if "Fish" in body.name or "Whatsapp" in body.name:
		Globals.score -= 15
		var tween_mod = get_tree().create_tween()
		var tween = get_tree().create_tween()
		tween.tween_property(body, "position", body.position - Vector2(0, 25), 0.3)
		tween_mod.tween_property(body, "modulate:a", 0, 0.3)
		tween_mod.tween_callback(body.queue_free)

func _on_button_pressed():
	can_rotate = false
	own_button.disabled = true
	timer.start(2)
	
func shoot():
	var missile_instance = missile.instantiate()
	missile_instance.position.x = self.position.x
	missile_instance.position.y = self.position.y + 100
	missile_instance.apply_impulse(Vector2(-300, 0))
	get_tree().root.add_child(missile_instance)

func _on_bomb_cooldown_timeout():
	on_cooldown = false
	$Button3.text = ""
	
func _on_button_3_pressed():
	if $Button3/BombCooldown.is_stopped():
		shoot()
		$Button3/BombCooldown.start(3)
		on_cooldown = true

func _on_fault_timer_timeout():
	if not is_broken:
		chance_to_break = randi_range(1,25)
		
func apply_punishment():
	if is_broken:
		if Globals.boss_active:
			var tween_mod = get_tree().create_tween()
			var tween = get_tree().create_tween()
			tween.tween_property(self, "position", position - Vector2(0, 25), 0.3)
			tween_mod.tween_property(self, "modulate:a", 0, 0.3)
			tween_mod.tween_callback(queue_free)
		print("punishment")
		own_button.disabled = true
		$PunishmentTimer.start(3)

func _on_punishment_timer_timeout():
	print("working")
	is_broken = false
	own_button.disabled = false
	
func no_punishment():
	own_button.disabled = false
	is_broken = false

func _on_laser_button_pressed():
	if laser_cooldown.is_stopped():
		shoot_laser()
		$LaserButton/LaserButtonCooldown.start(3)
		laser_on_cooldown = true
		Globals.camera.shake(1,5)
	
func shoot_laser():
	var laser_instance = laser_scene.instantiate()
	laser_instance.position.x = global_position.x
	laser_instance.position.y = global_position.y + 100
	get_tree().root.add_child(laser_instance)

func _on_laser_button_cooldown_timeout():
	laser_on_cooldown = false
