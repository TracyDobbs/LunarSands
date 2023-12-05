extends Node2D

# Variables
# UI
@onready var ui: CanvasLayer = $UI

# Opens the replay options menu when the credits finish
func _on_end_credit_anim_animation_finished(anim_name):
	ui.replay_options_mode(true)
