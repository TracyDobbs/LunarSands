extends StaticBody2D

# Sprite
var sprite: Sprite2D

# Door states
var doorState: String = ""

# Door positions
var closedPos: Vector2
var openPos: Vector2

func _ready():
	sprite = $Sprite2D
	closedPos = position
	openPos = Vector2(position.x, closedPos.y + sprite.texture.get_size().y)
	doorState = "Closed"

func switch_door_state():
	match doorState:
		"Closed":
			doorState = "Open"
			position = openPos
		"Open":
			doorState = "Closed"
			position = closedPos
