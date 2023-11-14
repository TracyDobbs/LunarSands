extends Node

# Variables
# Text files
@onready var no_items = 'res://dialogues/goddess/PlayerHasTestCollectible.txt'
@onready var one_item = 'res://dialogues/goddess/PlayerHasOneItem.txt'
@onready var two_items = 'res://dialogues/goddess/PlayerHasTwoItems.txt'
@onready var all_items = 'res://dialogues/goddess/PlayerHasAllItems.txt'
@onready var remain_werewolf = 'res://dialogues/goddess/PlayerChoosesToRemainWerewolf.txt'
@onready var save_themself = 'res://dialogues/goddess/PlayerChoosesToSaveThemselves.txt'
@onready var test_collectable = 'res://dialogues/goddess/PlayerHasTestCollectible.txt'

# Signals when the progress input is detected
signal progress_dialogue

# UI
var ui

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (ui == null):
		ui = get_parent().ui
	
func determine_dialogue_options():
	get_parent().isTalking = true
	if (GlobalScript.inventory.has("TestCollectable")):
		has_test_collectable()
		return
		
	match GlobalScript.inventory.size():
		0:
			print("no items")
		1: 
			print("1 item")
		2:
			print("2 items")
		3: 
			print("all items")
			
# Called when the player has the godlike test collectable
func has_test_collectable():
	var file = FileAccess.open(test_collectable, FileAccess.READ) # Open and read the provided text file
	
	# Enter dialogue mode
	ui.dialogue_mode(true)
	
	while (file.get_position() < file.get_length()):
		ui.dialogue_text(file.get_line())
		await progress_dialogue
	
	ui.dialogue_mode(false)
	get_parent().isTalking = false
	
func _input(event):
	if (event.is_action_pressed("progress")):
		progress_dialogue.emit()
