@tool
extends Node

const CHUNK_SIZE_2D = 2048
const CHUNK_SIZE_3D = 100

func make_chunk_file_name_2d(pos: Vector2i):
	return "%s.%s.tscn" % [pos.x, pos.y]

func make_chunk_file_name_3d(pos: Vector3i):
	return "%s.%s.%s.tscn" % [pos.x, pos.y, pos.z]

func chunk_file_name_to_position_2d(file: String) -> Vector2i:
	var arr = file.split(".")
	return Vector2i(int(arr[0]), int(arr[1]))

func chunk_file_name_to_position_3d(file: String) -> Vector3i:
	var arr = file.split(".")
	return Vector3i(int(arr[0]), int(arr[1]), int(arr[2]))

func get_load_positions_square(global_pos: Vector2, distance: int, chunk_size: int) -> Array[Vector2i]:
	var center = global_pos / chunk_size
	var positions: Array[Vector2i]
	for x in range(center.x - distance, center.x + distance + 1):
		for y in range(center.y - distance, center.y + distance + 1):
			positions.append(Vector2i(x, y))
	
	return positions
