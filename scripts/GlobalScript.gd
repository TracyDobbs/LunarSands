extends Node

# Player inventory
var inventory: Array[String]

# Starting path of all levels
const FILE_BEGIN = "res://scenes/levels/"

# Changes the level to the level with the provided name
func change_level(level):		
		var next_level_path = FILE_BEGIN + level + ".tscn"	
		get_tree().change_scene_to_file(next_level_path)	
		print(next_level_path)
		print(inventory)

# Adds items to inventory when called
func add_to_inventory(item):
	var itemName = str(item).get_slice(":", 0)
	
	if ((item != null) && (inventory.has(itemName) == false)):
		inventory.append(itemName)
		item.queue_free()
		print("added " + itemName + " to inventory")
