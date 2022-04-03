extends AnimationPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var canPlay = true

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().position = Vector2(536.5, 323.3)
	if canPlay:
		canPlay = false
		play("planetExplosion")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
