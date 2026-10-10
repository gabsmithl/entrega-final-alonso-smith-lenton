extends CharacterBody2D
@onready var arm: Sprite2D = $Sprite/Arm
@onready var gun_tip: Marker2D = $Sprite/Arm/Marker2D
@onready var cooldown: Timer = $Cooldown
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var camera: Camera2D = $"../Camera2D"
@onready var sonido_disparo = $sonido_disparo
@onready var health_bar: ProgressBar = $HealthBar
@onready var main: Node2D = $".."
@onready var hit_sonido: AudioStreamPlayer = $hit_sonido
@onready var muerte_sonido: AudioStreamPlayer = $muerte_sonido



const BULLET_SCENE = preload("res://Scenes/bullet.tscn")
var SPEED = 250.0

var health = 100

func _ready() -> void:
	health_bar.value = health


func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED 
	if velocity:
		sprite.play("walk")
	else:
		sprite.play("idle")
	
	if direction.x > 0:
		sprite.flip_h = true
	
	
	elif direction.x < 0:
		sprite.flip_h = false

	look_at_mouse()
	move_and_slide()


func _process(_delta: float) -> void:
	velocidad()
	if Input.is_action_pressed("shoot") and cooldown.is_stopped():
		shoot()
	



func look_at_mouse():
	arm.look_at(get_global_mouse_position())



func shoot():

	var bullet = BULLET_SCENE.instantiate()
	bullet.rotation = arm.rotation
	get_parent().add_child(bullet)
	bullet.global_position = gun_tip.global_position
	sonido_disparo.play()
	cooldown.start()
	

func damage(dmg):
	health -= dmg
	health_bar.value = health
	hit_sonido.play()
	if health <= 0:
		set_physics_process(false)
		collision_layer = 0
		main.lose()
		muerte_sonido.play()
		await muerte_sonido.finished

	
func velocidad():
	if SPEED <250: 
		await get_tree().create_timer(1.0).timeout
		SPEED = 250
