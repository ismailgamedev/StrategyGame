extends Area2D

onready var building_sprite = get_node("BuildingSprite")

#Textures
onready var kucuk_ev_texture = preload("res://assets/sprites/buildings/ev2.png")
onready var orta_ev_texture = preload("res://assets/sprites/buildings/ev3.png")
onready var buyuk_ev_texture = preload("res://assets/sprites/buildings/apartman.png")
#Grid Building Type
enum current_building_enum { bos,kucuk_ev,orta_ev,buyuk_ev,fabrika,petrol_donusturucusu,biyo_yakit_donusturucusu, }
export(current_building_enum) var current_building = current_building_enum.bos



func _on_Grid_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			# Eger insaa ettigimiz bina yoksa girmiyoruz
			if Globals.current_building != Globals.current_building_enum.bos and current_building == current_building_enum.bos:
				
				if Globals.current_building == Globals.current_building_enum.kucuk_ev:
					building_sprite.texture = kucuk_ev_texture
					current_building = current_building_enum.kucuk_ev
					Globals.current_building = Globals.current_building_enum.bos

				if Globals.current_building == Globals.current_building_enum.orta_ev:
					building_sprite.texture = orta_ev_texture
					current_building = current_building_enum.orta_ev
					Globals.current_building = Globals.current_building_enum.bos

				if Globals.current_building == Globals.current_building_enum.buyuk_ev:
					building_sprite.texture = buyuk_ev_texture
					current_building = current_building_enum.buyuk_ev
					Globals.current_building = Globals.current_building_enum.bos

		

func _on_binaTimer_timeout():
	if current_building == current_building_enum.kucuk_ev:
		pass
