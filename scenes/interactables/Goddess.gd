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
	
func _input(event):
	if (player == null):
		return
		
	if (playerInRange == true && Input.is_action_just_pressed("interact") == true):
		$GoddessDialogueHandler.determine_dialogue_options()

# returns the playerInRange state
# this allows other objects to see if the player is within range of the NPC
func get_player_in_range():
	return playerInRange
