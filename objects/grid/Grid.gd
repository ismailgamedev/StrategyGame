extends Area2D

onready var building_sprite = get_node("BuildingSprite")

enum current_building_enum { bos,kucuk_ev,orta_ev,buyuk_ev,fabrika,petrol_donusturucusu,biyo_yakit_donusturucusu, }
export(current_building_enum) var dropoff = current_building_enum.bos

func _on_Grid_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			pass
