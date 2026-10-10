extends Node2D
@onready var mapa: Node2D = $Mapa
@onready var camera: Camera2D = $Camera2D
@onready var tren: Node2D = $Tren
@onready var player: CharacterBody2D = $Player

var enemies_killed = 0
var train_scene = preload("res://Scenes/tren.tscn")

@export var zoom_amount = Vector2(2.75, 2.75)
@onready var default_zoom = camera.zoom
@export var zoom_duration = 1
var initial_camera_pos : Vector2
var tween : Tween
var is_camera_fixed = false

@onready var marker_loc = tren.marker_locomotora
@onready var marker_vag = tren.marker_vagon



func killed():
	enemies_killed += 1
	match enemies_killed:
		3: mapa.level_up()
		6: mapa.level_up()
		12: is_camera_fixed = false; mapa.level_up(); mapa.reset_borders()



func spawn_train():
	tren.visible = true
	tren.playtrainaudio()
	train_camera()
	

func _process(delta: float) -> void:
	
	if !is_camera_fixed and player:
		camera.global_position.x = player.global_position.x
	
	
	if tren.visible and tren.global_position.x < 4000:
			tren.global_position.x += 1000 * delta
			zoom_in_train(tren.global_position + Vector2(300,0))


func train_camera():
	is_camera_fixed = true
	player.process_mode = Node.PROCESS_MODE_DISABLED
	initial_camera_pos = camera.global_position
	zoom_in_train(marker_loc.global_position)
	await get_tree().create_timer(3).timeout
	zoom_in_train(marker_vag.global_position)
	await get_tree().create_timer(3).timeout
	zoom_reset()
	mapa.update_borders()
	player.process_mode = Node.PROCESS_MODE_INHERIT
	await get_tree().create_timer(2).timeout
	tren.process_mode = Node.PROCESS_MODE_INHERIT
	

func zoom_in_train(target):
	tween = create_tween()

	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	
	tween.tween_property(camera, "global_position", target, zoom_duration)
	tween.tween_property(camera, "zoom", zoom_amount, zoom_duration)

func zoom_reset():
	tween = create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	
	tween.tween_property(camera, "global_position", initial_camera_pos, zoom_duration)
	tween.tween_property(camera, "zoom", default_zoom, zoom_duration)
	await tween.finished

func win():
	await fade_out()
	get_tree().change_scene_to_file("res://Scenes/victory.tscn")

func lose():
	await fade_out()
	get_tree().change_scene_to_file("res://Scenes/loss.tscn")

func fade_out() -> bool:
	is_camera_fixed = true
	tween = create_tween()

	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	
	tween.tween_property(self, "modulate", Color(0,0,0), 3)
	await tween.finished
	return true
	
	
	
	
	
	
