extends AnimatedSprite2D

func _ready():
	$DestroySparks.start(3)
	Globals.connect("success", destroy_sparks)

func _on_destroy_sparks_timeout():
	self.queue_free()

func destroy_sparks():
	self.queue_free()
