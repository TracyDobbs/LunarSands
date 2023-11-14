extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	$AnimatedSprite2D.play("interact_prompt")
	
func _process(delta):
	if (get_parent() == null):
		return
		
	$AnimatedSprite2D.visible = get_parent().get_player_in_range()
