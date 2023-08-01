class_name ChunkManager3D
extends Node3D

enum Mode
{
	XY,
	XYZ,
}

@export_dir var world := ""
@export var chunk_size := Chunks.CHUNK_SIZE_3D
@export var mode := Mode.XY

var loaded_chunks := {}
var loading_positions: Array[ChunkLoadingPosition3D]

func load_chunks():
	match mode:
		Mode.XY:
			for pos in loading_positions:
				var list = Chunks.get_load_positions_square(Vector2(pos.global_position.x, pos.global_position.z), pos.loading_distance, chunk_size)
				for item in list:
					if loaded_chunks.has(item):
						continue
					
					var file_name = Chunks.make_chunk_file_name_2d(item)
					var path = world + "/" + file_name
					
					if !FileAccess.file_exists(path):
						continue
					
					var scene = load(path)
					var node = scene.instantiate()
					node.position = Vector3(item.x, 0, item.y) * chunk_size
					node.name = "%sx%s" % [item.x, item.y]
					add_child(node)
					
					loaded_chunks[item] = node

func unload_chunks():
	var keep = []
	for pos in loading_positions:
		keep.append_array(Chunks.get_load_positions_square(Vector2(pos.global_position.x, pos.global_position.z), pos.loading_distance, chunk_size))
	
	for chunk in loaded_chunks.keys():
		if !keep.has(chunk):
			loaded_chunks[chunk].queue_free()
			loaded_chunks.erase(chunk)

func _on_update_chunks_timeout() -> void:
	load_chunks()
	unload_chunks()
