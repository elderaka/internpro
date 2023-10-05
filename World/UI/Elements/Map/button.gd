extends Control

const margin = 10

signal room_picked(point)
signal send_room(room, roomType)

@export var room: PackedScene
@export var roomType: String
@export var finished = false

var children: Array = []
var circleColor = Color.GHOST_WHITE
var point = Vector2.ZERO

@onready var button = %Button

func add_child_event(child):
	if !children.has(child):
		children.append(child)
		child.button.set_disabled(true)
		queue_redraw()

func set_color(idx):
	if idx == 0 or idx == 1:
		circleColor = Color.RED

func set_point(point):
	self.point = point
	if point.x == 0:
		button.disabled = false

func _draw():
	for child in children:
		var line = (child.position + Vector2(20, 15)) - (position + Vector2(20, 15))
		var normal = line.normalized()
		line -= margin * normal
		var color = Color.GRAY
		draw_line(normal * margin, line, color, 1, true)

func _on_button_pressed():
	ButtonSoundPool.PlayRandomSound(false)
	print("room picked")
	for child in children:
		child.button.set_disabled(false)
		child.finished = true
	button.set_disabled(true)
	finished = true
	emit_signal("room_picked", self)
	emit_signal("send_room", room, roomType)
	
