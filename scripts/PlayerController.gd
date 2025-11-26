class_name Player
extends CharacterBody2D

signal player_hit

const HIT = preload("res://assets/character/character_purple_hit.png")
const IDLE = preload("res://assets/character/character_purple_front.png")
const JUMP = preload("res://assets/character/character_purple_jump.png")

@export var gravity: int = 120
@export var jump_velocity: int = 120
@export var speed: int = 100

@onready var coyote = $Coyote
var can_jump = true

func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("left", "right")
	velocity.x = speed * direction
	
	if not is_on_floor():
		if coyote.is_stopped():
			coyote.start()
		velocity.y += gravity * delta
		$Sprite2D.texture = JUMP
	else:
		$Sprite2D.texture = IDLE
		coyote.stop()
		can_jump = true
	
	var jump_pressed = Input.is_action_just_pressed("jump")
	if jump_pressed and can_jump:
		$Jump.play()
		velocity.y -= jump_velocity
	
	move_and_slide()


func _on_coyote_timeout() -> void:
	can_jump = false
	
func take_damage() -> void:
	$Sprite2D.texture = HIT
	$HitTimer.start()
	$Hurt.play()
	player_hit.emit()

func _on_hit_timer_timeout() -> void:
	$Sprite2D.texture = IDLE if is_on_floor() else JUMP
