@tool
class_name VisualShapeRect
extends Node2D

@export var size: Vector2:
	set(value):
		size = value
		queue_redraw()
@export var color := Color.WHITE:
	set(value):
		color = value
		queue_redraw()
@export var filled := true:
	set(value):
		filled = value
		queue_redraw()
@export var width := -1.0:
	set(value):
		width = value
		queue_redraw()

func _draw():
	draw_rect(Rect2(-size / 2, size), color, filled, width)
