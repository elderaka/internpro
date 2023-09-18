extends Node

func generate(plane_x, plane_y, node_count, path_count):
	#make sure to regenerate new map
	randomize()
	
	#Step 1: generating points
	var points = []
	points.append(Vector2(0, plane_y/2))
	points.append(Vector2(plane_x, plane_y/2))
	
	var center = Vector2(plane_x/2, plane_y/2)
	for i in range(node_count):
		while true:
			var point = Vector2(randi() % plane_x, randi() % plane_y)
			var distFromCenter = (point - center)
			#accept point within the circle
			var inSquare = point.x > 0 and point.x < plane_x
			if not points.has(point) and inSquare:
				points.append(point)
				break
	
	#Step 2: Connect all points without intersecting
	var pool = PackedVector2Array(points)
	var triangle = Geometry2D.triangulate_delaunay(pool)
	
	#Step 3: Finding path from start to finish with A*
	var astar = AStar2D.new()
	for i in range(points.size()):
		astar.add_point(i, points[i])
	
	for i in range(triangle.size() / 3):
		var p1 = triangle[i * 3]
		var p2 = triangle[i * 3 + 1]
		var p3 = triangle[i * 3 + 2]
		if not astar.are_points_connected(p1, p2):
			astar.connect_points(p1, p2)
		if not astar.are_points_connected(p2, p3):
			astar.connect_points(p2, p3)
		if not astar.are_points_connected(p1, p3):
			astar.connect_points(p1, p3)
	
	var paths = []
	
	for i in range(path_count):
		
		var id_path = astar.get_id_path(0, 1)
		if id_path.size() == 0:
			break
		
		paths.append(id_path)
		
		#Step 4: removing nodes / generating unique path
		for j in range(randi() % 2 + 1):
			# index between 1 and id_path.size() - 2 (inclusive)
			var index = randi() % (id_path.size() - 2) + 1
			var id = id_path[index]
			astar.set_point_disabled(id)
			
	var data = preload("res://World/UI/Elements/Map/mapData.gd").new()
	data.set_paths(paths, points)
	return data

