extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/dolarPanel/dolarBox.value = Globals.data["dolar"]
	$Panel/yemekPanel/yemekBox.value = Globals.data["yemek"] 
	$Panel/enerjiPanel/enerjiBox.value = Globals.data["enerji"]
	pass # Replace with function body.




func _on_Button_pressed():
	Globals.data["dolar"] = $Panel/dolarPanel/dolarBox.value
	Globals.data["yemek"] = $Panel/yemekPanel/yemekBox.value
	Globals.data["enerji"] = $Panel/enerjiPanel/enerjiBox.value
	pass # Replace with function body.
