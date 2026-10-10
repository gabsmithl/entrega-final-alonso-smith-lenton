extends Node2D


var tween : Tween

func _ready() -> void:
	modulate = Color()
	fade_in()

func fade_in():
	modulate = Color()
	tween = create_tween()

	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	
	tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 1.0), 4)
	await tween.finished



func _on_inicio_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
