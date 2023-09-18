extends Control

const plane_x = 10
const plane_y = 5
#node count depends on amoung of available grid
const node_count = plane_x * plane_y / 3
const path_count = 20

const mapScale = 25

var events = {}
var event_scene = preload("res://World/UI/Elements/Map/room_map.tscn")

func _ready():
	var generator = preload("res://World/UI/Elements/Map/mapGenerator.gd").new()
	var map_data = generator.generate(plane_x, plane_y, node_count, path_count)
	
	for k in map_data.nodes.keys():
		var point = map_data.nodes[k]
		var event = event_scene.instantiate()
		event.position = point * mapScale + (get_viewport_rect().size/8)
		add_child(event)
		event.set_color(k)
		event.set_point(point)
		event.connect("room_picked", picked_a_room)
		events[k] = event
	
	
	for path in map_data.paths:
		for i in range(path.size()-1):
			var index1 = path[i]
			var index2 = path[i+1]
			
			events[index1].add_child_event(events[index2])
	
	for child in get_children():
		for grandchild in child.children:
			if grandchild.point.x == child.point.x:
				get_tree().reload_current_scene()
				print("refreshed")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()

func picked_a_room(point):
	for child in get_children():
		if child not in point.children:
			child.button.disabled = true
