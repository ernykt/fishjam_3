extends Camera2D

@onready var timer = $Timer

var shake_amount = 0
var default_offset = offset

func _ready():
	Globals.camera = self
	set_process(false)
	randomize()
	
func _process(delta):
	offset = Vector2(randi_range(-1, 1) * shake_amount, randi_range(-1, 1) * shake_amount)

func shake(time, amount):
	timer.wait_time = time
	shake_amount = amount
	set_process(true)
	timer.start()

func _on_timer_timeout():
	set_process(false)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "offset", default_offset, 0.1)
