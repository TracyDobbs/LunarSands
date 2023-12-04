extends CharacterBody2D

# Movement Variables
var speed: int = 100

var movDirX: int
var movDirY: int

# Sprite animation
@export var sprite: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
	#print("Player is WEREWOLF!")
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
		
func die():
	get_tree().reload_current_scene()
