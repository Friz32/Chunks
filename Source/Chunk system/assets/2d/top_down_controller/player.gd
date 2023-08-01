class_name TDCPlayer
extends CharacterBody2D

@export var move_speed := 20.0
@export var deceleration := 0.2

@onready var anim_tree := $AnimationTree
@onready var playback = anim_tree["parameters/playback"]

func _physics_process(delta):
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	velocity += input * move_speed
	move_and_slide()
	velocity = velocity.lerp(Vector2.ZERO, deceleration)
	
	if input.length() > 0:
		playback.travel("move")
		
		anim_tree["parameters/idle/blend_position"] = input
		anim_tree["parameters/move/blend_position"] = input
	else:
		playback.travel("idle")
