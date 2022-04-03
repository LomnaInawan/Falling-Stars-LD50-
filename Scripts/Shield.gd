extends Node2D

export (PackedScene) var explosionScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("m_asteroid") || body.is_in_group("c_asteroid"):
		body.get_parent().destroyAsteroid()
		
		var tempFx = explosionScene.instance()
		get_parent().add_child(tempFx)
		tempFx.position = position
		tempFx.rotation_degrees = rotation_degrees
		if $AnimatedSprite.animation == "broken":
			queue_free()
		$AnimatedSprite.animation = "broken"
		pass
	pass # Replace with function body.
