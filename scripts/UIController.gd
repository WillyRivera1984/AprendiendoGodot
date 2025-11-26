extends CanvasLayer

const HEART_FULL = preload("res://assets/ui/hud_heart.png")
const HEART_EMPTY = preload("res://assets/ui/hud_heart_empty.png")
@onready var health_container = $Health
var hearts = []

func _ready() -> void:
	for i in range(5):
		var new_heart = TextureRect.new()
		new_heart.texture = HEART_FULL
		health_container.add_child(new_heart)
		hearts.append(new_heart)

func _on_game_controller_player_health_updated(new_player_health: int) -> void:
	for i in hearts.size():
		var heart = hearts[i]
		heart.texture = HEART_EMPTY if (i+1) > new_player_health else HEART_FULL


func _on_game_controller_time_updated(time: int) -> void:
	$ColorRect/Timer.text = str(time)
