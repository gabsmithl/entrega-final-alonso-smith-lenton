extends Node2D
@onready var locomotora: AnimatedSprite2D = $SpritesLocomotora
@onready var marker_locomotora: Marker2D = $MarkerLocomotora
@onready var marker_vagon: Marker2D = $MarkerVagon
@onready var train_audio: AudioStreamPlayer = $train_audio

func playtrainaudio():
	train_audio.play()
