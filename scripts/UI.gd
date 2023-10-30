extends CanvasLayer

# Variables
# UI Components
# Dialogue
@onready var dialogue = find_child("Dialogue")
@onready var dialogueLabel = find_child("DialogueLabel")

# Death screen
@onready var deathScreenComponent = find_child("DeathScreen")

# Called when the node enters the scene tree for the first time.
func _ready():
	dialogue_mode(false) # Disable the dialogue component on ready
	death_screen_mode(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
# When called, the visibility of the dialogue component is toggled
func dialogue_mode(toggle):
	dialogue.visible = toggle
			
# This function can set the content of the dialogue label
func dialogue_text(text: String):
	dialogueLabel.text = text
	
func death_screen_mode(toggle):
	deathScreenComponent.visible = toggle
