extends Area2D

func _on_body_entered(body):
	if body == null:
		print("body is null")
		return
	if body.is_in_group("Human"):
		body.die()
