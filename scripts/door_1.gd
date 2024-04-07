extends CharacterBody2D

@onready var door_timer = $DoorCollisionTimer
@onready var missile = preload("res://scenes/bomb.tscn")
@onready var minigame = preload("res://scenes/mini_game.tscn")
const laserdo = preload("res://scenes/laserdo.tscn")

var Ylist = [96, 328, 536]
var can_rotate = true
var in_position = false
var disable_collision = false
var timer : Timer
var on_cooldown = false
var chance_to_break
var is_broken = false
var laser_cooldown = false

func _ready():
	timer = Timer.new()
	timer.one_shot = true
	add_child(timer)

func _process(delta):
	#var chance_to_break = randi_range(1, 100)
	$DetectFish.rotation = 0

	if not can_rotate:
		$DoorSprite.rotation -= 1.5 * delta
	if $DoorSprite.rotation_degrees < -90:
		can_rotate = true
		in_position = true
		#$DoorShape.disabled = false
		if not disable_collision:
			disable_collision = true
			$DoorShape.disabled = true
	if can_rotate and in_position and timer.is_stopped():
		$DoorSprite.rotation += 1.5 * delta
		disable_collision = false
		$DoorShape.disabled = false
	if $DoorSprite.rotation_degrees >= 0:
		in_position = false
		$Button.disabled = false
	if on_cooldown:
		$Button3.text = str(int($Button3/BombCooldown.time_left))
	if laser_cooldown:
		$Button2.text = str(int($Button2/LaserCooldown.time_left))
		
		
func _on_detect_fish_body_entered(body):
	if "Fish" in body.name:
		Globals.score += 10
	
func _on_button_pressed():
	can_rotate = false
	$Button.disabled = true
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
		
func shoot_laser():
	var laser_instance = laserdo.instantiate()
	laser_instance.position.y = self.position.y + 100
	get_tree().root.add_child(laser_instance)
	laser_cooldown = false
	
func _on_button_2_pressed():
	if $Button2/LaserCooldown.is_stopped():
		shoot_laser()
		$Button2/LaserCooldown.start(15)
		laser_cooldown = true
	


func _on_laser_cooldown_timeout():
	laser_cooldown = false
	$Button3.text = ""
