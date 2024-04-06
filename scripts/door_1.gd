extends CharacterBody2D

@onready var door_timer = $DoorCollisionTimer

var can_rotate = true
var in_position = false
var disable_collision = false
var timer : Timer

func _ready():
	timer = Timer.new()
	timer.one_shot = true
	add_child(timer)

func _process(delta):
	$DetectFish.rotation = 0

	if not can_rotate:
		$DoorSprite.rotation -= 1 * delta
	if $DoorSprite.rotation_degrees < -90:
		can_rotate = true
		in_position = true
		#$DoorShape.disabled = false
		if not disable_collision:
			disable_collision = true
			$DoorShape.disabled = true
	if can_rotate and in_position and timer.is_stopped():
		$DoorSprite.rotation += 1 * delta
		disable_collision = false
		$DoorShape.disabled = false
	if $DoorSprite.rotation_degrees >= 0:
		in_position = false
		$Button.disabled = false

func _on_detect_fish_body_entered(body):
	#$DoorShape.set_deferred("disabled", false)
	pass
	
func _on_button_pressed():
	can_rotate = false
	$Button.disabled = true
	timer.start(2)
	
