extends Node2D

export var metalCollected = 5
export (PackedScene) var explosion

var state = "open"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func _on_Area2D_body_entered(body):
	if body.is_in_group("m_asteroid") and state == "open":
		$AnimatedSprite.animation = "close"
		$resource.play()
		state = "close"
		get_parent().metal += 10
		get_parent().carbon += 6
		get_parent().score += 10
		body.get_parent().destroyAsteroid()
	elif body.is_in_group("c_asteroid") or state == "close":
		get_parent().playHitFX()
		var new = explosion.instance()
		get_parent().add_child(new)
		new.position = position
		new.rotation_degrees = rotation_degrees
		body.get_parent().destroyAsteroid()
		queue_free()
	pass # Replace with function body.
