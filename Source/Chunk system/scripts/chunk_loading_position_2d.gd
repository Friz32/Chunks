class_name ChunkLoadingPosition2D
extends Node2D

@export var loading_distance := 1.0

func _enter_tree() -> void:
	var manager
	for child in get_tree().current_scene.get_children():
		if child is ChunkManager2D:
			manager = child
			break
	
	manager.loading_positions.append(self)

func _exit_tree() -> void:
	var manager
	for child in get_tree().current_scene.get_children():
		if child is ChunkManager2D:
			manager = child
			break
	
	var loading_positions = manager.loading_positions
	loading_positions.remove_at(loading_positions.find(self))
