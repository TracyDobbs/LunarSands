extends Camera2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (get_parent().get_player() != null):
		position = get_parent().get_player().position # camera follows the player position
