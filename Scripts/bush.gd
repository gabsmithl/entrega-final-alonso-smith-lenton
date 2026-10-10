extends Node2D

func _process(delta: float) -> void:
	global_position.x -= 100 * delta
	rotate(-15 * delta)




func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	global_position.x += get_viewport().size.x
