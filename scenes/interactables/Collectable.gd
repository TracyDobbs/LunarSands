extends StaticBody2D

# Name of the Object
@onready var thisObjectsName = to_string().get_slice(":", 0)

# Get the current inventory on scene load
@onready var inventory = GlobalScript.inventory

func _ready():
	for itemName in inventory:
		if itemName == thisObjectsName:
			queue_free()
