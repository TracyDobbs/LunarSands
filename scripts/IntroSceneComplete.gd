extends Node2D

# Check for keyboard inputs
func _input(event):
	if (Input.is_action_pressed("progress")):
			GlobalScript.change_level("intro_level")

# Changes from intro cutscene to the beginner level
func _on_animation_player_animation_finished(anim_name):
	GlobalScript.change_level("intro_level")
