extends Node2D


func _ready():
	var bodies = get_tree().get_nodes_in_group("light_occluder")
	var light_occluders = []
	# get the shapes of the bodies
	for b in bodies:
		for c in b.get_children():
			if c is CollisionShape2D:
				var shape = c.shape
				var rect_dim = shape.extents * 2
				var rect_pos = c.global_position - rect_dim / 2
				var polygon = [rect_pos, 
					rect_pos + Vector2(rect_dim.x, 0), 
					rect_pos + rect_dim, 
					rect_pos + Vector2(0, rect_dim.y)]
				var occluder_poly = OccluderPolygon2D.new()
				occluder_poly.polygon = polygon
				var occluder = LightOccluder2D.new()
				occluder.occluder = occluder_poly
				
				light_occluders.append(occluder)
				# add the shape to the light occluder
	
	# add the occluders
	for o in light_occluders:
		
		add_child(o)
		o.global_position = Vector2()
				
