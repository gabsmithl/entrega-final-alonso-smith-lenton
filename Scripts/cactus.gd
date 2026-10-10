extends Node2D

var damage = 5

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("damage"):
		body.SPEED = 150
		body.damage(damage)
	queue_free()
pass 
