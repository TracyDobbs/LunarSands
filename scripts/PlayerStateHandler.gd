extends Node2D

# State Variables
var currentState: String = ""
var astronomer = preload("res://scenes/players/astronomer.tscn")
var werewolf = preload("res://scenes/players/werewolf.tscn")
var canInteract: bool

# Player variables
var player: CharacterBody2D
var spawnPos: Vector2
var timer: Timer

# Tile information
@onready var tileMap: TileMap = get_parent().find_child("TileMap")
var tileData: TileData
var layer: int = 0

# Signals
signal playerInteracted

# Called when the node enters the scene tree for the first time.
func _ready():
	spawnPos = $Spawnpoint.position	
	timer = $Timer
	canInteract = true
	_astronomer()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var tilePlayerPosition: Vector2i = tileMap.local_to_map(get_global_player_position())
	tileData = tileMap.get_cell_tile_data(layer, tilePlayerPosition)
		
	# Ensures that code dependent on the presence of tile data does not run if tile data is null
	if ((tileData != null) && tileData.get_custom_data("moonlight")):
#		print("Found tile data!")	
#		print(tileData)
		player_entered_moonlight()

# Called when the conditions are met for the player to transform to astronomer
func _astronomer():
	if (currentState == "werewolf"):
		spawnPos = player.position
		remove_child(player)
		
	player = astronomer.instantiate()
	player.position = spawnPos
	add_child(player) # The player is instantiated into the scene
	currentState = "astronomer"
	#print(currentState)

# Called when the conditions are met for the player to transform to werewolf
func _werewolf():
	# When the player transforms, they will transform right where they are and their other form will be removed from the scene
	if (currentState == "astronomer"):
		spawnPos = player.position
		remove_child(player)
		
	player = werewolf.instantiate()
	player.position = spawnPos 
	add_child(player) # The player is instantiated into the scene
	currentState = "werewolf"
	#print(currentState)
	timer.start() # Begins the timer until the player is transformed back to human

# Transforms the player back to their human state
func _on_timer_timeout():
	_astronomer()
	
# Returns the current player position
func get_global_player_position():
	return player.get_global_position()

# When the signal in PlayerPositionHandler is triggered, this function is called.
# Therefore, the function is called when the player is on a moonlight tile
func player_entered_moonlight():
	#print("Body has entered moonlight!")
	if (currentState == "astronomer"):
		#print("Transformation!")
		_werewolf()
		return
		
	#print("No transformation...")
	
func get_player():
	return player


