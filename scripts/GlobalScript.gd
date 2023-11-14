extends Node

# Complete inventory
var completeInventory: Array[String]

# Missing items
var missingItems: Array[String]

# Player inventory
var inventory: Array[String]

# Starting path of all levels
const FILE_BEGIN = "res://scenes/levels/"

# Run on load
func _ready():
	completeInventory.append("Moonlight Orchid")
	completeInventory.append("Werewolf's Claw")
	completeInventory.append("Wolfsbane")

# Changes the level to the level with the provided name
func change_level(level):		
		var next_level_path = FILE_BEGIN + level + ".tscn"	
		get_tree().change_scene_to_file(next_level_path)	
		print(next_level_path)
		print(inventory)

# Adds items to inventory when called
func add_to_inventory(item):
	var itemName = item.collectableName
	
	if ((item != null) && (inventory.has(itemName) == false)):
		inventory.append(itemName)
		item.queue_free()
		print("added " + itemName + " to inventory")
		
# Returns what items the player needs to have a complete inventory
func missing_collectables():
	missingItems.clear()
	
	# Iterate through inventory and find missing items
	for item in completeInventory:
		if (!inventory.has(item)):
			missingItems.append(item)
	print(missingItems)
