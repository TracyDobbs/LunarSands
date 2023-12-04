extends CharacterBody2D

# Movement Variables
var speed: int = 50
var movDirX: int
var movDirY: int




# Sprite animation
@export var sprite: AnimatedSprite2D

# Signals
signal playerInteracted

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called when input is detected and applies forward force to player based on pressed key
func _handleInput():
	var moveDirection = Input.get_vector("left", "right", "up", "down")
	movDirX = moveDirection.x
	movDirY = moveDirection.y
	
	velocity = moveDirection * speed
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_handleInput()
	move_and_slide()
	
	# Resets the level upon pressing ENTER
	if Input.is_action_just_pressed("enter"):
		get_tree().reload_current_scene()
		
	# Determine which sprite animation to play
	match movDirX:
		-1:sprite.play("left")
		1: sprite.play("right")
			
	match movDirY:
		-1: sprite.play("up")
		1: sprite.play("down")
		
	if (!Input.is_anything_pressed()):
		if (movDirX == 0 && movDirY == 0):
			sprite.play("idle")
	else:
		if $Timer.time_left <=0:
			$WalkSound.pitch_scale = randf_range(0.8, 1.2)
			$WalkSound.play()
			$Timer.start(0.3)

		
func die():
	get_parent().ui.death_screen_mode(true)
	get_tree().paused = true
	await get_tree().create_timer(3).timeout
	get_tree().paused = false
	get_tree().reload_current_scene()
	
# this is used to check if a collectable is within range of the player
func _on_area_2d_body_entered(body):
	print(body)
	if body.is_in_group("Collectable"):
		GlobalScript.add_to_inventory(body)
		$ItemGrab.play()
