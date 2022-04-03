extends "res://Scripts/Asteroid.gd"

func _ready():
	randomize()
	var i = randi() % 3
	var a = $KinematicBody2D/AnimatedSprite.frames.get_animation_names()
	$KinematicBody2D/AnimatedSprite.animation = a[i]
	pass # Replace with function body.

func destroyAsteroid():
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
