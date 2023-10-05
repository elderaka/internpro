extends Button
var prices = 100
func price(bytes):
	prices = bytes
	$MarginContainer/Price.text = str(bytes)
