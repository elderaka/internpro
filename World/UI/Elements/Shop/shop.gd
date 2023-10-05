extends MarginContainer

signal level_finished
@onready var bytes = %Bytes
@onready var stats = load("res://World/Player/DefaultPlayerStats.tres")
@onready var slot1 = $"VBoxContainer/CenterContainer/Section Seperator/ItemBG/MarginContainer/Base Vbox/Item Hbox/Item Vbox/HBoxContainer"
@onready var slot2 = $"VBoxContainer/CenterContainer/Section Seperator/ItemBG/MarginContainer/Base Vbox/Item Hbox/Item Vbox/HBoxContainer2"
@onready var slot3 = $"VBoxContainer/CenterContainer/Section Seperator/ItemBG/MarginContainer/Base Vbox/Item Hbox/Special Vbox"
@onready var heal = $"VBoxContainer/CenterContainer/Section Seperator/ItemBG/MarginContainer/Base Vbox/Comsumeable Hbox/Heal Shop"
@onready var ammo = $"VBoxContainer/CenterContainer/Section Seperator/ItemBG/MarginContainer/Base Vbox/Comsumeable Hbox/Ammo Shop"
var lowbal = false
func _ready():
	initialize_item()
	merchant_text()

func leave():
	ButtonSoundPool.PlayRandomSound(false)
	emit_signal("level_finished")
	queue_free()
	
func initialize_item():
	var slots1 = slot1.get_children()
	var slots2 = slot2.get_children()
	var slots3 = slot3.get_children()
	heal.price(100+(stats.maxhealth - stats.health))
	ammo.price(100+(stats.maxram - stats.ram))
	for i in range(slots1.size()):
		slots1[i].initialize_item(roll())
	for i in range(slots2.size()):
		slots2[i].initialize_item(roll())
	for i in range(slots3.size()):
		slots3[i].initialize_item(specialroll())
	
		
		
func roll():
	var dice = randf()
	if dice <= 0.8:
		return getCommon()
	elif dice <= 0.95:
		return getRare()
	elif dice <= 0.98:
		return getEpic()
	else:
		if PlayerInventory.weapon.size() < 2:
			return getWeapon()
		else:
			return getEpic()
			
func specialroll():
	#Yes, I'm too lazy to make else if in previous roll
	var dice = randf()
	if dice <= 0.75:
		return getRare()
	elif dice <= 0.90:
		return getEpic()
	else:
		if PlayerInventory.weapon.size() < 2:
			return getWeapon()
		else:
			return getEpic()
			
func getCommon():
	#Another dice roll, to pick which Item it will become
	return (randi_range(1,8))

func getRare():
	#Another dice roll, to pick which Item it will become
	return (randi_range(9,14))

func getEpic():
	#Another dice roll, to pick which Item it will become
	return (randi_range(15,19))

func getWeapon():
	#Another dice roll, to pick which Item it will become
	return (randi_range(23,27))
	
func merchant_text():
	var texts = [
		"Wah, wah, wah. Kaisei, apa kabar?",
		"Kamu mau apa lagi, Kaisei? Disc lagi buat nyenengin kebiasaanmu?",
		"Aku heran kamu masih hidup. Kukira kamu udah mati sekarang, ngeliat rekam jejakmu.",
		"Selamat datang di toko ini, satu-satunya tempat di mana kamu bisa menemukan penawaran terbaik untuk discs. Tapi jangan buang waktu saya, saya sibuk.",
		"Saya lihat kamu akhirnya menemukan jalan ke toko saya. Saya mulai berpikir kamu tersesat.",
		"Apa yang membawamu ke tempat tinggal saya yang sederhana, Kaisei? Apakah kamu di sini untuk membelanjakan Bytes hasil jerih payahmu?",
		"Saya terkejut kamu ada di sini begitu cepat. Saya tidak berpikir Anda akan dapat menahan untuk menghabiskan semua Bytes-mu begitu cepat.",
		"Selamat datang kembali, Kaisei. Saya harap Anda tidak di sini untuk mengembalikan apa pun.",
		"Saya lihat Anda masih memakai senjata yang sama. Mungkin sudah waktunya untuk ditingkatkan.",
		"Apa yang kamu lihat? Aku tidak punya sesuatu yang istimewa untukmu hanya karena kamu Kaisei. Bayar dan pergi."
	]
	var not_enough = [
		"Oh, sepertinya kamu tidak memiliki cukup item. Jangan coba-coba lagi ya!",	
		"Sayangnya, kantong kamu belum cukup dalam. Perlu lebih banyak lagi!",
		"Kamu mau beli ini? Hmm, kamu butuh lebih banyak item dulu, sayang.",
		"Stok barang ini hanya untuk mereka yang punya bytes berlimpah. Coba lagi nanti, mungkin.",
		"Hmm, sepertinya kamu harus kembali berburu bytes sebelum bisa beli ini.",
		"Sedikit kurang untuk kebahagiaan ini. Kumpulkan lebih banyak bytes, deh.",
		"Hanya orang berkantong tebal yang bisa beli ini. Jadi, belom bisa!",
		"Kamu belum mencapai standar minimum untuk bisa beli ini. Terus berusaha!"
	]
	var text = texts[randi_range(0,9)]
	if lowbal:
		text = not_enough[randi_range(0,7)]
	else:
		text = texts[randi_range(0,9)]
	
	$"VBoxContainer/CenterContainer/Section Seperator/Merchant Vbox/MerchantBG/MarginContainer/VBoxContainer/TextureRect2/RichTextLabel".text = text
func _on_leave_pressed():
	leave()



func _on_heal_shop_pressed():
	stats.health = stats.maxhealth
	if stats.bytes > heal.prices:
		stats.bytes -= heal.prices
	else:
		lowbal = true
		merchant_text()

func _on_ammo_shop_pressed():
	stats.ram = stats.maxram
	if stats.bytes > ammo.prices:
		stats.bytes -= ammo.prices
	else:
		lowbal = true
		merchant_text()


func _on_shop_slot_not_enough():
	lowbal = true
	merchant_text()
	
	


func _on_special_shop_slot_not_enough():
	lowbal = true
	merchant_text()
