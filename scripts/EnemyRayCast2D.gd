extends RayCast2D


# Stores NavAgent
@export var path: PathFinding
@onready var navAgent = path.find_child("NavigationAgent2D")

# Variable for the sight distance 
var range: float = 80 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):	
	#print(target_position)
	target_position = path.direction * range
	
	if is_colliding(): # Checks if the RayCast2D is colliding with something
		if (get_collider() == get_player()): # If the colliding object is equal to the player
			#print("player detected")		 # then set the target to the player
			path.set_target(owner.get_parent().get_player())
			await get_tree().create_timer(5).timeout
			path.set_target(null)
			#get_parent().set_target() = get_player()

# This retrieves the player data
func get_player():
	if (get_tree().root.get_child(0) != null):
		#print(get_tree().root.get_child(0).get_player())
		return get_tree().root.get_child(0).get_player()
