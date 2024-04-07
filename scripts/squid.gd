extends AnimatedSprite2D


var SPEED = 300
var right = true
var random_y = randf_range(150, 300)
var random_x = randi_range(100, 900)

func _ready():
	if move_direction(position.x) == false:
		right = false

func _process(delta):
	if right:
		position.x += 100 * delta
	if not right:
		flip_h = true
		position.x -= 100 * delta
	if position.x == -50 && 1500:
		queue_free()
		
func move_direction(spawn):
	if spawn < 0:
		return true
	return false
