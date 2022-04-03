extends Node2D

export (PackedScene) var planetExplosionScene

signal game_over
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Area2D_body_entered(body):
	if body.is_in_group("m_asteroid") || body.is_in_group("c_asteroid"):
		emit_signal("game_over")
		var tempFX = planetExplosionScene.instance()
		add_child(tempFX)
		body.get_parent().destroyAsteroid()

	
	pass # Replace with function body.
