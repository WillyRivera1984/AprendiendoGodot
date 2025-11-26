class_name Saw
extends RigidBody2D

@export var far_off: int = 5000
@onready var hitbox = $Hitbox
var damage_done = false

func _ready() -> void:
	hitbox.connect("body_entered", _on_body_entered)

func _process(delta: float) -> void:
	if position.y > far_off:
		queue_free()
		
func _on_body_entered(body) -> void:
	if body is Player:
		if not damage_done:
			damage_done = true
			body.take_damage()
