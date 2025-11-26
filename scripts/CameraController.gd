extends Camera2D

@export var object_follow: Node2D

func _process(delta: float) -> void:
	position = object_follow.position
