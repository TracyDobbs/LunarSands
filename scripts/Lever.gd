extends StaticBody2D

# Stores reference to the UI
@onready var ui: CanvasLayer = owner.find_child("UI")

# Nodes
var player: CharacterBody2D
@export var door: StaticBody2D
@export var leversound: AudioStreamPlayer

# State variables
var leverState: String = ""
var frame: int = 0
var playerInRange: bool = false

# Signals
signal playerInteractedWithLever

func _ready():
	leverState = "On"
	$LeverState.frame = frame
	
func _process(_delta):
	$LeverState.frame = frame

func _on_area_body_entered(body):
	if (!body.is_in_group("Player")):
		return
		
	player = body
	playerInRange = true

func _on_area_body_exited(body):
	if (!body.is_in_group("Player")):
		return
		
	player = null
	playerInRange = false

func _input(event):
	if (player == null):
		return
		
	if (playerInRange == true && Input.is_action_just_pressed("interact") == true):
		_on_player_interacted_with_lever()
		door.switch_door_state()

func _on_player_interacted_with_lever():
	match leverState:
		"Off":
			leverState = "On"
			frame = 0
		"On":
			leverState = "Off"
			frame = 1
	
	leversound.play()		
	dialogue_trigger()
# returns the playerInRange state
# this allows other objects to see if the player is within range of the lever
func get_player_in_range():
	return playerInRange
	
func dialogue_trigger():
	ui.dialogue_text("Lever interacted with!")
	ui.dialogue_mode(true)
	await get_tree().create_timer(1.0).timeout
	ui.dialogue_mode(false)
