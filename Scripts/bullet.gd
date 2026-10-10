extends Node2D


var direction: Vector2
const SPEED = 500
var damage = 20


func _ready():
	direction = Vector2.RIGHT.rotated(rotation)
	
func _process(delta: float) -> void:
	position += direction * SPEED * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("damage"):
		body.damage(damage)
	queue_free()
