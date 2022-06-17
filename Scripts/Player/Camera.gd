extends Camera2D

func _set_limits():
	limit_left = 0
	limit_top = 0
	limit_right = 0
	limit_bottom = 0
	
	var tilemaps = get_tree().get_nodes_in_group("tilemap")
	for tilemap in tilemaps:
		var used = tilemap.get_used_rect()
		limit_left = min(used.position.x * tilemap.cell_size.x, limit_left) + 12
		limit_top = min(used.position.y * tilemap.cell_size.x, limit_top) + 12
		limit_right = max(used.end.x * tilemap.cell_size.x, limit_right) - 12
		limit_bottom = max(used.end.y * tilemap.cell_size.x, limit_bottom) - 12
