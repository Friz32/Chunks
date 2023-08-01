class_name FreeCamera
extends Camera3D

const MOUSE_SENSITIVITY = 0.1

@export var speed := 1.0:
	set(value):
		speed = max(0, value)
@export var speed_modifier := 0.1

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * MOUSE_SENSITIVITY
		rotation_degrees.x -= event.relative.y * MOUSE_SENSITIVITY
		rotation_degrees.x = clamp(rotation_degrees.x, -89, 89)
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			speed += speed_modifier
		
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			speed -= speed_modifier

func _process(delta: float) -> void:
	var input = Vector3()
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if InputMap.has_action("fly_up") && InputMap.has_action("fly_down"):
		input.y = Input.get_action_strength("fly_up") - Input.get_action_strength("fly_down")
	
	input = input.normalized()
	
	var vec = basis.z * input.z + basis.x * input.x
	vec.y = input.y
	vec = vec.normalized()
	position += vec * speed
