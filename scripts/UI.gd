extends CanvasLayer

# Variables
# UI Components
# Dialogue
@onready var dialogue = find_child("Dialogue")
@onready var dialogueLabel = find_child("DialogueLabel")

# Death screen
@onready var deathScreenComponent = find_child("DeathScreen")

# Replay options
@onready var replayOptions = find_child("ReplayOptions")
@onready var replayButton = find_child("Replay")
@onready var quitButton  = find_child("Quit")

# Called when the node enters the scene tree for the first time.
func _ready():
	dialogue_mode(false) # Disable the dialogue component on ready
	death_screen_mode(false)
	replay_options_mode(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
# When called, the visibility of the dialogue component is toggled
func dialogue_mode(toggle):
	dialogue.visible = toggle
			
# This function can set the content of the dialogue label
func dialogue_text(text: String):
	dialogueLabel.text = text

# Called to toggle the deathscreen
func death_screen_mode(toggle):
	deathScreenComponent.visible = toggle
	
# Called to toggle the replay options screen
func replay_options_mode(toggle):
	replayOptions.visible = toggle
	replayButton.disabled = !toggle
	quitButton.disabled = !toggle

# Called when the replay button is pressed
func _on_replay_pressed():
	GlobalScript.change_level("intro_scene")

# Called when the quit button is pressed
func _on_quit_pressed():
	get_tree().quit()
