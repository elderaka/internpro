extends Control

signal picked_room(room, type)
signal refreshMap

const plane_x = 10
const plane_y = 5
#node count depends on amoung of available grid
const node_count = plane_x * plane_y / 3
const path_count = 20

const mapScale = 25

var events = {}
@export var rooms : Array[Random_Item]

func _ready():
	var generator = preload("res://World/UI/Elements/Map/mapGenerator.gd").new()
	var map_data = generator.generate(plane_x, plane_y, node_count, path_count)
	
	for k in map_data.nodes.keys():
		var point = map_data.nodes[k]
		var random = random_room(point)
		var room = load(random)
		print(random)
		var event = room.instantiate()
		print("instantiated")
		event.position = point * mapScale + (get_viewport_rect().size/8)
		add_child(event)
		event.set_color(k)
		event.set_point(point)
		event.connect("room_picked", picked_a_room)
		event.connect("send_room", send_room)
		events[k] = event
	
	for path in map_data.paths:
		for i in range(path.size()-1):
			var index1 = path[i]
			var index2 = path[i+1]
			
			events[index1].add_child_event(events[index2])
	
	var is_chest_room = false
	var midRoomCount = 0
	for child in get_children():
		for grandchild in child.children:
			if grandchild.point.x <= child.point.x:
				emit_signal("refreshMap")
				print("refreshed")
		if child.point.x == 5:
			is_chest_room = true
			midRoomCount += 1
	
	if not is_chest_room or midRoomCount <= 1:
		emit_signal("refreshMap")
		print("refreshed")
	
	get_child(0)._on_button_pressed()

func picked_a_room(point):
	for child in get_children():
		if child not in point.children:
			child.button.disabled = true

func random_room(point):
	var randomRoomPicker = Random_Picker.new()
	var picked = "res://World/UI/Elements/Map/fight_room.tscn"
	if point.x == 5:
		picked = "res://World/UI/Elements/Map/chest_room.tscn"
	elif point.x == 10:
		picked = "res://World/UI/Elements/Map/rensen_room.tscn"
	elif point.x > 0:
		picked = randomRoomPicker.pick_random_item(rooms)
	return picked

func send_room(room, type):
	emit_signal("picked_room", room, type)
