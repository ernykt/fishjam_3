extends Node2D

@onready var cursor = $CursorBody
@onready var board = $ShootMiddle

var border_left = -248
var border_right = 216
var SPEED = 300.0
var right = true
var pos
var pressed = false
var has_tried = false

func _ready():
	pos = to_local(cursor.position)

func _process(_delta):
	if cursor in $ShootMiddle/GoodSpot.get_overlapping_bodies() and pressed and not has_tried:
		print("nice")
	if not pressed:
		pass
		#move_cursor()
	cursor.move_and_slide()
	
func _on_shoot_pressed():
	cursor.velocity = Vector2.ZERO
	pressed = true

func move_cursor():
		if to_local(cursor.position).x <= pos.x + 240 and right:
			cursor.velocity = SPEED * Vector2.RIGHT
		if int(to_local(cursor.position).x) == int(pos.x + 240):
			print(to_local(cursor.position).x)
			right = false
		if not right and to_local(cursor.position).x >= pos.x - 240:
			cursor.velocity = SPEED * Vector2.LEFT
			print("going left")
		if  int(to_local(cursor.position).x) == int(pos.x - 240):
			right = true
