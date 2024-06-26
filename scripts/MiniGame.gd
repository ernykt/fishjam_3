extends Node2D

@onready var cursor = $CursorBody
@onready var board = $ShootMiddle

var SPEED = 300.0
var right = true
var pos
var pressed = false
var hit = false

func _ready():
	cursor.velocity = SPEED * Vector2.RIGHT
	pos = to_local(cursor.position)
	$Disappear.start(3)

func _process(_delta):
	if cursor in $ShootMiddle/GoodSpot.get_overlapping_bodies() and pressed and not hit:
		Globals.score += 50
		hit = true
		Globals.emit_signal("success")
		board.visible = false
		cursor.visible = false
		$Label.visible = true
		$Shoot.visible = false
		$Disappear.stop()
		$Label/Timer.start(1)
	if pressed and cursor not in $ShootMiddle/GoodSpot.get_overlapping_bodies():
		Globals.score -= 30
		Globals.emit_signal("punishment")
		self.queue_free()
	cursor.move_and_slide()
	
func _on_shoot_pressed():
	cursor.velocity = Vector2.ZERO
	pressed = true

#func move_cursor():
		#if to_local(cursor.position).x <= pos.x + 120 and right:
			#cursor.velocity = SPEED * Vector2.RIGHT
		#if int(to_local(cursor.position).x) == int(pos.x + 120):
			#right = false
		#if not right and to_local(cursor.position).x >= pos.x - 120:
			#cursor.velocity = SPEED * Vector2.LEFT
		#if  int(to_local(cursor.position).x) == int(pos.x - 120):
			#right = true
			
func _on_disappear_timeout():
	Globals.emit_signal("punishment")
	self.queue_free()

func _on_right_body_entered(_body):
	cursor.velocity = -cursor.velocity

func _on_left_body_entered(_body):
	cursor.velocity = -cursor.velocity

func _on_timer_timeout():
	self.queue_free()
