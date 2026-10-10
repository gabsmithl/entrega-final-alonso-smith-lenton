extends Node2D
@onready var level_1: CollisionShape2D = $LevelBorders/Level1
@onready var level_2: CollisionShape2D = $LevelBorders/Level2
@onready var level_3: CollisionShape2D = $LevelBorders/Level3
@onready var border_left: CollisionShape2D = $WorldBorders/WorldBorderLeft
@onready var border_right: CollisionShape2D = $WorldBorders/WorldBorderRight
@onready var camera: Camera2D = $"../Camera2D"




@onready var main: Node = $".."
@onready var sensor: Area2D = $SensorSpawn

var level = 1
var left_original_pos
var right_original_pos
@onready var viewport_size = get_viewport().size.x

func _ready() -> void:
	left_original_pos = border_left.global_position.x
	right_original_pos = border_right.global_position.x

func call_train():
	main.spawn_train()
	sensor.queue_free()

func level_up():
	level += 1
	
	match level:
		2: level_1.queue_free()
		3: level_2.queue_free()
		4: level_3.queue_free()

func update_borders():
	viewport_size = get_viewport().size.x / 1.5
	border_left.global_position.x = camera.global_position.x - (viewport_size/2)
	border_right.global_position.x = camera.global_position.x + (viewport_size/2)
	
func reset_borders():
	border_left.global_position.x = left_original_pos
	border_right.global_position.x = right_original_pos


func _on_sensor_spawn_body_entered(_body: Node2D) -> void:
	call_train()


func _on_sensor_win_body_entered(_body: Node2D) -> void:
	main.win()
