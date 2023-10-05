extends CenterContainer

signal back()
signal play()
@onready var skill1 = $VBoxContainer/ScrollContainer/HBoxContainer/Skill
@onready var skill2 = $VBoxContainer/ScrollContainer/HBoxContainer/Skill2
@onready var skill3 = $VBoxContainer/ScrollContainer/HBoxContainer/Skill3
@onready var skill4 = $VBoxContainer/ScrollContainer/HBoxContainer/Skill4
@onready var skill5 = $VBoxContainer/ScrollContainer/HBoxContainer/Skill5
@onready var skill6 = $VBoxContainer/ScrollContainer/HBoxContainer/Skill6
@onready var h_box_container = $VBoxContainer/ScrollContainer/HBoxContainer
var dot = load("res://World/UI/Elements/Item/Dot.tres")
var lance = load("res://World/UI/Elements/Item/Lance.tres")
var datathrower = load("res://World/UI/Elements/Item/Dot_thrower.tres")
var bounce = load("res://World/UI/Elements/Item/Bounce.tres")
var laser = load("res://World/UI/Elements/Item/Laser.tres")
var spread = load("res://World/UI/Elements/Item/Dot.tres")

func _ready():
	
	for node in h_box_container.get_children():
		node.connect("start", _on_skill_start)

func _physics_process(delta):
	print(skill1.names)
	skill1.names.text = "Dot"
	skill1.desc.text = JsonData.item_data["23"]["Description"]
	skill1.sprite.texture = dot
	skill2.names.text = "Lance"
	skill2.desc.text =JsonData.item_data["24"]["Description"]
	skill2.sprite.texture = lance
	skill3.names.text = "Bounce"
	skill3.desc.text = JsonData.item_data["25"]["Description"]
	skill3.sprite.texture = bounce
	skill4.names.text = "Datathrower"
	skill4.desc.text = JsonData.item_data["26"]["Description"]
	skill4.sprite.texture = datathrower
	skill5.names.text = "Laser"
	skill5.desc.text = JsonData.item_data["27"]["Description"]
	skill5.sprite.texture = laser
func _on_button_pressed():
	ButtonSoundPool.PlayRandomSound(false)
	emit_signal("back")

func _on_skill_start():
	ButtonSoundPool.PlayRandomSound(true)
	emit_signal("play")
