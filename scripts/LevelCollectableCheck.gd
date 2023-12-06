extends Node2D

# The point of this script is to check if the level's collectable is present
# if not then return the player to the hub.

func _process(delta):
	if (!get_tree().get_nodes_in_group("Collectable").is_empty()):
		return
		
	print("player already has collectable")
	GlobalScript.change_level("intro_level")
