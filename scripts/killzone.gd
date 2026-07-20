extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("you died")
	
	if body.has_method("take_damage"):
		body.take_damage()
		# Désactive temporairement la killzone pour éviter les détections multiples
		monitoring = false
		await get_tree().create_timer(2.0).timeout
		monitoring = true
