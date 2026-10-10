extends Node2D
@onready var menu_canvas: CanvasLayer = $MenuCanvas
@onready var credits_canvas: CanvasLayer = $CreditsCanvas



func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_credit_button_pressed() -> void:
	menu_canvas.visible = false
	credits_canvas.visible = true


func _on_salir_button_pressed() -> void:
	get_tree().quit()


func _on_volver_button_pressed() -> void:
	menu_canvas.visible = true
	credits_canvas.visible = false
