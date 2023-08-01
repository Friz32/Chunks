@tool
class_name ChunkComponent2D
extends Node2D

@export var chunk_size := Chunks.CHUNK_SIZE_2D:
	set(value):
		chunk_size = value
		queue_redraw()
@export var preview_neighboring_chunks := false:
	set(value):
		preview_neighboring_chunks = value
		
		if Engine.is_editor_hint():
			if value:
				add_neighbors()
			else:
				for child in neighboring_chunks.get_children():
					child.queue_free()
@export var preview_distance := 1.0

@onready var neighboring_chunks := $NeighboringChunks

func _draw() -> void:
	if Engine.is_editor_hint():
		draw_rect(Rect2(0, 0, chunk_size, chunk_size), Color.RED, false)

func add_neighbors():
	var pos = Chunks.chunk_file_name_to_position_2d(owner.scene_file_path.get_file())
	var list = Chunks.get_load_positions_square(pos * chunk_size, preview_distance, chunk_size)
	list.remove_at(list.find(pos))
	var world_path = owner.scene_file_path.get_base_dir()
	
	for item in list:
		var file_name = Chunks.make_chunk_file_name_2d(item)
		var path = world_path + "/" + file_name
		
		if !FileAccess.file_exists(path):
			continue
		
		var scene = load(path)
		var node = scene.instantiate()
		node.position = (item - pos) * chunk_size
		neighboring_chunks.add_child(node)
