extends Node2D

export (PackedScene) var planetExplosionScene

var game_over_bool = false

signal game_over
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body.is_in_group("m_asteroid") || body.is_in_group("c_asteroid"):
		emit_signal("game_over")
		if game_over_bool == false:
			$explosionFX.play()
			game_over_bool = true
			var tempFX = planetExplosionScene.instance()
			add_child(tempFX)
		body.get_parent().destroyAsteroid()

	
	pass # Replace with function body.
