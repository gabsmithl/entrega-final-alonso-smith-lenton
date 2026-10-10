extends CharacterBody2D

@onready var main: Node = $"../.."
@onready var player: CharacterBody2D = $"../../Player"
@onready var health_bar: ProgressBar = $HealthBar
@onready var sprite: Sprite2D = $Sprite2D
@onready var raycast: RayCast2D = $RayCast2D
@onready var gun_tip: Marker2D = $GunTip
@onready var enemigo_sonido = $enemigo_sonido
@onready var timer: Timer = $Timer
@onready var hit_sonido: AudioStreamPlayer = $hit_sonido
@onready var muerte_sonido: AudioStreamPlayer = $muerte_sonido

var health = 100

func damage(dmg):
	health -= dmg
	health_bar.value = health
	hit_sonido.play()
	if health <= 0:
		main.killed()
		muerte_sonido.play()
		collision_layer = 0
		await muerte_sonido.finished
		queue_free()

const bullet_scene = preload("res://Scenes/enemy_bullet.tscn")



func _ready():
	timer.wait_time = randf_range(0.5, 1.5)
	health_bar.value = health

func _process(_delta):
	if !player:
		return
	raycast.look_at(player.global_position)


func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.rotation = raycast.rotation
	get_parent().add_child(bullet)
	bullet.global_position = gun_tip.global_position
	enemigo_sonido.play()


func raycast_logic():
	if raycast.is_colliding():
			shoot()


func _on_timer_timeout() -> void:
	raycast_logic()
