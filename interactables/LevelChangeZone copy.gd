extends Node2D

# Variables
# Components
@onready var area2d = $Area2D

# Level
@export var levelName: String

# Called when the player enters the zone
func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		GlobalScript.change_level(levelName)
func die() -> void:
	queue_free()
