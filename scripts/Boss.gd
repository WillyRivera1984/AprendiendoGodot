class_name Boss
extends Node2D

@export var gravity = 0.1
@onready var animation_player = $AnimationPlayer
const SAW_SCENE = preload("res://scenes/saw.tscn")

func spawn_saw() -> void:
	var saw: RigidBody2D = SAW_SCENE.instantiate()
	add_child(saw)
	saw.gravity_scale = gravity
	saw.add_constant_torque(500)
	
	var height_impulse = -100
	var random_propulsion = randf_range(-250, 250)
	saw.apply_impulse(Vector2(random_propulsion, height_impulse))

func _on_timer_timeout() -> void:
	animation_player.play("spawn")
	$Timer.wait_time = randf_range(0.25, 1.5)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "spawn":
		animation_player.play("idle")

func _ready() -> void:
	$Timer.connect("timeout", _on_timer_timeout)
	animation_player.play("idle")
