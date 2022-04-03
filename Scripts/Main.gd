extends Node2D

export (PackedScene) var c_asteroid_scene
export (PackedScene) var m_asteroid_scene
export (PackedScene) var placer

export var mSpawnRatio = 0.5
export var decreaseRate = 0.2

export var initalSpawnRate = 2
export var minSpawnRate = 0.4
export var spawnRange = Vector2.ZERO

var canRestart = false

var score = 0
var metal = 5
var carbon = 5

func playHitFX():
	$HitFX.play()

func _ready(): 
	$UI/ScoreLabel.hide()
	$UI/MetalLabel.hide()
	$UI/CarbonLabel.hide()
	$destroyedPlanet.hide()
	pass # Replace with function body.

func _physics_process(delta):
	$UI/MetalLabel.text = "IRON : " + str(metal)
	$UI/CarbonLabel.text = "CARBON : " + str(carbon)
	$UI/ScoreLabel.text = "SCORE : " + str(score)

func spawnAsteroid(var xSpawn):
	randomize()
	var asteroid: Node2D
	if (randf() >= mSpawnRatio):
		asteroid = c_asteroid_scene.instance()
	else:
		asteroid = m_asteroid_scene.instance()
	add_child(asteroid)
	#asteroid.center = $Earth.position
	var randPosition = Vector2(xSpawn, rand_range(spawnRange.x, spawnRange.y))
	asteroid.position = randPosition
	pass

func _on_timerA_timeout():
	spawnAsteroid(-31)
	$timerA.wait_time = initalSpawnRate
	if(initalSpawnRate >= minSpawnRate):
		initalSpawnRate -= decreaseRate * initalSpawnRate
	score += 1
	metal += 1
	carbon += 2
	pass # Replace with function body.


func _on_timerB_timeout():
	spawnAsteroid(1054)
	$timerB.wait_time = initalSpawnRate
	if(initalSpawnRate >= minSpawnRate):
		initalSpawnRate -= decreaseRate * initalSpawnRate
	pass # Replace with function body.


func _on_Earth_game_over():
	$timerA.stop()
	$timerB.stop()
	$UI/CarbonLabel.hide()
	$UI/MetalLabel.hide()
	$UI/ScoreLabel.hide()
	canRestart = true
	score += carbon * 5
	score += metal * 10
	carbon = 0
	metal = 0
	$timerC.start()
	$timerD.start()
	pass # Replace with function body.

func _on_Play_button_up():
	$timerA.start()
	$timerB.start()
	var placerNode = placer.instance()
	add_child(placerNode)
	$UI/Play.hide()
	$UI/Title.hide()
	$UI/Tutorial.hide()
	$textbackground.hide()
	$UI/ScoreLabel.show()
	$UI/MetalLabel.show()
	$UI/CarbonLabel.show()
	$shield.hide()
	$metal_collector.hide()
	if canRestart:
		get_tree().reload_current_scene()
	pass # Replace with function body.

func _on_timerC_timeout():
	$destroyedPlanet.show()
	canRestart = true
	pass # Replace with function body.


func _on_timerD_timeout():
	$UI/Play.show()
	$UI/Play.text = "RESTART"
	$UI/Title.show()
	$UI/Title.text = "SCORE : " + str(score)
	pass # Replace with function body.
