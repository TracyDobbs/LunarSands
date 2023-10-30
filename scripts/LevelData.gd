extends Node2D

# Level variables
var player: CharacterBody2D = null;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player = $GeneralMechanics/PlayerHandler.get_player()
	
func get_player():
	if (player != null):
		return player
	else:
		return
