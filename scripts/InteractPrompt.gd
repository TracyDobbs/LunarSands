extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (get_parent() == null):
		return
		
	find_child("Sprite2D").visible = get_parent().get_player_in_range()
