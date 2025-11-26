extends CanvasLayer

const LEVEL = "res://scenes/level.tscn"

func set_title(title):
	$ColorRect/VBoxContainer/Label.text = title

func _on_button_button_down() -> void:
	get_tree().change_scene_to_file(LEVEL)
