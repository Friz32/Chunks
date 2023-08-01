class_name ChunkLoadingPosition3D
extends Node3D

@export var loading_distance := 1.0

func _enter_tree() -> void:
	var manager
	for child in get_tree().current_scene.get_children():
		if child is ChunkManager3D:
			manager = child
			break
	
	manager.loading_positions.append(self)

func _exit_tree() -> void:
	var manager
	for child in get_tree().current_scene.get_children():
		if child is ChunkManager3D:
			manager = child
			break
	
	var loading_positions = manager.loading_positions
	loading_positions.remove_at(loading_positions.find(self))
