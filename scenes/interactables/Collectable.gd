extends StaticBody2D

# Name of the Object
@export var collectableName: String

# Get the current inventory on scene load
@onready var inventory = GlobalScript.inventory

func _ready():
	for itemName in inventory:
		if itemName == collectableName:
			queue_free()
