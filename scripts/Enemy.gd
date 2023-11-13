extends CharacterBody2D


# Stores reference to the UI
@onready var ui: CanvasLayer = owner.find_child("UI")

# Variables storing references to components
@export var path: PathFinding
@export var killArea: Area2D

#@onready var target = get_parent().get_player()

# Patrol points
@export var patrolPoints: Array[Marker2D]
var tempPoints = patrolPoints

var speed = 100;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = path.direction * speed
	move_and_slide()
	
func get_patrol_points():
	return patrolPoints

func _on_kill_area_body_entered(body):
	if (body.is_in_group("Player")):
		print("player caught")
		ui.death_screen_mode(true)
		get_tree().paused = true
		await get_tree().create_timer(3).timeout
		get_tree().paused = false
		body.die()
