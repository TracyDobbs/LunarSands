extends Node2D
class_name PathFinding

# Enemy movement variables
var direction = Vector2.ZERO

# External nodes
@onready var navAgent = $NavigationAgent2D

# Navigation target
@onready var target

# Patrol points
var patrolPoints: Array
var tempPoints: Array

# runs on scene load
func _ready():
	patrolPoints = get_parent().get_patrol_points()
	tempPoints = patrolPoints.duplicate()
	set_target(tempPoints.pop_front())
	update_target()

	
# process runs every frame
func _process(delta):
	pass
	#if (target == null):
		#target = owner.get_parent().get_player()
		#update_target()

# This setter method allows other scripts referencing this object to set it's current target
func set_target(temp):
	if (temp == null):
		temp = tempPoints.pop_front()
	if (tempPoints.is_empty()):
		tempPoints = patrolPoints.duplicate()
		
	target = temp 
	print("target set")
	
# Updates the position of the current target
func update_target():
	if (target != null):
		#print("target player")
		navAgent.target_position = target.get_global_position()
	else:
		set_target(tempPoints.pop_front())
		
# Tells the NavAgent to check for the current position of the target
func _on_reaction_time_timeout():
	#print("searching for player")
	update_target()
	#print("target player")
	direction = to_local(navAgent.get_next_path_position()).normalized()

# Determines what to do when reaching current target based on what the current target is
func _on_navigation_agent_2d_target_reached():
	print ("target reached")
		
	if (!patrolPoints.is_empty()):
		set_target(tempPoints.pop_front())
		return
