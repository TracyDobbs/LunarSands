extends Control


var notPaused = true 

func _ready():
	hide()

	
func _process(delta):
	if Input.is_action_just_pressed("pause"):	
		get_tree().paused = true 
		notPaused = false
		
		
	else: 
		get_tree().paused = false 
		notPaused = true 		 
		

		
	
	
	
