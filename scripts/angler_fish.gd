extends CharacterBody2D

@onready var lanes = [$TopLane, $MidLane, $BotLane]
@onready var marker = $HitMarker

var health = 1000
var is_active = false
var activated_lane
var active_lane_pos

var SPEED = 50.0

func _ready():
	marker.visible = false
	for lane in lanes:
		lane.disabled = true

func _physics_process(delta):
	if not is_active and $SpawnProtection.is_stopped():
		activated_lane = lanes.pick_random()
		activated_lane.disabled = false
		is_active = true
		
	if activated_lane:
		active_lane_pos = activated_lane.global_position
		marker.global_position = active_lane_pos
		marker.visible = true
		
	velocity = SPEED * Vector2.RIGHT
	
	move_and_collide(velocity * delta)

	if health <= 0:
		Globals.score += 1000
		var tween_mod = get_tree().create_tween()
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0, 25), 0.3)
		tween_mod.tween_property(self, "modulate:a", 0, 0.3)
		tween_mod.tween_callback(queue_free)
		get_tree().change_scene_to_file("res://scenes/you_won.tscn")
		
	if Globals.door_count == 0:
		get_tree().change_scene_to_file("res://scenes/you_lost.tscn")

func _on_pick_lane_timeout():
	if activated_lane:
		activated_lane.disabled = true
		is_active = false
		marker.visible = false

