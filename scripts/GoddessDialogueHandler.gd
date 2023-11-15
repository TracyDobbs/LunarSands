extends Node

# Variables
# Text files
@onready var no_items = 'res://dialogues/goddess/PlayerHasNoItems.txt'
@onready var one_item = 'res://dialogues/goddess/PlayerHasOneItem.txt'
@onready var two_items = 'res://dialogues/goddess/PlayerHasTwoItems.txt'
@onready var all_items = 'res://dialogues/goddess/PlayerHasAllItems.txt'
@onready var remain_werewolf = 'res://dialogues/goddess/PlayerChoosesToRemainWerewolf.txt'
@onready var save_themself = 'res://dialogues/goddess/PlayerChoosesToSaveThemselves.txt'
@onready var test_collectable = 'res://dialogues/goddess/PlayerHasTestCollectible.txt'

# Open file
var file

# Current lines of dialogue
var lines: PackedStringArray

# Signals when the progress input is detected
signal progress_dialogue

# UI
var ui

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (ui == null):
		ui = get_parent().ui

# Called to determine which dialogue needs to be set
func determine_dialogue_options():
	get_parent().isTalking = true
	GlobalScript.missing_collectables()
	
	if (GlobalScript.inventory.has("TestCollectable")):
		has_test_collectable()
		return
		
	match GlobalScript.inventory.size():
		0:
			has_no_items()
		1: 
			has_one_item()
		2:
			has_two_items()
		3: 
			has_all_items()
			

	
# Called when the player has not items
func has_no_items():
	file = FileAccess.open(no_items, FileAccess.READ) # Open and read the provided text file
	lines = file.get_as_text().split("\n")
	print(lines)
	
		# Enter dialogue mode
	ui.dialogue_mode(true)
	
	for line in lines:
		ui.dialogue_text(line)
		await progress_dialogue
		
	
	ui.dialogue_mode(false)
	get_parent().isTalking = false
	
	lines.clear()
	file.close()
	
# Called when the player only has one object
func has_one_item():
	file = FileAccess.open(one_item, FileAccess.READ) # Open and read the provided text file
	lines = file.get_as_text().split("\n")	
	
	# Dynamically update lines based on current inventory
	lines[0] = lines[0] + " " + GlobalScript.inventory[0]
	lines[1] = lines[1] + " " + GlobalScript.missingItems[0] + " and " + GlobalScript.missingItems[1]
	
	# Enter dialogue mode
	ui.dialogue_mode(true)
	
	for line in lines:
		ui.dialogue_text(line)
		await progress_dialogue
		
	
	ui.dialogue_mode(false)
	get_parent().isTalking = false
	
	lines.clear()
	file.close()
	
# called when the player has two objects
func has_two_items():
	file = FileAccess.open(two_items, FileAccess.READ) # Open and read the provided text file
	lines = file.get_as_text().split("\n")
	lines[0] = lines[0] + " " + GlobalScript.inventory[0] + " and " + GlobalScript.inventory[1] + "."
	lines[1] = lines[1] + " " + GlobalScript.missingItems[0] + "."
	
		# Enter dialogue mode
	ui.dialogue_mode(true)
	
	for line in lines:
		ui.dialogue_text(line)
		await progress_dialogue
		
	
	ui.dialogue_mode(false)
	get_parent().isTalking = false
	
	lines.clear()
	file.close()
	
# called when the player has all objects
func has_all_items():
	file = FileAccess.open(all_items, FileAccess.READ) # Open and read the provided text file
	lines = file.get_as_text().split("\n")
	print(lines)
	
		# Enter dialogue mode
	ui.dialogue_mode(true)
	
	for line in lines:
		ui.dialogue_text(line)
		await progress_dialogue
		
	
	ui.dialogue_mode(false)
	get_parent().isTalking = false
	
	lines.clear()
	file.close()
	
# Called when an input is detected
func _input(event):
	# this checks if the detected input is for the "progress" action
	if (event.is_action_pressed("progress")):
		progress_dialogue.emit() # emit a signal stating that the player wishes to progress dialogue
		
# Called when the player has the godlike test collectable
func has_test_collectable():
	file.open(test_collectable, FileAccess.READ) # Open and read the provided text file
	
	# Enter dialogue mode
	ui.dialogue_mode(true)
	
	while (file.get_position() < file.get_length()):
		ui.dialogue_text(file.get_line())
		await progress_dialogue
	
	ui.dialogue_mode(false)
	get_parent().isTalking = false
	file.close()
