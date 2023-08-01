@tool
class_name VisualShapeCircle
extends Node2D

@export var radius := 10.0:
	set(value):
		radius = value
		queue_redraw()
@export var color := Color.WHITE:
	set(value):
		color = value
		queue_redraw()

func _draw():
	draw_circle(Vector2.ZERO, radius, color)
