extends Control




func _on_Button_pressed():
	Globals.current_building = Globals.current_building_enum.buyuk_ev
	print(Globals.current_building)
	$Button.visible = false
