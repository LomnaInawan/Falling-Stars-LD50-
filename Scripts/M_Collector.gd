extends Node2D

export var metalCollected = 5
export (PackedScene) var explosion

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func _on_Area2D_body_entered(body):
	if body.is_in_group("m_asteroid"):
		$AnimatedSprite.animation = "close"
		get_parent().metal += 5
		body.get_parent().destroyAsteroid()
		$Timer.start()
	if body.is_in_group("c_asteroid"):
		var new = explosion.instance()
		get_parent().add_child(new)
		new.position = position
		new.rotation_degrees = rotation_degrees
	pass # Replace with function body.


func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.
