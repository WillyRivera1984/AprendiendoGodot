extends Node2D

const SCENE_FINISH = "res://scenes/scene_finish.tscn"

signal player_health_updated(new_player_health: int)
signal time_updated(time: int)

@export var time = 120
@export var health = 5

func game_over() -> void:
	get_tree().change_scene_to_file(SCENE_FINISH)

func game_victory() -> void:
	var scene_finish = preload(SCENE_FINISH).instantiate()
	scene_finish.set_title("You won!!!")
	add_child(scene_finish)

func _on_player_player_hit() -> void:
	if health > 1:
		health -= 1
		player_health_updated.emit(health)
	else:
		game_over()

func _on_area_2d_body_entered(body: Node2D) -> void:
	game_victory()

func _on_timer_timeout() -> void:
	if time > 0:
		time -= 1
	else:
		game_over()
	time_updated.emit(time)
	


func _on_song_finished() -> void:
	$Song.play()
