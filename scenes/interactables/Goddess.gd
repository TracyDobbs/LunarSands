extends CharacterBody2D

# Variables
# Stores reference to the UI
@onready var ui: CanvasLayer = owner.find_child("UI")

# Nodes
var player: CharacterBody2D

# State Variables
var playerInRange: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_area_2d_body_entered(body):
	if (!body.is_in_group("Player")):
		return
		
	player = body
	playerInRange = true


func _on_area_2d_body_exited(body):
	if (!body.is_in_group("Player")):
		return
		
	player = null
	playerInRange = false

# returns the playerInRange state
# this allows other objects to see if the player is within range of the lever
func get_player_in_range():
	return playerInRange
	
func dialogue_trigger():
	ui.dialogue_text("Lever interacted with!")
	ui.dialogue_mode(true)
	await get_tree().create_timer(1.0).timeout
	ui.dialogue_mode(false)



