extends Node2D

export (PackedScene) var shieldScene
export (PackedScene) var m_collectorScene
export var center = Vector2(536.5, 323.3)
export var radius = 120

var mouse_pos = Vector2.ZERO
var currentTool = ["shield", "m_collector"]
var currenSelected = 0
var canPlace = false

func placeTool(var sceneTool):
	if get_parent().carbon >= 2 and currenSelected == 0:
		get_parent().carbon -= 2
		var new = sceneTool.instance()
		get_parent().add_child(new)
		new.position = position
		new.rotation_degrees = rotation_degrees
	if get_parent().metal >= 5 and currenSelected == 1:
		get_parent().metal -= 5
		var new = sceneTool.instance()
		get_parent().add_child(new)
		new.position = position
		new.rotation_degrees = rotation_degrees		

func _input(event):
	if Input.is_action_just_pressed("switch_left"):
		currenSelected -= 1
		if currenSelected < 0:
			currenSelected = currentTool.size() - 1
			
	if Input.is_action_just_pressed("switch_right"):
		currenSelected += 1
		if currenSelected >= currentTool.size():
			currenSelected = 0
	
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and canPlace:
		if currentTool[currenSelected] == "shield":  
			placeTool(shieldScene)
		if currentTool[currenSelected] == "m_collector":
			placeTool(m_collectorScene)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateCanPlace()
	mouse_pos = get_viewport().get_mouse_position()
	var temp = Vector2(mouse_pos.x - center.x, mouse_pos.y - center.y)
	rotation_degrees = temp.angle() * 57.2957795131 + 90
	position = Vector2(radius * cos(temp.angle()) + center.x, radius * sin(temp.angle()) + center.y)
	
	if currentTool[currenSelected] == "shield":  
		$AnimatedSprite.animation = "shield"
	if currentTool[currenSelected] == "m_collector":
		$AnimatedSprite.animation = "m_collector"
	
	if canPlace:
		$AnimatedSprite.modulate = Color("#d232ff00")
	else:
		$AnimatedSprite.modulate = Color("#d2ff4800")

func updateCanPlace():
	var areas = $Area2D.get_overlapping_areas()
	for a in areas:
		if a.is_in_group("tools"):
			canPlace = false
			return
	
	canPlace = true
	return 
